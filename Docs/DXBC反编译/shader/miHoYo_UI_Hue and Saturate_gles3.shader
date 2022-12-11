//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/UI/Hue and Saturate" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_ColorScaler ("Color Scaler", Float) = 1
[Header(ASE Properties)] _Hue ("Hue", Range(0, 1)) = 0
_Saturate ("Saturate", Range(0, 1)) = 0
_Intensity ("Intensity", Range(0, 1)) = 0
_ASEHeader ("", Float) = 0
[Header(Stencil)] _StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
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
  GpuProgramID 29879
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _Hue;
uniform 	mediump float _Intensity;
uniform 	mediump float _Saturate;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
bvec2 u_xlatb4;
bool u_xlatb5;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 + _TextureSampleAdd;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.y>=u_xlat16_0.z);
#else
    u_xlatb1 = u_xlat16_0.y>=u_xlat16_0.z;
#endif
    u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_7.xy = vec2((-u_xlat16_0.z) + u_xlat16_0.y, (-u_xlat16_0.y) + u_xlat16_0.z);
    u_xlat16_1.xy = u_xlat16_2.xx * u_xlat16_7.xy + u_xlat16_0.zy;
    u_xlat16_7.x = float(1.0);
    u_xlat16_7.y = float(-1.0);
    u_xlat16_1.zw = u_xlat16_2.xx * u_xlat16_7.xy + vec2(-1.0, 0.666666687);
    u_xlat16_2.xyz = (-u_xlat16_1.xyw);
    u_xlat16_2.w = (-u_xlat16_0.x);
    u_xlat16_3.yzw = vec3(u_xlat16_1.y + u_xlat16_2.y, u_xlat16_1.z + u_xlat16_2.z, u_xlat16_1.x + u_xlat16_2.w);
    u_xlat16_3.x = u_xlat16_0.x + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat16_0.x>=u_xlat16_1.x);
#else
    u_xlatb5 = u_xlat16_0.x>=u_xlat16_1.x;
#endif
    u_xlat16_2.x = (u_xlatb5) ? 1.0 : 0.0;
    u_xlat16_7.x = u_xlat16_2.x * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_2.xzw = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyw;
    u_xlat16_3.x = min(u_xlat16_2.z, u_xlat16_7.x);
    u_xlat16_7.x = (-u_xlat16_2.z) + u_xlat16_7.x;
    u_xlat16_12 = u_xlat16_2.x + (-u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_12 * 6.0 + 1.00000001e-10;
    u_xlat16_7.x = u_xlat16_7.x / u_xlat16_3.x;
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_2.w;
    u_xlat16_17 = -abs(u_xlat16_7.x) + _Hue;
    u_xlat16_7.x = _Intensity * u_xlat16_17 + abs(u_xlat16_7.x);
    u_xlat16_3.xyz = u_xlat16_7.xxx + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat16_3.xyz = fract(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat16_3.xyz = abs(u_xlat16_3.xyz) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_7.x = u_xlat16_2.x + 1.00000001e-10;
    u_xlat16_7.x = u_xlat16_12 / u_xlat16_7.x;
    u_xlat16_12 = (-u_xlat16_7.x) + _Saturate;
    u_xlat16_7.x = _Intensity * u_xlat16_12 + u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_7.xyz * u_xlat16_2.xxx;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_ColorScaler);
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb4.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat4.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb4.xy));
    u_xlat0.xy = u_xlat0.xy * u_xlat4.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_0.w;
    SV_Target0.w = u_xlat0.x;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _Hue;
uniform 	mediump float _Intensity;
uniform 	mediump float _Saturate;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
bool u_xlatb5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_10;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat16_2.x = u_xlat16_1.w * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.w;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x<0.0);
#else
    u_xlatb0.x = u_xlat16_2.x<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_1.y>=u_xlat16_1.z);
#else
    u_xlatb0.x = u_xlat16_1.y>=u_xlat16_1.z;
