//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/Weapon_Transparent" {
Properties {
_MainColor ("Main Color", Color) = (1,1,1,1)
_MainTex ("Main Tex", 2D) = "white" { }
_EmissionScaler ("Emission Scaler", Float) = 1
_WeaponPatternTex ("WeaponPatternTex", 2D) = "white" { }
_WeaponPatternColor ("WeaponPatternColor", Color) = (1.682,1.568729,0.6554853,0)
_Pattern_Speed ("Pattern_Speed", Float) = -0.033
_WeaponDissolveTex ("WeaponDissolveTex", 2D) = "white" { }
_WeaponDissolveValue ("WeaponDissolveValue", Range(0, 1)) = 0
[MHYToggle] _DissolveDirection_Toggle ("DissolveDirection_Toggle", Float) = 0
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "MAIN"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 34127
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _EmissionScaler;
uniform 	vec4 _WeaponPatternTex_ST;
uniform 	float _Pattern_Speed;
uniform 	float _WeaponDissolveValue;
uniform 	vec4 _WeaponDissolveTex_ST;
uniform 	mediump float _DissolveDirection_Toggle;
uniform 	vec4 _WeaponPatternColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _WeaponPatternTex;
uniform lowp sampler2D _WeaponDissolveTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp vec2 u_xlat10_3;
bool u_xlatb3;
float u_xlat6;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.x = _WeaponDissolveValue + -0.25;
    u_xlat0.x = u_xlat0.x * 6.28000021;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat3.xy = vs_TEXCOORD1.xy * _WeaponPatternTex_ST.xy + _WeaponPatternTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_Pattern_Speed) + u_xlat3.xy;
    u_xlat10_3.x = texture(_WeaponPatternTex, u_xlat3.xy).x;
    u_xlat0.x = u_xlat10_3.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_DissolveDirection_Toggle==1.0);
#else
    u_xlatb3 = _DissolveDirection_Toggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD1.xy * _WeaponDissolveTex_ST.xy + _WeaponDissolveTex_ST.zw;
    u_xlat6 = (-u_xlat1.y) + 1.0;
    u_xlat3.x = (u_xlatb3) ? u_xlat6 : u_xlat1.y;
    u_xlat3.x = _WeaponDissolveValue * 2.0999999 + u_xlat3.x;
    u_xlat1.z = u_xlat3.x + -1.0;
    u_xlat10_3.xy = texture(_WeaponDissolveTex, u_xlat1.xz).xy;
    u_xlat16_6 = u_xlat10_3.y * 3.0;
    u_xlat0.x = u_xlat0.x * 0.5 + u_xlat16_6;
    u_xlat0.xzw = u_xlat0.xxx * _WeaponPatternColor.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1.xyz = u_xlat10_1.xyz * _MainColor.xyz;
    u_xlat16_3 = u_xlat10_3.x * u_xlat10_1.w;
    u_xlat2.w = u_xlat16_3 * _MainColor.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_EmissionScaler) + u_xlat0.xzw;
    SV_Target0 = u_xlat2;
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
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _EmissionScaler;
uniform 	vec4 _WeaponPatternTex_ST;
uniform 	float _Pattern_Speed;
uniform 	float _WeaponDissolveValue;
uniform 	vec4 _WeaponDissolveTex_ST;
uniform 	mediump float _DissolveDirection_Toggle;
uniform 	vec4 _WeaponPatternColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _WeaponPatternTex;
uniform lowp sampler2D _WeaponDissolveTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp vec2 u_xlat10_3;
bool u_xlatb3;
float u_xlat6;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.x = _WeaponDissolveValue + -0.25;
    u_xlat0.x = u_xlat0.x * 6.28000021;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat3.xy = vs_TEXCOORD1.xy * _WeaponPatternTex_ST.xy + _WeaponPatternTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_Pattern_Speed) + u_xlat3.xy;
    u_xlat10_3.x = texture(_WeaponPatternTex, u_xlat3.xy).x;
    u_xlat0.x = u_xlat10_3.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_DissolveDirection_Toggle==1.0);
