//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/CG/Cg_Asmoday_HandEffect" {
Properties {
_MainTex ("MainTex", 2D) = "white" { }
_LineColor ("LineColor", Color) = (1,1,1,0)
_LightColor ("LightColor", Color) = (0.4117647,0.1665225,0.1665225,0)
_ShadowColor ("ShadowColor", Color) = (0.2941176,0.1319204,0.1319204,0)
_DownMaskRange ("DownMaskRange", Range(0, 1)) = 0.3058824
_TopMaskRange ("TopMaskRange", Range(0, 1)) = 0.1147379
_TopLineRange ("TopLineRange", Range(0, 1)) = 0.2101024
_FresnelColor ("FresnelColor", Color) = (1,0.7573529,0.7573529,0)
_FresnelPower ("FresnelPower", Float) = 5
_FresnelScale ("FresnelScale", Range(-1, 1)) = -0.4970588
_ShadowWidth ("Shadow Width", Range(0, 1)) = 0.5764706
_Tex01_UV ("Tex01_UV", Vector) = (1,1,0,0)
_Tex01_Speed_U ("Tex01_Speed_U", Float) = 0.1
_Tex01_Speed_V ("Tex01_Speed_V", Float) = 0
_Tex02_UV ("Tex02_UV", Vector) = (1,1,0,0)
_Tex02_Speed_U ("Tex02_Speed_U", Float) = -0.1
_Tex02_Speed_V ("Tex02_Speed_V", Float) = 0
_Tex03_UV ("Tex03_UV", Vector) = (1,1,0,0)
_Tex03_Speed_U ("Tex03_Speed_U", Float) = 0
_Tex03_Speed_V ("Tex03_Speed_V", Float) = -0.5
_Tex04_UV ("Tex04_UV", Vector) = (1,1,0,-0.01)
_Tex04_Speed_U ("Tex04_Speed_U", Float) = 0
_Tex04_Speed_V ("Tex04_Speed_V", Float) = 0
_Tex05_UV ("Tex05_UV", Vector) = (1,1,0,0)
_Tex05_Speed_U ("Tex05_Speed_U", Float) = 0
_Tex05_Speed_V ("Tex05_Speed_V", Float) = 0
_Mask ("Mask", 2D) = "white" { }
_Mask_Speed_U ("Mask_Speed_U", Float) = -0.1
_GradientPower ("GradientPower", Float) = 1
_GradientScale ("GradientScale", Float) = 1
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
  GpuProgramID 44485
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelScale;
uniform 	mediump float _FresnelPower;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _Tex01_Speed_U;
uniform 	mediump float _Tex01_Speed_V;
uniform 	mediump vec4 _Tex01_UV;
uniform 	mediump float _Tex02_Speed_U;
uniform 	mediump float _Tex02_Speed_V;
uniform 	mediump vec4 _Tex02_UV;
uniform 	mediump float _Tex03_Speed_U;
uniform 	mediump float _Tex03_Speed_V;
uniform 	mediump vec4 _Tex03_UV;
uniform 	mediump float _Mask_Speed_U;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _TopMaskRange;
uniform 	mediump float _Tex04_Speed_U;
uniform 	mediump float _Tex04_Speed_V;
uniform 	mediump vec4 _Tex04_UV;
uniform 	mediump float _Tex05_Speed_U;
uniform 	mediump float _Tex05_Speed_V;
uniform 	mediump vec4 _Tex05_UV;
uniform 	mediump float _TopLineRange;
uniform 	mediump float _DownMaskRange;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _ShadowWidth;
uniform 	mediump float _GradientPower;
uniform 	mediump float _GradientScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
lowp float u_xlat10_7;
bool u_xlatb7;
vec3 u_xlat8;
mediump vec2 u_xlat16_10;
mediump float u_xlat16_17;
float u_xlat21;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat1.x = _Time.y * _Mask_Speed_U;
    u_xlat1.y = 0.0;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat10_0.xyz = texture(_Mask, u_xlat0.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy * _Tex01_UV.xy + _Tex01_UV.zw;
    u_xlat1.xy = _Time.yy * vec2(_Tex01_Speed_U, _Tex01_Speed_V) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyw;
    u_xlat2.xy = vs_TEXCOORD2.xy * _Tex02_UV.xy + _Tex02_UV.zw;
    u_xlat2.xy = _Time.yy * vec2(_Tex02_Speed_U, _Tex02_Speed_V) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyw;
    u_xlat16_3.x = max(u_xlat10_1.y, u_xlat10_2.y);
    u_xlat8.xz = vs_TEXCOORD2.xy * _Tex03_UV.xy + _Tex03_UV.zw;
    u_xlat8.xz = _Time.yy * vec2(_Tex03_Speed_U, _Tex03_Speed_V) + u_xlat8.xz;
    u_xlat10_4.xyz = texture(_MainTex, u_xlat8.xz).xyw;
    u_xlat16_3.x = max(u_xlat16_3.x, u_xlat10_4.y);
    u_xlat16_10.xy = u_xlat10_0.xz * u_xlat10_4.zx;
    u_xlat16_3.x = max(u_xlat10_0.y, u_xlat16_3.x);
    u_xlat16_10.xy = u_xlat10_1.zx * u_xlat10_2.zx + u_xlat16_10.xy;
    u_xlat16_3.x = (-u_xlat16_10.y) + u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD0.x>=_DownMaskRange);
#else
    u_xlatb0 = vs_TEXCOORD0.x>=_DownMaskRange;
#endif
    u_xlat16_17 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_10.x = u_xlat16_17 * u_xlat16_10.x;
    u_xlat0.xy = vs_TEXCOORD2.xy * _Tex04_UV.xy + _Tex04_UV.zw;
    u_xlat0.xy = _Time.yy * vec2(_Tex04_Speed_U, _Tex04_Speed_V) + u_xlat0.xy;
    u_xlat10_0.x = texture(_MainTex, u_xlat0.xy).z;
    u_xlat7.xy = vs_TEXCOORD2.xy * _Tex05_UV.xy + _Tex05_UV.zw;
    u_xlat7.xy = _Time.yy * vec2(_Tex05_Speed_U, _Tex05_Speed_V) + u_xlat7.xy;
    u_xlat10_7 = texture(_MainTex, u_xlat7.xy).z;
    u_xlat0.x = u_xlat10_7 * u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=_TopMaskRange);