#endif
    u_xlat16_2.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_6.xy = vec2((-u_xlat16_1.z) + u_xlat16_1.y, (-u_xlat16_1.y) + u_xlat16_1.z);
    u_xlat16_0.xy = u_xlat16_2.xx * u_xlat16_6.xy + u_xlat16_1.zy;
    u_xlat16_6.x = float(1.0);
    u_xlat16_6.y = float(-1.0);
    u_xlat16_0.zw = u_xlat16_2.xx * u_xlat16_6.xy + vec2(-1.0, 0.666666687);
    u_xlat16_2.xyz = (-u_xlat16_0.xyw);
    u_xlat16_2.w = (-u_xlat16_1.x);
    u_xlat16_3.yzw = vec3(u_xlat16_0.y + u_xlat16_2.y, u_xlat16_0.z + u_xlat16_2.z, u_xlat16_0.x + u_xlat16_2.w);
    u_xlat16_3.x = u_xlat16_1.x + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat16_1.x>=u_xlat16_0.x);
#else
    u_xlatb5 = u_xlat16_1.x>=u_xlat16_0.x;
#endif
    u_xlat16_2.x = (u_xlatb5) ? 1.0 : 0.0;
    u_xlat16_6.x = u_xlat16_2.x * u_xlat16_3.w + u_xlat16_1.x;
    u_xlat16_2.xzw = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_0.xyw;
    u_xlat16_3.x = (-u_xlat16_2.z) + u_xlat16_6.x;
    u_xlat16_6.x = min(u_xlat16_2.z, u_xlat16_6.x);
    u_xlat16_6.x = (-u_xlat16_6.x) + u_xlat16_2.x;
    u_xlat16_10 = u_xlat16_6.x * 6.0 + 1.00000001e-10;
    u_xlat16_10 = u_xlat16_3.x / u_xlat16_10;
    u_xlat16_10 = u_xlat16_10 + u_xlat16_2.w;
    u_xlat16_14 = -abs(u_xlat16_10) + _Hue;
    u_xlat16_10 = _Intensity * u_xlat16_14 + abs(u_xlat16_10);
    u_xlat16_3.xyz = vec3(u_xlat16_10) + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat16_3.xyz = fract(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat16_3.xyz = abs(u_xlat16_3.xyz) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_10 = u_xlat16_2.x + 1.00000001e-10;
    u_xlat16_6.x = u_xlat16_6.x / u_xlat16_10;
    u_xlat16_10 = (-u_xlat16_6.x) + _Saturate;
    u_xlat16_6.x = _Intensity * u_xlat16_10 + u_xlat16_6.x;
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_6.xyz * u_xlat16_2.xxx;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_ColorScaler);
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _Hue;
uniform 	mediump float _Intensity;
uniform 	mediump float _Saturate;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SmoothMaskTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
float u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
bvec2 u_xlatb5;
vec2 u_xlat6;
lowp float u_xlat10_6;
bvec2 u_xlatb6;
mediump vec3 u_xlat16_8;
float u_xlat11;
bool u_xlatb11;
vec2 u_xlat12;
bool u_xlatb12;
mediump float u_xlat16_14;
float u_xlat17;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
bool u_xlatb23;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 + _TextureSampleAdd;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat16_0.y>=u_xlat16_0.z);
#else
    u_xlatb1.x = u_xlat16_0.y>=u_xlat16_0.z;
#endif
    u_xlat16_2.x = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat16_8.xy = vec2((-u_xlat16_0.z) + u_xlat16_0.y, (-u_xlat16_0.y) + u_xlat16_0.z);
    u_xlat16_3.x = float(1.0);
    u_xlat16_3.y = float(-1.0);
    u_xlat16_1.xy = u_xlat16_2.xx * u_xlat16_8.xy + u_xlat16_0.zy;
    u_xlat16_1.zw = u_xlat16_2.xx * u_xlat16_3.xy + vec2(-1.0, 0.666666687);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(u_xlat16_0.x>=u_xlat16_1.x);
