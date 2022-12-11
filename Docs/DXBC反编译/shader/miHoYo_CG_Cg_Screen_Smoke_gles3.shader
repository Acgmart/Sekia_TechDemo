//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/CG/Cg_Screen_Smoke" {
Properties {
_DissolveMask_F ("DissolveMask_F", 2D) = "white" { }
_DissolveMask_A ("DissolveMask_A", 2D) = "white" { }
_DissolveMask_B ("DissolveMask_B", 2D) = "white" { }
_DissolveMask_C ("DissolveMask_C", 2D) = "white" { }
_DissolveMask_D ("DissolveMask_D", 2D) = "white" { }
_Dissolve01 ("Dissolve01", Float) = 0
_Dissolve02 ("Dissolve02", Range(0, 0.98)) = 0
_Dissolve03 ("Dissolve03", Range(0, 0.98)) = 0
_Dissolve04 ("Dissolve04", Range(0, 0.98)) = 0
_Dissolve05 ("Dissolve05", Range(0, 0.98)) = 0
_CeilRange_01 ("CeilRange_01", Float) = 0
_CeilRange_02 ("CeilRange_02", Float) = 0
_CeilRange_03 ("CeilRange_03", Float) = 0
_CeilRange_04 ("CeilRange_04", Float) = 0
_Mask ("Mask", 2D) = "white" { }
_mainColor ("mainColor", Color) = (1,1,1,0)
_Cutoff ("Mask Clip Value", Float) = 0
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
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
  Name "FORWARD"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 27281
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _DissolveMask_A_ST;
uniform 	mediump float _CeilRange_01;
uniform 	mediump float _CeilRange_02;
uniform 	mediump float _CeilRange_03;
uniform 	mediump float _CeilRange_04;
uniform 	mediump vec4 _mainColor;
uniform 	mediump float _Dissolve01;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _Dissolve02;
uniform 	mediump float _Dissolve03;
uniform 	mediump float _Dissolve04;
uniform 	mediump float _Dissolve05;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _DissolveMask_A;
uniform lowp sampler2D _DissolveMask_F;
uniform lowp sampler2D _DissolveMask_B;
uniform lowp sampler2D _DissolveMask_C;
uniform lowp sampler2D _DissolveMask_D;
uniform lowp sampler2D _Mask;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
lowp vec4 u_xlat10_4;
lowp vec4 u_xlat10_5;
bvec2 u_xlatb5;
mediump vec4 u_xlat16_6;
lowp vec4 u_xlat10_7;
mediump vec2 u_xlat16_10;
vec2 u_xlat16;
bool u_xlatb16;
bool u_xlatb24;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveMask_A_ST.xy + _DissolveMask_A_ST.zw;
    u_xlat10_1 = texture(_DissolveMask_B, u_xlat0.xy);
    u_xlat16_2.x = (-u_xlat10_1.w) + 1.0;
    u_xlat10_3 = texture(_DissolveMask_A, u_xlat0.xy);
    u_xlat16_2.x = u_xlat16_2.x + (-u_xlat10_3.w);
    u_xlat16_2.x = _Dissolve01 * u_xlat16_2.x + u_xlat10_3.w;
    u_xlat10_4 = texture(_DissolveMask_C, u_xlat0.xy);
    u_xlat16.xy = vs_TEXCOORD2.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_5 = texture(_Mask, u_xlat16.xy);
    u_xlat16_10.x = u_xlat10_4.w * u_xlat10_5.x;
    u_xlat16_6 = (-vec4(_Dissolve02, _Dissolve03, _Dissolve04, _Dissolve05)) + vec4(1.0, 1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16_6.x>=u_xlat16_10.x);
#else
    u_xlatb16 = u_xlat16_6.x>=u_xlat16_10.x;
#endif
    u_xlat16_10.x = (u_xlatb16) ? 1.0 : 0.0;
    u_xlat16_2.x = min(u_xlat16_10.x, u_xlat16_2.x);
    u_xlat10_7 = texture(_DissolveMask_D, u_xlat0.xy);
    u_xlat10_0.xyz = texture(_DissolveMask_F, u_xlat0.xy).xyz;
    u_xlat16_10.xy = vec2(u_xlat10_5.y * u_xlat10_7.w, u_xlat10_5.z * u_xlat10_7.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_6.w>=u_xlat10_5.w);
#else
    u_xlatb24 = u_xlat16_6.w>=u_xlat10_5.w;
#endif
    u_xlatb5.xy = greaterThanEqual(u_xlat16_6.yzyy, u_xlat16_10.xyxx).xy;
    u_xlat16_10.x = (u_xlatb5.x) ? float(1.0) : float(0.0);
    u_xlat16_10.y = (u_xlatb5.y) ? float(1.0) : float(0.0);
    u_xlat16_26 = (u_xlatb24) ? 1.0 : 0.0;
    u_xlat16_2.x = min(u_xlat16_10.x, u_xlat16_2.x);
    u_xlat16_2.x = min(u_xlat16_10.y, u_xlat16_2.x);
    u_xlat16_2.x = min(u_xlat16_26, u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_2.x<0.0);
#else
    u_xlatb24 = u_xlat16_2.x<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
    u_xlat16_3.xyz = (-u_xlat10_0.xyz) + u_xlat10_3.xyz;
    u_xlat16_0.xyz = vec3(_CeilRange_01) * u_xlat16_3.xyz + u_xlat10_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = vec3(vec3(_CeilRange_02, _CeilRange_02, _CeilRange_02)) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) + u_xlat10_4.xyz;
    u_xlat16_2.xyz = vec3(vec3(_CeilRange_03, _CeilRange_03, _CeilRange_03)) * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) + u_xlat10_7.xyz;
    u_xlat16_2.xyz = vec3(vec3(_CeilRange_04, _CeilRange_04, _CeilRange_04)) * u_xlat16_6.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * _mainColor.xyz;
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
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _DissolveMask_A_ST;
uniform 	mediump float _CeilRange_01;
uniform 	mediump float _CeilRange_02;
uniform 	mediump float _CeilRange_03;
uniform 	mediump float _CeilRange_04;
uniform 	mediump vec4 _mainColor;
uniform 	mediump float _Dissolve01;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _Dissolve02;
uniform 	mediump float _Dissolve03;
uniform 	mediump float _Dissolve04;
uniform 	mediump float _Dissolve05;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _DissolveMask_A;
uniform lowp sampler2D _DissolveMask_F;
uniform lowp sampler2D _DissolveMask_B;
uniform lowp sampler2D _DissolveMask_C;
uniform lowp sampler2D _DissolveMask_D;
uniform lowp sampler2D _Mask;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
lowp vec4 u_xlat10_4;
lowp vec4 u_xlat10_5;
bvec2 u_xlatb5;
mediump vec4 u_xlat16_6;
lowp vec4 u_xlat10_7;
mediump vec2 u_xlat16_10;
vec2 u_xlat16;
bool u_xlatb16;
bool u_xlatb24;
mediump float u_xlat16_26;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveMask_A_ST.xy + _DissolveMask_A_ST.zw;
    u_xlat10_1 = texture(_DissolveMask_B, u_xlat0.xy);
    u_xlat16_2.x = (-u_xlat10_1.w) + 1.0;
    u_xlat10_3 = texture(_DissolveMask_A, u_xlat0.xy);
    u_xlat16_2.x = u_xlat16_2.x + (-u_xlat10_3.w);
    u_xlat16_2.x = _Dissolve01 * u_xlat16_2.x + u_xlat10_3.w;
    u_xlat10_4 = texture(_DissolveMask_C, u_xlat0.xy);
    u_xlat16.xy = vs_TEXCOORD2.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_5 = texture(_Mask, u_xlat16.xy);
    u_xlat16_10.x = u_xlat10_4.w * u_xlat10_5.x;
    u_xlat16_6 = (-vec4(_Dissolve02, _Dissolve03, _Dissolve04, _Dissolve05)) + vec4(1.0, 1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16_6.x>=u_xlat16_10.x);