#else
    u_xlatb7 = u_xlat0.x>=_TopMaskRange;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=_TopLineRange);
#else
    u_xlatb0 = u_xlat0.x>=_TopLineRange;
#endif
    u_xlat16_17 = (u_xlatb0) ? -1.0 : -0.0;
    u_xlat16_24 = (u_xlatb7) ? 1.0 : 0.0;
    u_xlat16_10.x = u_xlat16_24 * u_xlat16_10.x;
    u_xlat16_17 = u_xlat16_17 + u_xlat16_24;
    u_xlat16_17 = u_xlat16_10.x * u_xlat16_17;
    u_xlat16_3.x = max(u_xlat16_17, u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _LineColor.xyz + (-_LightColor.xyz);
    u_xlat16_5.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz + _LightColor.xyz;
    u_xlat16_6.xyz = (-_ShadowColor.xyz) + _LineColor.xyz;
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_6.xyz + _ShadowColor.xyz;
    u_xlat16_5.xyz = (-u_xlat16_3.xzw) + u_xlat16_5.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_26 = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_26 = (-u_xlat16_26) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ShadowWidth>=u_xlat16_26);
#else
    u_xlatb0 = _ShadowWidth>=u_xlat16_26;
#endif
    u_xlat16_26 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_3.xzw = vec3(u_xlat16_26) * u_xlat16_5.xyz + u_xlat16_3.xzw;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat21 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_5.x = (-u_xlat0.x) + 1.0;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _FresnelPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x + _FresnelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = _FresnelColor.xyz * u_xlat16_5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.x = max(vs_TEXCOORD2.y, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _GradientPower;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _GradientScale;
    SV_Target0.w = u_xlat16_3.x * u_xlat16_10.x;
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
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
float u_xlat0;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat1.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD4.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelScale;
uniform 	mediump float _FresnelPower;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _Tex01_Speed_U;
uniform 	mediump float _Tex01_Speed_V;
uniform 	mediump vec4 _Tex01_UV;
uniform 	mediump float _Tex02_Speed_U;
uniform 	mediump float _Tex02_Speed_V;
uniform 	mediump vec4 _Tex02_UV;
uniform 	mediump float _Tex03_Speed_U;
uniform 	mediump float _Tex03_Speed_V;
uniform 	mediump vec4 _Tex03_UV;
uniform 	mediump float _Mask_Speed_U;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _TopMaskRange;
uniform 	mediump float _Tex04_Speed_U;
uniform 	mediump float _Tex04_Speed_V;
uniform 	mediump vec4 _Tex04_UV;
uniform 	mediump float _Tex05_Speed_U;
uniform 	mediump float _Tex05_Speed_V;
uniform 	mediump vec4 _Tex05_UV;
uniform 	mediump float _TopLineRange;
uniform 	mediump float _DownMaskRange;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _ShadowWidth;
uniform 	mediump float _GradientPower;
uniform 	mediump float _GradientScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
lowp float u_xlat10_7;
bool u_xlatb7;
vec3 u_xlat8;
mediump vec2 u_xlat16_10;
mediump float u_xlat16_17;
float u_xlat21;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat1.x = _Time.y * _Mask_Speed_U;
    u_xlat1.y = 0.0;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat10_0.xyz = texture(_Mask, u_xlat0.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy * _Tex01_UV.xy + _Tex01_UV.zw;
    u_xlat1.xy = _Time.yy * vec2(_Tex01_Speed_U, _Tex01_Speed_V) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyw;
    u_xlat2.xy = vs_TEXCOORD2.xy * _Tex02_UV.xy + _Tex02_UV.zw;
    u_xlat2.xy = _Time.yy * vec2(_Tex02_Speed_U, _Tex02_Speed_V) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyw;
    u_xlat16_3.x = max(u_xlat10_1.y, u_xlat10_2.y);
    u_xlat8.xz = vs_TEXCOORD2.xy * _Tex03_UV.xy + _Tex03_UV.zw;
    u_xlat8.xz = _Time.yy * vec2(_Tex03_Speed_U, _Tex03_Speed_V) + u_xlat8.xz;
    u_xlat10_4.xyz = texture(_MainTex, u_xlat8.xz).xyw;
    u_xlat16_3.x = max(u_xlat16_3.x, u_xlat10_4.y);
    u_xlat16_10.xy = u_xlat10_0.xz * u_xlat10_4.zx;
    u_xlat16_3.x = max(u_xlat10_0.y, u_xlat16_3.x);
    u_xlat16_10.xy = u_xlat10_1.zx * u_xlat10_2.zx + u_xlat16_10.xy;
    u_xlat16_3.x = (-u_xlat16_10.y) + u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD0.x>=_DownMaskRange);
#else
    u_xlatb0 = vs_TEXCOORD0.x>=_DownMaskRange;
#endif
    u_xlat16_17 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_10.x = u_xlat16_17 * u_xlat16_10.x;
    u_xlat0.xy = vs_TEXCOORD2.xy * _Tex04_UV.xy + _Tex04_UV.zw;
    u_xlat0.xy = _Time.yy * vec2(_Tex04_Speed_U, _Tex04_Speed_V) + u_xlat0.xy;
    u_xlat10_0.x = texture(_MainTex, u_xlat0.xy).z;
    u_xlat7.xy = vs_TEXCOORD2.xy * _Tex05_UV.xy + _Tex05_UV.zw;
    u_xlat7.xy = _Time.yy * vec2(_Tex05_Speed_U, _Tex05_Speed_V) + u_xlat7.xy;
    u_xlat10_7 = texture(_MainTex, u_xlat7.xy).z;
    u_xlat0.x = u_xlat10_7 * u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=_TopMaskRange);
#else
    u_xlatb7 = u_xlat0.x>=_TopMaskRange;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=_TopLineRange);