#else
    u_xlatb6.x = u_xlat16_0.x>=u_xlat16_1.x;
#endif
    u_xlat16_2.x = (u_xlatb6.x) ? 1.0 : 0.0;
    u_xlat16_3.xyz = (-u_xlat16_1.xyw);
    u_xlat16_3.w = (-u_xlat16_0.x);
    u_xlat16_4.x = u_xlat16_0.x + u_xlat16_3.x;
    u_xlat16_4.yzw = vec3(u_xlat16_1.y + u_xlat16_3.y, u_xlat16_1.z + u_xlat16_3.z, u_xlat16_1.x + u_xlat16_3.w);
    u_xlat16_8.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz + u_xlat16_1.xyw;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_4.w + u_xlat16_0.x;
    u_xlat16_3.x = min(u_xlat16_8.y, u_xlat16_2.x);
    u_xlat16_3.x = u_xlat16_8.x + (-u_xlat16_3.x);
    u_xlat16_2.x = (-u_xlat16_8.y) + u_xlat16_2.x;
    u_xlat16_14 = u_xlat16_3.x * 6.0 + 1.00000001e-10;
    u_xlat16_2.x = u_xlat16_2.x / u_xlat16_14;
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_8.z;
    u_xlat16_14 = u_xlat16_8.x + 1.00000001e-10;
    u_xlat16_14 = u_xlat16_3.x / u_xlat16_14;
    u_xlat16_20 = -abs(u_xlat16_2.x) + _Hue;
    u_xlat16_2.x = _Intensity * u_xlat16_20 + abs(u_xlat16_2.x);
    u_xlat16_20 = (-u_xlat16_14) + _Saturate;
    u_xlat16_14 = _Intensity * u_xlat16_20 + u_xlat16_14;
    u_xlat16_3.xyz = u_xlat16_2.xxx + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat16_3.xyz = fract(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat16_3.xyz = abs(u_xlat16_3.xyz) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xzw = vec3(u_xlat16_14) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xzw * u_xlat16_8.xxx;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_ColorScaler);
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb5.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat5.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlat0.xy = u_xlat0.xy * u_xlat5.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_0.w;
    if(_SmoothMaskType != 0) {
        u_xlatb6.xy = equal(ivec4(_SmoothMaskType), ivec4(1, 2, 0, 0)).xy;
        u_xlatb12 = u_xlatb6.y || u_xlatb6.x;
        if(u_xlatb12){
            u_xlat12.xy = vec2(-abs(vs_TEXCOORD1.z) + float(0.5), -abs(vs_TEXCOORD1.w) + float(0.5));
            u_xlat5.xy = vec2(1.0, 1.0) / _SmoothMaskSoftRanges.xy;
            u_xlat12.xy = u_xlat12.xy * u_xlat5.xy;
#ifdef UNITY_ADRENO_ES3
            u_xlat12.xy = min(max(u_xlat12.xy, 0.0), 1.0);
#else
            u_xlat12.xy = clamp(u_xlat12.xy, 0.0, 1.0);
#endif
            u_xlat5.xy = u_xlat12.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
            u_xlat12.xy = u_xlat12.xy * u_xlat12.xy;
            u_xlat12.xy = u_xlat12.xy * u_xlat5.xy;
            u_xlat16_2.x = u_xlat12.y * u_xlat12.x;
            if(u_xlatb6.x){
                u_xlat6.xy = vec2(vs_TEXCOORD1.z + float(0.5), vs_TEXCOORD1.w + float(0.5));
                u_xlat10_6 = texture(_SmoothMaskTexture, u_xlat6.xy).w;
                u_xlat16_2.x = u_xlat10_6 * u_xlat16_2.x;
                u_xlat16_2.x = u_xlat16_2.x;
            //ENDIF
            }
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb6.x = !!(_SmoothMaskType==3);
#else
            u_xlatb6.x = _SmoothMaskType==3;
#endif
            u_xlat12.x = dot(vs_TEXCOORD1.zw, vs_TEXCOORD1.zw);
            u_xlat12.x = sqrt(u_xlat12.x);
            u_xlat12.x = (-u_xlat12.x) + 0.5;
#ifdef UNITY_ADRENO_ES3
            u_xlatb18 = !!(0.00100000005<_SmoothMaskSoftRanges.w);
#else
            u_xlatb18 = 0.00100000005<_SmoothMaskSoftRanges.w;
#endif
            u_xlat5.xy = vec2(vs_TEXCOORD1.z * _SmoothMaskSoftRanges.z, vs_TEXCOORD1.w * _SmoothMaskSoftRanges.w);
            u_xlat5.x = dot(u_xlat5.xy, u_xlat5.xy);
            u_xlat5.x = sqrt(u_xlat5.x);
            u_xlat5.x = u_xlat5.x + u_xlat5.x;
            u_xlat16_8.x = (u_xlatb18) ? u_xlat5.x : _SmoothMaskSoftRanges.z;
            u_xlat16_8.x = float(1.0) / u_xlat16_8.x;
            u_xlat16_8.x = u_xlat12.x * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
            u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
            u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
            u_xlat16_14 = u_xlat16_8.x * -2.0 + 3.0;
            u_xlat16_8.x = u_xlat16_8.x * u_xlat16_8.x;
            u_xlat16_8.x = u_xlat16_8.x * u_xlat16_14;
            u_xlat16_2.x = (u_xlatb6.x) ? u_xlat16_8.x : 1.0;
        //ENDIF
        }
#ifdef UNITY_ADRENO_ES3
        u_xlatb6.x = !!(_SmoothMaskFillParams.x!=0.0);
#else
        u_xlatb6.x = _SmoothMaskFillParams.x!=0.0;
#endif
        if(u_xlatb6.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb6.x = !!(_SmoothMaskFillParams.x==1.0);
#else
            u_xlatb6.x = _SmoothMaskFillParams.x==1.0;
#endif
            if(u_xlatb6.x){
                u_xlat6.x = vs_TEXCOORD1.z + 0.5;
#ifdef UNITY_ADRENO_ES3
                u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                u_xlat18 = (-u_xlat6.x) + 1.0;
                u_xlat6.x = (u_xlatb12) ? u_xlat18 : u_xlat6.x;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb12 = !!(_SmoothMaskFillParams.x==2.0);
#else
                u_xlatb12 = _SmoothMaskFillParams.x==2.0;
#endif
                if(u_xlatb12){
                    u_xlat12.x = vs_TEXCOORD1.w + 0.5;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb18 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                    u_xlatb18 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                    u_xlat5.x = (-u_xlat12.x) + 1.0;
                    u_xlat6.x = (u_xlatb18) ? u_xlat5.x : u_xlat12.x;
                } else {
                    u_xlatb1 = equal(_SmoothMaskFillParams.zzzx, vec4(1.0, 2.0, 3.0, 3.0));
                    u_xlat3 = vec4(vs_TEXCOORD1.w * float(1.0), vs_TEXCOORD1.z * float(-1.0), vs_TEXCOORD1.w * float(-1.0), vs_TEXCOORD1.z * float(1.0));
                    u_xlat12.xy = (u_xlatb1.z) ? u_xlat3.xy : vs_TEXCOORD1.zw;
                    u_xlat12.xy = (u_xlatb1.y) ? (-vs_TEXCOORD1.zw) : u_xlat12.xy;
                    u_xlat5.xy = (u_xlatb1.x) ? u_xlat3.zw : u_xlat12.xy;
                    u_xlat12.xy = u_xlat5.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb23 = !!(_SmoothMaskFillParams.x==4.0);
#else
                    u_xlatb23 = _SmoothMaskFillParams.x==4.0;
#endif
                    u_xlat5.z = (u_xlatb23) ? u_xlat12.y : u_xlat5.y;
                    u_xlat12.xy = (u_xlatb1.w) ? u_xlat12.xy : u_xlat5.xz;
                    u_xlat12.x = u_xlat12.x * _SmoothMaskFillParams.w;
                    u_xlat5.x = min(abs(u_xlat12.y), abs(u_xlat12.x));
                    u_xlat11 = max(abs(u_xlat12.y), abs(u_xlat12.x));
                    u_xlat11 = float(1.0) / u_xlat11;
                    u_xlat5.x = u_xlat11 * u_xlat5.x;
                    u_xlat11 = u_xlat5.x * u_xlat5.x;
                    u_xlat17 = u_xlat11 * 0.0208350997 + -0.0851330012;
                    u_xlat17 = u_xlat11 * u_xlat17 + 0.180141002;
                    u_xlat17 = u_xlat11 * u_xlat17 + -0.330299497;
                    u_xlat11 = u_xlat11 * u_xlat17 + 0.999866009;
                    u_xlat17 = u_xlat11 * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb23 = !!(abs(u_xlat12.y)<abs(u_xlat12.x));
#else
                    u_xlatb23 = abs(u_xlat12.y)<abs(u_xlat12.x);
#endif
                    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
                    u_xlat17 = u_xlatb23 ? u_xlat17 : float(0.0);
                    u_xlat5.x = u_xlat5.x * u_xlat11 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb11 = !!(u_xlat12.y<(-u_xlat12.y));
#else
                    u_xlatb11 = u_xlat12.y<(-u_xlat12.y);
#endif
                    u_xlat11 = u_xlatb11 ? -3.14159274 : float(0.0);
                    u_xlat5.x = u_xlat11 + u_xlat5.x;
                    u_xlat11 = min(u_xlat12.y, u_xlat12.x);
                    u_xlat12.x = max(u_xlat12.y, u_xlat12.x);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb18 = !!(u_xlat11<(-u_xlat11));
#else
                    u_xlatb18 = u_xlat11<(-u_xlat11);
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb12 = !!(u_xlat12.x>=(-u_xlat12.x));
#else
                    u_xlatb12 = u_xlat12.x>=(-u_xlat12.x);
#endif
                    u_xlatb12 = u_xlatb12 && u_xlatb18;
                    u_xlat12.x = (u_xlatb12) ? (-u_xlat5.x) : u_xlat5.x;
                    u_xlat6.x = u_xlat12.x * 0.159154996 + 0.5;
                //ENDIF
                }
            //ENDIF
            }
#ifdef UNITY_ADRENO_ES3
            u_xlatb6.x = !!(_SmoothMaskFillParams.y>=u_xlat6.x);
#else
            u_xlatb6.x = _SmoothMaskFillParams.y>=u_xlat6.x;
#endif
            u_xlat6.x = u_xlatb6.x ? 1.0 : float(0.0);
            u_xlat2 = u_xlat6.x * u_xlat16_2.x;
            u_xlat16_2.x = u_xlat2;
        //ENDIF
        }
    } else {
        u_xlat16_2.x = 1.0;
    //ENDIF
    }
    SV_Target0.w = u_xlat0.x * u_xlat16_2.x;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _Hue;