#else
    u_xlatb16 = u_xlat16_6.x>=u_xlat16_10.x;
#endif
    u_xlat16_10.x = (u_xlatb16) ? 1.0 : 0.0;
    u_xlat16_2.x = min(u_xlat16_10.x, u_xlat16_2.x);
    u_xlat10_7 = texture(_DissolveMask_D, u_xlat0.xy);
    u_xlat10_0.xyz = texture(_DissolveMask_F, u_xlat0.xy).xyz;
    u_xlat16_10.xy = vec2(u_xlat10_5.y * u_xlat10_7.w, u_xlat10_5.z * u_xlat10_7.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_6.w>=u_xlat10_5.w);
#else
    u_xlatb24 = u_xlat16_6.w>=u_xlat10_5.w;
#endif
    u_xlatb5.xy = greaterThanEqual(u_xlat16_6.yzyy, u_xlat16_10.xyxx).xy;
    u_xlat16_10.x = (u_xlatb5.x) ? float(1.0) : float(0.0);
    u_xlat16_10.y = (u_xlatb5.y) ? float(1.0) : float(0.0);
    u_xlat16_26 = (u_xlatb24) ? 1.0 : 0.0;
    u_xlat16_2.x = min(u_xlat16_10.x, u_xlat16_2.x);
    u_xlat16_2.x = min(u_xlat16_10.y, u_xlat16_2.x);
    u_xlat16_2.x = min(u_xlat16_26, u_xlat16_2.x);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_2.x<0.0);