#else
    u_xlatb0 = u_xlat0.x>=_TopLineRange;
#endif
    u_xlat16_17 = (u_xlatb0) ? -1.0 : -0.0;
    u_xlat16_24 = (u_xlatb7) ? 1.0 : 0.0;
    u_xlat16_10.x = u_xlat16_24 * u_xlat16_10.x;
    u_xlat16_17 = u_xlat16_17 + u_xlat16_24;
    u_xlat16_17 = u_xlat16_10.x * u_xlat16_17;
    u_xlat16_3.x = max(u_xlat16_17, u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _LineColor.xyz + (-_LightColor.xyz);
    u_xlat16_5.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz + _LightColor.xyz;
    u_xlat16_6.xyz = (-_ShadowColor.xyz) + _LineColor.xyz;
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_6.xyz + _ShadowColor.xyz;
    u_xlat16_5.xyz = (-u_xlat16_3.xzw) + u_xlat16_5.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_26 = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_26 = (-u_xlat16_26) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ShadowWidth>=u_xlat16_26);
#else
    u_xlatb0 = _ShadowWidth>=u_xlat16_26;
#endif
    u_xlat16_26 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_3.xzw = vec3(u_xlat16_26) * u_xlat16_5.xyz + u_xlat16_3.xzw;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat21 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_5.x = (-u_xlat0.x) + 1.0;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _FresnelPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x + _FresnelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = _FresnelColor.xyz * u_xlat16_5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.x = max(vs_TEXCOORD2.y, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _GradientPower;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _GradientScale;
    SV_Target0.w = u_xlat16_3.x * u_xlat16_10.x;
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
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelScale;
uniform 	mediump float _FresnelPower;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _Tex01_Speed_U;
uniform 	mediump float _Tex01_Speed_V;
uniform 	mediump vec4 _Tex01_UV;
uniform 	mediump float _Tex02_Speed_U;
uniform 	mediump float _Tex02_Speed_V;
uniform 	mediump vec4 _Tex02_UV;
uniform 	mediump float _Tex03_Speed_U;
uniform 	mediump float _Tex03_Speed_V;
uniform 	mediump vec4 _Tex03_UV;
uniform 	mediump float _Mask_Speed_U;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _TopMaskRange;
uniform 	mediump float _Tex04_Speed_U;
uniform 	mediump float _Tex04_Speed_V;
uniform 	mediump vec4 _Tex04_UV;
uniform 	mediump float _Tex05_Speed_U;
uniform 	mediump float _Tex05_Speed_V;
uniform 	mediump vec4 _Tex05_UV;
uniform 	mediump float _TopLineRange;
uniform 	mediump float _DownMaskRange;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _ShadowWidth;
uniform 	mediump float _GradientPower;
uniform 	mediump float _GradientScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
lowp float u_xlat10_7;
bool u_xlatb7;
vec3 u_xlat8;
mediump vec2 u_xlat16_10;
mediump float u_xlat16_17;
float u_xlat21;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat1.x = _Time.y * _Mask_Speed_U;
    u_xlat1.y = 0.0;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat10_0.xyz = texture(_Mask, u_xlat0.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy * _Tex01_UV.xy + _Tex01_UV.zw;
    u_xlat1.xy = _Time.yy * vec2(_Tex01_Speed_U, _Tex01_Speed_V) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyw;
    u_xlat2.xy = vs_TEXCOORD2.xy * _Tex02_UV.xy + _Tex02_UV.zw;
    u_xlat2.xy = _Time.yy * vec2(_Tex02_Speed_U, _Tex02_Speed_V) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyw;
    u_xlat16_3.x = max(u_xlat10_1.y, u_xlat10_2.y);
    u_xlat8.xz = vs_TEXCOORD2.xy * _Tex03_UV.xy + _Tex03_UV.zw;
    u_xlat8.xz = _Time.yy * vec2(_Tex03_Speed_U, _Tex03_Speed_V) + u_xlat8.xz;
    u_xlat10_4.xyz = texture(_MainTex, u_xlat8.xz).xyw;
    u_xlat16_3.x = max(u_xlat16_3.x, u_xlat10_4.y);
    u_xlat16_10.xy = u_xlat10_0.xz * u_xlat10_4.zx;
    u_xlat16_3.x = max(u_xlat10_0.y, u_xlat16_3.x);
    u_xlat16_10.xy = u_xlat10_1.zx * u_xlat10_2.zx + u_xlat16_10.xy;
    u_xlat16_3.x = (-u_xlat16_10.y) + u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD0.x>=_DownMaskRange);
#else
    u_xlatb0 = vs_TEXCOORD0.x>=_DownMaskRange;
#endif
    u_xlat16_17 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_10.x = u_xlat16_17 * u_xlat16_10.x;
    u_xlat0.xy = vs_TEXCOORD2.xy * _Tex04_UV.xy + _Tex04_UV.zw;
    u_xlat0.xy = _Time.yy * vec2(_Tex04_Speed_U, _Tex04_Speed_V) + u_xlat0.xy;
    u_xlat10_0.x = texture(_MainTex, u_xlat0.xy).z;
    u_xlat7.xy = vs_TEXCOORD2.xy * _Tex05_UV.xy + _Tex05_UV.zw;
    u_xlat7.xy = _Time.yy * vec2(_Tex05_Speed_U, _Tex05_Speed_V) + u_xlat7.xy;
    u_xlat10_7 = texture(_MainTex, u_xlat7.xy).z;
    u_xlat0.x = u_xlat10_7 * u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=_TopMaskRange);
#else
    u_xlatb7 = u_xlat0.x>=_TopMaskRange;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=_TopLineRange);
#else
    u_xlatb0 = u_xlat0.x>=_TopLineRange;
