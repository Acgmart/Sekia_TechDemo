//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Scene/Base New LOD2" {
Properties {
[Header(Main Setting)] _ElementViewEleID ("Element ID", Float) = 0
_MaterialShadowBias ("Shadow Bias", Range(0, 0.1)) = 0
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("Main Tex", 2D) = "white" { }
[Header(Alpha Test)] [Toggle(ENABLE_ALPHA_TEST_ON)] _EnableAlphaTest ("Enable Alpha Test", Float) = 0
_CutOff ("Cutoff", Range(0, 1)) = 0.5
[Header(Emission (Vertex Color Alpha))] [KeywordEnum(None, Normal, Time)] Emission_Type ("Emission Type", Float) = 0
_EmissionColor ("Emission Color", Color) = (1,1,1,1)
_EmissionStrength ("Emission Strength", Range(0, 20)) = 1
[Toggle] _InvertEmission ("Invert Emission", Float) = 0
[Header(State)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
}
SubShader {
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "HYBRIDDEFERRED"
  Tags { "DebugView" = "On" "LIGHTMODE" = "HYBRIDDEFERRED" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 65486
Program "vp" {
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" "EMISSION_TYPE_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOff);
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" "EMISSION_TYPE_TIME" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
bool u_xlatb2;
lowp vec3 u_xlat10_3;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat0.x = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat0.x = _InvertEmission * u_xlat0.x + vs_COLOR0.w;
    u_xlat10_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat10_3.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
bool u_xlatb2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb9 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat9 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat9 = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat9 = _InvertEmission * u_xlat9 + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_1.xyz * vec3(u_xlat9) + u_xlat10_0.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" "EMISSION_TYPE_NORMAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
bool u_xlatb2;
lowp vec3 u_xlat10_3;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat0.x = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat0.x = _InvertEmission * u_xlat0.x + vs_COLOR0.w;
    u_xlat10_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat10_3.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_HIGH" "EMISSION_TYPE_NONE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_HIGH" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOff);
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_HIGH" "EMISSION_TYPE_TIME" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
bool u_xlatb2;
lowp vec3 u_xlat10_3;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat0.x = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat0.x = _InvertEmission * u_xlat0.x + vs_COLOR0.w;
    u_xlat10_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat10_3.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_HIGH" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
bool u_xlatb2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb9 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat9 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat9 = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat9 = _InvertEmission * u_xlat9 + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_1.xyz * vec3(u_xlat9) + u_xlat10_0.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_HIGH" "EMISSION_TYPE_NORMAL" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
bool u_xlatb2;
lowp vec3 u_xlat10_3;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat0.x = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat0.x = _InvertEmission * u_xlat0.x + vs_COLOR0.w;
    u_xlat10_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat10_3.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" "EMISSION_TYPE_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOff);
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" "EMISSION_TYPE_TIME" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
bool u_xlatb2;
lowp vec3 u_xlat10_3;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat0.x = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat0.x = _InvertEmission * u_xlat0.x + vs_COLOR0.w;
    u_xlat10_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat10_3.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
bool u_xlatb2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb9 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat9 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat9 = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat9 = _InvertEmission * u_xlat9 + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_1.xyz * vec3(u_xlat9) + u_xlat10_0.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" "EMISSION_TYPE_NORMAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
bool u_xlatb2;
lowp vec3 u_xlat10_3;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat0.x = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat0.x = _InvertEmission * u_xlat0.x + vs_COLOR0.w;
    u_xlat10_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat10_3.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_MIDDLE" "EMISSION_TYPE_NONE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_MIDDLE" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOff);
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_MIDDLE" "EMISSION_TYPE_TIME" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
bool u_xlatb2;
lowp vec3 u_xlat10_3;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat0.x = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat0.x = _InvertEmission * u_xlat0.x + vs_COLOR0.w;
    u_xlat10_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat10_3.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_MIDDLE" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
bool u_xlatb2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb9 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat9 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat9 = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat9 = _InvertEmission * u_xlat9 + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_1.xyz * vec3(u_xlat9) + u_xlat10_0.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_MIDDLE" "EMISSION_TYPE_NORMAL" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
bool u_xlatb2;
lowp vec3 u_xlat10_3;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat0.x = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat0.x = _InvertEmission * u_xlat0.x + vs_COLOR0.w;
    u_xlat10_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat10_3.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" "EMISSION_TYPE_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" "EMISSION_TYPE_TIME" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
bool u_xlatb2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat0.x = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat0.x = _InvertEmission * u_xlat0.x + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vs_COLOR0.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
bool u_xlatb2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat0.x = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat0.x = _InvertEmission * u_xlat0.x + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vs_COLOR0.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" "EMISSION_TYPE_NORMAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _InvertEmission;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
bool u_xlatb2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat0.x = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat0.x = _InvertEmission * u_xlat0.x + vs_COLOR0.w;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vs_COLOR0.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_LOW" "EMISSION_TYPE_NONE" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_LOW" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_LOW" "EMISSION_TYPE_TIME" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
bool u_xlatb2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat0.x = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat0.x = _InvertEmission * u_xlat0.x + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vs_COLOR0.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_LOW" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
bool u_xlatb2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat0.x = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat0.x = _InvertEmission * u_xlat0.x + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vs_COLOR0.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_LOW" "EMISSION_TYPE_NORMAL" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _InvertEmission;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
bool u_xlatb2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat0.x = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat0.x = _InvertEmission * u_xlat0.x + vs_COLOR0.w;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vs_COLOR0.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_HIGH" "EMISSION_TYPE_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat8;
bvec3 u_xlatb8;
float u_xlat9;
bvec3 u_xlatb9;
float u_xlat10;
vec2 u_xlat15;
vec2 u_xlat16;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
float u_xlat23;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb21){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb21){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb21){
        u_xlat21 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = max(u_xlat21, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb21){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat15.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat21 = dot(u_xlat15.xy, u_xlat15.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat21 = max(u_xlat21, u_xlat1.x);
        u_xlat21 = log2(u_xlat21);
        u_xlat21 = u_xlat21 * 0.5;
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat21 = u_xlat21 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = u_xlat1.x / u_xlat21;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb21){
        u_xlat1.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat2.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat2.xyxx).xy;
        u_xlatb21 = u_xlatb2.y || u_xlatb2.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (bool(u_xlatb21)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb21 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb21 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb21){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat21 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat21 = max(u_xlat21, u_xlat3.x);
            u_xlat21 = log2(u_xlat21);
            u_xlat21 = u_xlat21 * 0.5;
            u_xlat21 = max(u_xlat21, 0.0);
            u_xlat21 = u_xlat21 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat21);
            u_xlat21 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat9 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat23 = sqrt(u_xlat21);
            u_xlat3.x = sqrt(u_xlat9);
            u_xlat21 = inversesqrt(u_xlat21);
            u_xlat21 = u_xlat21 * abs(u_xlat2.z);
            u_xlat9 = inversesqrt(u_xlat9);
            u_xlat2.x = u_xlat9 * abs(u_xlat2.x);
            u_xlat21 = u_xlat21 * u_xlat2.x;
            u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
            u_xlat21 = sqrt(u_xlat21);
            u_xlat2.x = u_xlat23 * u_xlat3.x;
            u_xlat9 = u_xlat21 * u_xlat2.x;
            u_xlat16.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat16.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat16.xy = fract(u_xlat16.xy);
            u_xlat16.xy = u_xlat16.xy + vec2(0.5, 0.5);
            u_xlat16.xy = floor(u_xlat16.xy);
            u_xlat3.x = (-u_xlat16.x) + u_xlat3.x;
            u_xlat16.x = u_xlat3.x * u_xlat16.y + u_xlat16.x;
            u_xlat23 = (-u_xlat2.x) * u_xlat21 + 1.0;
            u_xlat3.xyz = (-u_xlat16.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat23) * u_xlat3.xyz + u_xlat16.xxx;
            u_xlatb9.xz = lessThan(vec4(u_xlat9), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat16.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat21 = u_xlat2.x * u_xlat21 + -4.0;
            u_xlat21 = exp2(u_xlat21);
            u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
            u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat16.xxx;
            u_xlat2.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb21 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb21 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb21){
                u_xlat2.x = float(0.0);
                u_xlat2.y = float(0.0);
                u_xlat2.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb21 = !!(u_xlat1.x>=0.0);
#else
                u_xlatb21 = u_xlat1.x>=0.0;
#endif
                if(u_xlatb21){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat21 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat23 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat21 = max(u_xlat21, u_xlat23);
                    u_xlat21 = log2(u_xlat21);
                    u_xlat21 = u_xlat21 * 0.5;
                    u_xlat21 = max(u_xlat21, 0.0);
                    u_xlat21 = u_xlat21 + 1.0;
                    u_xlat23 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat23) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat23);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat21);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat21);
                    u_xlat21 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat8 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat23 = sqrt(u_xlat21);
                    u_xlat10 = sqrt(u_xlat8);
                    u_xlat21 = inversesqrt(u_xlat21);
                    u_xlat21 = u_xlat21 * abs(u_xlat3.x);
                    u_xlat8 = inversesqrt(u_xlat8);
                    u_xlat1.x = u_xlat8 * abs(u_xlat1.x);
                    u_xlat21 = u_xlat21 * u_xlat1.x;
                    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
                    u_xlat21 = sqrt(u_xlat21);
                    u_xlat1.x = u_xlat23 * u_xlat10;
                    u_xlat8 = u_xlat21 * u_xlat1.x;
                    u_xlat15.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat23 = fract((-u_xlat15.x));
                    u_xlat23 = u_xlat23 + 0.5;
                    u_xlat23 = floor(u_xlat23);
                    u_xlat15.xy = fract(u_xlat15.xy);
                    u_xlat15.xy = u_xlat15.xy + vec2(0.5, 0.5);
                    u_xlat15.xy = floor(u_xlat15.xy);
                    u_xlat23 = (-u_xlat15.x) + u_xlat23;
                    u_xlat15.x = u_xlat23 * u_xlat15.y + u_xlat15.x;
                    u_xlat22 = (-u_xlat1.x) * u_xlat21 + 1.0;
                    u_xlat3.xyz = (-u_xlat15.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz + u_xlat15.xxx;
                    u_xlatb8.xz = lessThan(vec4(u_xlat8), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat15.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat21 = u_xlat1.x * u_xlat21 + -4.0;
                    u_xlat21 = exp2(u_xlat21);
                    u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
                    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat15.xxx;
                    u_xlat1.xzw = (u_xlatb8.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb8.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat2.x = float(0.0);
                    u_xlat2.y = float(0.0);
                    u_xlat2.z = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_6 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_6 : 0.0;
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_HIGH" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
bvec3 u_xlatb2;
vec4 u_xlat3;
bvec3 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump float u_xlat16_7;
float u_xlat10;
bvec3 u_xlatb10;
vec3 u_xlat11;
vec2 u_xlat18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat26;
float u_xlat27;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1<0.0);
#else
    u_xlatb24 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb24){
        u_xlatb2.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat1 = (u_xlatb2.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat1 = (u_xlatb2.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb24){
        u_xlat24 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = max(u_xlat24, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb2.x = !!(256.0<u_xlat24);
#else
        u_xlatb2.x = 256.0<u_xlat24;
#endif
        u_xlatb10.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat1 = (u_xlatb10.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb10.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb24){
        u_xlat2.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat18.xy = dFdx(u_xlat2.xy);
        u_xlat2.xy = dFdy(u_xlat2.xy);
        u_xlat24 = dot(u_xlat18.xy, u_xlat18.xy);
        u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
        u_xlat24 = max(u_xlat24, u_xlat2.x);
        u_xlat24 = log2(u_xlat24);
        u_xlat24 = u_xlat24 * 0.5;
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat24 = u_xlat24 + 1.0;
        u_xlat2.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = u_xlat2.x / u_xlat24;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2.x = !!(256.0<u_xlat24);
#else
        u_xlatb2.x = 256.0<u_xlat24;
#endif
        u_xlatb10.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat1 = (u_xlatb10.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb10.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb24){
        u_xlat1.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat2.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat2.xyxx).xy;
        u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (bool(u_xlatb24)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb24 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb24){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat24 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat24 = max(u_xlat24, u_xlat3.x);
            u_xlat24 = log2(u_xlat24);
            u_xlat24 = u_xlat24 * 0.5;
            u_xlat24 = max(u_xlat24, 0.0);
            u_xlat24 = u_xlat24 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat24);
            u_xlat24 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat10 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat26 = sqrt(u_xlat24);
            u_xlat3.x = sqrt(u_xlat10);
            u_xlat24 = inversesqrt(u_xlat24);
            u_xlat24 = u_xlat24 * abs(u_xlat2.z);
            u_xlat10 = inversesqrt(u_xlat10);
            u_xlat2.x = u_xlat10 * abs(u_xlat2.x);
            u_xlat24 = u_xlat24 * u_xlat2.x;
            u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
            u_xlat24 = sqrt(u_xlat24);
            u_xlat2.x = u_xlat26 * u_xlat3.x;
            u_xlat10 = u_xlat24 * u_xlat2.x;
            u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat18.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat18.xy = fract(u_xlat18.xy);
            u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
            u_xlat18.xy = floor(u_xlat18.xy);
            u_xlat3.x = (-u_xlat18.x) + u_xlat3.x;
            u_xlat18.x = u_xlat3.x * u_xlat18.y + u_xlat18.x;
            u_xlat26 = (-u_xlat2.x) * u_xlat24 + 1.0;
            u_xlat3.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat18.xxx;
            u_xlatb10.xz = lessThan(vec4(u_xlat10), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat24 = u_xlat2.x * u_xlat24 + -4.0;
            u_xlat24 = exp2(u_xlat24);
            u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
            u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat18.xxx;
            u_xlat2.xzw = (u_xlatb10.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb10.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb24 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb24 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb24){
                u_xlat2.x = float(0.0);
                u_xlat2.y = float(0.0);
                u_xlat2.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb24 = !!(u_xlat1.x>=0.0);
#else
                u_xlatb24 = u_xlat1.x>=0.0;
#endif
                if(u_xlatb24){
                    u_xlat3.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.zw = dFdx(u_xlat3.xy);
                    u_xlat3.xy = dFdy(u_xlat3.xy);
                    u_xlat24 = dot(u_xlat3.zw, u_xlat3.zw);
                    u_xlat26 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3 = vec4(u_xlat26) * u_xlat3;
                    u_xlat3 = u_xlat3 / vec4(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                    u_xlat26 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat11.x = sqrt(u_xlat24);
                    u_xlat27 = sqrt(u_xlat26);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.z);
                    u_xlat26 = inversesqrt(u_xlat26);
                    u_xlat26 = u_xlat26 * abs(u_xlat3.x);
                    u_xlat24 = u_xlat24 * u_xlat26;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat26 = u_xlat27 * u_xlat11.x;
                    u_xlat3.x = u_xlat24 * u_xlat26;
                    u_xlat11.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat27 = fract((-u_xlat11.x));
                    u_xlat11.z = u_xlat27 + 0.5;
                    u_xlat11.xy = fract(u_xlat11.xy);
                    u_xlat11.xy = u_xlat11.xy + vec2(0.5, 0.5);
                    u_xlat11.xyz = floor(u_xlat11.xyz);
                    u_xlat27 = (-u_xlat11.x) + u_xlat11.z;
                    u_xlat11.x = u_xlat27 * u_xlat11.y + u_xlat11.x;
                    u_xlat19 = (-u_xlat26) * u_xlat24 + 1.0;
                    u_xlat4.xyz = (-u_xlat11.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat11.xxx;
                    u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat6.xyz = u_xlat11.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat26 * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.zyy + u_xlat11.xxx;
                    u_xlat11.xyz = (u_xlatb3.z) ? u_xlat6.xyz : u_xlat4.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat5.xyz : u_xlat11.xyz;
                } else {
                    u_xlat2.x = float(0.0);
                    u_xlat2.y = float(0.0);
                    u_xlat2.z = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb2.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb2.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_7 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_7 : 0.0;
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_HIGH" "EMISSION_TYPE_TIME" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec2 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat8;
bvec3 u_xlatb8;
vec3 u_xlat9;
bvec3 u_xlatb9;
float u_xlat10;
vec2 u_xlat15;
vec2 u_xlat16;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
float u_xlat23;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb21){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb21){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb21){
        u_xlat21 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = max(u_xlat21, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb21){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat15.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat21 = dot(u_xlat15.xy, u_xlat15.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat21 = max(u_xlat21, u_xlat1.x);
        u_xlat21 = log2(u_xlat21);
        u_xlat21 = u_xlat21 * 0.5;
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat21 = u_xlat21 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = u_xlat1.x / u_xlat21;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb21){
        u_xlat1.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat2.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat2.xyxx).xy;
        u_xlatb21 = u_xlatb2.y || u_xlatb2.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (bool(u_xlatb21)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb21 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb21 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb21){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat21 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat21 = max(u_xlat21, u_xlat3.x);
            u_xlat21 = log2(u_xlat21);
            u_xlat21 = u_xlat21 * 0.5;
            u_xlat21 = max(u_xlat21, 0.0);
            u_xlat21 = u_xlat21 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat21);
            u_xlat21 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat9.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat23 = sqrt(u_xlat21);
            u_xlat3.x = sqrt(u_xlat9.x);
            u_xlat21 = inversesqrt(u_xlat21);
            u_xlat21 = u_xlat21 * abs(u_xlat2.z);
            u_xlat9.x = inversesqrt(u_xlat9.x);
            u_xlat2.x = u_xlat9.x * abs(u_xlat2.x);
            u_xlat21 = u_xlat21 * u_xlat2.x;
            u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
            u_xlat21 = sqrt(u_xlat21);
            u_xlat2.x = u_xlat23 * u_xlat3.x;
            u_xlat9.x = u_xlat21 * u_xlat2.x;
            u_xlat16.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat16.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat16.xy = fract(u_xlat16.xy);
            u_xlat16.xy = u_xlat16.xy + vec2(0.5, 0.5);
            u_xlat16.xy = floor(u_xlat16.xy);
            u_xlat3.x = (-u_xlat16.x) + u_xlat3.x;
            u_xlat16.x = u_xlat3.x * u_xlat16.y + u_xlat16.x;
            u_xlat23 = (-u_xlat2.x) * u_xlat21 + 1.0;
            u_xlat3.xyz = (-u_xlat16.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat23) * u_xlat3.xyz + u_xlat16.xxx;
            u_xlatb9.xz = lessThan(u_xlat9.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat16.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat21 = u_xlat2.x * u_xlat21 + -4.0;
            u_xlat21 = exp2(u_xlat21);
            u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
            u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat16.xxx;
            u_xlat2.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb21 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb21 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb21){
                u_xlat2.x = float(0.0);
                u_xlat2.y = float(0.0);
                u_xlat2.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb21 = !!(u_xlat1.x>=0.0);
#else
                u_xlatb21 = u_xlat1.x>=0.0;
#endif
                if(u_xlatb21){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat21 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat23 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat21 = max(u_xlat21, u_xlat23);
                    u_xlat21 = log2(u_xlat21);
                    u_xlat21 = u_xlat21 * 0.5;
                    u_xlat21 = max(u_xlat21, 0.0);
                    u_xlat21 = u_xlat21 + 1.0;
                    u_xlat23 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat23) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat23);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat21);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat21);
                    u_xlat21 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat8 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat23 = sqrt(u_xlat21);
                    u_xlat10 = sqrt(u_xlat8);
                    u_xlat21 = inversesqrt(u_xlat21);
                    u_xlat21 = u_xlat21 * abs(u_xlat3.x);
                    u_xlat8 = inversesqrt(u_xlat8);
                    u_xlat1.x = u_xlat8 * abs(u_xlat1.x);
                    u_xlat21 = u_xlat21 * u_xlat1.x;
                    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
                    u_xlat21 = sqrt(u_xlat21);
                    u_xlat1.x = u_xlat23 * u_xlat10;
                    u_xlat8 = u_xlat21 * u_xlat1.x;
                    u_xlat15.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat23 = fract((-u_xlat15.x));
                    u_xlat23 = u_xlat23 + 0.5;
                    u_xlat23 = floor(u_xlat23);
                    u_xlat15.xy = fract(u_xlat15.xy);
                    u_xlat15.xy = u_xlat15.xy + vec2(0.5, 0.5);
                    u_xlat15.xy = floor(u_xlat15.xy);
                    u_xlat23 = (-u_xlat15.x) + u_xlat23;
                    u_xlat15.x = u_xlat23 * u_xlat15.y + u_xlat15.x;
                    u_xlat22 = (-u_xlat1.x) * u_xlat21 + 1.0;
                    u_xlat3.xyz = (-u_xlat15.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz + u_xlat15.xxx;
                    u_xlatb8.xz = lessThan(vec4(u_xlat8), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat15.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat21 = u_xlat1.x * u_xlat21 + -4.0;
                    u_xlat21 = exp2(u_xlat21);
                    u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
                    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat15.xxx;
                    u_xlat1.xzw = (u_xlatb8.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb8.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat2.x = float(0.0);
                    u_xlat2.y = float(0.0);
                    u_xlat2.z = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_6.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat21 = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat21 = _InvertEmission * u_xlat21 + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_6.xyz * vec3(u_xlat21) + u_xlat10_0.xyz;
    u_xlat16_6.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_6.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2.x = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = (u_xlatb2.x) ? u_xlat16_1 : u_xlat16_0;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat9.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat9.xyz = u_xlat9.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat9.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb9.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_6.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb9.x) ? u_xlat16_6.x : 0.0;
    SV_Target0.w = 0.00392156886;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    SV_Target2.w = u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_HIGH" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump float _CutOff;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec3 u_xlatb2;
vec4 u_xlat3;
bvec3 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat10;
bvec3 u_xlatb10;
vec3 u_xlat11;
vec2 u_xlat18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat26;
float u_xlat27;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb24 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb24){
        u_xlatb2.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat1 = (u_xlatb2.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat1 = (u_xlatb2.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb24){
        u_xlat24 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = max(u_xlat24, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb2.x = !!(256.0<u_xlat24);
#else
        u_xlatb2.x = 256.0<u_xlat24;
#endif
        u_xlatb10.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat1 = (u_xlatb10.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb10.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb24){
        u_xlat2.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat18.xy = dFdx(u_xlat2.xy);
        u_xlat2.xy = dFdy(u_xlat2.xy);
        u_xlat24 = dot(u_xlat18.xy, u_xlat18.xy);
        u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
        u_xlat24 = max(u_xlat24, u_xlat2.x);
        u_xlat24 = log2(u_xlat24);
        u_xlat24 = u_xlat24 * 0.5;
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat24 = u_xlat24 + 1.0;
        u_xlat2.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = u_xlat2.x / u_xlat24;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2.x = !!(256.0<u_xlat24);
#else
        u_xlatb2.x = 256.0<u_xlat24;
#endif
        u_xlatb10.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat1 = (u_xlatb10.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb10.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb24){
        u_xlat1.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat2.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat2.xyxx).xy;
        u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (bool(u_xlatb24)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb24 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb24){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat24 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat24 = max(u_xlat24, u_xlat3.x);
            u_xlat24 = log2(u_xlat24);
            u_xlat24 = u_xlat24 * 0.5;
            u_xlat24 = max(u_xlat24, 0.0);
            u_xlat24 = u_xlat24 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat24);
            u_xlat24 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat10.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat26 = sqrt(u_xlat24);
            u_xlat3.x = sqrt(u_xlat10.x);
            u_xlat24 = inversesqrt(u_xlat24);
            u_xlat24 = u_xlat24 * abs(u_xlat2.z);
            u_xlat10.x = inversesqrt(u_xlat10.x);
            u_xlat2.x = u_xlat10.x * abs(u_xlat2.x);
            u_xlat24 = u_xlat24 * u_xlat2.x;
            u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
            u_xlat24 = sqrt(u_xlat24);
            u_xlat2.x = u_xlat26 * u_xlat3.x;
            u_xlat10.x = u_xlat24 * u_xlat2.x;
            u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat18.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat18.xy = fract(u_xlat18.xy);
            u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
            u_xlat18.xy = floor(u_xlat18.xy);
            u_xlat3.x = (-u_xlat18.x) + u_xlat3.x;
            u_xlat18.x = u_xlat3.x * u_xlat18.y + u_xlat18.x;
            u_xlat26 = (-u_xlat2.x) * u_xlat24 + 1.0;
            u_xlat3.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat18.xxx;
            u_xlatb10.xz = lessThan(u_xlat10.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat24 = u_xlat2.x * u_xlat24 + -4.0;
            u_xlat24 = exp2(u_xlat24);
            u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
            u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat18.xxx;
            u_xlat2.xzw = (u_xlatb10.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb10.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb24 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb24 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb24){
                u_xlat2.x = float(0.0);
                u_xlat2.y = float(0.0);
                u_xlat2.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb24 = !!(u_xlat1.x>=0.0);
#else
                u_xlatb24 = u_xlat1.x>=0.0;
#endif
                if(u_xlatb24){
                    u_xlat3.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.zw = dFdx(u_xlat3.xy);
                    u_xlat3.xy = dFdy(u_xlat3.xy);
                    u_xlat24 = dot(u_xlat3.zw, u_xlat3.zw);
                    u_xlat26 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3 = vec4(u_xlat26) * u_xlat3;
                    u_xlat3 = u_xlat3 / vec4(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                    u_xlat26 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat11.x = sqrt(u_xlat24);
                    u_xlat27 = sqrt(u_xlat26);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.z);
                    u_xlat26 = inversesqrt(u_xlat26);
                    u_xlat26 = u_xlat26 * abs(u_xlat3.x);
                    u_xlat24 = u_xlat24 * u_xlat26;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat26 = u_xlat27 * u_xlat11.x;
                    u_xlat3.x = u_xlat24 * u_xlat26;
                    u_xlat11.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat27 = fract((-u_xlat11.x));
                    u_xlat11.z = u_xlat27 + 0.5;
                    u_xlat11.xy = fract(u_xlat11.xy);
                    u_xlat11.xy = u_xlat11.xy + vec2(0.5, 0.5);
                    u_xlat11.xyz = floor(u_xlat11.xyz);
                    u_xlat27 = (-u_xlat11.x) + u_xlat11.z;
                    u_xlat11.x = u_xlat27 * u_xlat11.y + u_xlat11.x;
                    u_xlat19 = (-u_xlat26) * u_xlat24 + 1.0;
                    u_xlat4.xyz = (-u_xlat11.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat11.xxx;
                    u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat6.xyz = u_xlat11.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat26 * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.zyy + u_xlat11.xxx;
                    u_xlat11.xyz = (u_xlatb3.z) ? u_xlat6.xyz : u_xlat4.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat5.xyz : u_xlat11.xyz;
                } else {
                    u_xlat2.x = float(0.0);
                    u_xlat2.y = float(0.0);
                    u_xlat2.z = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb2.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb2.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_7.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat24 = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat24 = _InvertEmission * u_xlat24 + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_7.xyz * vec3(u_xlat24) + u_xlat10_0.xyz;
    u_xlat16_7.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_7.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2.x = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = (u_xlatb2.x) ? u_xlat16_1 : u_xlat16_0;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat10.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat10.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb10.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_7.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb10.x) ? u_xlat16_7.x : 0.0;
    SV_Target0.w = 0.00392156886;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    SV_Target2.w = u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_HIGH" "EMISSION_TYPE_NORMAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec2 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat8;
bvec3 u_xlatb8;
vec3 u_xlat9;
bvec3 u_xlatb9;
float u_xlat10;
vec2 u_xlat15;
vec2 u_xlat16;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
float u_xlat23;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb21){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb21){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb21){
        u_xlat21 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = max(u_xlat21, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb21){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat15.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat21 = dot(u_xlat15.xy, u_xlat15.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat21 = max(u_xlat21, u_xlat1.x);
        u_xlat21 = log2(u_xlat21);
        u_xlat21 = u_xlat21 * 0.5;
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat21 = u_xlat21 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = u_xlat1.x / u_xlat21;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb21){
        u_xlat1.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat2.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat2.xyxx).xy;
        u_xlatb21 = u_xlatb2.y || u_xlatb2.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (bool(u_xlatb21)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb21 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb21 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb21){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat21 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat21 = max(u_xlat21, u_xlat3.x);
            u_xlat21 = log2(u_xlat21);
            u_xlat21 = u_xlat21 * 0.5;
            u_xlat21 = max(u_xlat21, 0.0);
            u_xlat21 = u_xlat21 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat21);
            u_xlat21 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat9.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat23 = sqrt(u_xlat21);
            u_xlat3.x = sqrt(u_xlat9.x);
            u_xlat21 = inversesqrt(u_xlat21);
            u_xlat21 = u_xlat21 * abs(u_xlat2.z);
            u_xlat9.x = inversesqrt(u_xlat9.x);
            u_xlat2.x = u_xlat9.x * abs(u_xlat2.x);
            u_xlat21 = u_xlat21 * u_xlat2.x;
            u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
            u_xlat21 = sqrt(u_xlat21);
            u_xlat2.x = u_xlat23 * u_xlat3.x;
            u_xlat9.x = u_xlat21 * u_xlat2.x;
            u_xlat16.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat16.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat16.xy = fract(u_xlat16.xy);
            u_xlat16.xy = u_xlat16.xy + vec2(0.5, 0.5);
            u_xlat16.xy = floor(u_xlat16.xy);
            u_xlat3.x = (-u_xlat16.x) + u_xlat3.x;
            u_xlat16.x = u_xlat3.x * u_xlat16.y + u_xlat16.x;
            u_xlat23 = (-u_xlat2.x) * u_xlat21 + 1.0;
            u_xlat3.xyz = (-u_xlat16.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat23) * u_xlat3.xyz + u_xlat16.xxx;
            u_xlatb9.xz = lessThan(u_xlat9.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat16.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat21 = u_xlat2.x * u_xlat21 + -4.0;
            u_xlat21 = exp2(u_xlat21);
            u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
            u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat16.xxx;
            u_xlat2.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb21 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb21 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb21){
                u_xlat2.x = float(0.0);
                u_xlat2.y = float(0.0);
                u_xlat2.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb21 = !!(u_xlat1.x>=0.0);
#else
                u_xlatb21 = u_xlat1.x>=0.0;
#endif
                if(u_xlatb21){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat21 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat23 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat21 = max(u_xlat21, u_xlat23);
                    u_xlat21 = log2(u_xlat21);
                    u_xlat21 = u_xlat21 * 0.5;
                    u_xlat21 = max(u_xlat21, 0.0);
                    u_xlat21 = u_xlat21 + 1.0;
                    u_xlat23 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat23) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat23);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat21);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat21);
                    u_xlat21 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat8 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat23 = sqrt(u_xlat21);
                    u_xlat10 = sqrt(u_xlat8);
                    u_xlat21 = inversesqrt(u_xlat21);
                    u_xlat21 = u_xlat21 * abs(u_xlat3.x);
                    u_xlat8 = inversesqrt(u_xlat8);
                    u_xlat1.x = u_xlat8 * abs(u_xlat1.x);
                    u_xlat21 = u_xlat21 * u_xlat1.x;
                    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
                    u_xlat21 = sqrt(u_xlat21);
                    u_xlat1.x = u_xlat23 * u_xlat10;
                    u_xlat8 = u_xlat21 * u_xlat1.x;
                    u_xlat15.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat23 = fract((-u_xlat15.x));
                    u_xlat23 = u_xlat23 + 0.5;
                    u_xlat23 = floor(u_xlat23);
                    u_xlat15.xy = fract(u_xlat15.xy);
                    u_xlat15.xy = u_xlat15.xy + vec2(0.5, 0.5);
                    u_xlat15.xy = floor(u_xlat15.xy);
                    u_xlat23 = (-u_xlat15.x) + u_xlat23;
                    u_xlat15.x = u_xlat23 * u_xlat15.y + u_xlat15.x;
                    u_xlat22 = (-u_xlat1.x) * u_xlat21 + 1.0;
                    u_xlat3.xyz = (-u_xlat15.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz + u_xlat15.xxx;
                    u_xlatb8.xz = lessThan(vec4(u_xlat8), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat15.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat21 = u_xlat1.x * u_xlat21 + -4.0;
                    u_xlat21 = exp2(u_xlat21);
                    u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
                    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat15.xxx;
                    u_xlat1.xzw = (u_xlatb8.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb8.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat2.x = float(0.0);
                    u_xlat2.y = float(0.0);
                    u_xlat2.z = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_6.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat21 = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat21 = _InvertEmission * u_xlat21 + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_6.xyz * vec3(u_xlat21) + u_xlat10_0.xyz;
    u_xlat16_6.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_6.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2.x = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = (u_xlatb2.x) ? u_xlat16_1 : u_xlat16_0;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat9.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat9.xyz = u_xlat9.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat9.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb9.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_6.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb9.x) ? u_xlat16_6.x : 0.0;
    SV_Target0.w = 0.00392156886;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    SV_Target2.w = u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_HIGH" "EMISSION_TYPE_NONE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat8;
bvec3 u_xlatb8;
float u_xlat9;
bvec3 u_xlatb9;
float u_xlat10;
vec2 u_xlat15;
vec2 u_xlat16;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
float u_xlat23;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb21){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb21){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb21){
        u_xlat21 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = max(u_xlat21, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb21){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat15.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat21 = dot(u_xlat15.xy, u_xlat15.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat21 = max(u_xlat21, u_xlat1.x);
        u_xlat21 = log2(u_xlat21);
        u_xlat21 = u_xlat21 * 0.5;
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat21 = u_xlat21 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = u_xlat1.x / u_xlat21;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb21){
        u_xlat1.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat2.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat2.xyxx).xy;
        u_xlatb21 = u_xlatb2.y || u_xlatb2.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (bool(u_xlatb21)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb21 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb21 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb21){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat21 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat21 = max(u_xlat21, u_xlat3.x);
            u_xlat21 = log2(u_xlat21);
            u_xlat21 = u_xlat21 * 0.5;
            u_xlat21 = max(u_xlat21, 0.0);
            u_xlat21 = u_xlat21 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat21);
            u_xlat21 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat9 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat23 = sqrt(u_xlat21);
            u_xlat3.x = sqrt(u_xlat9);
            u_xlat21 = inversesqrt(u_xlat21);
            u_xlat21 = u_xlat21 * abs(u_xlat2.z);
            u_xlat9 = inversesqrt(u_xlat9);
            u_xlat2.x = u_xlat9 * abs(u_xlat2.x);
            u_xlat21 = u_xlat21 * u_xlat2.x;
            u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
            u_xlat21 = sqrt(u_xlat21);
            u_xlat2.x = u_xlat23 * u_xlat3.x;
            u_xlat9 = u_xlat21 * u_xlat2.x;
            u_xlat16.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat16.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat16.xy = fract(u_xlat16.xy);
            u_xlat16.xy = u_xlat16.xy + vec2(0.5, 0.5);
            u_xlat16.xy = floor(u_xlat16.xy);
            u_xlat3.x = (-u_xlat16.x) + u_xlat3.x;
            u_xlat16.x = u_xlat3.x * u_xlat16.y + u_xlat16.x;
            u_xlat23 = (-u_xlat2.x) * u_xlat21 + 1.0;
            u_xlat3.xyz = (-u_xlat16.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat23) * u_xlat3.xyz + u_xlat16.xxx;
            u_xlatb9.xz = lessThan(vec4(u_xlat9), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat16.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat21 = u_xlat2.x * u_xlat21 + -4.0;
            u_xlat21 = exp2(u_xlat21);
            u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
            u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat16.xxx;
            u_xlat2.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb21 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb21 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb21){
                u_xlat2.x = float(0.0);
                u_xlat2.y = float(0.0);
                u_xlat2.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb21 = !!(u_xlat1.x>=0.0);
#else
                u_xlatb21 = u_xlat1.x>=0.0;
#endif
                if(u_xlatb21){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat21 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat23 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat21 = max(u_xlat21, u_xlat23);
                    u_xlat21 = log2(u_xlat21);
                    u_xlat21 = u_xlat21 * 0.5;
                    u_xlat21 = max(u_xlat21, 0.0);
                    u_xlat21 = u_xlat21 + 1.0;
                    u_xlat23 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat23) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat23);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat21);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat21);
                    u_xlat21 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat8 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat23 = sqrt(u_xlat21);
                    u_xlat10 = sqrt(u_xlat8);
                    u_xlat21 = inversesqrt(u_xlat21);
                    u_xlat21 = u_xlat21 * abs(u_xlat3.x);
                    u_xlat8 = inversesqrt(u_xlat8);
                    u_xlat1.x = u_xlat8 * abs(u_xlat1.x);
                    u_xlat21 = u_xlat21 * u_xlat1.x;
                    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
                    u_xlat21 = sqrt(u_xlat21);
                    u_xlat1.x = u_xlat23 * u_xlat10;
                    u_xlat8 = u_xlat21 * u_xlat1.x;
                    u_xlat15.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat23 = fract((-u_xlat15.x));
                    u_xlat23 = u_xlat23 + 0.5;
                    u_xlat23 = floor(u_xlat23);
                    u_xlat15.xy = fract(u_xlat15.xy);
                    u_xlat15.xy = u_xlat15.xy + vec2(0.5, 0.5);
                    u_xlat15.xy = floor(u_xlat15.xy);
                    u_xlat23 = (-u_xlat15.x) + u_xlat23;
                    u_xlat15.x = u_xlat23 * u_xlat15.y + u_xlat15.x;
                    u_xlat22 = (-u_xlat1.x) * u_xlat21 + 1.0;
                    u_xlat3.xyz = (-u_xlat15.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz + u_xlat15.xxx;
                    u_xlatb8.xz = lessThan(vec4(u_xlat8), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat15.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat21 = u_xlat1.x * u_xlat21 + -4.0;
                    u_xlat21 = exp2(u_xlat21);
                    u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
                    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat15.xxx;
                    u_xlat1.xzw = (u_xlatb8.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb8.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat2.x = float(0.0);
                    u_xlat2.y = float(0.0);
                    u_xlat2.z = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_6 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_6 : 0.0;
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_HIGH" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
bvec3 u_xlatb2;
vec4 u_xlat3;
bvec3 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump float u_xlat16_7;
float u_xlat10;
bvec3 u_xlatb10;
vec3 u_xlat11;
vec2 u_xlat18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat26;
float u_xlat27;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1<0.0);
#else
    u_xlatb24 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb24){
        u_xlatb2.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat1 = (u_xlatb2.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat1 = (u_xlatb2.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb24){
        u_xlat24 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = max(u_xlat24, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb2.x = !!(256.0<u_xlat24);
#else
        u_xlatb2.x = 256.0<u_xlat24;
#endif
        u_xlatb10.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat1 = (u_xlatb10.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb10.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb24){
        u_xlat2.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat18.xy = dFdx(u_xlat2.xy);
        u_xlat2.xy = dFdy(u_xlat2.xy);
        u_xlat24 = dot(u_xlat18.xy, u_xlat18.xy);
        u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
        u_xlat24 = max(u_xlat24, u_xlat2.x);
        u_xlat24 = log2(u_xlat24);
        u_xlat24 = u_xlat24 * 0.5;
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat24 = u_xlat24 + 1.0;
        u_xlat2.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = u_xlat2.x / u_xlat24;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2.x = !!(256.0<u_xlat24);
#else
        u_xlatb2.x = 256.0<u_xlat24;
#endif
        u_xlatb10.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat1 = (u_xlatb10.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb10.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb24){
        u_xlat1.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat2.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat2.xyxx).xy;
        u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (bool(u_xlatb24)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb24 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb24){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat24 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat24 = max(u_xlat24, u_xlat3.x);
            u_xlat24 = log2(u_xlat24);
            u_xlat24 = u_xlat24 * 0.5;
            u_xlat24 = max(u_xlat24, 0.0);
            u_xlat24 = u_xlat24 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat24);
            u_xlat24 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat10 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat26 = sqrt(u_xlat24);
            u_xlat3.x = sqrt(u_xlat10);
            u_xlat24 = inversesqrt(u_xlat24);
            u_xlat24 = u_xlat24 * abs(u_xlat2.z);
            u_xlat10 = inversesqrt(u_xlat10);
            u_xlat2.x = u_xlat10 * abs(u_xlat2.x);
            u_xlat24 = u_xlat24 * u_xlat2.x;
            u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
            u_xlat24 = sqrt(u_xlat24);
            u_xlat2.x = u_xlat26 * u_xlat3.x;
            u_xlat10 = u_xlat24 * u_xlat2.x;
            u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat18.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat18.xy = fract(u_xlat18.xy);
            u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
            u_xlat18.xy = floor(u_xlat18.xy);
            u_xlat3.x = (-u_xlat18.x) + u_xlat3.x;
            u_xlat18.x = u_xlat3.x * u_xlat18.y + u_xlat18.x;
            u_xlat26 = (-u_xlat2.x) * u_xlat24 + 1.0;
            u_xlat3.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat18.xxx;
            u_xlatb10.xz = lessThan(vec4(u_xlat10), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat24 = u_xlat2.x * u_xlat24 + -4.0;
            u_xlat24 = exp2(u_xlat24);
            u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
            u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat18.xxx;
            u_xlat2.xzw = (u_xlatb10.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb10.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb24 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb24 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb24){
                u_xlat2.x = float(0.0);
                u_xlat2.y = float(0.0);
                u_xlat2.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb24 = !!(u_xlat1.x>=0.0);
#else
                u_xlatb24 = u_xlat1.x>=0.0;
#endif
                if(u_xlatb24){
                    u_xlat3.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.zw = dFdx(u_xlat3.xy);
                    u_xlat3.xy = dFdy(u_xlat3.xy);
                    u_xlat24 = dot(u_xlat3.zw, u_xlat3.zw);
                    u_xlat26 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3 = vec4(u_xlat26) * u_xlat3;
                    u_xlat3 = u_xlat3 / vec4(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                    u_xlat26 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat11.x = sqrt(u_xlat24);
                    u_xlat27 = sqrt(u_xlat26);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.z);
                    u_xlat26 = inversesqrt(u_xlat26);
                    u_xlat26 = u_xlat26 * abs(u_xlat3.x);
                    u_xlat24 = u_xlat24 * u_xlat26;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat26 = u_xlat27 * u_xlat11.x;
                    u_xlat3.x = u_xlat24 * u_xlat26;
                    u_xlat11.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat27 = fract((-u_xlat11.x));
                    u_xlat11.z = u_xlat27 + 0.5;
                    u_xlat11.xy = fract(u_xlat11.xy);
                    u_xlat11.xy = u_xlat11.xy + vec2(0.5, 0.5);
                    u_xlat11.xyz = floor(u_xlat11.xyz);
                    u_xlat27 = (-u_xlat11.x) + u_xlat11.z;
                    u_xlat11.x = u_xlat27 * u_xlat11.y + u_xlat11.x;
                    u_xlat19 = (-u_xlat26) * u_xlat24 + 1.0;
                    u_xlat4.xyz = (-u_xlat11.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat11.xxx;
                    u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat6.xyz = u_xlat11.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat26 * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.zyy + u_xlat11.xxx;
                    u_xlat11.xyz = (u_xlatb3.z) ? u_xlat6.xyz : u_xlat4.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat5.xyz : u_xlat11.xyz;
                } else {
                    u_xlat2.x = float(0.0);
                    u_xlat2.y = float(0.0);
                    u_xlat2.z = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb2.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb2.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_7 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_7 : 0.0;
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_HIGH" "EMISSION_TYPE_TIME" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec2 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat8;
bvec3 u_xlatb8;
vec3 u_xlat9;
bvec3 u_xlatb9;
float u_xlat10;
vec2 u_xlat15;
vec2 u_xlat16;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
float u_xlat23;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb21){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb21){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb21){
        u_xlat21 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = max(u_xlat21, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb21){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat15.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat21 = dot(u_xlat15.xy, u_xlat15.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat21 = max(u_xlat21, u_xlat1.x);
        u_xlat21 = log2(u_xlat21);
        u_xlat21 = u_xlat21 * 0.5;
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat21 = u_xlat21 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = u_xlat1.x / u_xlat21;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb21){
        u_xlat1.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat2.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat2.xyxx).xy;
        u_xlatb21 = u_xlatb2.y || u_xlatb2.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (bool(u_xlatb21)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb21 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb21 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb21){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat21 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat21 = max(u_xlat21, u_xlat3.x);
            u_xlat21 = log2(u_xlat21);
            u_xlat21 = u_xlat21 * 0.5;
            u_xlat21 = max(u_xlat21, 0.0);
            u_xlat21 = u_xlat21 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat21);
            u_xlat21 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat9.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat23 = sqrt(u_xlat21);
            u_xlat3.x = sqrt(u_xlat9.x);
            u_xlat21 = inversesqrt(u_xlat21);
            u_xlat21 = u_xlat21 * abs(u_xlat2.z);
            u_xlat9.x = inversesqrt(u_xlat9.x);
            u_xlat2.x = u_xlat9.x * abs(u_xlat2.x);
            u_xlat21 = u_xlat21 * u_xlat2.x;
            u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
            u_xlat21 = sqrt(u_xlat21);
            u_xlat2.x = u_xlat23 * u_xlat3.x;
            u_xlat9.x = u_xlat21 * u_xlat2.x;
            u_xlat16.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat16.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat16.xy = fract(u_xlat16.xy);
            u_xlat16.xy = u_xlat16.xy + vec2(0.5, 0.5);
            u_xlat16.xy = floor(u_xlat16.xy);
            u_xlat3.x = (-u_xlat16.x) + u_xlat3.x;
            u_xlat16.x = u_xlat3.x * u_xlat16.y + u_xlat16.x;
            u_xlat23 = (-u_xlat2.x) * u_xlat21 + 1.0;
            u_xlat3.xyz = (-u_xlat16.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat23) * u_xlat3.xyz + u_xlat16.xxx;
            u_xlatb9.xz = lessThan(u_xlat9.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat16.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat21 = u_xlat2.x * u_xlat21 + -4.0;
            u_xlat21 = exp2(u_xlat21);
            u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
            u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat16.xxx;
            u_xlat2.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb21 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb21 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb21){
                u_xlat2.x = float(0.0);
                u_xlat2.y = float(0.0);
                u_xlat2.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb21 = !!(u_xlat1.x>=0.0);
#else
                u_xlatb21 = u_xlat1.x>=0.0;
#endif
                if(u_xlatb21){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat21 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat23 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat21 = max(u_xlat21, u_xlat23);
                    u_xlat21 = log2(u_xlat21);
                    u_xlat21 = u_xlat21 * 0.5;
                    u_xlat21 = max(u_xlat21, 0.0);
                    u_xlat21 = u_xlat21 + 1.0;
                    u_xlat23 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat23) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat23);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat21);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat21);
                    u_xlat21 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat8 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat23 = sqrt(u_xlat21);
                    u_xlat10 = sqrt(u_xlat8);
                    u_xlat21 = inversesqrt(u_xlat21);
                    u_xlat21 = u_xlat21 * abs(u_xlat3.x);
                    u_xlat8 = inversesqrt(u_xlat8);
                    u_xlat1.x = u_xlat8 * abs(u_xlat1.x);
                    u_xlat21 = u_xlat21 * u_xlat1.x;
                    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
                    u_xlat21 = sqrt(u_xlat21);
                    u_xlat1.x = u_xlat23 * u_xlat10;
                    u_xlat8 = u_xlat21 * u_xlat1.x;
                    u_xlat15.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat23 = fract((-u_xlat15.x));
                    u_xlat23 = u_xlat23 + 0.5;
                    u_xlat23 = floor(u_xlat23);
                    u_xlat15.xy = fract(u_xlat15.xy);
                    u_xlat15.xy = u_xlat15.xy + vec2(0.5, 0.5);
                    u_xlat15.xy = floor(u_xlat15.xy);
                    u_xlat23 = (-u_xlat15.x) + u_xlat23;
                    u_xlat15.x = u_xlat23 * u_xlat15.y + u_xlat15.x;
                    u_xlat22 = (-u_xlat1.x) * u_xlat21 + 1.0;
                    u_xlat3.xyz = (-u_xlat15.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz + u_xlat15.xxx;
                    u_xlatb8.xz = lessThan(vec4(u_xlat8), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat15.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat21 = u_xlat1.x * u_xlat21 + -4.0;
                    u_xlat21 = exp2(u_xlat21);
                    u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
                    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat15.xxx;
                    u_xlat1.xzw = (u_xlatb8.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb8.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat2.x = float(0.0);
                    u_xlat2.y = float(0.0);
                    u_xlat2.z = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_6.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat21 = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat21 = _InvertEmission * u_xlat21 + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_6.xyz * vec3(u_xlat21) + u_xlat10_0.xyz;
    u_xlat16_6.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_6.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2.x = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = (u_xlatb2.x) ? u_xlat16_1 : u_xlat16_0;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat9.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat9.xyz = u_xlat9.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat9.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb9.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_6.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb9.x) ? u_xlat16_6.x : 0.0;
    SV_Target0.w = 0.00392156886;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    SV_Target2.w = u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_HIGH" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump float _CutOff;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec3 u_xlatb2;
vec4 u_xlat3;
bvec3 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat10;
bvec3 u_xlatb10;
vec3 u_xlat11;
vec2 u_xlat18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat26;
float u_xlat27;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb24 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb24){
        u_xlatb2.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat1 = (u_xlatb2.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat1 = (u_xlatb2.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb24){
        u_xlat24 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = max(u_xlat24, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb2.x = !!(256.0<u_xlat24);
#else
        u_xlatb2.x = 256.0<u_xlat24;
#endif
        u_xlatb10.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat1 = (u_xlatb10.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb10.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb24){
        u_xlat2.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat18.xy = dFdx(u_xlat2.xy);
        u_xlat2.xy = dFdy(u_xlat2.xy);
        u_xlat24 = dot(u_xlat18.xy, u_xlat18.xy);
        u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
        u_xlat24 = max(u_xlat24, u_xlat2.x);
        u_xlat24 = log2(u_xlat24);
        u_xlat24 = u_xlat24 * 0.5;
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat24 = u_xlat24 + 1.0;
        u_xlat2.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = u_xlat2.x / u_xlat24;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2.x = !!(256.0<u_xlat24);
#else
        u_xlatb2.x = 256.0<u_xlat24;
#endif
        u_xlatb10.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat1 = (u_xlatb10.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb10.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb24){
        u_xlat1.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat2.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat2.xyxx).xy;
        u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (bool(u_xlatb24)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb24 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb24){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat24 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat24 = max(u_xlat24, u_xlat3.x);
            u_xlat24 = log2(u_xlat24);
            u_xlat24 = u_xlat24 * 0.5;
            u_xlat24 = max(u_xlat24, 0.0);
            u_xlat24 = u_xlat24 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat24);
            u_xlat24 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat10.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat26 = sqrt(u_xlat24);
            u_xlat3.x = sqrt(u_xlat10.x);
            u_xlat24 = inversesqrt(u_xlat24);
            u_xlat24 = u_xlat24 * abs(u_xlat2.z);
            u_xlat10.x = inversesqrt(u_xlat10.x);
            u_xlat2.x = u_xlat10.x * abs(u_xlat2.x);
            u_xlat24 = u_xlat24 * u_xlat2.x;
            u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
            u_xlat24 = sqrt(u_xlat24);
            u_xlat2.x = u_xlat26 * u_xlat3.x;
            u_xlat10.x = u_xlat24 * u_xlat2.x;
            u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat18.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat18.xy = fract(u_xlat18.xy);
            u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
            u_xlat18.xy = floor(u_xlat18.xy);
            u_xlat3.x = (-u_xlat18.x) + u_xlat3.x;
            u_xlat18.x = u_xlat3.x * u_xlat18.y + u_xlat18.x;
            u_xlat26 = (-u_xlat2.x) * u_xlat24 + 1.0;
            u_xlat3.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat18.xxx;
            u_xlatb10.xz = lessThan(u_xlat10.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat24 = u_xlat2.x * u_xlat24 + -4.0;
            u_xlat24 = exp2(u_xlat24);
            u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
            u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat18.xxx;
            u_xlat2.xzw = (u_xlatb10.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb10.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb24 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb24 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb24){
                u_xlat2.x = float(0.0);
                u_xlat2.y = float(0.0);
                u_xlat2.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb24 = !!(u_xlat1.x>=0.0);
#else
                u_xlatb24 = u_xlat1.x>=0.0;
#endif
                if(u_xlatb24){
                    u_xlat3.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.zw = dFdx(u_xlat3.xy);
                    u_xlat3.xy = dFdy(u_xlat3.xy);
                    u_xlat24 = dot(u_xlat3.zw, u_xlat3.zw);
                    u_xlat26 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3 = vec4(u_xlat26) * u_xlat3;
                    u_xlat3 = u_xlat3 / vec4(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                    u_xlat26 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat11.x = sqrt(u_xlat24);
                    u_xlat27 = sqrt(u_xlat26);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.z);
                    u_xlat26 = inversesqrt(u_xlat26);
                    u_xlat26 = u_xlat26 * abs(u_xlat3.x);
                    u_xlat24 = u_xlat24 * u_xlat26;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat26 = u_xlat27 * u_xlat11.x;
                    u_xlat3.x = u_xlat24 * u_xlat26;
                    u_xlat11.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat27 = fract((-u_xlat11.x));
                    u_xlat11.z = u_xlat27 + 0.5;
                    u_xlat11.xy = fract(u_xlat11.xy);
                    u_xlat11.xy = u_xlat11.xy + vec2(0.5, 0.5);
                    u_xlat11.xyz = floor(u_xlat11.xyz);
                    u_xlat27 = (-u_xlat11.x) + u_xlat11.z;
                    u_xlat11.x = u_xlat27 * u_xlat11.y + u_xlat11.x;
                    u_xlat19 = (-u_xlat26) * u_xlat24 + 1.0;
                    u_xlat4.xyz = (-u_xlat11.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat11.xxx;
                    u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat6.xyz = u_xlat11.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat26 * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.zyy + u_xlat11.xxx;
                    u_xlat11.xyz = (u_xlatb3.z) ? u_xlat6.xyz : u_xlat4.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat5.xyz : u_xlat11.xyz;
                } else {
                    u_xlat2.x = float(0.0);
                    u_xlat2.y = float(0.0);
                    u_xlat2.z = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb2.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb2.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_7.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat24 = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat24 = _InvertEmission * u_xlat24 + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_7.xyz * vec3(u_xlat24) + u_xlat10_0.xyz;
    u_xlat16_7.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_7.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2.x = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = (u_xlatb2.x) ? u_xlat16_1 : u_xlat16_0;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat10.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat10.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb10.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_7.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb10.x) ? u_xlat16_7.x : 0.0;
    SV_Target0.w = 0.00392156886;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    SV_Target2.w = u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_HIGH" "EMISSION_TYPE_NORMAL" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec2 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat8;
bvec3 u_xlatb8;
vec3 u_xlat9;
bvec3 u_xlatb9;
float u_xlat10;
vec2 u_xlat15;
vec2 u_xlat16;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
float u_xlat23;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb21){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb21){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb21){
        u_xlat21 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = max(u_xlat21, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb21){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat15.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat21 = dot(u_xlat15.xy, u_xlat15.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat21 = max(u_xlat21, u_xlat1.x);
        u_xlat21 = log2(u_xlat21);
        u_xlat21 = u_xlat21 * 0.5;
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat21 = u_xlat21 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = u_xlat1.x / u_xlat21;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb21){
        u_xlat1.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat2.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat2.xyxx).xy;
        u_xlatb21 = u_xlatb2.y || u_xlatb2.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (bool(u_xlatb21)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb21 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb21 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb21){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat21 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat21 = max(u_xlat21, u_xlat3.x);
            u_xlat21 = log2(u_xlat21);
            u_xlat21 = u_xlat21 * 0.5;
            u_xlat21 = max(u_xlat21, 0.0);
            u_xlat21 = u_xlat21 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat21);
            u_xlat21 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat9.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat23 = sqrt(u_xlat21);
            u_xlat3.x = sqrt(u_xlat9.x);
            u_xlat21 = inversesqrt(u_xlat21);
            u_xlat21 = u_xlat21 * abs(u_xlat2.z);
            u_xlat9.x = inversesqrt(u_xlat9.x);
            u_xlat2.x = u_xlat9.x * abs(u_xlat2.x);
            u_xlat21 = u_xlat21 * u_xlat2.x;
            u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
            u_xlat21 = sqrt(u_xlat21);
            u_xlat2.x = u_xlat23 * u_xlat3.x;
            u_xlat9.x = u_xlat21 * u_xlat2.x;
            u_xlat16.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat16.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat16.xy = fract(u_xlat16.xy);
            u_xlat16.xy = u_xlat16.xy + vec2(0.5, 0.5);
            u_xlat16.xy = floor(u_xlat16.xy);
            u_xlat3.x = (-u_xlat16.x) + u_xlat3.x;
            u_xlat16.x = u_xlat3.x * u_xlat16.y + u_xlat16.x;
            u_xlat23 = (-u_xlat2.x) * u_xlat21 + 1.0;
            u_xlat3.xyz = (-u_xlat16.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat23) * u_xlat3.xyz + u_xlat16.xxx;
            u_xlatb9.xz = lessThan(u_xlat9.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat16.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat21 = u_xlat2.x * u_xlat21 + -4.0;
            u_xlat21 = exp2(u_xlat21);
            u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
            u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat16.xxx;
            u_xlat2.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb21 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb21 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb21){
                u_xlat2.x = float(0.0);
                u_xlat2.y = float(0.0);
                u_xlat2.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb21 = !!(u_xlat1.x>=0.0);
#else
                u_xlatb21 = u_xlat1.x>=0.0;
#endif
                if(u_xlatb21){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat21 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat23 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat21 = max(u_xlat21, u_xlat23);
                    u_xlat21 = log2(u_xlat21);
                    u_xlat21 = u_xlat21 * 0.5;
                    u_xlat21 = max(u_xlat21, 0.0);
                    u_xlat21 = u_xlat21 + 1.0;
                    u_xlat23 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat23) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat23);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat21);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat21);
                    u_xlat21 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat8 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat23 = sqrt(u_xlat21);
                    u_xlat10 = sqrt(u_xlat8);
                    u_xlat21 = inversesqrt(u_xlat21);
                    u_xlat21 = u_xlat21 * abs(u_xlat3.x);
                    u_xlat8 = inversesqrt(u_xlat8);
                    u_xlat1.x = u_xlat8 * abs(u_xlat1.x);
                    u_xlat21 = u_xlat21 * u_xlat1.x;
                    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
                    u_xlat21 = sqrt(u_xlat21);
                    u_xlat1.x = u_xlat23 * u_xlat10;
                    u_xlat8 = u_xlat21 * u_xlat1.x;
                    u_xlat15.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat23 = fract((-u_xlat15.x));
                    u_xlat23 = u_xlat23 + 0.5;
                    u_xlat23 = floor(u_xlat23);
                    u_xlat15.xy = fract(u_xlat15.xy);
                    u_xlat15.xy = u_xlat15.xy + vec2(0.5, 0.5);
                    u_xlat15.xy = floor(u_xlat15.xy);
                    u_xlat23 = (-u_xlat15.x) + u_xlat23;
                    u_xlat15.x = u_xlat23 * u_xlat15.y + u_xlat15.x;
                    u_xlat22 = (-u_xlat1.x) * u_xlat21 + 1.0;
                    u_xlat3.xyz = (-u_xlat15.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz + u_xlat15.xxx;
                    u_xlatb8.xz = lessThan(vec4(u_xlat8), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat15.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat21 = u_xlat1.x * u_xlat21 + -4.0;
                    u_xlat21 = exp2(u_xlat21);
                    u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
                    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat15.xxx;
                    u_xlat1.xzw = (u_xlatb8.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb8.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat2.x = float(0.0);
                    u_xlat2.y = float(0.0);
                    u_xlat2.z = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_6.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat21 = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat21 = _InvertEmission * u_xlat21 + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_6.xyz * vec3(u_xlat21) + u_xlat10_0.xyz;
    u_xlat16_6.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_6.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2.x = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = (u_xlatb2.x) ? u_xlat16_1 : u_xlat16_0;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat9.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat9.xyz = u_xlat9.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat9.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb9.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_6.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb9.x) ? u_xlat16_6.x : 0.0;
    SV_Target0.w = 0.00392156886;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    SV_Target2.w = u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_MIDDLE" "EMISSION_TYPE_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat8;
bvec3 u_xlatb8;
float u_xlat9;
bvec3 u_xlatb9;
float u_xlat10;
vec2 u_xlat15;
vec2 u_xlat16;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
float u_xlat23;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb21){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb21){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb21){
        u_xlat21 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = max(u_xlat21, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb21){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat15.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat21 = dot(u_xlat15.xy, u_xlat15.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat21 = max(u_xlat21, u_xlat1.x);
        u_xlat21 = log2(u_xlat21);
        u_xlat21 = u_xlat21 * 0.5;
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat21 = u_xlat21 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = u_xlat1.x / u_xlat21;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb21){
        u_xlat1.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat2.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat2.xyxx).xy;
        u_xlatb21 = u_xlatb2.y || u_xlatb2.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (bool(u_xlatb21)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb21 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb21 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb21){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat21 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat21 = max(u_xlat21, u_xlat3.x);
            u_xlat21 = log2(u_xlat21);
            u_xlat21 = u_xlat21 * 0.5;
            u_xlat21 = max(u_xlat21, 0.0);
            u_xlat21 = u_xlat21 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat21);
            u_xlat21 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat9 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat23 = sqrt(u_xlat21);
            u_xlat3.x = sqrt(u_xlat9);
            u_xlat21 = inversesqrt(u_xlat21);
            u_xlat21 = u_xlat21 * abs(u_xlat2.z);
            u_xlat9 = inversesqrt(u_xlat9);
            u_xlat2.x = u_xlat9 * abs(u_xlat2.x);
            u_xlat21 = u_xlat21 * u_xlat2.x;
            u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
            u_xlat21 = sqrt(u_xlat21);
            u_xlat2.x = u_xlat23 * u_xlat3.x;
            u_xlat9 = u_xlat21 * u_xlat2.x;
            u_xlat16.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat16.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat16.xy = fract(u_xlat16.xy);
            u_xlat16.xy = u_xlat16.xy + vec2(0.5, 0.5);
            u_xlat16.xy = floor(u_xlat16.xy);
            u_xlat3.x = (-u_xlat16.x) + u_xlat3.x;
            u_xlat16.x = u_xlat3.x * u_xlat16.y + u_xlat16.x;
            u_xlat23 = (-u_xlat2.x) * u_xlat21 + 1.0;
            u_xlat3.xyz = (-u_xlat16.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat23) * u_xlat3.xyz + u_xlat16.xxx;
            u_xlatb9.xz = lessThan(vec4(u_xlat9), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat16.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat21 = u_xlat2.x * u_xlat21 + -4.0;
            u_xlat21 = exp2(u_xlat21);
            u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
            u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat16.xxx;
            u_xlat2.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb21 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb21 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb21){
                u_xlat2.x = float(0.0);
                u_xlat2.y = float(0.0);
                u_xlat2.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb21 = !!(u_xlat1.x>=0.0);
#else
                u_xlatb21 = u_xlat1.x>=0.0;
#endif
                if(u_xlatb21){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat21 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat23 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat21 = max(u_xlat21, u_xlat23);
                    u_xlat21 = log2(u_xlat21);
                    u_xlat21 = u_xlat21 * 0.5;
                    u_xlat21 = max(u_xlat21, 0.0);
                    u_xlat21 = u_xlat21 + 1.0;
                    u_xlat23 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat23) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat23);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat21);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat21);
                    u_xlat21 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat8 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat23 = sqrt(u_xlat21);
                    u_xlat10 = sqrt(u_xlat8);
                    u_xlat21 = inversesqrt(u_xlat21);
                    u_xlat21 = u_xlat21 * abs(u_xlat3.x);
                    u_xlat8 = inversesqrt(u_xlat8);
                    u_xlat1.x = u_xlat8 * abs(u_xlat1.x);
                    u_xlat21 = u_xlat21 * u_xlat1.x;
                    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
                    u_xlat21 = sqrt(u_xlat21);
                    u_xlat1.x = u_xlat23 * u_xlat10;
                    u_xlat8 = u_xlat21 * u_xlat1.x;
                    u_xlat15.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat23 = fract((-u_xlat15.x));
                    u_xlat23 = u_xlat23 + 0.5;
                    u_xlat23 = floor(u_xlat23);
                    u_xlat15.xy = fract(u_xlat15.xy);
                    u_xlat15.xy = u_xlat15.xy + vec2(0.5, 0.5);
                    u_xlat15.xy = floor(u_xlat15.xy);
                    u_xlat23 = (-u_xlat15.x) + u_xlat23;
                    u_xlat15.x = u_xlat23 * u_xlat15.y + u_xlat15.x;
                    u_xlat22 = (-u_xlat1.x) * u_xlat21 + 1.0;
                    u_xlat3.xyz = (-u_xlat15.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz + u_xlat15.xxx;
                    u_xlatb8.xz = lessThan(vec4(u_xlat8), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat15.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat21 = u_xlat1.x * u_xlat21 + -4.0;
                    u_xlat21 = exp2(u_xlat21);
                    u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
                    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat15.xxx;
                    u_xlat1.xzw = (u_xlatb8.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb8.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat2.x = float(0.0);
                    u_xlat2.y = float(0.0);
                    u_xlat2.z = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_6 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_6 : 0.0;
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_MIDDLE" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
bvec3 u_xlatb2;
vec4 u_xlat3;
bvec3 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump float u_xlat16_7;
float u_xlat10;
bvec3 u_xlatb10;
vec3 u_xlat11;
vec2 u_xlat18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat26;
float u_xlat27;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1<0.0);
#else
    u_xlatb24 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb24){
        u_xlatb2.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat1 = (u_xlatb2.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat1 = (u_xlatb2.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb24){
        u_xlat24 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = max(u_xlat24, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb2.x = !!(256.0<u_xlat24);
#else
        u_xlatb2.x = 256.0<u_xlat24;
#endif
        u_xlatb10.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat1 = (u_xlatb10.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb10.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb24){
        u_xlat2.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat18.xy = dFdx(u_xlat2.xy);
        u_xlat2.xy = dFdy(u_xlat2.xy);
        u_xlat24 = dot(u_xlat18.xy, u_xlat18.xy);
        u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
        u_xlat24 = max(u_xlat24, u_xlat2.x);
        u_xlat24 = log2(u_xlat24);
        u_xlat24 = u_xlat24 * 0.5;
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat24 = u_xlat24 + 1.0;
        u_xlat2.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = u_xlat2.x / u_xlat24;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2.x = !!(256.0<u_xlat24);
#else
        u_xlatb2.x = 256.0<u_xlat24;
#endif
        u_xlatb10.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat1 = (u_xlatb10.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb10.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb24){
        u_xlat1.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat2.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat2.xyxx).xy;
        u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (bool(u_xlatb24)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb24 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb24){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat24 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat24 = max(u_xlat24, u_xlat3.x);
            u_xlat24 = log2(u_xlat24);
            u_xlat24 = u_xlat24 * 0.5;
            u_xlat24 = max(u_xlat24, 0.0);
            u_xlat24 = u_xlat24 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat24);
            u_xlat24 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat10 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat26 = sqrt(u_xlat24);
            u_xlat3.x = sqrt(u_xlat10);
            u_xlat24 = inversesqrt(u_xlat24);
            u_xlat24 = u_xlat24 * abs(u_xlat2.z);
            u_xlat10 = inversesqrt(u_xlat10);
            u_xlat2.x = u_xlat10 * abs(u_xlat2.x);
            u_xlat24 = u_xlat24 * u_xlat2.x;
            u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
            u_xlat24 = sqrt(u_xlat24);
            u_xlat2.x = u_xlat26 * u_xlat3.x;
            u_xlat10 = u_xlat24 * u_xlat2.x;
            u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat18.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat18.xy = fract(u_xlat18.xy);
            u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
            u_xlat18.xy = floor(u_xlat18.xy);
            u_xlat3.x = (-u_xlat18.x) + u_xlat3.x;
            u_xlat18.x = u_xlat3.x * u_xlat18.y + u_xlat18.x;
            u_xlat26 = (-u_xlat2.x) * u_xlat24 + 1.0;
            u_xlat3.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat18.xxx;
            u_xlatb10.xz = lessThan(vec4(u_xlat10), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat24 = u_xlat2.x * u_xlat24 + -4.0;
            u_xlat24 = exp2(u_xlat24);
            u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
            u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat18.xxx;
            u_xlat2.xzw = (u_xlatb10.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb10.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb24 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb24 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb24){
                u_xlat2.x = float(0.0);
                u_xlat2.y = float(0.0);
                u_xlat2.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb24 = !!(u_xlat1.x>=0.0);
#else
                u_xlatb24 = u_xlat1.x>=0.0;
#endif
                if(u_xlatb24){
                    u_xlat3.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.zw = dFdx(u_xlat3.xy);
                    u_xlat3.xy = dFdy(u_xlat3.xy);
                    u_xlat24 = dot(u_xlat3.zw, u_xlat3.zw);
                    u_xlat26 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3 = vec4(u_xlat26) * u_xlat3;
                    u_xlat3 = u_xlat3 / vec4(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                    u_xlat26 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat11.x = sqrt(u_xlat24);
                    u_xlat27 = sqrt(u_xlat26);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.z);
                    u_xlat26 = inversesqrt(u_xlat26);
                    u_xlat26 = u_xlat26 * abs(u_xlat3.x);
                    u_xlat24 = u_xlat24 * u_xlat26;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat26 = u_xlat27 * u_xlat11.x;
                    u_xlat3.x = u_xlat24 * u_xlat26;
                    u_xlat11.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat27 = fract((-u_xlat11.x));
                    u_xlat11.z = u_xlat27 + 0.5;
                    u_xlat11.xy = fract(u_xlat11.xy);
                    u_xlat11.xy = u_xlat11.xy + vec2(0.5, 0.5);
                    u_xlat11.xyz = floor(u_xlat11.xyz);
                    u_xlat27 = (-u_xlat11.x) + u_xlat11.z;
                    u_xlat11.x = u_xlat27 * u_xlat11.y + u_xlat11.x;
                    u_xlat19 = (-u_xlat26) * u_xlat24 + 1.0;
                    u_xlat4.xyz = (-u_xlat11.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat11.xxx;
                    u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat6.xyz = u_xlat11.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat26 * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.zyy + u_xlat11.xxx;
                    u_xlat11.xyz = (u_xlatb3.z) ? u_xlat6.xyz : u_xlat4.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat5.xyz : u_xlat11.xyz;
                } else {
                    u_xlat2.x = float(0.0);
                    u_xlat2.y = float(0.0);
                    u_xlat2.z = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb2.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb2.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_7 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_7 : 0.0;
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_MIDDLE" "EMISSION_TYPE_TIME" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec2 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat8;
bvec3 u_xlatb8;
vec3 u_xlat9;
bvec3 u_xlatb9;
float u_xlat10;
vec2 u_xlat15;
vec2 u_xlat16;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
float u_xlat23;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb21){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb21){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb21){
        u_xlat21 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = max(u_xlat21, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb21){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat15.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat21 = dot(u_xlat15.xy, u_xlat15.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat21 = max(u_xlat21, u_xlat1.x);
        u_xlat21 = log2(u_xlat21);
        u_xlat21 = u_xlat21 * 0.5;
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat21 = u_xlat21 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = u_xlat1.x / u_xlat21;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb21){
        u_xlat1.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat2.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat2.xyxx).xy;
        u_xlatb21 = u_xlatb2.y || u_xlatb2.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (bool(u_xlatb21)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb21 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb21 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb21){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat21 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat21 = max(u_xlat21, u_xlat3.x);
            u_xlat21 = log2(u_xlat21);
            u_xlat21 = u_xlat21 * 0.5;
            u_xlat21 = max(u_xlat21, 0.0);
            u_xlat21 = u_xlat21 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat21);
            u_xlat21 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat9.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat23 = sqrt(u_xlat21);
            u_xlat3.x = sqrt(u_xlat9.x);
            u_xlat21 = inversesqrt(u_xlat21);
            u_xlat21 = u_xlat21 * abs(u_xlat2.z);
            u_xlat9.x = inversesqrt(u_xlat9.x);
            u_xlat2.x = u_xlat9.x * abs(u_xlat2.x);
            u_xlat21 = u_xlat21 * u_xlat2.x;
            u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
            u_xlat21 = sqrt(u_xlat21);
            u_xlat2.x = u_xlat23 * u_xlat3.x;
            u_xlat9.x = u_xlat21 * u_xlat2.x;
            u_xlat16.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat16.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat16.xy = fract(u_xlat16.xy);
            u_xlat16.xy = u_xlat16.xy + vec2(0.5, 0.5);
            u_xlat16.xy = floor(u_xlat16.xy);
            u_xlat3.x = (-u_xlat16.x) + u_xlat3.x;
            u_xlat16.x = u_xlat3.x * u_xlat16.y + u_xlat16.x;
            u_xlat23 = (-u_xlat2.x) * u_xlat21 + 1.0;
            u_xlat3.xyz = (-u_xlat16.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat23) * u_xlat3.xyz + u_xlat16.xxx;
            u_xlatb9.xz = lessThan(u_xlat9.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat16.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat21 = u_xlat2.x * u_xlat21 + -4.0;
            u_xlat21 = exp2(u_xlat21);
            u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
            u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat16.xxx;
            u_xlat2.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb21 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb21 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb21){
                u_xlat2.x = float(0.0);
                u_xlat2.y = float(0.0);
                u_xlat2.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb21 = !!(u_xlat1.x>=0.0);
#else
                u_xlatb21 = u_xlat1.x>=0.0;
#endif
                if(u_xlatb21){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat21 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat23 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat21 = max(u_xlat21, u_xlat23);
                    u_xlat21 = log2(u_xlat21);
                    u_xlat21 = u_xlat21 * 0.5;
                    u_xlat21 = max(u_xlat21, 0.0);
                    u_xlat21 = u_xlat21 + 1.0;
                    u_xlat23 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat23) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat23);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat21);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat21);
                    u_xlat21 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat8 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat23 = sqrt(u_xlat21);
                    u_xlat10 = sqrt(u_xlat8);
                    u_xlat21 = inversesqrt(u_xlat21);
                    u_xlat21 = u_xlat21 * abs(u_xlat3.x);
                    u_xlat8 = inversesqrt(u_xlat8);
                    u_xlat1.x = u_xlat8 * abs(u_xlat1.x);
                    u_xlat21 = u_xlat21 * u_xlat1.x;
                    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
                    u_xlat21 = sqrt(u_xlat21);
                    u_xlat1.x = u_xlat23 * u_xlat10;
                    u_xlat8 = u_xlat21 * u_xlat1.x;
                    u_xlat15.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat23 = fract((-u_xlat15.x));
                    u_xlat23 = u_xlat23 + 0.5;
                    u_xlat23 = floor(u_xlat23);
                    u_xlat15.xy = fract(u_xlat15.xy);
                    u_xlat15.xy = u_xlat15.xy + vec2(0.5, 0.5);
                    u_xlat15.xy = floor(u_xlat15.xy);
                    u_xlat23 = (-u_xlat15.x) + u_xlat23;
                    u_xlat15.x = u_xlat23 * u_xlat15.y + u_xlat15.x;
                    u_xlat22 = (-u_xlat1.x) * u_xlat21 + 1.0;
                    u_xlat3.xyz = (-u_xlat15.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz + u_xlat15.xxx;
                    u_xlatb8.xz = lessThan(vec4(u_xlat8), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat15.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat21 = u_xlat1.x * u_xlat21 + -4.0;
                    u_xlat21 = exp2(u_xlat21);
                    u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
                    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat15.xxx;
                    u_xlat1.xzw = (u_xlatb8.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb8.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat2.x = float(0.0);
                    u_xlat2.y = float(0.0);
                    u_xlat2.z = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_6.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat21 = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat21 = _InvertEmission * u_xlat21 + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_6.xyz * vec3(u_xlat21) + u_xlat10_0.xyz;
    u_xlat16_6.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_6.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2.x = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = (u_xlatb2.x) ? u_xlat16_1 : u_xlat16_0;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat9.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat9.xyz = u_xlat9.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat9.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb9.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_6.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb9.x) ? u_xlat16_6.x : 0.0;
    SV_Target0.w = 0.00392156886;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    SV_Target2.w = u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_MIDDLE" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump float _CutOff;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec3 u_xlatb2;
vec4 u_xlat3;
bvec3 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat10;
bvec3 u_xlatb10;
vec3 u_xlat11;
vec2 u_xlat18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat26;
float u_xlat27;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb24 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb24){
        u_xlatb2.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat1 = (u_xlatb2.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat1 = (u_xlatb2.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb24){
        u_xlat24 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = max(u_xlat24, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb2.x = !!(256.0<u_xlat24);
#else
        u_xlatb2.x = 256.0<u_xlat24;
#endif
        u_xlatb10.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat1 = (u_xlatb10.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb10.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb24){
        u_xlat2.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat18.xy = dFdx(u_xlat2.xy);
        u_xlat2.xy = dFdy(u_xlat2.xy);
        u_xlat24 = dot(u_xlat18.xy, u_xlat18.xy);
        u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
        u_xlat24 = max(u_xlat24, u_xlat2.x);
        u_xlat24 = log2(u_xlat24);
        u_xlat24 = u_xlat24 * 0.5;
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat24 = u_xlat24 + 1.0;
        u_xlat2.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = u_xlat2.x / u_xlat24;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2.x = !!(256.0<u_xlat24);
#else
        u_xlatb2.x = 256.0<u_xlat24;
#endif
        u_xlatb10.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat1 = (u_xlatb10.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb10.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb24){
        u_xlat1.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat2.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat2.xyxx).xy;
        u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (bool(u_xlatb24)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb24 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb24){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat24 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat24 = max(u_xlat24, u_xlat3.x);
            u_xlat24 = log2(u_xlat24);
            u_xlat24 = u_xlat24 * 0.5;
            u_xlat24 = max(u_xlat24, 0.0);
            u_xlat24 = u_xlat24 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat24);
            u_xlat24 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat10.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat26 = sqrt(u_xlat24);
            u_xlat3.x = sqrt(u_xlat10.x);
            u_xlat24 = inversesqrt(u_xlat24);
            u_xlat24 = u_xlat24 * abs(u_xlat2.z);
            u_xlat10.x = inversesqrt(u_xlat10.x);
            u_xlat2.x = u_xlat10.x * abs(u_xlat2.x);
            u_xlat24 = u_xlat24 * u_xlat2.x;
            u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
            u_xlat24 = sqrt(u_xlat24);
            u_xlat2.x = u_xlat26 * u_xlat3.x;
            u_xlat10.x = u_xlat24 * u_xlat2.x;
            u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat18.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat18.xy = fract(u_xlat18.xy);
            u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
            u_xlat18.xy = floor(u_xlat18.xy);
            u_xlat3.x = (-u_xlat18.x) + u_xlat3.x;
            u_xlat18.x = u_xlat3.x * u_xlat18.y + u_xlat18.x;
            u_xlat26 = (-u_xlat2.x) * u_xlat24 + 1.0;
            u_xlat3.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat18.xxx;
            u_xlatb10.xz = lessThan(u_xlat10.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat24 = u_xlat2.x * u_xlat24 + -4.0;
            u_xlat24 = exp2(u_xlat24);
            u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
            u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat18.xxx;
            u_xlat2.xzw = (u_xlatb10.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb10.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb24 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb24 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb24){
                u_xlat2.x = float(0.0);
                u_xlat2.y = float(0.0);
                u_xlat2.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb24 = !!(u_xlat1.x>=0.0);
#else
                u_xlatb24 = u_xlat1.x>=0.0;
#endif
                if(u_xlatb24){
                    u_xlat3.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.zw = dFdx(u_xlat3.xy);
                    u_xlat3.xy = dFdy(u_xlat3.xy);
                    u_xlat24 = dot(u_xlat3.zw, u_xlat3.zw);
                    u_xlat26 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3 = vec4(u_xlat26) * u_xlat3;
                    u_xlat3 = u_xlat3 / vec4(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                    u_xlat26 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat11.x = sqrt(u_xlat24);
                    u_xlat27 = sqrt(u_xlat26);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.z);
                    u_xlat26 = inversesqrt(u_xlat26);
                    u_xlat26 = u_xlat26 * abs(u_xlat3.x);
                    u_xlat24 = u_xlat24 * u_xlat26;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat26 = u_xlat27 * u_xlat11.x;
                    u_xlat3.x = u_xlat24 * u_xlat26;
                    u_xlat11.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat27 = fract((-u_xlat11.x));
                    u_xlat11.z = u_xlat27 + 0.5;
                    u_xlat11.xy = fract(u_xlat11.xy);
                    u_xlat11.xy = u_xlat11.xy + vec2(0.5, 0.5);
                    u_xlat11.xyz = floor(u_xlat11.xyz);
                    u_xlat27 = (-u_xlat11.x) + u_xlat11.z;
                    u_xlat11.x = u_xlat27 * u_xlat11.y + u_xlat11.x;
                    u_xlat19 = (-u_xlat26) * u_xlat24 + 1.0;
                    u_xlat4.xyz = (-u_xlat11.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat11.xxx;
                    u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat6.xyz = u_xlat11.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat26 * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.zyy + u_xlat11.xxx;
                    u_xlat11.xyz = (u_xlatb3.z) ? u_xlat6.xyz : u_xlat4.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat5.xyz : u_xlat11.xyz;
                } else {
                    u_xlat2.x = float(0.0);
                    u_xlat2.y = float(0.0);
                    u_xlat2.z = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb2.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb2.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_7.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat24 = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat24 = _InvertEmission * u_xlat24 + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_7.xyz * vec3(u_xlat24) + u_xlat10_0.xyz;
    u_xlat16_7.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_7.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2.x = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = (u_xlatb2.x) ? u_xlat16_1 : u_xlat16_0;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat10.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat10.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb10.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_7.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb10.x) ? u_xlat16_7.x : 0.0;
    SV_Target0.w = 0.00392156886;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    SV_Target2.w = u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_MIDDLE" "EMISSION_TYPE_NORMAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec2 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat8;
bvec3 u_xlatb8;
vec3 u_xlat9;
bvec3 u_xlatb9;
float u_xlat10;
vec2 u_xlat15;
vec2 u_xlat16;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
float u_xlat23;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb21){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb21){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb21){
        u_xlat21 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = max(u_xlat21, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb21){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat15.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat21 = dot(u_xlat15.xy, u_xlat15.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat21 = max(u_xlat21, u_xlat1.x);
        u_xlat21 = log2(u_xlat21);
        u_xlat21 = u_xlat21 * 0.5;
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat21 = u_xlat21 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = u_xlat1.x / u_xlat21;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb21){
        u_xlat1.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat2.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat2.xyxx).xy;
        u_xlatb21 = u_xlatb2.y || u_xlatb2.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (bool(u_xlatb21)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb21 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb21 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb21){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat21 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat21 = max(u_xlat21, u_xlat3.x);
            u_xlat21 = log2(u_xlat21);
            u_xlat21 = u_xlat21 * 0.5;
            u_xlat21 = max(u_xlat21, 0.0);
            u_xlat21 = u_xlat21 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat21);
            u_xlat21 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat9.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat23 = sqrt(u_xlat21);
            u_xlat3.x = sqrt(u_xlat9.x);
            u_xlat21 = inversesqrt(u_xlat21);
            u_xlat21 = u_xlat21 * abs(u_xlat2.z);
            u_xlat9.x = inversesqrt(u_xlat9.x);
            u_xlat2.x = u_xlat9.x * abs(u_xlat2.x);
            u_xlat21 = u_xlat21 * u_xlat2.x;
            u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
            u_xlat21 = sqrt(u_xlat21);
            u_xlat2.x = u_xlat23 * u_xlat3.x;
            u_xlat9.x = u_xlat21 * u_xlat2.x;
            u_xlat16.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat16.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat16.xy = fract(u_xlat16.xy);
            u_xlat16.xy = u_xlat16.xy + vec2(0.5, 0.5);
            u_xlat16.xy = floor(u_xlat16.xy);
            u_xlat3.x = (-u_xlat16.x) + u_xlat3.x;
            u_xlat16.x = u_xlat3.x * u_xlat16.y + u_xlat16.x;
            u_xlat23 = (-u_xlat2.x) * u_xlat21 + 1.0;
            u_xlat3.xyz = (-u_xlat16.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat23) * u_xlat3.xyz + u_xlat16.xxx;
            u_xlatb9.xz = lessThan(u_xlat9.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat16.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat21 = u_xlat2.x * u_xlat21 + -4.0;
            u_xlat21 = exp2(u_xlat21);
            u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
            u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat16.xxx;
            u_xlat2.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb21 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb21 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb21){
                u_xlat2.x = float(0.0);
                u_xlat2.y = float(0.0);
                u_xlat2.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb21 = !!(u_xlat1.x>=0.0);
#else
                u_xlatb21 = u_xlat1.x>=0.0;
#endif
                if(u_xlatb21){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat21 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat23 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat21 = max(u_xlat21, u_xlat23);
                    u_xlat21 = log2(u_xlat21);
                    u_xlat21 = u_xlat21 * 0.5;
                    u_xlat21 = max(u_xlat21, 0.0);
                    u_xlat21 = u_xlat21 + 1.0;
                    u_xlat23 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat23) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat23);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat21);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat21);
                    u_xlat21 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat8 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat23 = sqrt(u_xlat21);
                    u_xlat10 = sqrt(u_xlat8);
                    u_xlat21 = inversesqrt(u_xlat21);
                    u_xlat21 = u_xlat21 * abs(u_xlat3.x);
                    u_xlat8 = inversesqrt(u_xlat8);
                    u_xlat1.x = u_xlat8 * abs(u_xlat1.x);
                    u_xlat21 = u_xlat21 * u_xlat1.x;
                    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
                    u_xlat21 = sqrt(u_xlat21);
                    u_xlat1.x = u_xlat23 * u_xlat10;
                    u_xlat8 = u_xlat21 * u_xlat1.x;
                    u_xlat15.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat23 = fract((-u_xlat15.x));
                    u_xlat23 = u_xlat23 + 0.5;
                    u_xlat23 = floor(u_xlat23);
                    u_xlat15.xy = fract(u_xlat15.xy);
                    u_xlat15.xy = u_xlat15.xy + vec2(0.5, 0.5);
                    u_xlat15.xy = floor(u_xlat15.xy);
                    u_xlat23 = (-u_xlat15.x) + u_xlat23;
                    u_xlat15.x = u_xlat23 * u_xlat15.y + u_xlat15.x;
                    u_xlat22 = (-u_xlat1.x) * u_xlat21 + 1.0;
                    u_xlat3.xyz = (-u_xlat15.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz + u_xlat15.xxx;
                    u_xlatb8.xz = lessThan(vec4(u_xlat8), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat15.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat21 = u_xlat1.x * u_xlat21 + -4.0;
                    u_xlat21 = exp2(u_xlat21);
                    u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
                    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat15.xxx;
                    u_xlat1.xzw = (u_xlatb8.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb8.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat2.x = float(0.0);
                    u_xlat2.y = float(0.0);
                    u_xlat2.z = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_6.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat21 = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat21 = _InvertEmission * u_xlat21 + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_6.xyz * vec3(u_xlat21) + u_xlat10_0.xyz;
    u_xlat16_6.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_6.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2.x = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = (u_xlatb2.x) ? u_xlat16_1 : u_xlat16_0;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat9.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat9.xyz = u_xlat9.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat9.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb9.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_6.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb9.x) ? u_xlat16_6.x : 0.0;
    SV_Target0.w = 0.00392156886;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    SV_Target2.w = u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_MIDDLE" "EMISSION_TYPE_NONE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat8;
bvec3 u_xlatb8;
float u_xlat9;
bvec3 u_xlatb9;
float u_xlat10;
vec2 u_xlat15;
vec2 u_xlat16;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
float u_xlat23;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb21){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb21){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb21){
        u_xlat21 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = max(u_xlat21, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb21){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat15.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat21 = dot(u_xlat15.xy, u_xlat15.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat21 = max(u_xlat21, u_xlat1.x);
        u_xlat21 = log2(u_xlat21);
        u_xlat21 = u_xlat21 * 0.5;
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat21 = u_xlat21 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = u_xlat1.x / u_xlat21;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb21){
        u_xlat1.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat2.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat2.xyxx).xy;
        u_xlatb21 = u_xlatb2.y || u_xlatb2.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (bool(u_xlatb21)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb21 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb21 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb21){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat21 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat21 = max(u_xlat21, u_xlat3.x);
            u_xlat21 = log2(u_xlat21);
            u_xlat21 = u_xlat21 * 0.5;
            u_xlat21 = max(u_xlat21, 0.0);
            u_xlat21 = u_xlat21 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat21);
            u_xlat21 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat9 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat23 = sqrt(u_xlat21);
            u_xlat3.x = sqrt(u_xlat9);
            u_xlat21 = inversesqrt(u_xlat21);
            u_xlat21 = u_xlat21 * abs(u_xlat2.z);
            u_xlat9 = inversesqrt(u_xlat9);
            u_xlat2.x = u_xlat9 * abs(u_xlat2.x);
            u_xlat21 = u_xlat21 * u_xlat2.x;
            u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
            u_xlat21 = sqrt(u_xlat21);
            u_xlat2.x = u_xlat23 * u_xlat3.x;
            u_xlat9 = u_xlat21 * u_xlat2.x;
            u_xlat16.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat16.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat16.xy = fract(u_xlat16.xy);
            u_xlat16.xy = u_xlat16.xy + vec2(0.5, 0.5);
            u_xlat16.xy = floor(u_xlat16.xy);
            u_xlat3.x = (-u_xlat16.x) + u_xlat3.x;
            u_xlat16.x = u_xlat3.x * u_xlat16.y + u_xlat16.x;
            u_xlat23 = (-u_xlat2.x) * u_xlat21 + 1.0;
            u_xlat3.xyz = (-u_xlat16.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat23) * u_xlat3.xyz + u_xlat16.xxx;
            u_xlatb9.xz = lessThan(vec4(u_xlat9), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat16.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat21 = u_xlat2.x * u_xlat21 + -4.0;
            u_xlat21 = exp2(u_xlat21);
            u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
            u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat16.xxx;
            u_xlat2.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb21 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb21 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb21){
                u_xlat2.x = float(0.0);
                u_xlat2.y = float(0.0);
                u_xlat2.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb21 = !!(u_xlat1.x>=0.0);
#else
                u_xlatb21 = u_xlat1.x>=0.0;
#endif
                if(u_xlatb21){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat21 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat23 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat21 = max(u_xlat21, u_xlat23);
                    u_xlat21 = log2(u_xlat21);
                    u_xlat21 = u_xlat21 * 0.5;
                    u_xlat21 = max(u_xlat21, 0.0);
                    u_xlat21 = u_xlat21 + 1.0;
                    u_xlat23 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat23) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat23);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat21);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat21);
                    u_xlat21 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat8 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat23 = sqrt(u_xlat21);
                    u_xlat10 = sqrt(u_xlat8);
                    u_xlat21 = inversesqrt(u_xlat21);
                    u_xlat21 = u_xlat21 * abs(u_xlat3.x);
                    u_xlat8 = inversesqrt(u_xlat8);
                    u_xlat1.x = u_xlat8 * abs(u_xlat1.x);
                    u_xlat21 = u_xlat21 * u_xlat1.x;
                    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
                    u_xlat21 = sqrt(u_xlat21);
                    u_xlat1.x = u_xlat23 * u_xlat10;
                    u_xlat8 = u_xlat21 * u_xlat1.x;
                    u_xlat15.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat23 = fract((-u_xlat15.x));
                    u_xlat23 = u_xlat23 + 0.5;
                    u_xlat23 = floor(u_xlat23);
                    u_xlat15.xy = fract(u_xlat15.xy);
                    u_xlat15.xy = u_xlat15.xy + vec2(0.5, 0.5);
                    u_xlat15.xy = floor(u_xlat15.xy);
                    u_xlat23 = (-u_xlat15.x) + u_xlat23;
                    u_xlat15.x = u_xlat23 * u_xlat15.y + u_xlat15.x;
                    u_xlat22 = (-u_xlat1.x) * u_xlat21 + 1.0;
                    u_xlat3.xyz = (-u_xlat15.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz + u_xlat15.xxx;
                    u_xlatb8.xz = lessThan(vec4(u_xlat8), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat15.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat21 = u_xlat1.x * u_xlat21 + -4.0;
                    u_xlat21 = exp2(u_xlat21);
                    u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
                    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat15.xxx;
                    u_xlat1.xzw = (u_xlatb8.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb8.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat2.x = float(0.0);
                    u_xlat2.y = float(0.0);
                    u_xlat2.z = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_6 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_6 : 0.0;
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_MIDDLE" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
bvec3 u_xlatb2;
vec4 u_xlat3;
bvec3 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump float u_xlat16_7;
float u_xlat10;
bvec3 u_xlatb10;
vec3 u_xlat11;
vec2 u_xlat18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat26;
float u_xlat27;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1<0.0);
#else
    u_xlatb24 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb24){
        u_xlatb2.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat1 = (u_xlatb2.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat1 = (u_xlatb2.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb24){
        u_xlat24 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = max(u_xlat24, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb2.x = !!(256.0<u_xlat24);
#else
        u_xlatb2.x = 256.0<u_xlat24;
#endif
        u_xlatb10.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat1 = (u_xlatb10.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb10.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb24){
        u_xlat2.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat18.xy = dFdx(u_xlat2.xy);
        u_xlat2.xy = dFdy(u_xlat2.xy);
        u_xlat24 = dot(u_xlat18.xy, u_xlat18.xy);
        u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
        u_xlat24 = max(u_xlat24, u_xlat2.x);
        u_xlat24 = log2(u_xlat24);
        u_xlat24 = u_xlat24 * 0.5;
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat24 = u_xlat24 + 1.0;
        u_xlat2.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = u_xlat2.x / u_xlat24;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2.x = !!(256.0<u_xlat24);
#else
        u_xlatb2.x = 256.0<u_xlat24;
#endif
        u_xlatb10.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat1 = (u_xlatb10.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb10.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb24){
        u_xlat1.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat2.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat2.xyxx).xy;
        u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (bool(u_xlatb24)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb24 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb24){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat24 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat24 = max(u_xlat24, u_xlat3.x);
            u_xlat24 = log2(u_xlat24);
            u_xlat24 = u_xlat24 * 0.5;
            u_xlat24 = max(u_xlat24, 0.0);
            u_xlat24 = u_xlat24 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat24);
            u_xlat24 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat10 = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat26 = sqrt(u_xlat24);
            u_xlat3.x = sqrt(u_xlat10);
            u_xlat24 = inversesqrt(u_xlat24);
            u_xlat24 = u_xlat24 * abs(u_xlat2.z);
            u_xlat10 = inversesqrt(u_xlat10);
            u_xlat2.x = u_xlat10 * abs(u_xlat2.x);
            u_xlat24 = u_xlat24 * u_xlat2.x;
            u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
            u_xlat24 = sqrt(u_xlat24);
            u_xlat2.x = u_xlat26 * u_xlat3.x;
            u_xlat10 = u_xlat24 * u_xlat2.x;
            u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat18.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat18.xy = fract(u_xlat18.xy);
            u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
            u_xlat18.xy = floor(u_xlat18.xy);
            u_xlat3.x = (-u_xlat18.x) + u_xlat3.x;
            u_xlat18.x = u_xlat3.x * u_xlat18.y + u_xlat18.x;
            u_xlat26 = (-u_xlat2.x) * u_xlat24 + 1.0;
            u_xlat3.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat18.xxx;
            u_xlatb10.xz = lessThan(vec4(u_xlat10), vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat24 = u_xlat2.x * u_xlat24 + -4.0;
            u_xlat24 = exp2(u_xlat24);
            u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
            u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat18.xxx;
            u_xlat2.xzw = (u_xlatb10.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb10.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb24 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb24 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb24){
                u_xlat2.x = float(0.0);
                u_xlat2.y = float(0.0);
                u_xlat2.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb24 = !!(u_xlat1.x>=0.0);
#else
                u_xlatb24 = u_xlat1.x>=0.0;
#endif
                if(u_xlatb24){
                    u_xlat3.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.zw = dFdx(u_xlat3.xy);
                    u_xlat3.xy = dFdy(u_xlat3.xy);
                    u_xlat24 = dot(u_xlat3.zw, u_xlat3.zw);
                    u_xlat26 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3 = vec4(u_xlat26) * u_xlat3;
                    u_xlat3 = u_xlat3 / vec4(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                    u_xlat26 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat11.x = sqrt(u_xlat24);
                    u_xlat27 = sqrt(u_xlat26);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.z);
                    u_xlat26 = inversesqrt(u_xlat26);
                    u_xlat26 = u_xlat26 * abs(u_xlat3.x);
                    u_xlat24 = u_xlat24 * u_xlat26;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat26 = u_xlat27 * u_xlat11.x;
                    u_xlat3.x = u_xlat24 * u_xlat26;
                    u_xlat11.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat27 = fract((-u_xlat11.x));
                    u_xlat11.z = u_xlat27 + 0.5;
                    u_xlat11.xy = fract(u_xlat11.xy);
                    u_xlat11.xy = u_xlat11.xy + vec2(0.5, 0.5);
                    u_xlat11.xyz = floor(u_xlat11.xyz);
                    u_xlat27 = (-u_xlat11.x) + u_xlat11.z;
                    u_xlat11.x = u_xlat27 * u_xlat11.y + u_xlat11.x;
                    u_xlat19 = (-u_xlat26) * u_xlat24 + 1.0;
                    u_xlat4.xyz = (-u_xlat11.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat11.xxx;
                    u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat6.xyz = u_xlat11.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat26 * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.zyy + u_xlat11.xxx;
                    u_xlat11.xyz = (u_xlatb3.z) ? u_xlat6.xyz : u_xlat4.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat5.xyz : u_xlat11.xyz;
                } else {
                    u_xlat2.x = float(0.0);
                    u_xlat2.y = float(0.0);
                    u_xlat2.z = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb2.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb2.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_7 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_7 : 0.0;
    SV_Target0.w = 0.0;
    SV_Target1.w = 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_MIDDLE" "EMISSION_TYPE_TIME" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec2 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat8;
bvec3 u_xlatb8;
vec3 u_xlat9;
bvec3 u_xlatb9;
float u_xlat10;
vec2 u_xlat15;
vec2 u_xlat16;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
float u_xlat23;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb21){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb21){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb21){
        u_xlat21 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = max(u_xlat21, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb21){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat15.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat21 = dot(u_xlat15.xy, u_xlat15.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat21 = max(u_xlat21, u_xlat1.x);
        u_xlat21 = log2(u_xlat21);
        u_xlat21 = u_xlat21 * 0.5;
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat21 = u_xlat21 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = u_xlat1.x / u_xlat21;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb21){
        u_xlat1.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat2.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat2.xyxx).xy;
        u_xlatb21 = u_xlatb2.y || u_xlatb2.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (bool(u_xlatb21)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb21 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb21 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb21){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat21 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat21 = max(u_xlat21, u_xlat3.x);
            u_xlat21 = log2(u_xlat21);
            u_xlat21 = u_xlat21 * 0.5;
            u_xlat21 = max(u_xlat21, 0.0);
            u_xlat21 = u_xlat21 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat21);
            u_xlat21 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat9.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat23 = sqrt(u_xlat21);
            u_xlat3.x = sqrt(u_xlat9.x);
            u_xlat21 = inversesqrt(u_xlat21);
            u_xlat21 = u_xlat21 * abs(u_xlat2.z);
            u_xlat9.x = inversesqrt(u_xlat9.x);
            u_xlat2.x = u_xlat9.x * abs(u_xlat2.x);
            u_xlat21 = u_xlat21 * u_xlat2.x;
            u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
            u_xlat21 = sqrt(u_xlat21);
            u_xlat2.x = u_xlat23 * u_xlat3.x;
            u_xlat9.x = u_xlat21 * u_xlat2.x;
            u_xlat16.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat16.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat16.xy = fract(u_xlat16.xy);
            u_xlat16.xy = u_xlat16.xy + vec2(0.5, 0.5);
            u_xlat16.xy = floor(u_xlat16.xy);
            u_xlat3.x = (-u_xlat16.x) + u_xlat3.x;
            u_xlat16.x = u_xlat3.x * u_xlat16.y + u_xlat16.x;
            u_xlat23 = (-u_xlat2.x) * u_xlat21 + 1.0;
            u_xlat3.xyz = (-u_xlat16.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat23) * u_xlat3.xyz + u_xlat16.xxx;
            u_xlatb9.xz = lessThan(u_xlat9.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat16.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat21 = u_xlat2.x * u_xlat21 + -4.0;
            u_xlat21 = exp2(u_xlat21);
            u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
            u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat16.xxx;
            u_xlat2.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb21 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb21 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb21){
                u_xlat2.x = float(0.0);
                u_xlat2.y = float(0.0);
                u_xlat2.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb21 = !!(u_xlat1.x>=0.0);
#else
                u_xlatb21 = u_xlat1.x>=0.0;
#endif
                if(u_xlatb21){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat21 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat23 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat21 = max(u_xlat21, u_xlat23);
                    u_xlat21 = log2(u_xlat21);
                    u_xlat21 = u_xlat21 * 0.5;
                    u_xlat21 = max(u_xlat21, 0.0);
                    u_xlat21 = u_xlat21 + 1.0;
                    u_xlat23 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat23) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat23);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat21);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat21);
                    u_xlat21 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat8 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat23 = sqrt(u_xlat21);
                    u_xlat10 = sqrt(u_xlat8);
                    u_xlat21 = inversesqrt(u_xlat21);
                    u_xlat21 = u_xlat21 * abs(u_xlat3.x);
                    u_xlat8 = inversesqrt(u_xlat8);
                    u_xlat1.x = u_xlat8 * abs(u_xlat1.x);
                    u_xlat21 = u_xlat21 * u_xlat1.x;
                    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
                    u_xlat21 = sqrt(u_xlat21);
                    u_xlat1.x = u_xlat23 * u_xlat10;
                    u_xlat8 = u_xlat21 * u_xlat1.x;
                    u_xlat15.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat23 = fract((-u_xlat15.x));
                    u_xlat23 = u_xlat23 + 0.5;
                    u_xlat23 = floor(u_xlat23);
                    u_xlat15.xy = fract(u_xlat15.xy);
                    u_xlat15.xy = u_xlat15.xy + vec2(0.5, 0.5);
                    u_xlat15.xy = floor(u_xlat15.xy);
                    u_xlat23 = (-u_xlat15.x) + u_xlat23;
                    u_xlat15.x = u_xlat23 * u_xlat15.y + u_xlat15.x;
                    u_xlat22 = (-u_xlat1.x) * u_xlat21 + 1.0;
                    u_xlat3.xyz = (-u_xlat15.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz + u_xlat15.xxx;
                    u_xlatb8.xz = lessThan(vec4(u_xlat8), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat15.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat21 = u_xlat1.x * u_xlat21 + -4.0;
                    u_xlat21 = exp2(u_xlat21);
                    u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
                    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat15.xxx;
                    u_xlat1.xzw = (u_xlatb8.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb8.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat2.x = float(0.0);
                    u_xlat2.y = float(0.0);
                    u_xlat2.z = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_6.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat21 = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat21 = _InvertEmission * u_xlat21 + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_6.xyz * vec3(u_xlat21) + u_xlat10_0.xyz;
    u_xlat16_6.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_6.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2.x = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = (u_xlatb2.x) ? u_xlat16_1 : u_xlat16_0;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat9.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat9.xyz = u_xlat9.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat9.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb9.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_6.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb9.x) ? u_xlat16_6.x : 0.0;
    SV_Target0.w = 0.00392156886;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    SV_Target2.w = u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_MIDDLE" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump float _CutOff;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec3 u_xlatb2;
vec4 u_xlat3;
bvec3 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat10;
bvec3 u_xlatb10;
vec3 u_xlat11;
vec2 u_xlat18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat26;
float u_xlat27;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb24 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb24){
        u_xlatb2.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat1 = (u_xlatb2.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat1 = (u_xlatb2.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb24){
        u_xlat24 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = max(u_xlat24, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb2.x = !!(256.0<u_xlat24);
#else
        u_xlatb2.x = 256.0<u_xlat24;
#endif
        u_xlatb10.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat1 = (u_xlatb10.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb10.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb24){
        u_xlat2.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat18.xy = dFdx(u_xlat2.xy);
        u_xlat2.xy = dFdy(u_xlat2.xy);
        u_xlat24 = dot(u_xlat18.xy, u_xlat18.xy);
        u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
        u_xlat24 = max(u_xlat24, u_xlat2.x);
        u_xlat24 = log2(u_xlat24);
        u_xlat24 = u_xlat24 * 0.5;
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat24 = u_xlat24 + 1.0;
        u_xlat2.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat24 = u_xlat2.x / u_xlat24;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2.x = !!(256.0<u_xlat24);
#else
        u_xlatb2.x = 256.0<u_xlat24;
#endif
        u_xlatb10.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat24)).xy;
        u_xlat1 = (u_xlatb10.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb10.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat1 = (u_xlatb2.x) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb24){
        u_xlat1.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat2.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat2.xyxx).xy;
        u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (bool(u_xlatb24)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb24 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb24){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat24 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat24 = max(u_xlat24, u_xlat3.x);
            u_xlat24 = log2(u_xlat24);
            u_xlat24 = u_xlat24 * 0.5;
            u_xlat24 = max(u_xlat24, 0.0);
            u_xlat24 = u_xlat24 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat24);
            u_xlat24 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat10.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat26 = sqrt(u_xlat24);
            u_xlat3.x = sqrt(u_xlat10.x);
            u_xlat24 = inversesqrt(u_xlat24);
            u_xlat24 = u_xlat24 * abs(u_xlat2.z);
            u_xlat10.x = inversesqrt(u_xlat10.x);
            u_xlat2.x = u_xlat10.x * abs(u_xlat2.x);
            u_xlat24 = u_xlat24 * u_xlat2.x;
            u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
            u_xlat24 = sqrt(u_xlat24);
            u_xlat2.x = u_xlat26 * u_xlat3.x;
            u_xlat10.x = u_xlat24 * u_xlat2.x;
            u_xlat18.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat18.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat18.xy = fract(u_xlat18.xy);
            u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
            u_xlat18.xy = floor(u_xlat18.xy);
            u_xlat3.x = (-u_xlat18.x) + u_xlat3.x;
            u_xlat18.x = u_xlat3.x * u_xlat18.y + u_xlat18.x;
            u_xlat26 = (-u_xlat2.x) * u_xlat24 + 1.0;
            u_xlat3.xyz = (-u_xlat18.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat18.xxx;
            u_xlatb10.xz = lessThan(u_xlat10.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat18.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat24 = u_xlat2.x * u_xlat24 + -4.0;
            u_xlat24 = exp2(u_xlat24);
            u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
            u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.zyy + u_xlat18.xxx;
            u_xlat2.xzw = (u_xlatb10.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb10.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb24 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb24 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb24){
                u_xlat2.x = float(0.0);
                u_xlat2.y = float(0.0);
                u_xlat2.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb24 = !!(u_xlat1.x>=0.0);
#else
                u_xlatb24 = u_xlat1.x>=0.0;
#endif
                if(u_xlatb24){
                    u_xlat3.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.zw = dFdx(u_xlat3.xy);
                    u_xlat3.xy = dFdy(u_xlat3.xy);
                    u_xlat24 = dot(u_xlat3.zw, u_xlat3.zw);
                    u_xlat26 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat24 = max(u_xlat24, u_xlat26);
                    u_xlat24 = log2(u_xlat24);
                    u_xlat24 = u_xlat24 * 0.5;
                    u_xlat24 = max(u_xlat24, 0.0);
                    u_xlat24 = u_xlat24 + 1.0;
                    u_xlat26 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3 = vec4(u_xlat26) * u_xlat3;
                    u_xlat3 = u_xlat3 / vec4(u_xlat24);
                    u_xlat24 = dot(abs(u_xlat3.zw), abs(u_xlat3.zw));
                    u_xlat26 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat11.x = sqrt(u_xlat24);
                    u_xlat27 = sqrt(u_xlat26);
                    u_xlat24 = inversesqrt(u_xlat24);
                    u_xlat24 = u_xlat24 * abs(u_xlat3.z);
                    u_xlat26 = inversesqrt(u_xlat26);
                    u_xlat26 = u_xlat26 * abs(u_xlat3.x);
                    u_xlat24 = u_xlat24 * u_xlat26;
                    u_xlat24 = (-u_xlat24) * u_xlat24 + 1.0;
                    u_xlat24 = sqrt(u_xlat24);
                    u_xlat26 = u_xlat27 * u_xlat11.x;
                    u_xlat3.x = u_xlat24 * u_xlat26;
                    u_xlat11.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat27 = fract((-u_xlat11.x));
                    u_xlat11.z = u_xlat27 + 0.5;
                    u_xlat11.xy = fract(u_xlat11.xy);
                    u_xlat11.xy = u_xlat11.xy + vec2(0.5, 0.5);
                    u_xlat11.xyz = floor(u_xlat11.xyz);
                    u_xlat27 = (-u_xlat11.x) + u_xlat11.z;
                    u_xlat11.x = u_xlat27 * u_xlat11.y + u_xlat11.x;
                    u_xlat19 = (-u_xlat26) * u_xlat24 + 1.0;
                    u_xlat4.xyz = (-u_xlat11.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat5.xyz = vec3(u_xlat19) * u_xlat4.xyz + u_xlat11.xxx;
                    u_xlatb3.xz = lessThan(u_xlat3.xxxx, vec4(1.0, 0.0, 2.0, 0.0)).xz;
                    u_xlat6.xyz = u_xlat11.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat24 = u_xlat26 * u_xlat24 + -4.0;
                    u_xlat24 = exp2(u_xlat24);
                    u_xlat24 = u_xlat24 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
                    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
                    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.zyy + u_xlat11.xxx;
                    u_xlat11.xyz = (u_xlatb3.z) ? u_xlat6.xyz : u_xlat4.xyz;
                    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat5.xyz : u_xlat11.xyz;
                } else {
                    u_xlat2.x = float(0.0);
                    u_xlat2.y = float(0.0);
                    u_xlat2.z = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb2.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb2.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb24 = u_xlatb2.y || u_xlatb2.x;
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_7.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat24 = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat24 = _InvertEmission * u_xlat24 + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_7.xyz * vec3(u_xlat24) + u_xlat10_0.xyz;
    u_xlat16_7.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_7.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2.x = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = (u_xlatb2.x) ? u_xlat16_1 : u_xlat16_0;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat10.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat10.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb10.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_7.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb10.x) ? u_xlat16_7.x : 0.0;
    SV_Target0.w = 0.00392156886;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    SV_Target2.w = u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_MIDDLE" "EMISSION_TYPE_NORMAL" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _InvertEmission;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec2 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat8;
bvec3 u_xlatb8;
vec3 u_xlat9;
bvec3 u_xlatb9;
float u_xlat10;
vec2 u_xlat15;
vec2 u_xlat16;
float u_xlat21;
bool u_xlatb21;
float u_xlat22;
float u_xlat23;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb21){
        u_xlatb1.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.0), vec4(_LODIndex)).xyz;
        u_xlat2 = (u_xlatb1.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
        u_xlat2 = (u_xlatb1.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat2;
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb21){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb21){
        u_xlat21 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = max(u_xlat21, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb21){
        u_xlat1.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat15.xy = dFdx(u_xlat1.xy);
        u_xlat1.xy = dFdy(u_xlat1.xy);
        u_xlat21 = dot(u_xlat15.xy, u_xlat15.xy);
        u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
        u_xlat21 = max(u_xlat21, u_xlat1.x);
        u_xlat21 = log2(u_xlat21);
        u_xlat21 = u_xlat21 * 0.5;
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat21 = u_xlat21 + 1.0;
        u_xlat1.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat21 = u_xlat1.x / u_xlat21;
#ifdef UNITY_ADRENO_ES3
        u_xlatb1.x = !!(256.0<u_xlat21);
#else
        u_xlatb1.x = 256.0<u_xlat21;
#endif
        u_xlatb8.xy = greaterThanEqual(vec4(512.0, 1024.0, 0.0, 0.0), vec4(u_xlat21)).xy;
        u_xlat2 = (u_xlatb8.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat2 = (u_xlatb8.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat2;
        u_xlat1 = (u_xlatb1.x) ? u_xlat2 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat1;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb21 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb21){
        u_xlat1.zw = vec2(vs_TEXCOORD0.x + (-_MainTex_ST.z), vs_TEXCOORD0.y + (-_MainTex_ST.w));
        u_xlat2.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
        u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat2.xyxx).xy;
        u_xlatb21 = u_xlatb2.y || u_xlatb2.x;
        u_xlat1.xy = _MainTex_TexelSize.zw;
        u_xlat1 = (bool(u_xlatb21)) ? u_xlat1 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb21 = !!(_DebugTexelDensityViewMode<0.5);
#else
        u_xlatb21 = _DebugTexelDensityViewMode<0.5;
#endif
        if(u_xlatb21){
            u_xlat2.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
            u_xlat2.zw = dFdx(u_xlat2.xy);
            u_xlat2.xy = dFdy(u_xlat2.xy);
            u_xlat21 = dot(u_xlat2.zw, u_xlat2.zw);
            u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
            u_xlat21 = max(u_xlat21, u_xlat3.x);
            u_xlat21 = log2(u_xlat21);
            u_xlat21 = u_xlat21 * 0.5;
            u_xlat21 = max(u_xlat21, 0.0);
            u_xlat21 = u_xlat21 + 1.0;
            u_xlat3.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
            u_xlat2 = u_xlat2 * u_xlat3.xxxx;
            u_xlat2 = u_xlat2 / vec4(u_xlat21);
            u_xlat21 = dot(abs(u_xlat2.zw), abs(u_xlat2.zw));
            u_xlat9.x = dot(abs(u_xlat2.xy), abs(u_xlat2.xy));
            u_xlat23 = sqrt(u_xlat21);
            u_xlat3.x = sqrt(u_xlat9.x);
            u_xlat21 = inversesqrt(u_xlat21);
            u_xlat21 = u_xlat21 * abs(u_xlat2.z);
            u_xlat9.x = inversesqrt(u_xlat9.x);
            u_xlat2.x = u_xlat9.x * abs(u_xlat2.x);
            u_xlat21 = u_xlat21 * u_xlat2.x;
            u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
            u_xlat21 = sqrt(u_xlat21);
            u_xlat2.x = u_xlat23 * u_xlat3.x;
            u_xlat9.x = u_xlat21 * u_xlat2.x;
            u_xlat16.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
            u_xlat3.x = fract((-u_xlat16.x));
            u_xlat3.x = u_xlat3.x + 0.5;
            u_xlat3.x = floor(u_xlat3.x);
            u_xlat16.xy = fract(u_xlat16.xy);
            u_xlat16.xy = u_xlat16.xy + vec2(0.5, 0.5);
            u_xlat16.xy = floor(u_xlat16.xy);
            u_xlat3.x = (-u_xlat16.x) + u_xlat3.x;
            u_xlat16.x = u_xlat3.x * u_xlat16.y + u_xlat16.x;
            u_xlat23 = (-u_xlat2.x) * u_xlat21 + 1.0;
            u_xlat3.xyz = (-u_xlat16.xxx) + vec3(0.5, 0.0, 1.0);
            u_xlat4.xyz = vec3(u_xlat23) * u_xlat3.xyz + u_xlat16.xxx;
            u_xlatb9.xz = lessThan(u_xlat9.xxxx, vec4(1.0, 0.0, 2.0, 2.0)).xz;
            u_xlat5.xyz = u_xlat16.xxx * vec3(0.0, 1.0, 0.0);
            u_xlat21 = u_xlat2.x * u_xlat21 + -4.0;
            u_xlat21 = exp2(u_xlat21);
            u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
            u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
            u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
            u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat16.xxx;
            u_xlat2.xzw = (u_xlatb9.z) ? u_xlat5.xyz : u_xlat3.xyz;
            u_xlat2.xyz = (u_xlatb9.x) ? u_xlat4.xyz : u_xlat2.xzw;
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb21 = !!(_DebugTexelDensityViewMode<1.5);
#else
            u_xlatb21 = _DebugTexelDensityViewMode<1.5;
#endif
            if(u_xlatb21){
                u_xlat2.x = float(0.0);
                u_xlat2.y = float(0.0);
                u_xlat2.z = float(0.0);
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb21 = !!(u_xlat1.x>=0.0);
#else
                u_xlatb21 = u_xlat1.x>=0.0;
#endif
                if(u_xlatb21){
                    u_xlat1.xy = vec2(u_xlat1.x * u_xlat1.z, u_xlat1.y * u_xlat1.w);
                    u_xlat3.xy = dFdx(u_xlat1.xy);
                    u_xlat1.xy = dFdy(u_xlat1.xy);
                    u_xlat21 = dot(u_xlat3.xy, u_xlat3.xy);
                    u_xlat23 = dot(u_xlat1.xy, u_xlat1.xy);
                    u_xlat21 = max(u_xlat21, u_xlat23);
                    u_xlat21 = log2(u_xlat21);
                    u_xlat21 = u_xlat21 * 0.5;
                    u_xlat21 = max(u_xlat21, 0.0);
                    u_xlat21 = u_xlat21 + 1.0;
                    u_xlat23 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                    u_xlat3.xy = vec2(u_xlat23) * u_xlat3.xy;
                    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat23);
                    u_xlat3.xy = u_xlat3.xy / vec2(u_xlat21);
                    u_xlat1.xy = u_xlat1.xy / vec2(u_xlat21);
                    u_xlat21 = dot(abs(u_xlat3.xy), abs(u_xlat3.xy));
                    u_xlat8 = dot(abs(u_xlat1.xy), abs(u_xlat1.xy));
                    u_xlat23 = sqrt(u_xlat21);
                    u_xlat10 = sqrt(u_xlat8);
                    u_xlat21 = inversesqrt(u_xlat21);
                    u_xlat21 = u_xlat21 * abs(u_xlat3.x);
                    u_xlat8 = inversesqrt(u_xlat8);
                    u_xlat1.x = u_xlat8 * abs(u_xlat1.x);
                    u_xlat21 = u_xlat21 * u_xlat1.x;
                    u_xlat21 = (-u_xlat21) * u_xlat21 + 1.0;
                    u_xlat21 = sqrt(u_xlat21);
                    u_xlat1.x = u_xlat23 * u_xlat10;
                    u_xlat8 = u_xlat21 * u_xlat1.x;
                    u_xlat15.xy = vec2(u_xlat1.z * float(3.0), u_xlat1.w * float(3.0));
                    u_xlat23 = fract((-u_xlat15.x));
                    u_xlat23 = u_xlat23 + 0.5;
                    u_xlat23 = floor(u_xlat23);
                    u_xlat15.xy = fract(u_xlat15.xy);
                    u_xlat15.xy = u_xlat15.xy + vec2(0.5, 0.5);
                    u_xlat15.xy = floor(u_xlat15.xy);
                    u_xlat23 = (-u_xlat15.x) + u_xlat23;
                    u_xlat15.x = u_xlat23 * u_xlat15.y + u_xlat15.x;
                    u_xlat22 = (-u_xlat1.x) * u_xlat21 + 1.0;
                    u_xlat3.xyz = (-u_xlat15.xxx) + vec3(0.5, 0.0, 1.0);
                    u_xlat4.xyz = vec3(u_xlat22) * u_xlat3.xyz + u_xlat15.xxx;
                    u_xlatb8.xz = lessThan(vec4(u_xlat8), vec4(1.0, 0.0, 2.0, 2.0)).xz;
                    u_xlat5.xyz = u_xlat15.xxx * vec3(0.0, 1.0, 0.0);
                    u_xlat21 = u_xlat1.x * u_xlat21 + -4.0;
                    u_xlat21 = exp2(u_xlat21);
                    u_xlat21 = u_xlat21 + -0.25;
#ifdef UNITY_ADRENO_ES3
                    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
                    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
                    u_xlat3.xyz = vec3(u_xlat21) * u_xlat3.zyy + u_xlat15.xxx;
                    u_xlat1.xzw = (u_xlatb8.z) ? u_xlat5.xyz : u_xlat3.xyz;
                    u_xlat2.xyz = (u_xlatb8.x) ? u_xlat4.xyz : u_xlat1.xzw;
                } else {
                    u_xlat2.x = float(0.0);
                    u_xlat2.y = float(0.0);
                    u_xlat2.z = float(0.0);
                //ENDIF
                }
            //ENDIF
            }
        //ENDIF
        }
        SV_Target0.xyz = u_xlat2.xyz;
        SV_Target0.w = 1.0;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb1.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb21 = u_xlatb1.y || u_xlatb1.x;
    if(u_xlatb21){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_6.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat21 = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat21 = _InvertEmission * u_xlat21 + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_6.xyz * vec3(u_xlat21) + u_xlat10_0.xyz;
    u_xlat16_6.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_6.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2.x = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
    u_xlat16_0 = (u_xlatb2.x) ? u_xlat16_1 : u_xlat16_0;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat9.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat9.xyz = u_xlat9.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat9.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb9.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_6.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb9.x) ? u_xlat16_6.x : 0.0;
    SV_Target0.w = 0.00392156886;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    SV_Target2.w = u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_LOW" "EMISSION_TYPE_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_LOW" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_LOW" "EMISSION_TYPE_TIME" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
bool u_xlatb2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat0.x = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat0.x = _InvertEmission * u_xlat0.x + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vs_COLOR0.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_LOW" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
bool u_xlatb2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat0.x = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat0.x = _InvertEmission * u_xlat0.x + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vs_COLOR0.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_LOW" "EMISSION_TYPE_NORMAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _InvertEmission;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
bool u_xlatb2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat0.x = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat0.x = _InvertEmission * u_xlat0.x + vs_COLOR0.w;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vs_COLOR0.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_LOW" "EMISSION_TYPE_NONE" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_LOW" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    SV_Target1.xyz = vs_COLOR0.xyz * _Color.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : 0.0;
    SV_Target2.xyw = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_LOW" "EMISSION_TYPE_TIME" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
bool u_xlatb2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat0.x = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat0.x = _InvertEmission * u_xlat0.x + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vs_COLOR0.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_LOW" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionTimeStrength;
uniform 	mediump float _InvertEmission;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
bool u_xlatb2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionTimeStrength, _EmissionTimeStrength, _EmissionTimeStrength));
    u_xlat0.x = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat0.x = _InvertEmission * u_xlat0.x + vs_COLOR0.w;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vs_COLOR0.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_LOW" "EMISSION_TYPE_NORMAL" }
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
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _InvertEmission;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
bool u_xlatb2;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.00392156886;
    u_xlat0.x = vs_COLOR0.w * -2.0 + 1.0;
    u_xlat0.x = _InvertEmission * u_xlat0.x + vs_COLOR0.w;
    u_xlat16_1.xyz = _EmissionColor.xyz * vec3(_EmissionStrength);
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vs_COLOR0.xyz;
    u_xlat16_1.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
    u_xlat16_0.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb2 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0 = (bool(u_xlatb2)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = u_xlat16_0.xyz * _Color.xyz;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_2 = sqrt(u_xlat16_2);
    SV_Target2.w = u_xlat16_2;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : 0.0;
    SV_Target2.xy = vec2(0.0, 0.0);
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" "EMISSION_TYPE_NORMAL" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_HIGH" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_HIGH" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_HIGH" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_HIGH" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_HIGH" "EMISSION_TYPE_NORMAL" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" "EMISSION_TYPE_NORMAL" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_MIDDLE" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_MIDDLE" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_MIDDLE" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_MIDDLE" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_MIDDLE" "EMISSION_TYPE_NORMAL" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" "EMISSION_TYPE_NORMAL" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_LOW" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_LOW" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_LOW" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_LOW" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_LOW" "EMISSION_TYPE_NORMAL" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_HIGH" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_HIGH" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_HIGH" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_HIGH" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_HIGH" "EMISSION_TYPE_NORMAL" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_HIGH" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_HIGH" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_HIGH" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_HIGH" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_HIGH" "EMISSION_TYPE_NORMAL" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_MIDDLE" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_MIDDLE" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_MIDDLE" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_MIDDLE" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_MIDDLE" "EMISSION_TYPE_NORMAL" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_MIDDLE" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_MIDDLE" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_MIDDLE" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_MIDDLE" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_MIDDLE" "EMISSION_TYPE_NORMAL" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_LOW" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_LOW" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_LOW" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_LOW" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_LOW" "EMISSION_TYPE_NORMAL" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_LOW" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_LOW" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_NONE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_LOW" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_LOW" "ENABLE_ALPHA_TEST_ON" "EMISSION_TYPE_TIME" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_LOW" "EMISSION_TYPE_NORMAL" }
""
}
}
}
 Pass {
  Name "DEPTHONLY"
  Tags { "LIGHTMODE" = "DepthOnly" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 116031
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
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
    SV_TARGET0 = vec4(0.0, 0.0, 0.0, 0.0);
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
out highp vec2 vs_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
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
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_TARGET0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_TARGET0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
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
    SV_TARGET0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "LINE_INTERPOLATION" }
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
out highp vec2 vs_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
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
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0).w;
    u_xlat0 = u_xlat10_0 + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_TARGET0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "LINE_INTERPOLATION" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy, -1.0).w;
    u_xlat0 = u_xlat10_0 + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_TARGET0 = vec4(0.0, 0.0, 0.0, 0.0);
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
Keywords { "ENABLE_ALPHA_TEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "ENABLE_ALPHA_TEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" "ENABLE_ALPHA_TEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "LINE_INTERPOLATION" "ENABLE_ALPHA_TEST_ON" }
""
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  Cull Off
  GpuProgramID 171497
Program "vp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_0.yyy * u_xlat16_2.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_23 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_7.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz;
    u_xlat4.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat4.y * u_xlat4.y;
    u_xlat16_22 = u_xlat4.x * u_xlat4.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_21;
bool u_xlatb21;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb21 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb21) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_21 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_7.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat2.y * u_xlat2.y;
    u_xlat16_22 = u_xlat2.x * u_xlat2.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_0.yyy * u_xlat16_2.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_23 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_7.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz;
    u_xlat4.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat4.y * u_xlat4.y;
    u_xlat16_22 = u_xlat4.x * u_xlat4.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_21;
bool u_xlatb21;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb21 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb21) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_21 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_7.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat2.y * u_xlat2.y;
    u_xlat16_22 = u_xlat2.x * u_xlat2.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_0.yyy * u_xlat16_2.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_23 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_7.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz;
    u_xlat4.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat4.y * u_xlat4.y;
    u_xlat16_22 = u_xlat4.x * u_xlat4.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_21;
bool u_xlatb21;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb21 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb21) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_21 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_7.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat2.y * u_xlat2.y;
    u_xlat16_22 = u_xlat2.x * u_xlat2.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_0.yyy * u_xlat16_2.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_23 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_7.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz;
    u_xlat4.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat4.y * u_xlat4.y;
    u_xlat16_22 = u_xlat4.x * u_xlat4.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec3 u_xlat16_8;
lowp float u_xlat10_8;
float u_xlat24;
mediump float u_xlat16_24;
bool u_xlatb24;
mediump float u_xlat16_25;
float u_xlat26;
mediump float u_xlat16_27;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb24 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_25 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_1.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    u_xlat16_24 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat16_25) * u_xlat16_5.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_25 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_27 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_27 * u_xlat16_27;
    u_xlat16_8.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_8.x;
    u_xlat16_8.xyz = u_xlat16_5.xyz * u_xlat16_8.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_25) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat26 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat5.xyz = vec3(u_xlat26) * vs_TEXCOORD1.xyz;
    u_xlat26 = dot(u_xlat5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat26 * u_xlat16_0.x + (-u_xlat26);
    u_xlat26 = u_xlat6.x * u_xlat26 + 1.0;
    u_xlat26 = u_xlat26 * u_xlat26;
    u_xlat26 = max(u_xlat26, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat26;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat6.xyz = u_xlat16_8.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_8.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat6.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat8.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat8.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat8.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_8 = texture(_ShadowMapTexture, u_xlat8.xy).x;
    u_xlat16_25 = u_xlat0.x + u_xlat10_8;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat16_25) * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_25 = u_xlat5.y * u_xlat5.y;
    u_xlat16_25 = u_xlat5.x * u_xlat5.x + (-u_xlat16_25);
    u_xlat16_0 = u_xlat5.yzzx * u_xlat5.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_25) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_25 = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat5.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat5);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat5);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat5);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat13;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat1.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_1 = texture(_ShadowMapTexture, u_xlat1.xy).x;
    u_xlat16_2.x = u_xlat0.x + u_xlat10_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat16_3.xyz = u_xlat7.xyz * u_xlat0.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_5.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_0.yyy * u_xlat16_4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_1.xyz = (-u_xlat16_4.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_23) * u_xlat16_1.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_23 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat16_7.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat16_23) + u_xlat16_4.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_23) * u_xlat16_5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat6.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat13 = u_xlat6.x * u_xlat16_0.x + (-u_xlat6.x);
    u_xlat6.x = u_xlat13 * u_xlat6.x + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat6.x;
    u_xlat6.x = max(u_xlat6.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat6.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat6.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat6.xyz / u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_23 = u_xlat1.y * u_xlat1.y;
    u_xlat16_23 = u_xlat1.x * u_xlat1.x + (-u_xlat16_23);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_23) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_23 = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat1.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec3 u_xlat16_8;
lowp float u_xlat10_8;
float u_xlat24;
mediump float u_xlat16_24;
bool u_xlatb24;
mediump float u_xlat16_25;
float u_xlat26;
mediump float u_xlat16_27;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb24 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_25 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_1.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    u_xlat16_24 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat16_25) * u_xlat16_5.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_25 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_27 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_27 * u_xlat16_27;
    u_xlat16_8.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_8.x;
    u_xlat16_8.xyz = u_xlat16_5.xyz * u_xlat16_8.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_25) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat26 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat5.xyz = vec3(u_xlat26) * vs_TEXCOORD1.xyz;
    u_xlat26 = dot(u_xlat5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat26 * u_xlat16_0.x + (-u_xlat26);
    u_xlat26 = u_xlat6.x * u_xlat26 + 1.0;
    u_xlat26 = u_xlat26 * u_xlat26;
    u_xlat26 = max(u_xlat26, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat26;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat6.xyz = u_xlat16_8.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_8.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat6.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat8.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat8.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat8.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_8 = texture(_ShadowMapTexture, u_xlat8.xy).x;
    u_xlat16_25 = u_xlat0.x + u_xlat10_8;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat16_25) * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_25 = u_xlat5.y * u_xlat5.y;
    u_xlat16_25 = u_xlat5.x * u_xlat5.x + (-u_xlat16_25);
    u_xlat16_0 = u_xlat5.yzzx * u_xlat5.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_25) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_25 = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat5.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat5);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat5);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat5);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat13;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat1.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_1 = texture(_ShadowMapTexture, u_xlat1.xy).x;
    u_xlat16_2.x = u_xlat0.x + u_xlat10_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat16_3.xyz = u_xlat7.xyz * u_xlat0.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_5.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_0.yyy * u_xlat16_4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_1.xyz = (-u_xlat16_4.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_23) * u_xlat16_1.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_23 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat16_7.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat16_23) + u_xlat16_4.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_23) * u_xlat16_5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat6.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat13 = u_xlat6.x * u_xlat16_0.x + (-u_xlat6.x);
    u_xlat6.x = u_xlat13 * u_xlat6.x + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat6.x;
    u_xlat6.x = max(u_xlat6.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat6.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat6.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat6.xyz / u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_23 = u_xlat1.y * u_xlat1.y;
    u_xlat16_23 = u_xlat1.x * u_xlat1.x + (-u_xlat16_23);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_23) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_23 = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat1.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_21;
bool u_xlatb21;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb21 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb21) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_21 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_7.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat0.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_0.x = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat16_4.xyz = u_xlat10_0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_22 = u_xlat2.y * u_xlat2.y;
    u_xlat16_22 = u_xlat2.x * u_xlat2.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_0.yyy * u_xlat16_2.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_23 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_7.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz;
    u_xlat4.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_0.x = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat16_3.xyz = u_xlat10_0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
    u_xlat16_22 = u_xlat4.y * u_xlat4.y;
    u_xlat16_22 = u_xlat4.x * u_xlat4.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_21;
bool u_xlatb21;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb21 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb21) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_21 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_7.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat0.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_0.x = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat16_4.xyz = u_xlat10_0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_22 = u_xlat2.y * u_xlat2.y;
    u_xlat16_22 = u_xlat2.x * u_xlat2.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_0.yyy * u_xlat16_2.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_23 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_7.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz;
    u_xlat4.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_0.x = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat16_3.xyz = u_xlat10_0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
    u_xlat16_22 = u_xlat4.y * u_xlat4.y;
    u_xlat16_22 = u_xlat4.x * u_xlat4.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_21;
bool u_xlatb21;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb21 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb21) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_21 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_7.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat2.y * u_xlat2.y;
    u_xlat16_22 = u_xlat2.x * u_xlat2.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_0.yyy * u_xlat16_2.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_23 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_7.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz;
    u_xlat4.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat4.y * u_xlat4.y;
    u_xlat16_22 = u_xlat4.x * u_xlat4.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_21;
bool u_xlatb21;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb21 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb21) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_21 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_7.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat2.y * u_xlat2.y;
    u_xlat16_22 = u_xlat2.x * u_xlat2.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_0.yyy * u_xlat16_2.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_23 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_7.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz;
    u_xlat4.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat4.y * u_xlat4.y;
    u_xlat16_22 = u_xlat4.x * u_xlat4.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec3 u_xlat16_8;
lowp float u_xlat10_8;
float u_xlat24;
mediump float u_xlat16_24;
bool u_xlatb24;
mediump float u_xlat16_25;
float u_xlat26;
mediump float u_xlat16_27;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb24 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_25 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_1.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    u_xlat16_24 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat16_25) * u_xlat16_5.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_25 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_27 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_27 * u_xlat16_27;
    u_xlat16_8.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_8.x;
    u_xlat16_8.xyz = u_xlat16_5.xyz * u_xlat16_8.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_25) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat26 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat5.xyz = vec3(u_xlat26) * vs_TEXCOORD1.xyz;
    u_xlat26 = dot(u_xlat5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat26 * u_xlat16_0.x + (-u_xlat26);
    u_xlat26 = u_xlat6.x * u_xlat26 + 1.0;
    u_xlat26 = u_xlat26 * u_xlat26;
    u_xlat26 = max(u_xlat26, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat26;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat6.xyz = u_xlat16_8.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_8.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat6.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat8.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat8.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat8.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_8 = texture(_ShadowMapTexture, u_xlat8.xy).x;
    u_xlat16_25 = u_xlat0.x + u_xlat10_8;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat16_25) * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_25 = u_xlat5.y * u_xlat5.y;
    u_xlat16_25 = u_xlat5.x * u_xlat5.x + (-u_xlat16_25);
    u_xlat16_0 = u_xlat5.yzzx * u_xlat5.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_25) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_25 = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat5.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat5);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat5);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat5);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat13;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat1.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_1 = texture(_ShadowMapTexture, u_xlat1.xy).x;
    u_xlat16_2.x = u_xlat0.x + u_xlat10_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat16_3.xyz = u_xlat7.xyz * u_xlat0.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_5.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_0.yyy * u_xlat16_4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_1.xyz = (-u_xlat16_4.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_23) * u_xlat16_1.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_23 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat16_7.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat16_23) + u_xlat16_4.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_23) * u_xlat16_5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat6.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat13 = u_xlat6.x * u_xlat16_0.x + (-u_xlat6.x);
    u_xlat6.x = u_xlat13 * u_xlat6.x + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat6.x;
    u_xlat6.x = max(u_xlat6.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat6.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat6.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat6.xyz / u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_23 = u_xlat1.y * u_xlat1.y;
    u_xlat16_23 = u_xlat1.x * u_xlat1.x + (-u_xlat16_23);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_23) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_23 = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat1.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec3 u_xlat16_8;
lowp float u_xlat10_8;
float u_xlat24;
mediump float u_xlat16_24;
bool u_xlatb24;
mediump float u_xlat16_25;
float u_xlat26;
mediump float u_xlat16_27;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb24 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_25 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_1.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    u_xlat16_24 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat16_25) * u_xlat16_5.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_25 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_27 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_27 * u_xlat16_27;
    u_xlat16_8.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_8.x;
    u_xlat16_8.xyz = u_xlat16_5.xyz * u_xlat16_8.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_25) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat26 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat5.xyz = vec3(u_xlat26) * vs_TEXCOORD1.xyz;
    u_xlat26 = dot(u_xlat5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat26 * u_xlat16_0.x + (-u_xlat26);
    u_xlat26 = u_xlat6.x * u_xlat26 + 1.0;
    u_xlat26 = u_xlat26 * u_xlat26;
    u_xlat26 = max(u_xlat26, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat26;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat6.xyz = u_xlat16_8.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_8.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat6.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat8.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat8.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat8.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_8 = texture(_ShadowMapTexture, u_xlat8.xy).x;
    u_xlat16_25 = u_xlat0.x + u_xlat10_8;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat16_25) * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_25 = u_xlat5.y * u_xlat5.y;
    u_xlat16_25 = u_xlat5.x * u_xlat5.x + (-u_xlat16_25);
    u_xlat16_0 = u_xlat5.yzzx * u_xlat5.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_25) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_25 = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat5.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat5);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat5);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat5);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat13;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat1.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_1 = texture(_ShadowMapTexture, u_xlat1.xy).x;
    u_xlat16_2.x = u_xlat0.x + u_xlat10_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat16_3.xyz = u_xlat7.xyz * u_xlat0.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_5.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_0.yyy * u_xlat16_4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_1.xyz = (-u_xlat16_4.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_23) * u_xlat16_1.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_23 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat16_7.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat16_23) + u_xlat16_4.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_23) * u_xlat16_5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat6.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat13 = u_xlat6.x * u_xlat16_0.x + (-u_xlat6.x);
    u_xlat6.x = u_xlat13 * u_xlat6.x + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat6.x;
    u_xlat6.x = max(u_xlat6.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat6.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat6.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat6.xyz / u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_23 = u_xlat1.y * u_xlat1.y;
    u_xlat16_23 = u_xlat1.x * u_xlat1.x + (-u_xlat16_23);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_23) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_23 = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat1.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_21;
bool u_xlatb21;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb21 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb21) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_21 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_7.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat2.y * u_xlat2.y;
    u_xlat16_22 = u_xlat2.x * u_xlat2.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_0.yyy * u_xlat16_2.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_23 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_7.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz;
    u_xlat4.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat4.y * u_xlat4.y;
    u_xlat16_22 = u_xlat4.x * u_xlat4.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_21;
bool u_xlatb21;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb21 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb21) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_21 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_7.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat2.y * u_xlat2.y;
    u_xlat16_22 = u_xlat2.x * u_xlat2.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_0.yyy * u_xlat16_2.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_23 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_7.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz;
    u_xlat4.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat4.y * u_xlat4.y;
    u_xlat16_22 = u_xlat4.x * u_xlat4.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "INSTANCING_ON" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_21;
bool u_xlatb21;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb21 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb21) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_21 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_7.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat2.y * u_xlat2.y;
    u_xlat16_22 = u_xlat2.x * u_xlat2.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_0.yyy * u_xlat16_2.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_23 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_7.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz;
    u_xlat4.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat4.y * u_xlat4.y;
    u_xlat16_22 = u_xlat4.x * u_xlat4.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "INSTANCING_ON" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_21;
bool u_xlatb21;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb21 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb21) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_21 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_7.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat2.y * u_xlat2.y;
    u_xlat16_22 = u_xlat2.x * u_xlat2.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_0.yyy * u_xlat16_2.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_23 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_7.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz;
    u_xlat4.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat4.y * u_xlat4.y;
    u_xlat16_22 = u_xlat4.x * u_xlat4.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "INSTANCING_ON" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec3 u_xlat16_8;
lowp float u_xlat10_8;
float u_xlat24;
mediump float u_xlat16_24;
bool u_xlatb24;
mediump float u_xlat16_25;
float u_xlat26;
mediump float u_xlat16_27;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb24 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_25 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_1.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    u_xlat16_24 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat16_25) * u_xlat16_5.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_25 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_27 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_27 * u_xlat16_27;
    u_xlat16_8.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_8.x;
    u_xlat16_8.xyz = u_xlat16_5.xyz * u_xlat16_8.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_25) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat26 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat5.xyz = vec3(u_xlat26) * vs_TEXCOORD1.xyz;
    u_xlat26 = dot(u_xlat5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat26 * u_xlat16_0.x + (-u_xlat26);
    u_xlat26 = u_xlat6.x * u_xlat26 + 1.0;
    u_xlat26 = u_xlat26 * u_xlat26;
    u_xlat26 = max(u_xlat26, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat26;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat6.xyz = u_xlat16_8.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_8.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat6.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat8.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat8.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat8.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_8 = texture(_ShadowMapTexture, u_xlat8.xy).x;
    u_xlat16_25 = u_xlat0.x + u_xlat10_8;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat16_25) * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_25 = u_xlat5.y * u_xlat5.y;
    u_xlat16_25 = u_xlat5.x * u_xlat5.x + (-u_xlat16_25);
    u_xlat16_0 = u_xlat5.yzzx * u_xlat5.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_25) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_25 = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat5.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat5);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat5);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat5);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat13;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat1.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_1 = texture(_ShadowMapTexture, u_xlat1.xy).x;
    u_xlat16_2.x = u_xlat0.x + u_xlat10_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat16_3.xyz = u_xlat7.xyz * u_xlat0.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_5.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_0.yyy * u_xlat16_4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_1.xyz = (-u_xlat16_4.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_23) * u_xlat16_1.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_23 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat16_7.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat16_23) + u_xlat16_4.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_23) * u_xlat16_5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat6.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat13 = u_xlat6.x * u_xlat16_0.x + (-u_xlat6.x);
    u_xlat6.x = u_xlat13 * u_xlat6.x + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat6.x;
    u_xlat6.x = max(u_xlat6.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat6.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat6.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat6.xyz / u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_23 = u_xlat1.y * u_xlat1.y;
    u_xlat16_23 = u_xlat1.x * u_xlat1.x + (-u_xlat16_23);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_23) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_23 = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat1.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "INSTANCING_ON" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec3 u_xlat16_8;
lowp float u_xlat10_8;
float u_xlat24;
mediump float u_xlat16_24;
bool u_xlatb24;
mediump float u_xlat16_25;
float u_xlat26;
mediump float u_xlat16_27;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb24 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_25 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_1.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    u_xlat16_24 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat16_25) * u_xlat16_5.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_25 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_27 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_27 * u_xlat16_27;
    u_xlat16_8.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_8.x;
    u_xlat16_8.xyz = u_xlat16_5.xyz * u_xlat16_8.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_25) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat26 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat5.xyz = vec3(u_xlat26) * vs_TEXCOORD1.xyz;
    u_xlat26 = dot(u_xlat5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat26 * u_xlat16_0.x + (-u_xlat26);
    u_xlat26 = u_xlat6.x * u_xlat26 + 1.0;
    u_xlat26 = u_xlat26 * u_xlat26;
    u_xlat26 = max(u_xlat26, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat26;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat6.xyz = u_xlat16_8.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_8.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat6.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat8.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat8.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat8.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_8 = texture(_ShadowMapTexture, u_xlat8.xy).x;
    u_xlat16_25 = u_xlat0.x + u_xlat10_8;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat16_25) * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_25 = u_xlat5.y * u_xlat5.y;
    u_xlat16_25 = u_xlat5.x * u_xlat5.x + (-u_xlat16_25);
    u_xlat16_0 = u_xlat5.yzzx * u_xlat5.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_25) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_25 = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat5.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat5);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat5);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat5);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat13;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat1.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_1 = texture(_ShadowMapTexture, u_xlat1.xy).x;
    u_xlat16_2.x = u_xlat0.x + u_xlat10_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat16_3.xyz = u_xlat7.xyz * u_xlat0.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_5.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_0.yyy * u_xlat16_4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_1.xyz = (-u_xlat16_4.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_23) * u_xlat16_1.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_23 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat16_7.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat16_23) + u_xlat16_4.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_23) * u_xlat16_5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat6.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat13 = u_xlat6.x * u_xlat16_0.x + (-u_xlat6.x);
    u_xlat6.x = u_xlat13 * u_xlat6.x + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat6.x;
    u_xlat6.x = max(u_xlat6.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat6.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat6.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat6.xyz / u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_23 = u_xlat1.y * u_xlat1.y;
    u_xlat16_23 = u_xlat1.x * u_xlat1.x + (-u_xlat16_23);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_23) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_23 = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat1.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "INSTANCING_ON" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_21;
bool u_xlatb21;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb21 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb21) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_21 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_7.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat0.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_0.x = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat16_4.xyz = u_xlat10_0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_22 = u_xlat2.y * u_xlat2.y;
    u_xlat16_22 = u_xlat2.x * u_xlat2.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_0.yyy * u_xlat16_2.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_23 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_7.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz;
    u_xlat4.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_0.x = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat16_3.xyz = u_xlat10_0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
    u_xlat16_22 = u_xlat4.y * u_xlat4.y;
    u_xlat16_22 = u_xlat4.x * u_xlat4.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" "INSTANCING_ON" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_21;
bool u_xlatb21;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb21 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb21) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_21 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_7.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat0.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_0.x = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat16_4.xyz = u_xlat10_0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_22 = u_xlat2.y * u_xlat2.y;
    u_xlat16_22 = u_xlat2.x * u_xlat2.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_0.yyy * u_xlat16_2.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_23 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_7.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz;
    u_xlat4.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_0.x = texture(_ShadowMapTexture, u_xlat0.xy).x;
    u_xlat16_3.xyz = u_xlat10_0.xxx * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
    u_xlat16_22 = u_xlat4.y * u_xlat4.y;
    u_xlat16_22 = u_xlat4.x * u_xlat4.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "INSTANCING_ON" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_21;
bool u_xlatb21;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb21 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb21) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_21 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_7.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat2.y * u_xlat2.y;
    u_xlat16_22 = u_xlat2.x * u_xlat2.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_0.yyy * u_xlat16_2.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_23 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_7.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz;
    u_xlat4.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat4.y * u_xlat4.y;
    u_xlat16_22 = u_xlat4.x * u_xlat4.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "INSTANCING_ON" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_21;
bool u_xlatb21;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb21 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb21) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_21 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_7.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat2.y * u_xlat2.y;
    u_xlat16_22 = u_xlat2.x * u_xlat2.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat16_22 = u_xlat16_0.x * u_xlat16_22;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_0.yyy * u_xlat16_2.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_23 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_7.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_22) * u_xlat16_3.xyz;
    u_xlat4.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat4.y * u_xlat4.y;
    u_xlat16_22 = u_xlat4.x * u_xlat4.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat4.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_2.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "INSTANCING_ON" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec3 u_xlat16_8;
lowp float u_xlat10_8;
float u_xlat24;
mediump float u_xlat16_24;
bool u_xlatb24;
mediump float u_xlat16_25;
float u_xlat26;
mediump float u_xlat16_27;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb24 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_25 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_1.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    u_xlat16_24 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat16_25) * u_xlat16_5.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_25 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_27 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_27 * u_xlat16_27;
    u_xlat16_8.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_8.x;
    u_xlat16_8.xyz = u_xlat16_5.xyz * u_xlat16_8.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_25) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat26 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat5.xyz = vec3(u_xlat26) * vs_TEXCOORD1.xyz;
    u_xlat26 = dot(u_xlat5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat26 * u_xlat16_0.x + (-u_xlat26);
    u_xlat26 = u_xlat6.x * u_xlat26 + 1.0;
    u_xlat26 = u_xlat26 * u_xlat26;
    u_xlat26 = max(u_xlat26, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat26;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat6.xyz = u_xlat16_8.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_8.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat6.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat8.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat8.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat8.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_8 = texture(_ShadowMapTexture, u_xlat8.xy).x;
    u_xlat16_25 = u_xlat0.x + u_xlat10_8;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat16_25) * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_25 = u_xlat5.y * u_xlat5.y;
    u_xlat16_25 = u_xlat5.x * u_xlat5.x + (-u_xlat16_25);
    u_xlat16_0 = u_xlat5.yzzx * u_xlat5.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_25) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_25 = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat5.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat5);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat5);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat5);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat13;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat1.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_1 = texture(_ShadowMapTexture, u_xlat1.xy).x;
    u_xlat16_2.x = u_xlat0.x + u_xlat10_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat16_3.xyz = u_xlat7.xyz * u_xlat0.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_5.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_0.yyy * u_xlat16_4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_1.xyz = (-u_xlat16_4.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_23) * u_xlat16_1.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_23 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat16_7.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat16_23) + u_xlat16_4.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_23) * u_xlat16_5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat6.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat13 = u_xlat6.x * u_xlat16_0.x + (-u_xlat6.x);
    u_xlat6.x = u_xlat13 * u_xlat6.x + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat6.x;
    u_xlat6.x = max(u_xlat6.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat6.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat6.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat6.xyz / u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_23 = u_xlat1.y * u_xlat1.y;
    u_xlat16_23 = u_xlat1.x * u_xlat1.x + (-u_xlat16_23);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_23) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_23 = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat1.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "INSTANCING_ON" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec3 u_xlat16_8;
lowp float u_xlat10_8;
float u_xlat24;
mediump float u_xlat16_24;
bool u_xlatb24;
mediump float u_xlat16_25;
float u_xlat26;
mediump float u_xlat16_27;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb24 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_25 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_1.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    u_xlat16_24 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat16_25) * u_xlat16_5.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_25 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_27 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_27 * u_xlat16_27;
    u_xlat16_8.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_8.x;
    u_xlat16_8.xyz = u_xlat16_5.xyz * u_xlat16_8.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_25) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat26 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat5.xyz = vec3(u_xlat26) * vs_TEXCOORD1.xyz;
    u_xlat26 = dot(u_xlat5.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat26 * u_xlat16_0.x + (-u_xlat26);
    u_xlat26 = u_xlat6.x * u_xlat26 + 1.0;
    u_xlat26 = u_xlat26 * u_xlat26;
    u_xlat26 = max(u_xlat26, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat26;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat6.xyz = u_xlat16_8.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_8.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat6.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat8.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat8.x = (-u_xlat0.x) + u_xlat8.x;
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat8.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_8 = texture(_ShadowMapTexture, u_xlat8.xy).x;
    u_xlat16_25 = u_xlat0.x + u_xlat10_8;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat16_25) * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_25 = u_xlat5.y * u_xlat5.y;
    u_xlat16_25 = u_xlat5.x * u_xlat5.x + (-u_xlat16_25);
    u_xlat16_0 = u_xlat5.yzzx * u_xlat5.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_25) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_25 = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat5.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat5);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat5);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat5);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat13;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat0.x + u_xlat1.x;
    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat10_1 = texture(_ShadowMapTexture, u_xlat1.xy).x;
    u_xlat16_2.x = u_xlat0.x + u_xlat10_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat16_3.xyz = u_xlat7.xyz * u_xlat0.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_23 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz;
    u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat16_23 = u_xlat16_0.x * u_xlat16_23;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_5.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_0.yyy * u_xlat16_4.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_1.xyz = (-u_xlat16_4.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_23) * u_xlat16_1.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_23 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat16_7.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat16_23) + u_xlat16_4.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_23) * u_xlat16_5.xyz;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat6.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat13 = u_xlat6.x * u_xlat16_0.x + (-u_xlat6.x);
    u_xlat6.x = u_xlat13 * u_xlat6.x + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat6.x;
    u_xlat6.x = max(u_xlat6.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat6.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat6.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat6.xyz / u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_23 = u_xlat1.y * u_xlat1.y;
    u_xlat16_23 = u_xlat1.x * u_xlat1.x + (-u_xlat16_23);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * vec3(u_xlat16_23) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_23 = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat1.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_23) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
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
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat12;
float u_xlat21;
mediump float u_xlat16_21;
bool u_xlatb21;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb21 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb21) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_1.xyz = u_xlat2.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_22 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_22 = inversesqrt(u_xlat16_22);
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_21 = dot(_WorldSpaceLightPos0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat10_0.xy = texture(_DetailMask, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.xy = u_xlat10_0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_22) * u_xlat16_2.xyz;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.00100000005);
    u_xlat16_22 = (-u_xlat16_0.y) * 0.959999979 + 0.959999979;
    u_xlat16_0.x = min(u_xlat16_0.x, 0.999000013);
    u_xlat16_24 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_24 * u_xlat16_24;
    u_xlat16_7.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_7.xxx + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_22) * u_xlat16_4.xyz;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5.x * u_xlat16_0.x + (-u_xlat5.x);
    u_xlat5.x = u_xlat12 * u_xlat5.x + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = max(u_xlat5.x, 9.99999997e-07);
    u_xlat0.x = u_xlat16_0.x / u_xlat5.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat0.x = min(u_xlat0.x, 64.0);
    u_xlat5.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + vec3(2.0, 2.0, 2.0);
    u_xlat0.xyz = u_xlat5.xyz / u_xlat0.xyz;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_22 = u_xlat2.y * u_xlat2.y;
    u_xlat16_22 = u_xlat2.x * u_xlat2.x + (-u_xlat16_22);
    u_xlat16_0 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_4.xyz = unity_SHC.xyz * vec3(u_xlat16_22) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_22 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_3.xyz;
    SV_TARGET0.w = 1.0;
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
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "ENABLE_ALPHA_TEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "ENABLE_ALPHA_TEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "ENABLE_ALPHA_TEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "ENABLE_ALPHA_TEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "ENABLE_ALPHA_TEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "ENABLE_ALPHA_TEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" "ENABLE_ALPHA_TEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "ENABLE_ALPHA_TEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" "ENABLE_ALPHA_TEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "INSTANCING_ON" "ENABLE_ALPHA_TEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "INSTANCING_ON" "ENABLE_ALPHA_TEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "INSTANCING_ON" "ENABLE_ALPHA_TEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "INSTANCING_ON" "ENABLE_ALPHA_TEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "INSTANCING_ON" "ENABLE_ALPHA_TEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" "INSTANCING_ON" "ENABLE_ALPHA_TEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" "ENABLE_ALPHA_TEST_ON" }
""
}
}
}
 Pass {
  Name "META"
  Tags { "LIGHTMODE" = "META" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 199416
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	bvec4 unity_MetaVertexControl;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb6;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<in_POSITION0.z);
#else
    u_xlatb0 = 0.0<in_POSITION0.z;
#endif
    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
    u_xlat0.xy = in_TEXCOORD0.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.0<u_xlat0.z);
