//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/UI/UI_Eff_Circle" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_ColorScaler ("Color Scaler", Float) = 1
[Header(ASE Properties)] _MainColor ("MainColor", Color) = (1,0.2426471,0.2426471,0)
_Birghtness ("Birghtness", Float) = 1
_EdgeColor ("EdgeColor", Color) = (1,1,1,0)
_EdgeBirghtness ("EdgeBirghtness", Float) = 1
_CircleEdge ("CircleEdge", Range(0, 1)) = 0.1030809
_CircleScale ("CircleScale", Range(0, 1)) = 0.2009938
_CircleOpacity ("CircleOpacity", Range(0, 1)) = 1
_EdgeOpacity ("EdgeOpacity", Range(0, 1)) = 1
_ASEHeader ("", Float) = 0
[Header(Stencil)] [Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
[Header(SmoothMask)] [Toggle(UNITY_UI_SMOOTHMASK)] _UseUISmoothMask ("Use Smooth Mask", Float) = 0
_SmoothMaskType ("Smooth Mask Type [0:Unused 1:Texture 2: Rectangle 3:Circle 4:Radial]", Float) = 0
_SmoothMaskTexture ("Smooth Mask Texture", 2D) = "white" { }
_SmoothMaskSoftRanges ("Smooth Mask Soft Ranges [x:Horizontal y:Verticle z:Radial]", Vector) = (0,0,0,0)
_SmoothMaskFillParams ("Smooth Mask Fill Params [x:Type y:Amount z:Origin w:Clockwise]", Vector) = (1,0,0,0)
[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 5
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 10
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "DEFAULT"
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 17704
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
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
    u_xlat0 = in_COLOR0 * _Color;
    u_xlat16_2.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = log2(u_xlat16_2.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeBirghtness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _Birghtness;
uniform 	mediump float _CircleScale;
uniform 	mediump float _CircleEdge;
uniform 	mediump float _CircleOpacity;
uniform 	mediump float _EdgeOpacity;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-0.5, -0.5);
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_1.x = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_4 = _CircleEdge + _CircleScale;
    u_xlat16_1.y = (-u_xlat16_4) + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x + (-_CircleScale);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(999.999939, 999.999939);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xy = min(max(u_xlat16_1.xy, 0.0), 1.0);
#else
    u_xlat16_1.xy = clamp(u_xlat16_1.xy, 0.0, 1.0);
#endif
    u_xlat16_7 = u_xlat16_1.y * -2.0 + 3.0;
    u_xlat16_4 = u_xlat16_1.y * u_xlat16_1.y;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_7 * u_xlat16_1.x + (-u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * _CircleOpacity;
    u_xlat16_1.x = u_xlat16_1.x * _EdgeOpacity + u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * vs_COLOR0.w;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
    u_xlat16_1.xzw = _EdgeColor.xyz * vec3(_EdgeBirghtness);
    u_xlat16_2.xyz = _MainColor.xyz * vec3(_Birghtness) + (-u_xlat16_1.xzw);
    u_xlat16_1.xyz = vec3(u_xlat16_4) * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(_ColorScaler);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
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
    u_xlat0 = in_COLOR0 * _Color;
    u_xlat16_2.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = log2(u_xlat16_2.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeBirghtness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _Birghtness;
uniform 	mediump float _CircleScale;
uniform 	mediump float _CircleEdge;
uniform 	mediump float _CircleOpacity;
uniform 	mediump float _EdgeOpacity;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-0.5, -0.5);
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_1.x = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_4 = _CircleEdge + _CircleScale;
    u_xlat16_1.y = (-u_xlat16_4) + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x + (-_CircleScale);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(999.999939, 999.999939);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xy = min(max(u_xlat16_1.xy, 0.0), 1.0);
#else
    u_xlat16_1.xy = clamp(u_xlat16_1.xy, 0.0, 1.0);
#endif
    u_xlat16_7 = u_xlat16_1.y * -2.0 + 3.0;
    u_xlat16_4 = u_xlat16_1.y * u_xlat16_1.y;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_7 * u_xlat16_1.x + (-u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * _CircleOpacity;
    u_xlat16_1.x = u_xlat16_1.x * _EdgeOpacity + u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * vs_COLOR0.w;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_7 = u_xlat16_1.x * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7<0.0);
#else
    u_xlatb0.x = u_xlat16_7<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat16_1.xzw = _EdgeColor.xyz * vec3(_EdgeBirghtness);
    u_xlat16_2.xyz = _MainColor.xyz * vec3(_Birghtness) + (-u_xlat16_1.xzw);
    u_xlat16_1.xyz = vec3(u_xlat16_4) * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(_ColorScaler);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_SMOOTHMASK" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_SmoothMaskTransform[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
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
    u_xlat0 = in_COLOR0 * _Color;
    u_xlat16_2.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = log2(u_xlat16_2.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4_SmoothMaskTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_SmoothMaskTransform[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4_SmoothMaskTransform[2].xy * in_POSITION0.zz + u_xlat0.xy;
    vs_TEXCOORD1.zw = hlslcc_mtx4x4_SmoothMaskTransform[3].xy * in_POSITION0.ww + u_xlat0.xy;
    vs_TEXCOORD1.xy = in_POSITION0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	int _SmoothMaskType;
uniform 	vec4 _SmoothMaskSoftRanges;
uniform 	vec4 _SmoothMaskFillParams;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeBirghtness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _Birghtness;
uniform 	mediump float _CircleScale;
uniform 	mediump float _CircleEdge;
uniform 	mediump float _CircleOpacity;
uniform 	mediump float _EdgeOpacity;
uniform lowp sampler2D _SmoothMaskTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
float u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp float u_xlat10_5;
bvec2 u_xlatb5;
mediump float u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
vec2 u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
float u_xlat14;
float u_xlat15;
bool u_xlatb15;
mediump float u_xlat16_16;
bool u_xlatb19;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-0.5, -0.5);
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_1.x = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6 = _CircleEdge + _CircleScale;
    u_xlat16_6 = (-u_xlat16_6) + u_xlat16_1.x;
    u_xlat16_6 = u_xlat16_6 * 999.999939;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_11 = u_xlat16_6 * -2.0 + 3.0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_6 * _CircleOpacity;
    u_xlat16_2.xyz = _EdgeColor.xyz * vec3(_EdgeBirghtness);
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_Birghtness) + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_1.x = u_xlat16_1.x + (-_CircleScale);
    u_xlat16_1.x = u_xlat16_1.x * 999.999939;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat16_1.x = u_xlat16_16 * u_xlat16_1.x + (-u_xlat16_6);
    u_xlat16_1.x = u_xlat16_1.x * _EdgeOpacity + u_xlat16_11;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * vs_COLOR0.w;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_ColorScaler);
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    if(_SmoothMaskType != 0) {
        u_xlatb5.xy = equal(ivec4(_SmoothMaskType), ivec4(1, 2, 0, 0)).xy;
        u_xlatb10 = u_xlatb5.y || u_xlatb5.x;
        if(u_xlatb10){
            u_xlat10.xy = vec2(-abs(vs_TEXCOORD1.z) + float(0.5), -abs(vs_TEXCOORD1.w) + float(0.5));
            u_xlat4.xy = vec2(1.0, 1.0) / _SmoothMaskSoftRanges.xy;
            u_xlat10.xy = u_xlat10.xy * u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
            u_xlat10.xy = min(max(u_xlat10.xy, 0.0), 1.0);
#else
            u_xlat10.xy = clamp(u_xlat10.xy, 0.0, 1.0);
#endif
            u_xlat4.xy = u_xlat10.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
            u_xlat10.xy = u_xlat10.xy * u_xlat10.xy;
            u_xlat10.xy = u_xlat10.xy * u_xlat4.xy;
            u_xlat16_1.x = u_xlat10.y * u_xlat10.x;
            if(u_xlatb5.x){
                u_xlat5.xy = vec2(vs_TEXCOORD1.z + float(0.5), vs_TEXCOORD1.w + float(0.5));
                u_xlat10_5 = texture(_SmoothMaskTexture, u_xlat5.xy).w;
                u_xlat16_1.x = u_xlat10_5 * u_xlat16_1.x;
                u_xlat16_1.x = u_xlat16_1.x;
            //ENDIF
            }
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb5.x = !!(_SmoothMaskType==3);
#else
            u_xlatb5.x = _SmoothMaskType==3;
#endif
            u_xlat10.x = dot(vs_TEXCOORD1.zw, vs_TEXCOORD1.zw);
            u_xlat10.x = sqrt(u_xlat10.x);
            u_xlat10.x = (-u_xlat10.x) + 0.5;
#ifdef UNITY_ADRENO_ES3
            u_xlatb15 = !!(0.00100000005<_SmoothMaskSoftRanges.w);
#else
            u_xlatb15 = 0.00100000005<_SmoothMaskSoftRanges.w;
#endif
            u_xlat4.xy = vec2(vs_TEXCOORD1.z * _SmoothMaskSoftRanges.z, vs_TEXCOORD1.w * _SmoothMaskSoftRanges.w);
            u_xlat4.x = dot(u_xlat4.xy, u_xlat4.xy);
            u_xlat4.x = sqrt(u_xlat4.x);
            u_xlat4.x = u_xlat4.x + u_xlat4.x;
            u_xlat16_6 = (u_xlatb15) ? u_xlat4.x : _SmoothMaskSoftRanges.z;
            u_xlat16_6 = float(1.0) / u_xlat16_6;
            u_xlat16_6 = u_xlat10.x * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
            u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
            u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
            u_xlat16_11 = u_xlat16_6 * -2.0 + 3.0;
            u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
            u_xlat16_6 = u_xlat16_6 * u_xlat16_11;
            u_xlat16_1.x = (u_xlatb5.x) ? u_xlat16_6 : 1.0;
        //ENDIF
        }
#ifdef UNITY_ADRENO_ES3
        u_xlatb5.x = !!(_SmoothMaskFillParams.x!=0.0);
#else
        u_xlatb5.x = _SmoothMaskFillParams.x!=0.0;
#endif
        if(u_xlatb5.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb5.x = !!(_SmoothMaskFillParams.x==1.0);
#else
            u_xlatb5.x = _SmoothMaskFillParams.x==1.0;
#endif
            if(u_xlatb5.x){
                u_xlat5.x = vs_TEXCOORD1.z + 0.5;
#ifdef UNITY_ADRENO_ES3
                u_xlatb10 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                u_xlatb10 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                u_xlat15 = (-u_xlat5.x) + 1.0;
                u_xlat5.x = (u_xlatb10) ? u_xlat15 : u_xlat5.x;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb10 = !!(_SmoothMaskFillParams.x==2.0);
#else
                u_xlatb10 = _SmoothMaskFillParams.x==2.0;
#endif
                if(u_xlatb10){
                    u_xlat10.x = vs_TEXCOORD1.w + 0.5;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                    u_xlat4.x = (-u_xlat10.x) + 1.0;
                    u_xlat5.x = (u_xlatb15) ? u_xlat4.x : u_xlat10.x;
                } else {
                    u_xlatb2 = equal(_SmoothMaskFillParams.zzzx, vec4(1.0, 2.0, 3.0, 3.0));
                    u_xlat3 = vec4(vs_TEXCOORD1.w * float(1.0), vs_TEXCOORD1.z * float(-1.0), vs_TEXCOORD1.w * float(-1.0), vs_TEXCOORD1.z * float(1.0));
                    u_xlat10.xy = (u_xlatb2.z) ? u_xlat3.xy : vs_TEXCOORD1.zw;
                    u_xlat10.xy = (u_xlatb2.y) ? (-vs_TEXCOORD1.zw) : u_xlat10.xy;
                    u_xlat4.xy = (u_xlatb2.x) ? u_xlat3.zw : u_xlat10.xy;
                    u_xlat10.xy = u_xlat4.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb19 = !!(_SmoothMaskFillParams.x==4.0);
#else
                    u_xlatb19 = _SmoothMaskFillParams.x==4.0;
#endif
                    u_xlat4.z = (u_xlatb19) ? u_xlat10.y : u_xlat4.y;
                    u_xlat10.xy = (u_xlatb2.w) ? u_xlat10.xy : u_xlat4.xz;
                    u_xlat10.x = u_xlat10.x * _SmoothMaskFillParams.w;
                    u_xlat4.x = min(abs(u_xlat10.y), abs(u_xlat10.x));
                    u_xlat9 = max(abs(u_xlat10.y), abs(u_xlat10.x));
                    u_xlat9 = float(1.0) / u_xlat9;
                    u_xlat4.x = u_xlat9 * u_xlat4.x;
                    u_xlat9 = u_xlat4.x * u_xlat4.x;
                    u_xlat14 = u_xlat9 * 0.0208350997 + -0.0851330012;
                    u_xlat14 = u_xlat9 * u_xlat14 + 0.180141002;
                    u_xlat14 = u_xlat9 * u_xlat14 + -0.330299497;
                    u_xlat9 = u_xlat9 * u_xlat14 + 0.999866009;
                    u_xlat14 = u_xlat9 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb19 = !!(abs(u_xlat10.y)<abs(u_xlat10.x));
#else
                    u_xlatb19 = abs(u_xlat10.y)<abs(u_xlat10.x);
#endif
                    u_xlat14 = u_xlat14 * -2.0 + 1.57079637;
                    u_xlat14 = u_xlatb19 ? u_xlat14 : float(0.0);
                    u_xlat4.x = u_xlat4.x * u_xlat9 + u_xlat14;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb9 = !!(u_xlat10.y<(-u_xlat10.y));
#else
                    u_xlatb9 = u_xlat10.y<(-u_xlat10.y);
#endif
                    u_xlat9 = u_xlatb9 ? -3.14159274 : float(0.0);
                    u_xlat4.x = u_xlat9 + u_xlat4.x;
                    u_xlat9 = min(u_xlat10.y, u_xlat10.x);
                    u_xlat10.x = max(u_xlat10.y, u_xlat10.x);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15 = !!(u_xlat9<(-u_xlat9));
#else
                    u_xlatb15 = u_xlat9<(-u_xlat9);
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb10 = !!(u_xlat10.x>=(-u_xlat10.x));
#else
                    u_xlatb10 = u_xlat10.x>=(-u_xlat10.x);
#endif
                    u_xlatb10 = u_xlatb10 && u_xlatb15;
                    u_xlat10.x = (u_xlatb10) ? (-u_xlat4.x) : u_xlat4.x;
                    u_xlat5.x = u_xlat10.x * 0.159154996 + 0.5;
                //ENDIF
                }
            //ENDIF
            }
#ifdef UNITY_ADRENO_ES3
            u_xlatb5.x = !!(_SmoothMaskFillParams.y>=u_xlat5.x);
#else
            u_xlatb5.x = _SmoothMaskFillParams.y>=u_xlat5.x;
#endif
            u_xlat5.x = u_xlatb5.x ? 1.0 : float(0.0);
            u_xlat1 = u_xlat5.x * u_xlat16_1.x;
            u_xlat16_1.x = u_xlat1;
        //ENDIF
        }
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
    SV_Target0.w = u_xlat0.x * u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_SMOOTHMASK" "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_SmoothMaskTransform[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
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
    u_xlat0 = in_COLOR0 * _Color;
    u_xlat16_2.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = log2(u_xlat16_2.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat0.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4_SmoothMaskTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_SmoothMaskTransform[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4_SmoothMaskTransform[2].xy * in_POSITION0.zz + u_xlat0.xy;
    vs_TEXCOORD1.zw = hlslcc_mtx4x4_SmoothMaskTransform[3].xy * in_POSITION0.ww + u_xlat0.xy;
    vs_TEXCOORD1.xy = in_POSITION0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	int _SmoothMaskType;
uniform 	vec4 _SmoothMaskSoftRanges;
uniform 	vec4 _SmoothMaskFillParams;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeBirghtness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _Birghtness;
uniform 	mediump float _CircleScale;
uniform 	mediump float _CircleEdge;
uniform 	mediump float _CircleOpacity;
uniform 	mediump float _EdgeOpacity;
uniform lowp sampler2D _SmoothMaskTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
float u_xlat1;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp float u_xlat10_5;
bvec2 u_xlatb5;
mediump float u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
vec2 u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
float u_xlat14;
float u_xlat15;
bool u_xlatb15;
mediump float u_xlat16_16;
bool u_xlatb19;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-0.5, -0.5);
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_1.x = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_6 = _CircleEdge + _CircleScale;
    u_xlat16_6 = (-u_xlat16_6) + u_xlat16_1.x;
    u_xlat16_6 = u_xlat16_6 * 999.999939;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_11 = u_xlat16_6 * -2.0 + 3.0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_6 * _CircleOpacity;
    u_xlat16_2.xyz = _EdgeColor.xyz * vec3(_EdgeBirghtness);
    u_xlat16_3.xyz = _MainColor.xyz * vec3(_Birghtness) + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_1.x = u_xlat16_1.x + (-_CircleScale);
    u_xlat16_1.x = u_xlat16_1.x * 999.999939;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat16_1.x = u_xlat16_16 * u_xlat16_1.x + (-u_xlat16_6);
    u_xlat16_1.x = u_xlat16_1.x * _EdgeOpacity + u_xlat16_11;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * vs_COLOR0.w;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_ColorScaler);
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    if(_SmoothMaskType != 0) {
        u_xlatb5.xy = equal(ivec4(_SmoothMaskType), ivec4(1, 2, 0, 0)).xy;
        u_xlatb10 = u_xlatb5.y || u_xlatb5.x;
        if(u_xlatb10){
            u_xlat10.xy = vec2(-abs(vs_TEXCOORD1.z) + float(0.5), -abs(vs_TEXCOORD1.w) + float(0.5));
            u_xlat4.xy = vec2(1.0, 1.0) / _SmoothMaskSoftRanges.xy;
            u_xlat10.xy = u_xlat10.xy * u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
            u_xlat10.xy = min(max(u_xlat10.xy, 0.0), 1.0);
#else
            u_xlat10.xy = clamp(u_xlat10.xy, 0.0, 1.0);
#endif
            u_xlat4.xy = u_xlat10.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
            u_xlat10.xy = u_xlat10.xy * u_xlat10.xy;
            u_xlat10.xy = u_xlat10.xy * u_xlat4.xy;
            u_xlat16_1.x = u_xlat10.y * u_xlat10.x;
            if(u_xlatb5.x){
                u_xlat5.xy = vec2(vs_TEXCOORD1.z + float(0.5), vs_TEXCOORD1.w + float(0.5));
                u_xlat10_5 = texture(_SmoothMaskTexture, u_xlat5.xy).w;
                u_xlat16_1.x = u_xlat10_5 * u_xlat16_1.x;
                u_xlat16_1.x = u_xlat16_1.x;
            //ENDIF
            }
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb5.x = !!(_SmoothMaskType==3);
#else
            u_xlatb5.x = _SmoothMaskType==3;
#endif
            u_xlat10.x = dot(vs_TEXCOORD1.zw, vs_TEXCOORD1.zw);
            u_xlat10.x = sqrt(u_xlat10.x);
            u_xlat10.x = (-u_xlat10.x) + 0.5;
#ifdef UNITY_ADRENO_ES3
            u_xlatb15 = !!(0.00100000005<_SmoothMaskSoftRanges.w);
#else
            u_xlatb15 = 0.00100000005<_SmoothMaskSoftRanges.w;
#endif
            u_xlat4.xy = vec2(vs_TEXCOORD1.z * _SmoothMaskSoftRanges.z, vs_TEXCOORD1.w * _SmoothMaskSoftRanges.w);
            u_xlat4.x = dot(u_xlat4.xy, u_xlat4.xy);
            u_xlat4.x = sqrt(u_xlat4.x);
            u_xlat4.x = u_xlat4.x + u_xlat4.x;
            u_xlat16_6 = (u_xlatb15) ? u_xlat4.x : _SmoothMaskSoftRanges.z;
            u_xlat16_6 = float(1.0) / u_xlat16_6;
            u_xlat16_6 = u_xlat10.x * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
            u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
            u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
            u_xlat16_11 = u_xlat16_6 * -2.0 + 3.0;
            u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
            u_xlat16_6 = u_xlat16_6 * u_xlat16_11;
            u_xlat16_1.x = (u_xlatb5.x) ? u_xlat16_6 : 1.0;
        //ENDIF
        }
#ifdef UNITY_ADRENO_ES3
        u_xlatb5.x = !!(_SmoothMaskFillParams.x!=0.0);
#else
        u_xlatb5.x = _SmoothMaskFillParams.x!=0.0;
#endif
        if(u_xlatb5.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb5.x = !!(_SmoothMaskFillParams.x==1.0);
#else
            u_xlatb5.x = _SmoothMaskFillParams.x==1.0;
#endif
            if(u_xlatb5.x){
                u_xlat5.x = vs_TEXCOORD1.z + 0.5;
#ifdef UNITY_ADRENO_ES3
                u_xlatb10 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                u_xlatb10 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                u_xlat15 = (-u_xlat5.x) + 1.0;
                u_xlat5.x = (u_xlatb10) ? u_xlat15 : u_xlat5.x;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb10 = !!(_SmoothMaskFillParams.x==2.0);
#else
                u_xlatb10 = _SmoothMaskFillParams.x==2.0;
#endif
                if(u_xlatb10){
                    u_xlat10.x = vs_TEXCOORD1.w + 0.5;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                    u_xlatb15 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                    u_xlat4.x = (-u_xlat10.x) + 1.0;
                    u_xlat5.x = (u_xlatb15) ? u_xlat4.x : u_xlat10.x;
                } else {
                    u_xlatb2 = equal(_SmoothMaskFillParams.zzzx, vec4(1.0, 2.0, 3.0, 3.0));
                    u_xlat3 = vec4(vs_TEXCOORD1.w * float(1.0), vs_TEXCOORD1.z * float(-1.0), vs_TEXCOORD1.w * float(-1.0), vs_TEXCOORD1.z * float(1.0));
                    u_xlat10.xy = (u_xlatb2.z) ? u_xlat3.xy : vs_TEXCOORD1.zw;
                    u_xlat10.xy = (u_xlatb2.y) ? (-vs_TEXCOORD1.zw) : u_xlat10.xy;
                    u_xlat4.xy = (u_xlatb2.x) ? u_xlat3.zw : u_xlat10.xy;
                    u_xlat10.xy = u_xlat4.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb19 = !!(_SmoothMaskFillParams.x==4.0);
#else
                    u_xlatb19 = _SmoothMaskFillParams.x==4.0;
#endif
                    u_xlat4.z = (u_xlatb19) ? u_xlat10.y : u_xlat4.y;
                    u_xlat10.xy = (u_xlatb2.w) ? u_xlat10.xy : u_xlat4.xz;
                    u_xlat10.x = u_xlat10.x * _SmoothMaskFillParams.w;
                    u_xlat4.x = min(abs(u_xlat10.y), abs(u_xlat10.x));
                    u_xlat9 = max(abs(u_xlat10.y), abs(u_xlat10.x));
                    u_xlat9 = float(1.0) / u_xlat9;
                    u_xlat4.x = u_xlat9 * u_xlat4.x;
                    u_xlat9 = u_xlat4.x * u_xlat4.x;
                    u_xlat14 = u_xlat9 * 0.0208350997 + -0.0851330012;
                    u_xlat14 = u_xlat9 * u_xlat14 + 0.180141002;
                    u_xlat14 = u_xlat9 * u_xlat14 + -0.330299497;
                    u_xlat9 = u_xlat9 * u_xlat14 + 0.999866009;
                    u_xlat14 = u_xlat9 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb19 = !!(abs(u_xlat10.y)<abs(u_xlat10.x));
#else
                    u_xlatb19 = abs(u_xlat10.y)<abs(u_xlat10.x);
#endif
                    u_xlat14 = u_xlat14 * -2.0 + 1.57079637;
                    u_xlat14 = u_xlatb19 ? u_xlat14 : float(0.0);
                    u_xlat4.x = u_xlat4.x * u_xlat9 + u_xlat14;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb9 = !!(u_xlat10.y<(-u_xlat10.y));
#else
                    u_xlatb9 = u_xlat10.y<(-u_xlat10.y);
#endif
                    u_xlat9 = u_xlatb9 ? -3.14159274 : float(0.0);
                    u_xlat4.x = u_xlat9 + u_xlat4.x;
                    u_xlat9 = min(u_xlat10.y, u_xlat10.x);
                    u_xlat10.x = max(u_xlat10.y, u_xlat10.x);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15 = !!(u_xlat9<(-u_xlat9));
#else
                    u_xlatb15 = u_xlat9<(-u_xlat9);
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb10 = !!(u_xlat10.x>=(-u_xlat10.x));
#else
                    u_xlatb10 = u_xlat10.x>=(-u_xlat10.x);
#endif
                    u_xlatb10 = u_xlatb10 && u_xlatb15;
                    u_xlat10.x = (u_xlatb10) ? (-u_xlat4.x) : u_xlat4.x;
                    u_xlat5.x = u_xlat10.x * 0.159154996 + 0.5;
                //ENDIF
                }
            //ENDIF
            }
#ifdef UNITY_ADRENO_ES3
            u_xlatb5.x = !!(_SmoothMaskFillParams.y>=u_xlat5.x);
#else
            u_xlatb5.x = _SmoothMaskFillParams.y>=u_xlat5.x;
#endif
            u_xlat5.x = u_xlatb5.x ? 1.0 : float(0.0);
            u_xlat1 = u_xlat5.x * u_xlat16_1.x;
            u_xlat16_1.x = u_xlat1;
        //ENDIF
        }
    } else {
        u_xlat16_1.x = 1.0;
    //ENDIF
    }
    u_xlat16_6 = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0.x = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = u_xlat16_6;
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
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_SMOOTHMASK" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_SMOOTHMASK" "UNITY_UI_ALPHACLIP" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}