#endif
    u_xlat16_17 = (u_xlatb0) ? -1.0 : -0.0;
    u_xlat16_24 = (u_xlatb7) ? 1.0 : 0.0;
    u_xlat16_10.x = u_xlat16_24 * u_xlat16_10.x;
    u_xlat16_17 = u_xlat16_17 + u_xlat16_24;
    u_xlat16_17 = u_xlat16_10.x * u_xlat16_17;
    u_xlat16_3.x = max(u_xlat16_17, u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _LineColor.xyz + (-_LightColor.xyz);
    u_xlat16_5.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz + _LightColor.xyz;
    u_xlat16_6.xyz = (-_ShadowColor.xyz) + _LineColor.xyz;
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_6.xyz + _ShadowColor.xyz;
    u_xlat16_5.xyz = (-u_xlat16_3.xzw) + u_xlat16_5.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_26 = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_26 = (-u_xlat16_26) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ShadowWidth>=u_xlat16_26);
#else
    u_xlatb0 = _ShadowWidth>=u_xlat16_26;
#endif
    u_xlat16_26 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_3.xzw = vec3(u_xlat16_26) * u_xlat16_5.xyz + u_xlat16_3.xzw;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat21 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_5.x = (-u_xlat0.x) + 1.0;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _FresnelPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x + _FresnelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = _FresnelColor.xyz * u_xlat16_5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.x = max(vs_TEXCOORD2.y, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _GradientPower;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _GradientScale;
    SV_Target0.w = u_xlat16_3.x * u_xlat16_10.x;
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
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
float u_xlat0;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat1.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD4.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelScale;
uniform 	mediump float _FresnelPower;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _Tex01_Speed_U;
uniform 	mediump float _Tex01_Speed_V;
uniform 	mediump vec4 _Tex01_UV;
uniform 	mediump float _Tex02_Speed_U;
uniform 	mediump float _Tex02_Speed_V;
uniform 	mediump vec4 _Tex02_UV;
uniform 	mediump float _Tex03_Speed_U;
uniform 	mediump float _Tex03_Speed_V;
uniform 	mediump vec4 _Tex03_UV;
uniform 	mediump float _Mask_Speed_U;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _TopMaskRange;
uniform 	mediump float _Tex04_Speed_U;
uniform 	mediump float _Tex04_Speed_V;
uniform 	mediump vec4 _Tex04_UV;
uniform 	mediump float _Tex05_Speed_U;
uniform 	mediump float _Tex05_Speed_V;
uniform 	mediump vec4 _Tex05_UV;
uniform 	mediump float _TopLineRange;
uniform 	mediump float _DownMaskRange;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _ShadowWidth;
uniform 	mediump float _GradientPower;
uniform 	mediump float _GradientScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
lowp float u_xlat10_7;
bool u_xlatb7;
vec3 u_xlat8;
mediump vec2 u_xlat16_10;
mediump float u_xlat16_17;
float u_xlat21;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat1.x = _Time.y * _Mask_Speed_U;
    u_xlat1.y = 0.0;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat10_0.xyz = texture(_Mask, u_xlat0.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD2.xy * _Tex01_UV.xy + _Tex01_UV.zw;
    u_xlat1.xy = _Time.yy * vec2(_Tex01_Speed_U, _Tex01_Speed_V) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyw;
    u_xlat2.xy = vs_TEXCOORD2.xy * _Tex02_UV.xy + _Tex02_UV.zw;
    u_xlat2.xy = _Time.yy * vec2(_Tex02_Speed_U, _Tex02_Speed_V) + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_MainTex, u_xlat2.xy).xyw;
    u_xlat16_3.x = max(u_xlat10_1.y, u_xlat10_2.y);
    u_xlat8.xz = vs_TEXCOORD2.xy * _Tex03_UV.xy + _Tex03_UV.zw;
    u_xlat8.xz = _Time.yy * vec2(_Tex03_Speed_U, _Tex03_Speed_V) + u_xlat8.xz;
    u_xlat10_4.xyz = texture(_MainTex, u_xlat8.xz).xyw;
    u_xlat16_3.x = max(u_xlat16_3.x, u_xlat10_4.y);
    u_xlat16_10.xy = u_xlat10_0.xz * u_xlat10_4.zx;
    u_xlat16_3.x = max(u_xlat10_0.y, u_xlat16_3.x);
    u_xlat16_10.xy = u_xlat10_1.zx * u_xlat10_2.zx + u_xlat16_10.xy;
    u_xlat16_3.x = (-u_xlat16_10.y) + u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD0.x>=_DownMaskRange);
#else
    u_xlatb0 = vs_TEXCOORD0.x>=_DownMaskRange;
#endif
    u_xlat16_17 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_10.x = u_xlat16_17 * u_xlat16_10.x;
    u_xlat0.xy = vs_TEXCOORD2.xy * _Tex04_UV.xy + _Tex04_UV.zw;
    u_xlat0.xy = _Time.yy * vec2(_Tex04_Speed_U, _Tex04_Speed_V) + u_xlat0.xy;
    u_xlat10_0.x = texture(_MainTex, u_xlat0.xy).z;
    u_xlat7.xy = vs_TEXCOORD2.xy * _Tex05_UV.xy + _Tex05_UV.zw;
    u_xlat7.xy = _Time.yy * vec2(_Tex05_Speed_U, _Tex05_Speed_V) + u_xlat7.xy;
    u_xlat10_7 = texture(_MainTex, u_xlat7.xy).z;
    u_xlat0.x = u_xlat10_7 * u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat0.x>=_TopMaskRange);
#else
    u_xlatb7 = u_xlat0.x>=_TopMaskRange;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=_TopLineRange);
#else
    u_xlatb0 = u_xlat0.x>=_TopLineRange;
#endif
    u_xlat16_17 = (u_xlatb0) ? -1.0 : -0.0;
    u_xlat16_24 = (u_xlatb7) ? 1.0 : 0.0;
    u_xlat16_10.x = u_xlat16_24 * u_xlat16_10.x;
    u_xlat16_17 = u_xlat16_17 + u_xlat16_24;
    u_xlat16_17 = u_xlat16_10.x * u_xlat16_17;
    u_xlat16_3.x = max(u_xlat16_17, u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _LineColor.xyz + (-_LightColor.xyz);
    u_xlat16_5.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz + _LightColor.xyz;
    u_xlat16_6.xyz = (-_ShadowColor.xyz) + _LineColor.xyz;
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_6.xyz + _ShadowColor.xyz;
    u_xlat16_5.xyz = (-u_xlat16_3.xzw) + u_xlat16_5.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_26 = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_26 = (-u_xlat16_26) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_ShadowWidth>=u_xlat16_26);
