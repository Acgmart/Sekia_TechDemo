//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/CG/Cg_SeraphWings" {
Properties {
_MainTex ("MainTex", 2D) = "white" { }
_MainColor ("Main Color", Color) = (1,1,1,0)
_Brightness ("Brightness", Float) = 1.3
_DissolveTexture ("Dissolve Texture", 2D) = "white" { }
_DissolveIntensity ("Dissolve Intensity", Range(0, 450)) = 0
_MaskTexture01 ("Mask  Texture01", 2D) = "white" { }
_Mask01USpeed ("Mask01 USpeed", Float) = -0.1
_Mask01VSpeed ("Mask01 VSpeed", Float) = 0
_MaskTexture02 ("Mask  Texture02", 2D) = "white" { }
_Mask02USpeed ("Mask02 USpeed", Float) = -0.1
_Mask02VSpeed ("Mask02 VSpeed", Float) = 0
_MaskPower ("Mask Power", Float) = 1
_MaskScale ("Mask Scale", Float) = 1
_MaskStep ("Mask Step", Range(0, 1)) = 0.729
_texcoord ("", 2D) = "white" { }
_texcoord2 ("", 2D) = "white" { }
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
  GpuProgramID 12542
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
uniform 	mediump float _Brightness;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MaskStep;
uniform 	mediump float _Mask01USpeed;
uniform 	vec4 _MaskTexture01_ST;
uniform 	mediump float _Mask01VSpeed;
uniform 	mediump float _Mask02USpeed;
uniform 	mediump float _Mask02VSpeed;
uniform 	mediump float _MaskPower;
uniform 	mediump float _MaskScale;
uniform 	vec4 _DissolveTexture_ST;
uniform 	mediump float _DissolveIntensity;
uniform lowp sampler2D _MaskTexture01;
uniform lowp sampler2D _MaskTexture02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
lowp float u_xlat10_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat16_0 = (-vs_TEXCOORD1.x) + 1.0;
    u_xlat16_0 = max(u_xlat16_0, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _MaskPower;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _MaskScale;
    u_xlat1.xyz = vs_TEXCOORD1.yxy * _MaskTexture01_ST.yxy + _MaskTexture01_ST.wzw;
    u_xlat16_2.x = _Time.y * _Mask01USpeed + u_xlat1.y;
    u_xlat16_2.yzw = _Time.yyy * vec3(_Mask01VSpeed, _Mask02USpeed, _Mask02VSpeed) + u_xlat1.xyz;
    u_xlat10_1.x = texture(_MaskTexture01, u_xlat16_2.xy).x;
    u_xlat10_4 = texture(_MaskTexture02, u_xlat16_2.zw).x;
    u_xlat16_7 = u_xlat10_4 * u_xlat10_1.x;
    u_xlat16_1 = (-u_xlat10_1.x) * u_xlat10_4 + 1.0;
    u_xlat1.x = u_xlat16_0 * u_xlat16_1 + u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x>=_MaskStep);
#else
    u_xlatb1 = u_xlat1.x>=_MaskStep;
#endif
    u_xlat16_3 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat1.xy = vs_TEXCOORD1.xy * _DissolveTexture_ST.xy + _DissolveTexture_ST.zw;
    u_xlat10_1.x = texture(_DissolveTexture, u_xlat1.xy).y;
    u_xlat16_1 = u_xlat10_1.x * _DissolveIntensity;
    u_xlat0.w = u_xlat16_3 * u_xlat16_0 + (-u_xlat16_1);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = _MainColor.xyz * vec3(_Brightness);
    u_xlat0.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _Brightness;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MaskStep;
uniform 	mediump float _Mask01USpeed;
uniform 	vec4 _MaskTexture01_ST;
uniform 	mediump float _Mask01VSpeed;
uniform 	mediump float _Mask02USpeed;
uniform 	mediump float _Mask02VSpeed;
uniform 	mediump float _MaskPower;
uniform 	mediump float _MaskScale;
uniform 	vec4 _DissolveTexture_ST;
uniform 	mediump float _DissolveIntensity;
uniform lowp sampler2D _MaskTexture01;
uniform lowp sampler2D _MaskTexture02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
lowp float u_xlat10_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat16_0 = (-vs_TEXCOORD1.x) + 1.0;
    u_xlat16_0 = max(u_xlat16_0, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _MaskPower;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _MaskScale;
    u_xlat1.xyz = vs_TEXCOORD1.yxy * _MaskTexture01_ST.yxy + _MaskTexture01_ST.wzw;
    u_xlat16_2.x = _Time.y * _Mask01USpeed + u_xlat1.y;
    u_xlat16_2.yzw = _Time.yyy * vec3(_Mask01VSpeed, _Mask02USpeed, _Mask02VSpeed) + u_xlat1.xyz;
    u_xlat10_1.x = texture(_MaskTexture01, u_xlat16_2.xy).x;
    u_xlat10_4 = texture(_MaskTexture02, u_xlat16_2.zw).x;
    u_xlat16_7 = u_xlat10_4 * u_xlat10_1.x;
    u_xlat16_1 = (-u_xlat10_1.x) * u_xlat10_4 + 1.0;
    u_xlat1.x = u_xlat16_0 * u_xlat16_1 + u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x>=_MaskStep);
#else
    u_xlatb1 = u_xlat1.x>=_MaskStep;
#endif
    u_xlat16_3 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat1.xy = vs_TEXCOORD1.xy * _DissolveTexture_ST.xy + _DissolveTexture_ST.zw;
    u_xlat10_1.x = texture(_DissolveTexture, u_xlat1.xy).y;
    u_xlat16_1 = u_xlat10_1.x * _DissolveIntensity;
    u_xlat0.w = u_xlat16_3 * u_xlat16_0 + (-u_xlat16_1);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = _MainColor.xyz * vec3(_Brightness);
    u_xlat0.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
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
uniform 	mediump float _Brightness;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MaskStep;
uniform 	mediump float _Mask01USpeed;
uniform 	vec4 _MaskTexture01_ST;
uniform 	mediump float _Mask01VSpeed;
uniform 	mediump float _Mask02USpeed;
uniform 	mediump float _Mask02VSpeed;
uniform 	mediump float _MaskPower;
uniform 	mediump float _MaskScale;
uniform 	vec4 _DissolveTexture_ST;
uniform 	mediump float _DissolveIntensity;
uniform lowp sampler2D _MaskTexture01;
uniform lowp sampler2D _MaskTexture02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
lowp float u_xlat10_12;
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
    u_xlat1.xyz = vs_TEXCOORD1.yxy * _MaskTexture01_ST.yxy + _MaskTexture01_ST.wzw;
    u_xlat16_2.x = _Time.y * _Mask01USpeed + u_xlat1.y;
    u_xlat16_2.yzw = _Time.yyy * vec3(_Mask01VSpeed, _Mask02USpeed, _Mask02VSpeed) + u_xlat1.xyz;
    u_xlat16_3 = (-vs_TEXCOORD1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _MaskPower;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _MaskScale;
    u_xlat10_8 = texture(_MaskTexture01, u_xlat16_2.xy).x;
    u_xlat10_12 = texture(_MaskTexture02, u_xlat16_2.zw).x;
    u_xlat16_1 = u_xlat10_12 * u_xlat10_8;
    u_xlat16_8 = (-u_xlat10_8) * u_xlat10_12 + 1.0;
    u_xlat8 = u_xlat16_3 * u_xlat16_8 + u_xlat16_1;
    u_xlat1.xy = vs_TEXCOORD1.xy * _DissolveTexture_ST.xy + _DissolveTexture_ST.zw;
    u_xlat16_2.xyz = _MainColor.xyz * vec3(_Brightness);
    u_xlat10_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_0.xyw * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat8>=_MaskStep);
#else
    u_xlatb0.x = u_xlat8>=_MaskStep;
#endif
    u_xlat16_7 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat10_0.x = texture(_DissolveTexture, u_xlat1.xy).y;
    u_xlat16_0 = u_xlat10_0.x * _DissolveIntensity;
    u_xlat2.w = u_xlat16_7 * u_xlat16_3 + (-u_xlat16_0);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
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
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _Brightness;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MaskStep;
uniform 	mediump float _Mask01USpeed;
uniform 	vec4 _MaskTexture01_ST;
uniform 	mediump float _Mask01VSpeed;
uniform 	mediump float _Mask02USpeed;
uniform 	mediump float _Mask02VSpeed;
uniform 	mediump float _MaskPower;
uniform 	mediump float _MaskScale;
uniform 	vec4 _DissolveTexture_ST;
uniform 	mediump float _DissolveIntensity;
uniform lowp sampler2D _MaskTexture01;
uniform lowp sampler2D _MaskTexture02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
lowp float u_xlat10_12;
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
    u_xlat1.xyz = vs_TEXCOORD1.yxy * _MaskTexture01_ST.yxy + _MaskTexture01_ST.wzw;
    u_xlat16_2.x = _Time.y * _Mask01USpeed + u_xlat1.y;
    u_xlat16_2.yzw = _Time.yyy * vec3(_Mask01VSpeed, _Mask02USpeed, _Mask02VSpeed) + u_xlat1.xyz;
    u_xlat16_3 = (-vs_TEXCOORD1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _MaskPower;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _MaskScale;
    u_xlat10_8 = texture(_MaskTexture01, u_xlat16_2.xy).x;
    u_xlat10_12 = texture(_MaskTexture02, u_xlat16_2.zw).x;
    u_xlat16_1 = u_xlat10_12 * u_xlat10_8;
    u_xlat16_8 = (-u_xlat10_8) * u_xlat10_12 + 1.0;
    u_xlat8 = u_xlat16_3 * u_xlat16_8 + u_xlat16_1;
    u_xlat1.xy = vs_TEXCOORD1.xy * _DissolveTexture_ST.xy + _DissolveTexture_ST.zw;
    u_xlat16_2.xyz = _MainColor.xyz * vec3(_Brightness);
    u_xlat10_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_0.xyw * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat8>=_MaskStep);
#else
    u_xlatb0.x = u_xlat8>=_MaskStep;
#endif
    u_xlat16_7 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat10_0.x = texture(_DissolveTexture, u_xlat1.xy).y;
    u_xlat16_0 = u_xlat10_0.x * _DissolveIntensity;
    u_xlat2.w = u_xlat16_7 * u_xlat16_3 + (-u_xlat16_0);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
uniform 	mediump float _Brightness;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MaskStep;
uniform 	mediump float _Mask01USpeed;
uniform 	vec4 _MaskTexture01_ST;
uniform 	mediump float _Mask01VSpeed;
uniform 	mediump float _Mask02USpeed;
uniform 	mediump float _Mask02VSpeed;
uniform 	mediump float _MaskPower;
uniform 	mediump float _MaskScale;
uniform 	vec4 _DissolveTexture_ST;
uniform 	mediump float _DissolveIntensity;
uniform lowp sampler2D _MaskTexture01;
uniform lowp sampler2D _MaskTexture02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
lowp float u_xlat10_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat16_0 = (-vs_TEXCOORD1.x) + 1.0;
    u_xlat16_0 = max(u_xlat16_0, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _MaskPower;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _MaskScale;
    u_xlat1.xyz = vs_TEXCOORD1.yxy * _MaskTexture01_ST.yxy + _MaskTexture01_ST.wzw;
    u_xlat16_2.x = _Time.y * _Mask01USpeed + u_xlat1.y;
    u_xlat16_2.yzw = _Time.yyy * vec3(_Mask01VSpeed, _Mask02USpeed, _Mask02VSpeed) + u_xlat1.xyz;
    u_xlat10_1.x = texture(_MaskTexture01, u_xlat16_2.xy).x;
    u_xlat10_4 = texture(_MaskTexture02, u_xlat16_2.zw).x;
    u_xlat16_7 = u_xlat10_4 * u_xlat10_1.x;
    u_xlat16_1 = (-u_xlat10_1.x) * u_xlat10_4 + 1.0;
    u_xlat1.x = u_xlat16_0 * u_xlat16_1 + u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x>=_MaskStep);
#else
    u_xlatb1 = u_xlat1.x>=_MaskStep;
#endif
    u_xlat16_3 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat1.xy = vs_TEXCOORD1.xy * _DissolveTexture_ST.xy + _DissolveTexture_ST.zw;
    u_xlat10_1.x = texture(_DissolveTexture, u_xlat1.xy).y;
    u_xlat16_1 = u_xlat10_1.x * _DissolveIntensity;
    u_xlat0.w = u_xlat16_3 * u_xlat16_0 + (-u_xlat16_1);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = _MainColor.xyz * vec3(_Brightness);
    u_xlat0.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _Brightness;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MaskStep;
uniform 	mediump float _Mask01USpeed;
uniform 	vec4 _MaskTexture01_ST;
uniform 	mediump float _Mask01VSpeed;
uniform 	mediump float _Mask02USpeed;
uniform 	mediump float _Mask02VSpeed;
uniform 	mediump float _MaskPower;
uniform 	mediump float _MaskScale;
uniform 	vec4 _DissolveTexture_ST;
uniform 	mediump float _DissolveIntensity;
uniform lowp sampler2D _MaskTexture01;
uniform lowp sampler2D _MaskTexture02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
lowp float u_xlat10_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat16_0 = (-vs_TEXCOORD1.x) + 1.0;
    u_xlat16_0 = max(u_xlat16_0, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _MaskPower;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _MaskScale;
    u_xlat1.xyz = vs_TEXCOORD1.yxy * _MaskTexture01_ST.yxy + _MaskTexture01_ST.wzw;
    u_xlat16_2.x = _Time.y * _Mask01USpeed + u_xlat1.y;
    u_xlat16_2.yzw = _Time.yyy * vec3(_Mask01VSpeed, _Mask02USpeed, _Mask02VSpeed) + u_xlat1.xyz;
    u_xlat10_1.x = texture(_MaskTexture01, u_xlat16_2.xy).x;
    u_xlat10_4 = texture(_MaskTexture02, u_xlat16_2.zw).x;
    u_xlat16_7 = u_xlat10_4 * u_xlat10_1.x;
    u_xlat16_1 = (-u_xlat10_1.x) * u_xlat10_4 + 1.0;
    u_xlat1.x = u_xlat16_0 * u_xlat16_1 + u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x>=_MaskStep);
#else
    u_xlatb1 = u_xlat1.x>=_MaskStep;
#endif
    u_xlat16_3 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat1.xy = vs_TEXCOORD1.xy * _DissolveTexture_ST.xy + _DissolveTexture_ST.zw;
    u_xlat10_1.x = texture(_DissolveTexture, u_xlat1.xy).y;
    u_xlat16_1 = u_xlat10_1.x * _DissolveIntensity;
    u_xlat0.w = u_xlat16_3 * u_xlat16_0 + (-u_xlat16_1);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = _MainColor.xyz * vec3(_Brightness);
    u_xlat0.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
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
out highp vec4 vs_TEXCOORD3;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _Brightness;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MaskStep;
uniform 	mediump float _Mask01USpeed;
uniform 	vec4 _MaskTexture01_ST;
uniform 	mediump float _Mask01VSpeed;
uniform 	mediump float _Mask02USpeed;
uniform 	mediump float _Mask02VSpeed;
uniform 	mediump float _MaskPower;
uniform 	mediump float _MaskScale;
uniform 	vec4 _DissolveTexture_ST;
uniform 	mediump float _DissolveIntensity;
uniform lowp sampler2D _MaskTexture01;
uniform lowp sampler2D _MaskTexture02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
lowp float u_xlat10_12;
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
    u_xlat1.xyz = vs_TEXCOORD1.yxy * _MaskTexture01_ST.yxy + _MaskTexture01_ST.wzw;
    u_xlat16_2.x = _Time.y * _Mask01USpeed + u_xlat1.y;
    u_xlat16_2.yzw = _Time.yyy * vec3(_Mask01VSpeed, _Mask02USpeed, _Mask02VSpeed) + u_xlat1.xyz;
    u_xlat16_3 = (-vs_TEXCOORD1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _MaskPower;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _MaskScale;
    u_xlat10_8 = texture(_MaskTexture01, u_xlat16_2.xy).x;
    u_xlat10_12 = texture(_MaskTexture02, u_xlat16_2.zw).x;
    u_xlat16_1 = u_xlat10_12 * u_xlat10_8;
    u_xlat16_8 = (-u_xlat10_8) * u_xlat10_12 + 1.0;
    u_xlat8 = u_xlat16_3 * u_xlat16_8 + u_xlat16_1;
    u_xlat1.xy = vs_TEXCOORD1.xy * _DissolveTexture_ST.xy + _DissolveTexture_ST.zw;
    u_xlat16_2.xyz = _MainColor.xyz * vec3(_Brightness);
    u_xlat10_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_0.xyw * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat8>=_MaskStep);
#else
    u_xlatb0.x = u_xlat8>=_MaskStep;
#endif
    u_xlat16_7 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat10_0.x = texture(_DissolveTexture, u_xlat1.xy).y;
    u_xlat16_0 = u_xlat10_0.x * _DissolveIntensity;
    u_xlat2.w = u_xlat16_7 * u_xlat16_3 + (-u_xlat16_0);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _Brightness;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MaskStep;
uniform 	mediump float _Mask01USpeed;
uniform 	vec4 _MaskTexture01_ST;
uniform 	mediump float _Mask01VSpeed;
uniform 	mediump float _Mask02USpeed;
uniform 	mediump float _Mask02VSpeed;
uniform 	mediump float _MaskPower;
uniform 	mediump float _MaskScale;
uniform 	vec4 _DissolveTexture_ST;
uniform 	mediump float _DissolveIntensity;
uniform lowp sampler2D _MaskTexture01;
uniform lowp sampler2D _MaskTexture02;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DissolveTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
lowp float u_xlat10_12;
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
    u_xlat1.xyz = vs_TEXCOORD1.yxy * _MaskTexture01_ST.yxy + _MaskTexture01_ST.wzw;
    u_xlat16_2.x = _Time.y * _Mask01USpeed + u_xlat1.y;
    u_xlat16_2.yzw = _Time.yyy * vec3(_Mask01VSpeed, _Mask02USpeed, _Mask02VSpeed) + u_xlat1.xyz;
    u_xlat16_3 = (-vs_TEXCOORD1.x) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _MaskPower;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * _MaskScale;
    u_xlat10_8 = texture(_MaskTexture01, u_xlat16_2.xy).x;
    u_xlat10_12 = texture(_MaskTexture02, u_xlat16_2.zw).x;
    u_xlat16_1 = u_xlat10_12 * u_xlat10_8;
    u_xlat16_8 = (-u_xlat10_8) * u_xlat10_12 + 1.0;
    u_xlat8 = u_xlat16_3 * u_xlat16_8 + u_xlat16_1;
    u_xlat1.xy = vs_TEXCOORD1.xy * _DissolveTexture_ST.xy + _DissolveTexture_ST.zw;
    u_xlat16_2.xyz = _MainColor.xyz * vec3(_Brightness);
    u_xlat10_0.xyw = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat2.xyz = u_xlat10_0.xyw * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat8>=_MaskStep);