#else
    u_xlatb24 = u_xlat16_2.x<0.0;
#endif
    if((int(u_xlatb24) * int(0xffffffffu))!=0){discard;}
    u_xlat16_3.xyz = (-u_xlat10_0.xyz) + u_xlat10_3.xyz;
    u_xlat16_0.xyz = vec3(_CeilRange_01) * u_xlat16_3.xyz + u_xlat10_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = vec3(vec3(_CeilRange_02, _CeilRange_02, _CeilRange_02)) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) + u_xlat10_4.xyz;
    u_xlat16_2.xyz = vec3(vec3(_CeilRange_03, _CeilRange_03, _CeilRange_03)) * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = (-u_xlat16_2.xyz) + u_xlat10_7.xyz;
    u_xlat16_2.xyz = vec3(vec3(_CeilRange_04, _CeilRange_04, _CeilRange_04)) * u_xlat16_6.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * _mainColor.xyz;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _DissolveMask_A_ST;
uniform 	mediump float _CeilRange_01;
uniform 	mediump float _CeilRange_02;
uniform 	mediump float _CeilRange_03;
uniform 	mediump float _CeilRange_04;
uniform 	mediump vec4 _mainColor;
uniform 	mediump float _Dissolve01;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _Dissolve02;
uniform 	mediump float _Dissolve03;
uniform 	mediump float _Dissolve04;
uniform 	mediump float _Dissolve05;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _DissolveMask_A;
uniform lowp sampler2D _DissolveMask_F;
uniform lowp sampler2D _DissolveMask_B;
uniform lowp sampler2D _DissolveMask_C;
uniform lowp sampler2D _DissolveMask_D;
uniform lowp sampler2D _Mask;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec2 u_xlat16_9;
mediump float u_xlat16_21;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveMask_A_ST.xy + _DissolveMask_A_ST.zw;
    u_xlat10_1 = texture(_DissolveMask_A, u_xlat0.xy);
    u_xlat10_2.xyz = texture(_DissolveMask_F, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
    u_xlat16_1.xyz = vec3(_CeilRange_01) * u_xlat16_1.xyz + u_xlat10_2.xyz;
    u_xlat10_2 = texture(_DissolveMask_B, u_xlat0.xy);
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat10_2.xyz;
    u_xlat16_3.xyz = vec3(vec3(_CeilRange_02, _CeilRange_02, _CeilRange_02)) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat10_4 = texture(_DissolveMask_C, u_xlat0.xy);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + u_xlat10_4.xyz;
    u_xlat16_3.xyz = vec3(vec3(_CeilRange_03, _CeilRange_03, _CeilRange_03)) * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_DissolveMask_D, u_xlat0.xy);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
    u_xlat16_3.xyz = vec3(vec3(_CeilRange_04, _CeilRange_04, _CeilRange_04)) * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat16_21 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_21 = (-u_xlat10_1.w) + u_xlat16_21;
    u_xlat16_21 = _Dissolve01 * u_xlat16_21 + u_xlat10_1.w;
    u_xlat0.xy = vs_TEXCOORD2.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_1 = texture(_Mask, u_xlat0.xy);
    SV_Target0.xyz = u_xlat16_3.xyz * _mainColor.xyz;
    u_xlat16_3.x = u_xlat10_1.x * u_xlat10_4.w;
    u_xlat16_2 = (-vec4(_Dissolve02, _Dissolve03, _Dissolve04, _Dissolve05)) + vec4(1.0, 1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=u_xlat16_3.x);
#else
    u_xlatb0.x = u_xlat16_2.x>=u_xlat16_3.x;
#endif
    u_xlat16_3.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.x = min(u_xlat16_3.x, u_xlat16_21);
    u_xlat16_9.xy = vec2(u_xlat10_0.w * u_xlat10_1.y, u_xlat10_0.w * u_xlat10_1.z);
    u_xlatb0.xy = greaterThanEqual(u_xlat16_2.yzyy, u_xlat16_9.xyxx).xy;
    u_xlat16_9.x = (u_xlatb0.x) ? float(1.0) : float(0.0);
    u_xlat16_9.y = (u_xlatb0.y) ? float(1.0) : float(0.0);
    u_xlat16_3.x = min(u_xlat16_9.x, u_xlat16_3.x);
    u_xlat16_3.x = min(u_xlat16_9.y, u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.w>=u_xlat10_1.w);