#else
    u_xlatb0 = _ShadowWidth>=u_xlat16_26;
#endif
    u_xlat16_26 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_3.xzw = vec3(u_xlat16_26) * u_xlat16_5.xyz + u_xlat16_3.xzw;
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat21 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_5.x = (-u_xlat0.x) + 1.0;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _FresnelPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x + _FresnelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = _FresnelColor.xyz * u_xlat16_5.xxx + u_xlat16_3.xzw;
    u_xlat16_3.x = max(vs_TEXCOORD2.y, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _GradientPower;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _GradientScale;
    SV_Target0.w = u_xlat16_3.x * u_xlat16_10.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelScale;
uniform 	mediump float _FresnelPower;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _Tex01_Speed_U;
uniform 	mediump float _Tex01_Speed_V;
uniform 	mediump vec4 _Tex01_UV;
uniform 	mediump float _Tex02_Speed_U;
uniform 	mediump float _Tex02_Speed_V;
uniform 	mediump vec4 _Tex02_UV;
uniform 	mediump float _Tex03_Speed_U;
uniform 	mediump float _Tex03_Speed_V;
uniform 	mediump vec4 _Tex03_UV;
uniform 	mediump float _Mask_Speed_U;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _TopMaskRange;
uniform 	mediump float _Tex04_Speed_U;
uniform 	mediump float _Tex04_Speed_V;
uniform 	mediump vec4 _Tex04_UV;
uniform 	mediump float _Tex05_Speed_U;
uniform 	mediump float _Tex05_Speed_V;
uniform 	mediump vec4 _Tex05_UV;
uniform 	mediump float _TopLineRange;
uniform 	mediump float _DownMaskRange;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _ShadowWidth;
uniform 	mediump float _GradientPower;
uniform 	mediump float _GradientScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
lowp vec3 u_xlat10_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_10;
mediump float u_xlat16_18;
vec2 u_xlat21;
float u_xlat24;
lowp float u_xlat10_24;
bool u_xlatb24;
lowp float u_xlat10_25;
bool u_xlatb25;
mediump float u_xlat16_26;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_2 = log2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _FresnelPower;
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 + _FresnelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xy = vs_TEXCOORD2.xy * _Tex01_UV.xy + _Tex01_UV.zw;
    u_xlat0.xy = _Time.yy * vec2(_Tex01_Speed_U, _Tex01_Speed_V) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyw;
    u_xlat1.xy = vs_TEXCOORD2.xy * _Tex02_UV.xy + _Tex02_UV.zw;
    u_xlat1.xy = _Time.yy * vec2(_Tex02_Speed_U, _Tex02_Speed_V) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyw;
    u_xlat3.xy = vs_TEXCOORD2.xy * _Tex03_UV.xy + _Tex03_UV.zw;
    u_xlat3.xy = _Time.yy * vec2(_Tex03_Speed_U, _Tex03_Speed_V) + u_xlat3.xy;
    u_xlat10_3.xyz = texture(_MainTex, u_xlat3.xy).xyw;
    u_xlat4.xy = vs_TEXCOORD2.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat5.x = _Time.y * _Mask_Speed_U;
    u_xlat5.y = 0.0;
    u_xlat4.xy = u_xlat4.xy + u_xlat5.xy;
    u_xlat10_4.xyz = texture(_Mask, u_xlat4.xy).xyz;
    u_xlat5.xy = vs_TEXCOORD2.xy * _Tex04_UV.xy + _Tex04_UV.zw;
    u_xlat5.xy = _Time.yy * vec2(_Tex04_Speed_U, _Tex04_Speed_V) + u_xlat5.xy;
    u_xlat21.xy = vs_TEXCOORD2.xy * _Tex05_UV.xy + _Tex05_UV.zw;
    u_xlat21.xy = _Time.yy * vec2(_Tex05_Speed_U, _Tex05_Speed_V) + u_xlat21.xy;
    u_xlat10_24 = texture(_MainTex, u_xlat5.xy).z;
    u_xlat10_25 = texture(_MainTex, u_xlat21.xy).z;
    u_xlat24 = u_xlat10_24 * u_xlat10_25;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(u_xlat24>=_TopMaskRange);
#else
    u_xlatb25 = u_xlat24>=_TopMaskRange;
#endif
    u_xlat16_10 = (u_xlatb25) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24>=_TopLineRange);
#else
    u_xlatb24 = u_xlat24>=_TopLineRange;
#endif
    u_xlat16_18 = (u_xlatb24) ? -1.0 : -0.0;
    u_xlat16_18 = u_xlat16_18 + u_xlat16_10;
    u_xlat16_6.xy = u_xlat10_3.zx * u_xlat10_4.xz;
    u_xlat16_6.xy = u_xlat10_0.zx * u_xlat10_1.zx + u_xlat16_6.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vs_TEXCOORD0.x>=_DownMaskRange);
#else
    u_xlatb0.x = vs_TEXCOORD0.x>=_DownMaskRange;
#endif
    u_xlat16_26 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_26;
    u_xlat16_26 = max(u_xlat10_0.y, u_xlat10_1.y);
    u_xlat16_26 = max(u_xlat10_3.y, u_xlat16_26);
    u_xlat16_26 = max(u_xlat10_4.y, u_xlat16_26);
    u_xlat16_26 = (-u_xlat16_6.y) + u_xlat16_26;
    u_xlat16_18 = u_xlat16_10 * u_xlat16_18;
    u_xlat16_18 = max(u_xlat16_18, u_xlat16_26);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = (-_ShadowColor.xyz) + _LineColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_18) * u_xlat16_6.xyz + _ShadowColor.xyz;
    u_xlat16_7.xyz = _LineColor.xyz + (-_LightColor.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_18) * u_xlat16_7.xyz + _LightColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_18 = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_18 = (-u_xlat16_18) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_ShadowWidth>=u_xlat16_18);