#else
    u_xlatb3 = _DissolveDirection_Toggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD1.xy * _WeaponDissolveTex_ST.xy + _WeaponDissolveTex_ST.zw;
    u_xlat6 = (-u_xlat1.y) + 1.0;
    u_xlat3.x = (u_xlatb3) ? u_xlat6 : u_xlat1.y;
    u_xlat3.x = _WeaponDissolveValue * 2.0999999 + u_xlat3.x;
    u_xlat1.z = u_xlat3.x + -1.0;
    u_xlat10_3.xy = texture(_WeaponDissolveTex, u_xlat1.xz).xy;
    u_xlat16_6 = u_xlat10_3.y * 3.0;
    u_xlat0.x = u_xlat0.x * 0.5 + u_xlat16_6;
    u_xlat0.xzw = u_xlat0.xxx * _WeaponPatternColor.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1.xyz = u_xlat10_1.xyz * _MainColor.xyz;
    u_xlat16_3 = u_xlat10_3.x * u_xlat10_1.w;
    u_xlat2.w = u_xlat16_3 * _MainColor.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_EmissionScaler) + u_xlat0.xzw;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _EmissionScaler;
uniform 	vec4 _WeaponPatternTex_ST;
uniform 	float _Pattern_Speed;
uniform 	float _WeaponDissolveValue;
uniform 	vec4 _WeaponDissolveTex_ST;
uniform 	mediump float _DissolveDirection_Toggle;
uniform 	vec4 _WeaponPatternColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _WeaponPatternTex;
uniform lowp sampler2D _WeaponDissolveTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp vec2 u_xlat10_3;
bool u_xlatb3;
float u_xlat6;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.x = _WeaponDissolveValue + -0.25;
    u_xlat0.x = u_xlat0.x * 6.28000021;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat3.xy = vs_TEXCOORD1.xy * _WeaponPatternTex_ST.xy + _WeaponPatternTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_Pattern_Speed) + u_xlat3.xy;
    u_xlat10_3.x = texture(_WeaponPatternTex, u_xlat3.xy).x;
    u_xlat0.x = u_xlat10_3.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_DissolveDirection_Toggle==1.0);
#else
    u_xlatb3 = _DissolveDirection_Toggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD1.xy * _WeaponDissolveTex_ST.xy + _WeaponDissolveTex_ST.zw;
    u_xlat6 = (-u_xlat1.y) + 1.0;
    u_xlat3.x = (u_xlatb3) ? u_xlat6 : u_xlat1.y;
    u_xlat3.x = _WeaponDissolveValue * 2.0999999 + u_xlat3.x;
    u_xlat1.z = u_xlat3.x + -1.0;
    u_xlat10_3.xy = texture(_WeaponDissolveTex, u_xlat1.xz).xy;
    u_xlat16_6 = u_xlat10_3.y * 3.0;
    u_xlat0.x = u_xlat0.x * 0.5 + u_xlat16_6;
    u_xlat0.xzw = u_xlat0.xxx * _WeaponPatternColor.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1.xyz = u_xlat10_1.xyz * _MainColor.xyz;
    u_xlat16_3 = u_xlat10_3.x * u_xlat10_1.w;
    u_xlat2.w = u_xlat16_3 * _MainColor.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_EmissionScaler) + u_xlat0.xzw;
    SV_Target0 = u_xlat2;
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
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _EmissionScaler;
uniform 	vec4 _WeaponPatternTex_ST;
uniform 	float _Pattern_Speed;
uniform 	float _WeaponDissolveValue;
uniform 	vec4 _WeaponDissolveTex_ST;
uniform 	mediump float _DissolveDirection_Toggle;
uniform 	vec4 _WeaponPatternColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _WeaponPatternTex;
uniform lowp sampler2D _WeaponDissolveTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp vec2 u_xlat10_3;
bool u_xlatb3;
float u_xlat6;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.x = _WeaponDissolveValue + -0.25;
    u_xlat0.x = u_xlat0.x * 6.28000021;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat3.xy = vs_TEXCOORD1.xy * _WeaponPatternTex_ST.xy + _WeaponPatternTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_Pattern_Speed) + u_xlat3.xy;
    u_xlat10_3.x = texture(_WeaponPatternTex, u_xlat3.xy).x;
    u_xlat0.x = u_xlat10_3.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_DissolveDirection_Toggle==1.0);