#else
    u_xlatb0.x = u_xlat16_2.w>=u_xlat10_1.w;
#endif
    u_xlat16_9.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.x = min(u_xlat16_9.x, u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3.x<0.0);
#else
    u_xlatb0.x = u_xlat16_3.x<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
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
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _DissolveMask_A_ST;
uniform 	mediump float _CeilRange_01;
uniform 	mediump float _CeilRange_02;
uniform 	mediump float _CeilRange_03;
uniform 	mediump float _CeilRange_04;
uniform 	mediump vec4 _mainColor;
uniform 	mediump float _Dissolve01;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _Dissolve02;
uniform 	mediump float _Dissolve03;
uniform 	mediump float _Dissolve04;
uniform 	mediump float _Dissolve05;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _DissolveMask_A;
uniform lowp sampler2D _DissolveMask_F;
uniform lowp sampler2D _DissolveMask_B;
uniform lowp sampler2D _DissolveMask_C;
uniform lowp sampler2D _DissolveMask_D;
uniform lowp sampler2D _Mask;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec2 u_xlat16_9;
mediump float u_xlat16_21;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveMask_A_ST.xy + _DissolveMask_A_ST.zw;
    u_xlat10_1 = texture(_DissolveMask_A, u_xlat0.xy);
    u_xlat10_2.xyz = texture(_DissolveMask_F, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
    u_xlat16_1.xyz = vec3(_CeilRange_01) * u_xlat16_1.xyz + u_xlat10_2.xyz;
    u_xlat10_2 = texture(_DissolveMask_B, u_xlat0.xy);
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat10_2.xyz;
    u_xlat16_3.xyz = vec3(vec3(_CeilRange_02, _CeilRange_02, _CeilRange_02)) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat10_4 = texture(_DissolveMask_C, u_xlat0.xy);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + u_xlat10_4.xyz;
    u_xlat16_3.xyz = vec3(vec3(_CeilRange_03, _CeilRange_03, _CeilRange_03)) * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat10_0 = texture(_DissolveMask_D, u_xlat0.xy);
    u_xlat16_5.xyz = (-u_xlat16_3.xyz) + u_xlat10_0.xyz;
    u_xlat16_3.xyz = vec3(vec3(_CeilRange_04, _CeilRange_04, _CeilRange_04)) * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat16_21 = (-u_xlat10_2.w) + 1.0;
    u_xlat16_21 = (-u_xlat10_1.w) + u_xlat16_21;
    u_xlat16_21 = _Dissolve01 * u_xlat16_21 + u_xlat10_1.w;
    u_xlat0.xy = vs_TEXCOORD2.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat10_1 = texture(_Mask, u_xlat0.xy);
    SV_Target0.xyz = u_xlat16_3.xyz * _mainColor.xyz;
    u_xlat16_3.x = u_xlat10_1.x * u_xlat10_4.w;
    u_xlat16_2 = (-vec4(_Dissolve02, _Dissolve03, _Dissolve04, _Dissolve05)) + vec4(1.0, 1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=u_xlat16_3.x);
#else
    u_xlatb0.x = u_xlat16_2.x>=u_xlat16_3.x;
#endif
    u_xlat16_3.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.x = min(u_xlat16_3.x, u_xlat16_21);
    u_xlat16_9.xy = vec2(u_xlat10_0.w * u_xlat10_1.y, u_xlat10_0.w * u_xlat10_1.z);
    u_xlatb0.xy = greaterThanEqual(u_xlat16_2.yzyy, u_xlat16_9.xyxx).xy;
    u_xlat16_9.x = (u_xlatb0.x) ? float(1.0) : float(0.0);
    u_xlat16_9.y = (u_xlatb0.y) ? float(1.0) : float(0.0);
    u_xlat16_3.x = min(u_xlat16_9.x, u_xlat16_3.x);
    u_xlat16_3.x = min(u_xlat16_9.y, u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.w>=u_xlat10_1.w);
#else
    u_xlatb0.x = u_xlat16_2.w>=u_xlat10_1.w;
#endif
    u_xlat16_9.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.x = min(u_xlat16_9.x, u_xlat16_3.x);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = u_xlat16_3.x + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3.x<0.0);
#else
    u_xlatb0.x = u_xlat16_3.x<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
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
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}