#else
    u_xlatb0.x = _ShadowWidth>=u_xlat16_18;
#endif
    u_xlat16_18 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_18) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = _FresnelColor.xyz * vec3(u_xlat16_2) + u_xlat16_6.xyz;
    u_xlat16_2 = max(vs_TEXCOORD2.y, 9.99999975e-05);
    u_xlat16_2 = log2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _GradientPower;
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _GradientScale;
    SV_Target0.w = u_xlat16_2 * u_xlat16_10;
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
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
float u_xlat0;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat1.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD4.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelScale;
uniform 	mediump float _FresnelPower;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _Tex01_Speed_U;
uniform 	mediump float _Tex01_Speed_V;
uniform 	mediump vec4 _Tex01_UV;
uniform 	mediump float _Tex02_Speed_U;
uniform 	mediump float _Tex02_Speed_V;
uniform 	mediump vec4 _Tex02_UV;
uniform 	mediump float _Tex03_Speed_U;
uniform 	mediump float _Tex03_Speed_V;
uniform 	mediump vec4 _Tex03_UV;
uniform 	mediump float _Mask_Speed_U;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _TopMaskRange;
uniform 	mediump float _Tex04_Speed_U;
uniform 	mediump float _Tex04_Speed_V;
uniform 	mediump vec4 _Tex04_UV;
uniform 	mediump float _Tex05_Speed_U;
uniform 	mediump float _Tex05_Speed_V;
uniform 	mediump vec4 _Tex05_UV;
uniform 	mediump float _TopLineRange;
uniform 	mediump float _DownMaskRange;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _ShadowWidth;
uniform 	mediump float _GradientPower;
uniform 	mediump float _GradientScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
lowp vec3 u_xlat10_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_10;
mediump float u_xlat16_18;
vec2 u_xlat21;
float u_xlat24;
lowp float u_xlat10_24;
bool u_xlatb24;
lowp float u_xlat10_25;
bool u_xlatb25;
mediump float u_xlat16_26;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_2 = log2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _FresnelPower;
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 + _FresnelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xy = vs_TEXCOORD2.xy * _Tex01_UV.xy + _Tex01_UV.zw;
    u_xlat0.xy = _Time.yy * vec2(_Tex01_Speed_U, _Tex01_Speed_V) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyw;
    u_xlat1.xy = vs_TEXCOORD2.xy * _Tex02_UV.xy + _Tex02_UV.zw;
    u_xlat1.xy = _Time.yy * vec2(_Tex02_Speed_U, _Tex02_Speed_V) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyw;
    u_xlat3.xy = vs_TEXCOORD2.xy * _Tex03_UV.xy + _Tex03_UV.zw;
    u_xlat3.xy = _Time.yy * vec2(_Tex03_Speed_U, _Tex03_Speed_V) + u_xlat3.xy;
    u_xlat10_3.xyz = texture(_MainTex, u_xlat3.xy).xyw;
    u_xlat4.xy = vs_TEXCOORD2.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat5.x = _Time.y * _Mask_Speed_U;
    u_xlat5.y = 0.0;
    u_xlat4.xy = u_xlat4.xy + u_xlat5.xy;
    u_xlat10_4.xyz = texture(_Mask, u_xlat4.xy).xyz;
    u_xlat5.xy = vs_TEXCOORD2.xy * _Tex04_UV.xy + _Tex04_UV.zw;
    u_xlat5.xy = _Time.yy * vec2(_Tex04_Speed_U, _Tex04_Speed_V) + u_xlat5.xy;
    u_xlat21.xy = vs_TEXCOORD2.xy * _Tex05_UV.xy + _Tex05_UV.zw;
    u_xlat21.xy = _Time.yy * vec2(_Tex05_Speed_U, _Tex05_Speed_V) + u_xlat21.xy;
    u_xlat10_24 = texture(_MainTex, u_xlat5.xy).z;
    u_xlat10_25 = texture(_MainTex, u_xlat21.xy).z;
    u_xlat24 = u_xlat10_24 * u_xlat10_25;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(u_xlat24>=_TopMaskRange);
#else
    u_xlatb25 = u_xlat24>=_TopMaskRange;
#endif
    u_xlat16_10 = (u_xlatb25) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24>=_TopLineRange);
#else
    u_xlatb24 = u_xlat24>=_TopLineRange;
#endif
    u_xlat16_18 = (u_xlatb24) ? -1.0 : -0.0;
    u_xlat16_18 = u_xlat16_18 + u_xlat16_10;
    u_xlat16_6.xy = u_xlat10_3.zx * u_xlat10_4.xz;
    u_xlat16_6.xy = u_xlat10_0.zx * u_xlat10_1.zx + u_xlat16_6.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vs_TEXCOORD0.x>=_DownMaskRange);
#else
    u_xlatb0.x = vs_TEXCOORD0.x>=_DownMaskRange;
#endif
    u_xlat16_26 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_26;
    u_xlat16_26 = max(u_xlat10_0.y, u_xlat10_1.y);
    u_xlat16_26 = max(u_xlat10_3.y, u_xlat16_26);
    u_xlat16_26 = max(u_xlat10_4.y, u_xlat16_26);
    u_xlat16_26 = (-u_xlat16_6.y) + u_xlat16_26;
    u_xlat16_18 = u_xlat16_10 * u_xlat16_18;
    u_xlat16_18 = max(u_xlat16_18, u_xlat16_26);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = (-_ShadowColor.xyz) + _LineColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_18) * u_xlat16_6.xyz + _ShadowColor.xyz;
    u_xlat16_7.xyz = _LineColor.xyz + (-_LightColor.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_18) * u_xlat16_7.xyz + _LightColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_18 = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_18 = (-u_xlat16_18) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_ShadowWidth>=u_xlat16_18);
#else
    u_xlatb0.x = _ShadowWidth>=u_xlat16_18;