#else
    u_xlatb3 = _DissolveDirection_Toggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD1.xy * _WeaponDissolveTex_ST.xy + _WeaponDissolveTex_ST.zw;
    u_xlat6 = (-u_xlat1.y) + 1.0;
    u_xlat3.x = (u_xlatb3) ? u_xlat6 : u_xlat1.y;
    u_xlat3.x = _WeaponDissolveValue * 2.0999999 + u_xlat3.x;
    u_xlat1.z = u_xlat3.x + -1.0;
    u_xlat10_3.xy = texture(_WeaponDissolveTex, u_xlat1.xz).xy;
    u_xlat16_6 = u_xlat10_3.y * 3.0;
    u_xlat0.x = u_xlat0.x * 0.5 + u_xlat16_6;
    u_xlat0.xzw = u_xlat0.xxx * _WeaponPatternColor.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_1.xyz = u_xlat10_1.xyz * _MainColor.xyz;
    u_xlat16_3 = u_xlat10_3.x * u_xlat10_1.w;
    u_xlat2.w = u_xlat16_3 * _MainColor.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(_EmissionScaler) + u_xlat0.xzw;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _EmissionScaler;
uniform 	vec4 _WeaponPatternTex_ST;
uniform 	float _Pattern_Speed;
uniform 	float _WeaponDissolveValue;
uniform 	vec4 _WeaponDissolveTex_ST;
uniform 	mediump float _DissolveDirection_Toggle;
uniform 	vec4 _WeaponPatternColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _WeaponPatternTex;
uniform lowp sampler2D _WeaponDissolveTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat7;
float u_xlat10;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.xy = vs_TEXCOORD1.xy * _WeaponPatternTex_ST.xy + _WeaponPatternTex_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_Pattern_Speed) + u_xlat1.xy;
    u_xlat10_1 = texture(_WeaponPatternTex, u_xlat1.xy).x;
    u_xlat2.xy = vs_TEXCOORD1.xy * _WeaponDissolveTex_ST.xy + _WeaponDissolveTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DissolveDirection_Toggle==1.0);
#else
    u_xlatb4 = _DissolveDirection_Toggle==1.0;
#endif
    u_xlat7.x = (-u_xlat2.y) + 1.0;
    u_xlat4.x = (u_xlatb4) ? u_xlat7.x : u_xlat2.y;
    u_xlat4.x = _WeaponDissolveValue * 2.0999999 + u_xlat4.x;
    u_xlat2.z = u_xlat4.x + -1.0;
    u_xlat4.xy = texture(_WeaponDissolveTex, u_xlat2.xz).xy;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat4.z = _WeaponDissolveValue + -0.25;
    u_xlat7.xy = vec2(u_xlat4.y * float(3.0), u_xlat4.z * float(6.28000021));
    u_xlat10 = sin(u_xlat7.y);
    u_xlat10 = u_xlat10 + 1.0;
    u_xlat1.x = u_xlat10_1 * u_xlat10;
    u_xlat1.x = u_xlat1.x * 0.5 + u_xlat7.x;
    u_xlat1.xzw = u_xlat1.xxx * _WeaponPatternColor.xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler) + u_xlat1.xzw;
    u_xlat0.x = u_xlat10_0.w * u_xlat4.x;
    u_xlat2.w = u_xlat0.x * _MainColor.w;
    SV_Target0 = u_xlat2;
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
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _EmissionScaler;
uniform 	vec4 _WeaponPatternTex_ST;
uniform 	float _Pattern_Speed;
uniform 	float _WeaponDissolveValue;
uniform 	vec4 _WeaponDissolveTex_ST;
uniform 	mediump float _DissolveDirection_Toggle;
uniform 	vec4 _WeaponPatternColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _WeaponPatternTex;
uniform lowp sampler2D _WeaponDissolveTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat7;
float u_xlat10;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.xy = vs_TEXCOORD1.xy * _WeaponPatternTex_ST.xy + _WeaponPatternTex_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_Pattern_Speed) + u_xlat1.xy;
    u_xlat10_1 = texture(_WeaponPatternTex, u_xlat1.xy).x;
    u_xlat2.xy = vs_TEXCOORD1.xy * _WeaponDissolveTex_ST.xy + _WeaponDissolveTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DissolveDirection_Toggle==1.0);