uniform 	mediump float _Intensity;
uniform 	mediump float _Saturate;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SmoothMaskTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
float u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
bvec2 u_xlatb5;
vec2 u_xlat6;
lowp float u_xlat10_6;
bvec2 u_xlatb6;
mediump vec3 u_xlat16_8;
float u_xlat11;
bool u_xlatb11;
vec2 u_xlat12;
bool u_xlatb12;
mediump float u_xlat16_14;
float u_xlat17;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
bool u_xlatb23;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 + _TextureSampleAdd;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat16_0.y>=u_xlat16_0.z);
#else
    u_xlatb1.x = u_xlat16_0.y>=u_xlat16_0.z;
#endif
    u_xlat16_2.x = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat16_8.xy = vec2((-u_xlat16_0.z) + u_xlat16_0.y, (-u_xlat16_0.y) + u_xlat16_0.z);
    u_xlat16_3.x = float(1.0);
    u_xlat16_3.y = float(-1.0);
    u_xlat16_1.xy = u_xlat16_2.xx * u_xlat16_8.xy + u_xlat16_0.zy;
    u_xlat16_1.zw = u_xlat16_2.xx * u_xlat16_3.xy + vec2(-1.0, 0.666666687);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(u_xlat16_0.x>=u_xlat16_1.x);