#endif
    u_xlat16_18 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_18) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = _FresnelColor.xyz * vec3(u_xlat16_2) + u_xlat16_6.xyz;
    u_xlat16_2 = max(vs_TEXCOORD2.y, 9.99999975e-05);
    u_xlat16_2 = log2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _GradientPower;
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _GradientScale;
    SV_Target0.w = u_xlat16_2 * u_xlat16_10;
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
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
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
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD3.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelScale;
uniform 	mediump float _FresnelPower;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _Tex01_Speed_U;
uniform 	mediump float _Tex01_Speed_V;
uniform 	mediump vec4 _Tex01_UV;
uniform 	mediump float _Tex02_Speed_U;
uniform 	mediump float _Tex02_Speed_V;
uniform 	mediump vec4 _Tex02_UV;
uniform 	mediump float _Tex03_Speed_U;
uniform 	mediump float _Tex03_Speed_V;
uniform 	mediump vec4 _Tex03_UV;
uniform 	mediump float _Mask_Speed_U;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _TopMaskRange;
uniform 	mediump float _Tex04_Speed_U;
uniform 	mediump float _Tex04_Speed_V;
uniform 	mediump vec4 _Tex04_UV;
uniform 	mediump float _Tex05_Speed_U;
uniform 	mediump float _Tex05_Speed_V;
uniform 	mediump vec4 _Tex05_UV;
uniform 	mediump float _TopLineRange;
uniform 	mediump float _DownMaskRange;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _ShadowWidth;
uniform 	mediump float _GradientPower;
uniform 	mediump float _GradientScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
lowp vec3 u_xlat10_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_10;
mediump float u_xlat16_18;
vec2 u_xlat21;
float u_xlat24;
lowp float u_xlat10_24;
bool u_xlatb24;
lowp float u_xlat10_25;
bool u_xlatb25;
mediump float u_xlat16_26;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_2 = log2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _FresnelPower;
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 + _FresnelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xy = vs_TEXCOORD2.xy * _Tex01_UV.xy + _Tex01_UV.zw;
    u_xlat0.xy = _Time.yy * vec2(_Tex01_Speed_U, _Tex01_Speed_V) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyw;
    u_xlat1.xy = vs_TEXCOORD2.xy * _Tex02_UV.xy + _Tex02_UV.zw;
    u_xlat1.xy = _Time.yy * vec2(_Tex02_Speed_U, _Tex02_Speed_V) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyw;
    u_xlat3.xy = vs_TEXCOORD2.xy * _Tex03_UV.xy + _Tex03_UV.zw;
    u_xlat3.xy = _Time.yy * vec2(_Tex03_Speed_U, _Tex03_Speed_V) + u_xlat3.xy;
    u_xlat10_3.xyz = texture(_MainTex, u_xlat3.xy).xyw;
    u_xlat4.xy = vs_TEXCOORD2.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat5.x = _Time.y * _Mask_Speed_U;
    u_xlat5.y = 0.0;
    u_xlat4.xy = u_xlat4.xy + u_xlat5.xy;
    u_xlat10_4.xyz = texture(_Mask, u_xlat4.xy).xyz;
    u_xlat5.xy = vs_TEXCOORD2.xy * _Tex04_UV.xy + _Tex04_UV.zw;
    u_xlat5.xy = _Time.yy * vec2(_Tex04_Speed_U, _Tex04_Speed_V) + u_xlat5.xy;
    u_xlat21.xy = vs_TEXCOORD2.xy * _Tex05_UV.xy + _Tex05_UV.zw;
    u_xlat21.xy = _Time.yy * vec2(_Tex05_Speed_U, _Tex05_Speed_V) + u_xlat21.xy;
    u_xlat10_24 = texture(_MainTex, u_xlat5.xy).z;
    u_xlat10_25 = texture(_MainTex, u_xlat21.xy).z;
    u_xlat24 = u_xlat10_24 * u_xlat10_25;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(u_xlat24>=_TopMaskRange);
#else
    u_xlatb25 = u_xlat24>=_TopMaskRange;
#endif
    u_xlat16_10 = (u_xlatb25) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24>=_TopLineRange);
#else
    u_xlatb24 = u_xlat24>=_TopLineRange;
#endif
    u_xlat16_18 = (u_xlatb24) ? -1.0 : -0.0;
    u_xlat16_18 = u_xlat16_18 + u_xlat16_10;
    u_xlat16_6.xy = u_xlat10_3.zx * u_xlat10_4.xz;
    u_xlat16_6.xy = u_xlat10_0.zx * u_xlat10_1.zx + u_xlat16_6.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vs_TEXCOORD0.x>=_DownMaskRange);
#else
    u_xlatb0.x = vs_TEXCOORD0.x>=_DownMaskRange;
#endif
    u_xlat16_26 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_26;
    u_xlat16_26 = max(u_xlat10_0.y, u_xlat10_1.y);
    u_xlat16_26 = max(u_xlat10_3.y, u_xlat16_26);
    u_xlat16_26 = max(u_xlat10_4.y, u_xlat16_26);
    u_xlat16_26 = (-u_xlat16_6.y) + u_xlat16_26;
    u_xlat16_18 = u_xlat16_10 * u_xlat16_18;
    u_xlat16_18 = max(u_xlat16_18, u_xlat16_26);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = (-_ShadowColor.xyz) + _LineColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_18) * u_xlat16_6.xyz + _ShadowColor.xyz;
    u_xlat16_7.xyz = _LineColor.xyz + (-_LightColor.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_18) * u_xlat16_7.xyz + _LightColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_18 = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_18 = (-u_xlat16_18) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_ShadowWidth>=u_xlat16_18);
#else
    u_xlatb0.x = _ShadowWidth>=u_xlat16_18;