#else
    u_xlatb4 = _DissolveDirection_Toggle==1.0;
#endif
    u_xlat7.x = (-u_xlat2.y) + 1.0;
    u_xlat4.x = (u_xlatb4) ? u_xlat7.x : u_xlat2.y;
    u_xlat4.x = _WeaponDissolveValue * 2.0999999 + u_xlat4.x;
    u_xlat2.z = u_xlat4.x + -1.0;
    u_xlat4.xy = texture(_WeaponDissolveTex, u_xlat2.xz).xy;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat4.z = _WeaponDissolveValue + -0.25;
    u_xlat7.xy = vec2(u_xlat4.y * float(3.0), u_xlat4.z * float(6.28000021));
    u_xlat10 = sin(u_xlat7.y);
    u_xlat10 = u_xlat10 + 1.0;
    u_xlat1.x = u_xlat10_1 * u_xlat10;
    u_xlat1.x = u_xlat1.x * 0.5 + u_xlat7.x;
    u_xlat1.xzw = u_xlat1.xxx * _WeaponPatternColor.xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler) + u_xlat1.xzw;
    u_xlat0.x = u_xlat10_0.w * u_xlat4.x;
    u_xlat2.w = u_xlat0.x * _MainColor.w;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _EmissionScaler;
uniform 	vec4 _WeaponPatternTex_ST;
uniform 	float _Pattern_Speed;
uniform 	float _WeaponDissolveValue;
uniform 	vec4 _WeaponDissolveTex_ST;
uniform 	mediump float _DissolveDirection_Toggle;
uniform 	vec4 _WeaponPatternColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _WeaponPatternTex;
uniform lowp sampler2D _WeaponDissolveTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat7;
float u_xlat10;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.xy = vs_TEXCOORD1.xy * _WeaponPatternTex_ST.xy + _WeaponPatternTex_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_Pattern_Speed) + u_xlat1.xy;
    u_xlat10_1 = texture(_WeaponPatternTex, u_xlat1.xy).x;
    u_xlat2.xy = vs_TEXCOORD1.xy * _WeaponDissolveTex_ST.xy + _WeaponDissolveTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DissolveDirection_Toggle==1.0);
#else
    u_xlatb4 = _DissolveDirection_Toggle==1.0;