#else
    u_xlatb0.x = u_xlat8>=_MaskStep;
#endif
    u_xlat16_7 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat10_0.x = texture(_DissolveTexture, u_xlat1.xy).y;
    u_xlat16_0 = u_xlat10_0.x * _DissolveIntensity;
    u_xlat2.w = u_xlat16_7 * u_xlat16_3 + (-u_xlat16_0);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
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
  GpuProgramID 110449
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
  GpuProgramID 179257
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
uniform 	vec4 _Time;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump float _MaskStep;
uniform 	mediump float _Mask01USpeed;
uniform 	vec4 _MaskTexture01_ST;
uniform 	mediump float _Mask01VSpeed;
uniform 	mediump float _Mask02USpeed;
uniform 	mediump float _Mask02VSpeed;
uniform 	mediump float _MaskPower;
uniform 	mediump float _MaskScale;
uniform 	vec4 _DissolveTexture_ST;
uniform 	mediump float _DissolveIntensity;
uniform lowp sampler2D _MaskTexture01;
uniform lowp sampler2D _MaskTexture02;
uniform lowp sampler2D _DissolveTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
ivec2 u_xlati3;
mediump float u_xlat16_4;
lowp float u_xlat10_5;
vec2 u_xlat9;
mediump float u_xlat16_9;
ivec2 u_xlati9;
void main()
{
    u_xlat16_0 = (-vs_TEXCOORD1.x) + 1.0;
    u_xlat16_0 = max(u_xlat16_0, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _MaskPower;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _MaskScale;
    u_xlat1.xyz = vs_TEXCOORD1.yxy * _MaskTexture01_ST.yxy + _MaskTexture01_ST.wzw;
    u_xlat16_2.x = _Time.y * _Mask01USpeed + u_xlat1.y;
    u_xlat16_2.yzw = _Time.yyy * vec3(_Mask01VSpeed, _Mask02USpeed, _Mask02VSpeed) + u_xlat1.xyz;
    u_xlat10_1 = texture(_MaskTexture01, u_xlat16_2.xy).x;
    u_xlat10_5 = texture(_MaskTexture02, u_xlat16_2.zw).x;
    u_xlat16_9 = u_xlat10_5 * u_xlat10_1;
    u_xlat16_1 = (-u_xlat10_1) * u_xlat10_5 + 1.0;
    u_xlat1.x = u_xlat16_0 * u_xlat16_1 + u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x>=_MaskStep);
#else
    u_xlatb1 = u_xlat1.x>=_MaskStep;
#endif
    u_xlat16_4 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat1.xy = vs_TEXCOORD1.xy * _DissolveTexture_ST.xy + _DissolveTexture_ST.zw;
    u_xlat10_1 = texture(_DissolveTexture, u_xlat1.xy).y;
    u_xlat16_1 = u_xlat10_1 * _DissolveIntensity;
    u_xlat16_1 = u_xlat16_4 * u_xlat16_0 + (-u_xlat16_1);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_1 + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat9.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat9.xy = u_xlat9.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat9.xy * vec2(0.5, 0.5) + (-u_xlat1.xy);
    u_xlati9.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat1.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat1.xy = sqrt(abs(u_xlat1.xy));
    u_xlati9.xy = (-u_xlati9.xy) + u_xlati3.xy;
    u_xlat9.xy = vec2(u_xlati9.xy);
    u_xlat1.xy = u_xlat9.xy * u_xlat1.xy;
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
uniform 	vec4 _Time;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump float _MaskStep;
uniform 	mediump float _Mask01USpeed;
uniform 	vec4 _MaskTexture01_ST;
uniform 	mediump float _Mask01VSpeed;
uniform 	mediump float _Mask02USpeed;
uniform 	mediump float _Mask02VSpeed;
uniform 	mediump float _MaskPower;
uniform 	mediump float _MaskScale;
uniform 	vec4 _DissolveTexture_ST;
uniform 	mediump float _DissolveIntensity;
uniform lowp sampler2D _MaskTexture01;
uniform lowp sampler2D _MaskTexture02;
uniform lowp sampler2D _DissolveTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
ivec2 u_xlati3;
mediump float u_xlat16_4;
lowp float u_xlat10_5;
vec2 u_xlat9;
mediump float u_xlat16_9;
ivec2 u_xlati9;
void main()
{
    u_xlat16_0 = (-vs_TEXCOORD1.x) + 1.0;
    u_xlat16_0 = max(u_xlat16_0, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _MaskPower;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _MaskScale;
    u_xlat1.xyz = vs_TEXCOORD1.yxy * _MaskTexture01_ST.yxy + _MaskTexture01_ST.wzw;
    u_xlat16_2.x = _Time.y * _Mask01USpeed + u_xlat1.y;
    u_xlat16_2.yzw = _Time.yyy * vec3(_Mask01VSpeed, _Mask02USpeed, _Mask02VSpeed) + u_xlat1.xyz;
    u_xlat10_1 = texture(_MaskTexture01, u_xlat16_2.xy).x;
    u_xlat10_5 = texture(_MaskTexture02, u_xlat16_2.zw).x;
    u_xlat16_9 = u_xlat10_5 * u_xlat10_1;
    u_xlat16_1 = (-u_xlat10_1) * u_xlat10_5 + 1.0;
    u_xlat1.x = u_xlat16_0 * u_xlat16_1 + u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x>=_MaskStep);
#else
    u_xlatb1 = u_xlat1.x>=_MaskStep;
#endif
    u_xlat16_4 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat1.xy = vs_TEXCOORD1.xy * _DissolveTexture_ST.xy + _DissolveTexture_ST.zw;
    u_xlat10_1 = texture(_DissolveTexture, u_xlat1.xy).y;
    u_xlat16_1 = u_xlat10_1 * _DissolveIntensity;
    u_xlat16_1 = u_xlat16_4 * u_xlat16_0 + (-u_xlat16_1);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_1 + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0<0.0);
#else
    u_xlatb1 = u_xlat16_0<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat9.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat9.xy = u_xlat9.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat9.xy * vec2(0.5, 0.5) + (-u_xlat1.xy);
    u_xlati9.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat1.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat1.xy = sqrt(abs(u_xlat1.xy));
    u_xlati9.xy = (-u_xlati9.xy) + u_xlati3.xy;
    u_xlat9.xy = vec2(u_xlati9.xy);
    u_xlat1.xy = u_xlat9.xy * u_xlat1.xy;
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