#endif
    u_xlat16_18 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_18) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = _FresnelColor.xyz * vec3(u_xlat16_2) + u_xlat16_6.xyz;
    u_xlat16_2 = max(vs_TEXCOORD2.y, 9.99999975e-05);
    u_xlat16_2 = log2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _GradientPower;
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _GradientScale;
    SV_Target0.w = u_xlat16_2 * u_xlat16_10;
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
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
float u_xlat0;
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
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat1.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD4.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelScale;
uniform 	mediump float _FresnelPower;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _Tex01_Speed_U;
uniform 	mediump float _Tex01_Speed_V;
uniform 	mediump vec4 _Tex01_UV;
uniform 	mediump float _Tex02_Speed_U;
uniform 	mediump float _Tex02_Speed_V;
uniform 	mediump vec4 _Tex02_UV;
uniform 	mediump float _Tex03_Speed_U;
uniform 	mediump float _Tex03_Speed_V;
uniform 	mediump vec4 _Tex03_UV;
uniform 	mediump float _Mask_Speed_U;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _TopMaskRange;
uniform 	mediump float _Tex04_Speed_U;
uniform 	mediump float _Tex04_Speed_V;
uniform 	mediump vec4 _Tex04_UV;
uniform 	mediump float _Tex05_Speed_U;
uniform 	mediump float _Tex05_Speed_V;
uniform 	mediump vec4 _Tex05_UV;
uniform 	mediump float _TopLineRange;
uniform 	mediump float _DownMaskRange;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _ShadowWidth;
uniform 	mediump float _GradientPower;
uniform 	mediump float _GradientScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Mask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
lowp vec3 u_xlat10_3;
vec2 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_10;
mediump float u_xlat16_18;
vec2 u_xlat21;
float u_xlat24;
lowp float u_xlat10_24;
bool u_xlatb24;
lowp float u_xlat10_25;
bool u_xlatb25;
mediump float u_xlat16_26;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2 = (-u_xlat0.x) + 1.0;
    u_xlat16_2 = max(u_xlat16_2, 9.99999975e-05);
    u_xlat16_2 = log2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _FresnelPower;
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 + _FresnelScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xy = vs_TEXCOORD2.xy * _Tex01_UV.xy + _Tex01_UV.zw;
    u_xlat0.xy = _Time.yy * vec2(_Tex01_Speed_U, _Tex01_Speed_V) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyw;
    u_xlat1.xy = vs_TEXCOORD2.xy * _Tex02_UV.xy + _Tex02_UV.zw;
    u_xlat1.xy = _Time.yy * vec2(_Tex02_Speed_U, _Tex02_Speed_V) + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyw;
    u_xlat3.xy = vs_TEXCOORD2.xy * _Tex03_UV.xy + _Tex03_UV.zw;
    u_xlat3.xy = _Time.yy * vec2(_Tex03_Speed_U, _Tex03_Speed_V) + u_xlat3.xy;
    u_xlat10_3.xyz = texture(_MainTex, u_xlat3.xy).xyw;
    u_xlat4.xy = vs_TEXCOORD2.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat5.x = _Time.y * _Mask_Speed_U;
    u_xlat5.y = 0.0;
    u_xlat4.xy = u_xlat4.xy + u_xlat5.xy;
    u_xlat10_4.xyz = texture(_Mask, u_xlat4.xy).xyz;
    u_xlat5.xy = vs_TEXCOORD2.xy * _Tex04_UV.xy + _Tex04_UV.zw;
    u_xlat5.xy = _Time.yy * vec2(_Tex04_Speed_U, _Tex04_Speed_V) + u_xlat5.xy;
    u_xlat21.xy = vs_TEXCOORD2.xy * _Tex05_UV.xy + _Tex05_UV.zw;
    u_xlat21.xy = _Time.yy * vec2(_Tex05_Speed_U, _Tex05_Speed_V) + u_xlat21.xy;
    u_xlat10_24 = texture(_MainTex, u_xlat5.xy).z;
    u_xlat10_25 = texture(_MainTex, u_xlat21.xy).z;
    u_xlat24 = u_xlat10_24 * u_xlat10_25;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(u_xlat24>=_TopMaskRange);
#else
    u_xlatb25 = u_xlat24>=_TopMaskRange;
#endif
    u_xlat16_10 = (u_xlatb25) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24>=_TopLineRange);
#else
    u_xlatb24 = u_xlat24>=_TopLineRange;
#endif
    u_xlat16_18 = (u_xlatb24) ? -1.0 : -0.0;
    u_xlat16_18 = u_xlat16_18 + u_xlat16_10;
    u_xlat16_6.xy = u_xlat10_3.zx * u_xlat10_4.xz;
    u_xlat16_6.xy = u_xlat10_0.zx * u_xlat10_1.zx + u_xlat16_6.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vs_TEXCOORD0.x>=_DownMaskRange);
#else
    u_xlatb0.x = vs_TEXCOORD0.x>=_DownMaskRange;
#endif
    u_xlat16_26 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_6.x;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_26;
    u_xlat16_26 = max(u_xlat10_0.y, u_xlat10_1.y);
    u_xlat16_26 = max(u_xlat10_3.y, u_xlat16_26);
    u_xlat16_26 = max(u_xlat10_4.y, u_xlat16_26);
    u_xlat16_26 = (-u_xlat16_6.y) + u_xlat16_26;
    u_xlat16_18 = u_xlat16_10 * u_xlat16_18;
    u_xlat16_18 = max(u_xlat16_18, u_xlat16_26);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = (-_ShadowColor.xyz) + _LineColor.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_18) * u_xlat16_6.xyz + _ShadowColor.xyz;
    u_xlat16_7.xyz = _LineColor.xyz + (-_LightColor.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_18) * u_xlat16_7.xyz + _LightColor.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_18 = u_xlat0.x * 0.5 + 0.5;
    u_xlat16_18 = (-u_xlat16_18) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_ShadowWidth>=u_xlat16_18);
#else
    u_xlatb0.x = _ShadowWidth>=u_xlat16_18;
#endif
    u_xlat16_18 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_18) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = _FresnelColor.xyz * vec3(u_xlat16_2) + u_xlat16_6.xyz;
    u_xlat16_2 = max(vs_TEXCOORD2.y, 9.99999975e-05);
    u_xlat16_2 = log2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _GradientPower;
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _GradientScale;
    SV_Target0.w = u_xlat16_2 * u_xlat16_10;
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
  GpuProgramID 96854
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