#endif
    u_xlat7.x = (-u_xlat2.y) + 1.0;
    u_xlat4.x = (u_xlatb4) ? u_xlat7.x : u_xlat2.y;
    u_xlat4.x = _WeaponDissolveValue * 2.0999999 + u_xlat4.x;
    u_xlat2.z = u_xlat4.x + -1.0;
    u_xlat4.xy = texture(_WeaponDissolveTex, u_xlat2.xz).xy;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat4.z = _WeaponDissolveValue + -0.25;
    u_xlat7.xy = vec2(u_xlat4.y * float(3.0), u_xlat4.z * float(6.28000021));
    u_xlat10 = sin(u_xlat7.y);
    u_xlat10 = u_xlat10 + 1.0;
    u_xlat1.x = u_xlat10_1 * u_xlat10;
    u_xlat1.x = u_xlat1.x * 0.5 + u_xlat7.x;
    u_xlat1.xzw = u_xlat1.xxx * _WeaponPatternColor.xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler) + u_xlat1.xzw;
    u_xlat0.x = u_xlat10_0.w * u_xlat4.x;
    u_xlat2.w = u_xlat0.x * _MainColor.w;
    SV_Target0 = u_xlat2;
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
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _EmissionScaler;
uniform 	vec4 _WeaponPatternTex_ST;
uniform 	float _Pattern_Speed;
uniform 	float _WeaponDissolveValue;
uniform 	vec4 _WeaponDissolveTex_ST;
uniform 	mediump float _DissolveDirection_Toggle;
uniform 	vec4 _WeaponPatternColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _WeaponPatternTex;
uniform lowp sampler2D _WeaponDissolveTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat7;
float u_xlat10;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.xy = vs_TEXCOORD1.xy * _WeaponPatternTex_ST.xy + _WeaponPatternTex_ST.zw;
    u_xlat1.xy = _Time.yy * vec2(_Pattern_Speed) + u_xlat1.xy;
    u_xlat10_1 = texture(_WeaponPatternTex, u_xlat1.xy).x;
    u_xlat2.xy = vs_TEXCOORD1.xy * _WeaponDissolveTex_ST.xy + _WeaponDissolveTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DissolveDirection_Toggle==1.0);
#else
    u_xlatb4 = _DissolveDirection_Toggle==1.0;
#endif
    u_xlat7.x = (-u_xlat2.y) + 1.0;
    u_xlat4.x = (u_xlatb4) ? u_xlat7.x : u_xlat2.y;
    u_xlat4.x = _WeaponDissolveValue * 2.0999999 + u_xlat4.x;
    u_xlat2.z = u_xlat4.x + -1.0;
    u_xlat4.xy = texture(_WeaponDissolveTex, u_xlat2.xz).xy;
    u_xlat16_0.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    u_xlat4.z = _WeaponDissolveValue + -0.25;
    u_xlat7.xy = vec2(u_xlat4.y * float(3.0), u_xlat4.z * float(6.28000021));
    u_xlat10 = sin(u_xlat7.y);
    u_xlat10 = u_xlat10 + 1.0;
    u_xlat1.x = u_xlat10_1 * u_xlat10;
    u_xlat1.x = u_xlat1.x * 0.5 + u_xlat7.x;
    u_xlat1.xzw = u_xlat1.xxx * _WeaponPatternColor.xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(_EmissionScaler) + u_xlat1.xzw;
    u_xlat0.x = u_xlat10_0.w * u_xlat4.x;
    u_xlat2.w = u_xlat0.x * _MainColor.w;
    SV_Target0 = u_xlat2;
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
}
}
 Pass {
  Name "MOTIONVECTORS"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "MOTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 69118
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousM[4];
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	int _HasLastPositionData;
uniform 	float _MotionVectorDepthBias;
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD0 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = in_NORMAL0.xyz;
    u_xlat1.w = 1.0;
    u_xlat1 = (_HasLastPositionData != 0) ? u_xlat1 : in_POSITION0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_PreviousM[1];
    u_xlat2 = hlslcc_mtx4x4_PreviousM[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_PreviousM[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_PreviousM[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat2 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD1 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat0.x * u_xlat0.w + u_xlat0.z;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	int _ForceNoMotion;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
ivec2 u_xlati0;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlat16_1.x = (_ForceNoMotion != 0) ? 1.0 : 0.0;
    u_xlat16_1.xy = u_xlat16_1.xx * (-u_xlat0.xy) + u_xlat0.xy;
    u_xlati0.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat16_1.xyxx).xy) * 0xFFFFFFFFu);
    u_xlati6.xy = ivec2(uvec2(lessThan(u_xlat16_1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat16_2.xy = sqrt(abs(u_xlat16_1.xy));
    u_xlati0.xy = (-u_xlati0.xy) + u_xlati6.xy;
    u_xlat0.xy = vec2(u_xlati0.xy);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_2.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat0.xy;
    SV_Target0.zw = vec2(1.0, 1.0);
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
CustomEditor "MiHoYoASEMaterialInspector"
}