#else
    u_xlatb6 = 0.0<u_xlat0.z;
#endif
    u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
    u_xlat1.xy = in_TEXCOORD1.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	bvec4 unity_MetaFragmentControl;
uniform 	float unity_OneOverOutputBoost;
uniform 	float unity_MaxOutputValue;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
float u_xlat6;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat6 = unity_OneOverOutputBoost;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(u_xlat6);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
    u_xlat16_0.xyz = (unity_MetaFragmentControl.x) ? u_xlat0.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_0.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
    SV_TARGET0 = (unity_MetaFragmentControl.y) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "ENABLE_ALPHA_TEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	bvec4 unity_MetaVertexControl;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb6;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<in_POSITION0.z);
#else
    u_xlatb0 = 0.0<in_POSITION0.z;
#endif
    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
    u_xlat0.xy = in_TEXCOORD0.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.0<u_xlat0.z);
#else
    u_xlatb6 = 0.0<u_xlat0.z;
#endif
    u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
    u_xlat1.xy = in_TEXCOORD1.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	bvec4 unity_MetaFragmentControl;
uniform 	float unity_OneOverOutputBoost;
uniform 	float unity_MaxOutputValue;
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOff;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_3;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOff);
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
    u_xlat16_0.xyz = log2(u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat16_1<0.0);
#else
    u_xlatb6 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb6) * int(0xffffffffu))!=0){discard;}
    u_xlat6 = unity_OneOverOutputBoost;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(u_xlat6);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
    u_xlat16_0.xyz = (unity_MetaFragmentControl.x) ? u_xlat0.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_0.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
    SV_TARGET0 = (unity_MetaFragmentControl.y) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat16_0;
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
Keywords { "ENABLE_ALPHA_TEST_ON" }
""
}
}
}
 UsePass "miHoYo/Shadow/ShadowMapPass/LSPSM"
}
Fallback "Legacy Shaders/Specular"
}