#else
    u_xlatb6.x = u_xlat16_0.x>=u_xlat16_1.x;
#endif
    u_xlat16_2.x = (u_xlatb6.x) ? 1.0 : 0.0;
    u_xlat16_3.xyz = (-u_xlat16_1.xyw);
    u_xlat16_3.w = (-u_xlat16_0.x);
    u_xlat16_4.x = u_xlat16_0.x + u_xlat16_3.x;
    u_xlat16_4.yzw = vec3(u_xlat16_1.y + u_xlat16_3.y, u_xlat16_1.z + u_xlat16_3.z, u_xlat16_1.x + u_xlat16_3.w);
    u_xlat16_8.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz + u_xlat16_1.xyw;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_4.w + u_xlat16_0.x;
    u_xlat16_3.x = min(u_xlat16_8.y, u_xlat16_2.x);
    u_xlat16_3.x = u_xlat16_8.x + (-u_xlat16_3.x);
    u_xlat16_2.x = (-u_xlat16_8.y) + u_xlat16_2.x;
    u_xlat16_14 = u_xlat16_3.x * 6.0 + 1.00000001e-10;
    u_xlat16_2.x = u_xlat16_2.x / u_xlat16_14;
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_8.z;
    u_xlat16_14 = u_xlat16_8.x + 1.00000001e-10;
    u_xlat16_14 = u_xlat16_3.x / u_xlat16_14;
    u_xlat16_20 = -abs(u_xlat16_2.x) + _Hue;
    u_xlat16_2.x = _Intensity * u_xlat16_20 + abs(u_xlat16_2.x);
    u_xlat16_20 = (-u_xlat16_14) + _Saturate;
    u_xlat16_14 = _Intensity * u_xlat16_20 + u_xlat16_14;
    u_xlat16_3.xyz = u_xlat16_2.xxx + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat16_3.xyz = fract(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat16_3.xyz = abs(u_xlat16_3.xyz) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xzw = vec3(u_xlat16_14) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xzw * u_xlat16_8.xxx;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_ColorScaler);
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat0.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xy));
    u_xlatb5.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat5.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlat0.xy = u_xlat0.xy * u_xlat5.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_0.w;
    if(_SmoothMaskType != 0) {
        u_xlatb6.xy = equal(ivec4(_SmoothMaskType), ivec4(1, 2, 0, 0)).xy;
        u_xlatb12 = u_xlatb6.y || u_xlatb6.x;
        if(u_xlatb12){
            u_xlat12.xy = vec2(-abs(vs_TEXCOORD1.z) + float(0.5), -abs(vs_TEXCOORD1.w) + float(0.5));
            u_xlat5.xy = vec2(1.0, 1.0) / _SmoothMaskSoftRanges.xy;
            u_xlat12.xy = u_xlat12.xy * u_xlat5.xy;
#ifdef UNITY_ADRENO_ES3
            u_xlat12.xy = min(max(u_xlat12.xy, 0.0), 1.0);
#else
            u_xlat12.xy = clamp(u_xlat12.xy, 0.0, 1.0);
#endif
            u_xlat5.xy = u_xlat12.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
            u_xlat12.xy = u_xlat12.xy * u_xlat12.xy;
            u_xlat12.xy = u_xlat12.xy * u_xlat5.xy;
            u_xlat16_2.x = u_xlat12.y * u_xlat12.x;
            if(u_xlatb6.x){
                u_xlat6.xy = vec2(vs_TEXCOORD1.z + float(0.5), vs_TEXCOORD1.w + float(0.5));
                u_xlat10_6 = texture(_SmoothMaskTexture, u_xlat6.xy).w;
                u_xlat16_2.x = u_xlat10_6 * u_xlat16_2.x;
                u_xlat16_2.x = u_xlat16_2.x;
            //ENDIF
            }
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb6.x = !!(_SmoothMaskType==3);
#else
            u_xlatb6.x = _SmoothMaskType==3;
#endif
            u_xlat12.x = dot(vs_TEXCOORD1.zw, vs_TEXCOORD1.zw);
            u_xlat12.x = sqrt(u_xlat12.x);
            u_xlat12.x = (-u_xlat12.x) + 0.5;
#ifdef UNITY_ADRENO_ES3
            u_xlatb18 = !!(0.00100000005<_SmoothMaskSoftRanges.w);
#else
            u_xlatb18 = 0.00100000005<_SmoothMaskSoftRanges.w;
#endif
            u_xlat5.xy = vec2(vs_TEXCOORD1.z * _SmoothMaskSoftRanges.z, vs_TEXCOORD1.w * _SmoothMaskSoftRanges.w);
            u_xlat5.x = dot(u_xlat5.xy, u_xlat5.xy);
            u_xlat5.x = sqrt(u_xlat5.x);
            u_xlat5.x = u_xlat5.x + u_xlat5.x;
            u_xlat16_8.x = (u_xlatb18) ? u_xlat5.x : _SmoothMaskSoftRanges.z;
            u_xlat16_8.x = float(1.0) / u_xlat16_8.x;
            u_xlat16_8.x = u_xlat12.x * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
            u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
            u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
            u_xlat16_14 = u_xlat16_8.x * -2.0 + 3.0;
            u_xlat16_8.x = u_xlat16_8.x * u_xlat16_8.x;
            u_xlat16_8.x = u_xlat16_8.x * u_xlat16_14;
            u_xlat16_2.x = (u_xlatb6.x) ? u_xlat16_8.x : 1.0;
        //ENDIF
        }
#ifdef UNITY_ADRENO_ES3
        u_xlatb6.x = !!(_SmoothMaskFillParams.x!=0.0);
#else
        u_xlatb6.x = _SmoothMaskFillParams.x!=0.0;
#endif
        if(u_xlatb6.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb6.x = !!(_SmoothMaskFillParams.x==1.0);
#else
            u_xlatb6.x = _SmoothMaskFillParams.x==1.0;
#endif
            if(u_xlatb6.x){
                u_xlat6.x = vs_TEXCOORD1.z + 0.5;
#ifdef UNITY_ADRENO_ES3
                u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                u_xlat18 = (-u_xlat6.x) + 1.0;
                u_xlat6.x = (u_xlatb12) ? u_xlat18 : u_xlat6.x;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb12 = !!(_SmoothMaskFillParams.x==2.0);
#else
                u_xlatb12 = _SmoothMaskFillParams.x==2.0;
#endif
                if(u_xlatb12){
                    u_xlat12.x = vs_TEXCOORD1.w + 0.5;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb18 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                    u_xlatb18 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                    u_xlat5.x = (-u_xlat12.x) + 1.0;
                    u_xlat6.x = (u_xlatb18) ? u_xlat5.x : u_xlat12.x;
                } else {
                    u_xlatb1 = equal(_SmoothMaskFillParams.zzzx, vec4(1.0, 2.0, 3.0, 3.0));
                    u_xlat3 = vec4(vs_TEXCOORD1.w * float(1.0), vs_TEXCOORD1.z * float(-1.0), vs_TEXCOORD1.w * float(-1.0), vs_TEXCOORD1.z * float(1.0));
                    u_xlat12.xy = (u_xlatb1.z) ? u_xlat3.xy : vs_TEXCOORD1.zw;
                    u_xlat12.xy = (u_xlatb1.y) ? (-vs_TEXCOORD1.zw) : u_xlat12.xy;
                    u_xlat5.xy = (u_xlatb1.x) ? u_xlat3.zw : u_xlat12.xy;
                    u_xlat12.xy = u_xlat5.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb23 = !!(_SmoothMaskFillParams.x==4.0);
#else
                    u_xlatb23 = _SmoothMaskFillParams.x==4.0;
#endif
                    u_xlat5.z = (u_xlatb23) ? u_xlat12.y : u_xlat5.y;
                    u_xlat12.xy = (u_xlatb1.w) ? u_xlat12.xy : u_xlat5.xz;
                    u_xlat12.x = u_xlat12.x * _SmoothMaskFillParams.w;
                    u_xlat5.x = min(abs(u_xlat12.y), abs(u_xlat12.x));
                    u_xlat11 = max(abs(u_xlat12.y), abs(u_xlat12.x));
                    u_xlat11 = float(1.0) / u_xlat11;
                    u_xlat5.x = u_xlat11 * u_xlat5.x;
                    u_xlat11 = u_xlat5.x * u_xlat5.x;
                    u_xlat17 = u_xlat11 * 0.0208350997 + -0.0851330012;
                    u_xlat17 = u_xlat11 * u_xlat17 + 0.180141002;
                    u_xlat17 = u_xlat11 * u_xlat17 + -0.330299497;
                    u_xlat11 = u_xlat11 * u_xlat17 + 0.999866009;
                    u_xlat17 = u_xlat11 * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb23 = !!(abs(u_xlat12.y)<abs(u_xlat12.x));
#else
                    u_xlatb23 = abs(u_xlat12.y)<abs(u_xlat12.x);
#endif
                    u_xlat17 = u_xlat17 * -2.0 + 1.57079637;
                    u_xlat17 = u_xlatb23 ? u_xlat17 : float(0.0);
                    u_xlat5.x = u_xlat5.x * u_xlat11 + u_xlat17;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb11 = !!(u_xlat12.y<(-u_xlat12.y));
#else
                    u_xlatb11 = u_xlat12.y<(-u_xlat12.y);
#endif
                    u_xlat11 = u_xlatb11 ? -3.14159274 : float(0.0);
                    u_xlat5.x = u_xlat11 + u_xlat5.x;
                    u_xlat11 = min(u_xlat12.y, u_xlat12.x);
                    u_xlat12.x = max(u_xlat12.y, u_xlat12.x);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb18 = !!(u_xlat11<(-u_xlat11));
#else
                    u_xlatb18 = u_xlat11<(-u_xlat11);
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb12 = !!(u_xlat12.x>=(-u_xlat12.x));
#else
                    u_xlatb12 = u_xlat12.x>=(-u_xlat12.x);
#endif
                    u_xlatb12 = u_xlatb12 && u_xlatb18;
                    u_xlat12.x = (u_xlatb12) ? (-u_xlat5.x) : u_xlat5.x;
                    u_xlat6.x = u_xlat12.x * 0.159154996 + 0.5;
                //ENDIF
                }
            //ENDIF
            }
#ifdef UNITY_ADRENO_ES3
            u_xlatb6.x = !!(_SmoothMaskFillParams.y>=u_xlat6.x);
#else
            u_xlatb6.x = _SmoothMaskFillParams.y>=u_xlat6.x;
#endif
            u_xlat6.x = u_xlatb6.x ? 1.0 : float(0.0);
            u_xlat2 = u_xlat6.x * u_xlat16_2.x;
            u_xlat16_2.x = u_xlat2;
        //ENDIF
        }
    } else {
        u_xlat16_2.x = 1.0;
    //ENDIF
    }
    u_xlat16_8.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x<0.0);
#else
    u_xlatb0.x = u_xlat16_2.x<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = u_xlat16_8.x;
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