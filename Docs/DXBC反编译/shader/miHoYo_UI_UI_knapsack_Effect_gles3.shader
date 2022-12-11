//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/UI/UI_knapsack_Effect" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_ColorScaler ("Color Scaler", Float) = 1
[Header(ASE Properties)] _BorderMask ("BorderMask", 2D) = "black" { }
_BorderNoise ("BorderNoise", 2D) = "black" { }
_BorderNoisePower ("BorderNoisePower", Float) = 2
_BorderColor ("BorderColor", Color) = (1,1,1,0)
_BorderBrightness ("BorderBrightness", Float) = 2
_BorderNoise_RotatorSpeed ("BorderNoise_RotatorSpeed", Float) = -0.3
_BaseNoise01 ("BaseNoise01", 2D) = "black" { }
_BaseNoise01_Uspeed ("BaseNoise01_Uspeed", Float) = 0.1
_BaseNoise01_Vspeed ("BaseNoise01_Vspeed", Float) = -0.05
_BaseNoise02 ("BaseNoise02", 2D) = "black" { }
_BaseNoise02_Uspeed ("BaseNoise02_Uspeed", Float) = 0.05
_BaseNoise02_Vspeed ("BaseNoise02_Vspeed", Float) = 0
_BaseNoiseColor ("BaseNoiseColor", Color) = (1,1,1,0)
_NoiseBrightness ("NoiseBrightness", Float) = 1.2
_StarMap01 ("StarMap01", 2D) = "black" { }
_StarBrightness ("StarBrightness", Float) = 2
_StarColor ("StarColor", Color) = (1,1,1,0)
_StarMap01_Uspeed ("StarMap01_Uspeed", Float) = 0
_StarMap01_Vspeed ("StarMap01_Vspeed", Float) = -0.1
_StarMap02 ("StarMap02", 2D) = "black" { }
_StarMap02_Uspeed ("StarMap02_Uspeed", Float) = 0
_FlowOpacity ("FlowOpacity", Range(0, 1)) = 1
_StarOpacity ("StarOpacity", Range(0, 1)) = 1
_StarMap02_Vspeed ("StarMap02_Vspeed", Float) = -0.05
_EdgeOpacity ("EdgeOpacity", Range(0, 1)) = 1
_texcoord ("", 2D) = "white" { }
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
  GpuProgramID 6272
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
uniform 	vec4 _Time;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	vec4 _BorderMask_ST;
uniform 	vec4 _BorderNoise_ST;
uniform 	mediump float _BorderNoise_RotatorSpeed;
uniform 	mediump float _BorderNoisePower;
uniform 	mediump float _BorderBrightness;
uniform 	mediump vec4 _BorderColor;
uniform 	mediump vec4 _BaseNoiseColor;
uniform 	mediump float _NoiseBrightness;
uniform 	mediump float _BaseNoise01_Uspeed;
uniform 	vec4 _BaseNoise01_ST;
uniform 	mediump float _BaseNoise01_Vspeed;
uniform 	mediump float _BaseNoise02_Uspeed;
uniform 	vec4 _BaseNoise02_ST;
uniform 	mediump float _BaseNoise02_Vspeed;
uniform 	mediump vec4 _StarColor;
uniform 	mediump float _StarBrightness;
uniform 	mediump float _StarMap01_Uspeed;
uniform 	vec4 _StarMap01_ST;
uniform 	mediump float _StarMap01_Vspeed;
uniform 	mediump float _StarMap02_Uspeed;
uniform 	vec4 _StarMap02_ST;
uniform 	mediump float _StarMap02_Vspeed;
uniform 	mediump float _EdgeOpacity;
uniform 	mediump float _FlowOpacity;
uniform 	mediump float _StarOpacity;
uniform lowp sampler2D _BorderMask;
uniform lowp sampler2D _BorderNoise;
uniform lowp sampler2D _BaseNoise01;
uniform lowp sampler2D _BaseNoise02;
uniform lowp sampler2D _StarMap01;
uniform lowp sampler2D _StarMap02;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
bvec2 u_xlatb3;
vec2 u_xlat4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
mediump float u_xlat16_8;
vec2 u_xlat12;
lowp float u_xlat10_12;
bvec2 u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BorderNoise_ST.xy + _BorderNoise_ST.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat12.x = _Time.y * _BorderNoise_RotatorSpeed;
    u_xlat16_1 = sin(u_xlat12.x);
    u_xlat16_2.x = cos(u_xlat12.x);
    u_xlat3.x = (-u_xlat16_1);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat4.x = dot(u_xlat0.xy, u_xlat16_2.xy);
    u_xlat3.y = u_xlat16_2.x;
    u_xlat4.y = dot(u_xlat0.xy, u_xlat3.xy);
    u_xlat0.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_BorderNoise, u_xlat0.xy).x;
    u_xlat16_0 = max(u_xlat10_0, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _BorderNoisePower;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat6.xy = vs_TEXCOORD0.xy * _BorderMask_ST.xy + _BorderMask_ST.zw;
    u_xlat10_1 = texture(_BorderMask, u_xlat6.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1.x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _BaseNoise01_ST.xy + _BaseNoise01_ST.zw;
    u_xlat16_2.x = _Time.y * _BaseNoise01_Uspeed + u_xlat6.x;
    u_xlat16_2.y = _Time.y * _BaseNoise01_Vspeed + u_xlat6.y;
    u_xlat10_6 = texture(_BaseNoise01, u_xlat16_2.xy).x;
    u_xlat12.xy = vs_TEXCOORD0.xy * _BaseNoise02_ST.xy + _BaseNoise02_ST.zw;
    u_xlat16_2.x = _Time.y * _BaseNoise02_Uspeed + u_xlat12.x;
    u_xlat16_2.y = _Time.y * _BaseNoise02_Vspeed + u_xlat12.y;
    u_xlat10_12 = texture(_BaseNoise02, u_xlat16_2.xy).x;
    u_xlat16_6 = u_xlat10_12 * u_xlat10_6;
    u_xlat16_2.x = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_2.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat10_1.y;
    u_xlat16_2.x = u_xlat16_6 * _FlowOpacity;
    u_xlat16_2.x = u_xlat16_0 * _EdgeOpacity + u_xlat16_2.x;
    u_xlat16_8 = u_xlat16_0 * _BorderBrightness;
    u_xlat0.xz = vs_TEXCOORD0.xy * _StarMap01_ST.xy + _StarMap01_ST.zw;
    u_xlat16_5.x = _Time.y * _StarMap01_Uspeed + u_xlat0.x;
    u_xlat16_5.y = _Time.y * _StarMap01_Vspeed + u_xlat0.z;
    u_xlat10_0 = texture(_StarMap01, u_xlat16_5.xy).x;
    u_xlat12.xy = vs_TEXCOORD0.xy * _StarMap02_ST.xy + _StarMap02_ST.zw;
    u_xlat16_5.x = _Time.y * _StarMap02_Uspeed + u_xlat12.x;
    u_xlat16_5.y = _Time.y * _StarMap02_Vspeed + u_xlat12.y;
    u_xlat10_12 = texture(_StarMap02, u_xlat16_5.xy).x;
    u_xlat16_0 = u_xlat10_12 + u_xlat10_0;
    u_xlat16_0 = u_xlat10_1.z * u_xlat16_0;
    u_xlat16_2.x = _StarOpacity * u_xlat16_0 + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat10_1.w * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * vs_COLOR0.w;
    u_xlatb12.xy = greaterThanEqual(vs_TEXCOORD1.xyxy, _ClipRect.xyxy).xy;
    u_xlat12.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb12.xy));
    u_xlatb3.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb3.xy));
    u_xlat12.xy = u_xlat12.xy * u_xlat3.xy;
    u_xlat12.x = u_xlat12.y * u_xlat12.x;
    u_xlat12.x = u_xlat12.x * u_xlat16_2.x;
    SV_Target0.w = u_xlat12.x;
    u_xlat16_2.xzw = _BaseNoiseColor.xyz * vec3(_NoiseBrightness);
    u_xlat16_2.xzw = vec3(u_xlat16_6) * u_xlat16_2.xzw;
    u_xlat16_2.xyz = vec3(u_xlat16_8) * _BorderColor.xyz + u_xlat16_2.xzw;
    u_xlat16_5.xyz = _StarColor.xyz * vec3(_StarBrightness);
    u_xlat16_2.xyz = u_xlat16_5.xyz * vec3(u_xlat16_0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_ColorScaler);
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
uniform 	vec4 _Time;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	vec4 _BorderMask_ST;
uniform 	vec4 _BorderNoise_ST;
uniform 	mediump float _BorderNoise_RotatorSpeed;
uniform 	mediump float _BorderNoisePower;
uniform 	mediump float _BorderBrightness;
uniform 	mediump vec4 _BorderColor;
uniform 	mediump vec4 _BaseNoiseColor;
uniform 	mediump float _NoiseBrightness;
uniform 	mediump float _BaseNoise01_Uspeed;
uniform 	vec4 _BaseNoise01_ST;
uniform 	mediump float _BaseNoise01_Vspeed;
uniform 	mediump float _BaseNoise02_Uspeed;
uniform 	vec4 _BaseNoise02_ST;
uniform 	mediump float _BaseNoise02_Vspeed;
uniform 	mediump vec4 _StarColor;
uniform 	mediump float _StarBrightness;
uniform 	mediump float _StarMap01_Uspeed;
uniform 	vec4 _StarMap01_ST;
uniform 	mediump float _StarMap01_Vspeed;
uniform 	mediump float _StarMap02_Uspeed;
uniform 	vec4 _StarMap02_ST;
uniform 	mediump float _StarMap02_Vspeed;
uniform 	mediump float _EdgeOpacity;
uniform 	mediump float _FlowOpacity;
uniform 	mediump float _StarOpacity;
uniform lowp sampler2D _BorderMask;
uniform lowp sampler2D _BorderNoise;
uniform lowp sampler2D _BaseNoise01;
uniform lowp sampler2D _BaseNoise02;
uniform lowp sampler2D _StarMap01;
uniform lowp sampler2D _StarMap02;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
bvec2 u_xlatb3;
vec2 u_xlat4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
mediump float u_xlat16_8;
vec2 u_xlat12;
lowp float u_xlat10_12;
bvec2 u_xlatb12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BorderNoise_ST.xy + _BorderNoise_ST.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat12.x = _Time.y * _BorderNoise_RotatorSpeed;
    u_xlat16_1 = sin(u_xlat12.x);
    u_xlat16_2.x = cos(u_xlat12.x);
    u_xlat3.x = (-u_xlat16_1);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat4.x = dot(u_xlat0.xy, u_xlat16_2.xy);
    u_xlat3.y = u_xlat16_2.x;
    u_xlat4.y = dot(u_xlat0.xy, u_xlat3.xy);
    u_xlat0.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_BorderNoise, u_xlat0.xy).x;
    u_xlat16_0 = max(u_xlat10_0, 9.99999975e-05);
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _BorderNoisePower;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat6.xy = vs_TEXCOORD0.xy * _BorderMask_ST.xy + _BorderMask_ST.zw;
    u_xlat10_1 = texture(_BorderMask, u_xlat6.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1.x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _BaseNoise01_ST.xy + _BaseNoise01_ST.zw;
    u_xlat16_2.x = _Time.y * _BaseNoise01_Uspeed + u_xlat6.x;
    u_xlat16_2.y = _Time.y * _BaseNoise01_Vspeed + u_xlat6.y;
    u_xlat10_6 = texture(_BaseNoise01, u_xlat16_2.xy).x;
    u_xlat12.xy = vs_TEXCOORD0.xy * _BaseNoise02_ST.xy + _BaseNoise02_ST.zw;
    u_xlat16_2.x = _Time.y * _BaseNoise02_Uspeed + u_xlat12.x;
    u_xlat16_2.y = _Time.y * _BaseNoise02_Vspeed + u_xlat12.y;
    u_xlat10_12 = texture(_BaseNoise02, u_xlat16_2.xy).x;
    u_xlat16_6 = u_xlat10_12 * u_xlat10_6;
    u_xlat16_2.x = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_2.x;
    u_xlat16_6 = u_xlat16_6 * u_xlat10_1.y;
    u_xlat16_2.x = u_xlat16_6 * _FlowOpacity;
    u_xlat16_2.x = u_xlat16_0 * _EdgeOpacity + u_xlat16_2.x;
    u_xlat16_8 = u_xlat16_0 * _BorderBrightness;
    u_xlat0.xz = vs_TEXCOORD0.xy * _StarMap01_ST.xy + _StarMap01_ST.zw;
    u_xlat16_5.x = _Time.y * _StarMap01_Uspeed + u_xlat0.x;
    u_xlat16_5.y = _Time.y * _StarMap01_Vspeed + u_xlat0.z;
    u_xlat10_0 = texture(_StarMap01, u_xlat16_5.xy).x;
    u_xlat12.xy = vs_TEXCOORD0.xy * _StarMap02_ST.xy + _StarMap02_ST.zw;
    u_xlat16_5.x = _Time.y * _StarMap02_Uspeed + u_xlat12.x;
    u_xlat16_5.y = _Time.y * _StarMap02_Vspeed + u_xlat12.y;
    u_xlat10_12 = texture(_StarMap02, u_xlat16_5.xy).x;
    u_xlat16_0 = u_xlat10_12 + u_xlat10_0;
    u_xlat16_0 = u_xlat10_1.z * u_xlat16_0;
    u_xlat16_2.x = _StarOpacity * u_xlat16_0 + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat10_1.w * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * vs_COLOR0.w;
    u_xlatb12.xy = greaterThanEqual(vs_TEXCOORD1.xyxy, _ClipRect.xyxy).xy;
    u_xlat12.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb12.xy));
    u_xlatb3.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb3.xy));
    u_xlat12.xy = u_xlat12.xy * u_xlat3.xy;
    u_xlat12.x = u_xlat12.y * u_xlat12.x;
    u_xlat16_14 = u_xlat16_2.x * u_xlat12.x + -0.00100000005;
    u_xlat12.x = u_xlat12.x * u_xlat16_2.x;
    SV_Target0.w = u_xlat12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(u_xlat16_14<0.0);
#else
    u_xlatb12.x = u_xlat16_14<0.0;
#endif
    if((int(u_xlatb12.x) * int(0xffffffffu))!=0){discard;}
    u_xlat16_2.xzw = _BaseNoiseColor.xyz * vec3(_NoiseBrightness);
    u_xlat16_2.xzw = vec3(u_xlat16_6) * u_xlat16_2.xzw;
    u_xlat16_2.xyz = vec3(u_xlat16_8) * _BorderColor.xyz + u_xlat16_2.xzw;
    u_xlat16_5.xyz = _StarColor.xyz * vec3(_StarBrightness);
    u_xlat16_2.xyz = u_xlat16_5.xyz * vec3(u_xlat16_0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
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
uniform 	vec4 _Time;
uniform 	int _SmoothMaskType;
uniform 	vec4 _SmoothMaskSoftRanges;
uniform 	vec4 _SmoothMaskFillParams;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	vec4 _BorderMask_ST;
uniform 	vec4 _BorderNoise_ST;
uniform 	mediump float _BorderNoise_RotatorSpeed;
uniform 	mediump float _BorderNoisePower;
uniform 	mediump float _BorderBrightness;
uniform 	mediump vec4 _BorderColor;
uniform 	mediump vec4 _BaseNoiseColor;
uniform 	mediump float _NoiseBrightness;
uniform 	mediump float _BaseNoise01_Uspeed;
uniform 	vec4 _BaseNoise01_ST;
uniform 	mediump float _BaseNoise01_Vspeed;
uniform 	mediump float _BaseNoise02_Uspeed;
uniform 	vec4 _BaseNoise02_ST;
uniform 	mediump float _BaseNoise02_Vspeed;
uniform 	mediump vec4 _StarColor;
uniform 	mediump float _StarBrightness;
uniform 	mediump float _StarMap01_Uspeed;
uniform 	vec4 _StarMap01_ST;
uniform 	mediump float _StarMap01_Vspeed;
uniform 	mediump float _StarMap02_Uspeed;
uniform 	vec4 _StarMap02_ST;
uniform 	mediump float _StarMap02_Vspeed;
uniform 	mediump float _EdgeOpacity;
uniform 	mediump float _FlowOpacity;
uniform 	mediump float _StarOpacity;
uniform lowp sampler2D _BorderMask;
uniform lowp sampler2D _BorderNoise;
uniform lowp sampler2D _BaseNoise01;
uniform lowp sampler2D _BaseNoise02;
uniform lowp sampler2D _StarMap01;
uniform lowp sampler2D _StarMap02;
uniform lowp sampler2D _SmoothMaskTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec2 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
bvec2 u_xlatb7;
lowp float u_xlat10_8;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp float u_xlat10_11;
bool u_xlatb11;
vec2 u_xlat14;
mediump float u_xlat16_14;
bool u_xlatb14;
float u_xlat15;
mediump float u_xlat16_17;
float u_xlat18;
float u_xlat21;
bool u_xlatb21;
mediump float u_xlat16_24;
bool u_xlatb25;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BorderMask_ST.xy + _BorderMask_ST.zw;
    u_xlat10_0 = texture(_BorderMask, u_xlat0.xy);
    u_xlat1.xy = vs_TEXCOORD0.xy * _BorderNoise_ST.xy + _BorderNoise_ST.zw;
    u_xlat15 = _Time.y * _BorderNoise_RotatorSpeed;
    u_xlat16_2.x = sin(u_xlat15);
    u_xlat16_3.x = cos(u_xlat15);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat4.x = (-u_xlat16_2.x);
    u_xlat16_3.y = u_xlat16_2.x;
    u_xlat5.x = dot(u_xlat1.xy, u_xlat16_3.xy);
    u_xlat4.y = u_xlat16_3.x;
    u_xlat5.y = dot(u_xlat1.xy, u_xlat4.xy);
    u_xlat1.xy = u_xlat5.xy + vec2(0.5, 0.5);
    u_xlat10_1 = texture(_BorderNoise, u_xlat1.xy).x;
    u_xlat16_1 = max(u_xlat10_1, 9.99999975e-05);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _BorderNoisePower;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_0 = u_xlat10_0.x * u_xlat16_1;
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseNoise01_ST.xy + _BaseNoise01_ST.zw;
    u_xlat16_2.x = _Time.y * _BaseNoise01_Uspeed + u_xlat1.x;
    u_xlat16_2.y = _Time.y * _BaseNoise01_Vspeed + u_xlat1.y;
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseNoise02_ST.xy + _BaseNoise02_ST.zw;
    u_xlat16_3.x = _Time.y * _BaseNoise02_Uspeed + u_xlat1.x;
    u_xlat16_3.y = _Time.y * _BaseNoise02_Vspeed + u_xlat1.y;
    u_xlat16_17 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat10_1 = texture(_BaseNoise01, u_xlat16_2.xy).x;
    u_xlat10_8 = texture(_BaseNoise02, u_xlat16_3.xy).x;
    u_xlat16_1 = u_xlat10_8 * u_xlat10_1;
    u_xlat16_1 = u_xlat16_17 * u_xlat16_1;
    u_xlat16_7 = u_xlat10_0.y * u_xlat16_1;
    u_xlat1.xy = vs_TEXCOORD0.xy * _StarMap01_ST.xy + _StarMap01_ST.zw;
    u_xlat16_3.x = _Time.y * _StarMap01_Uspeed + u_xlat1.x;
    u_xlat16_3.y = _Time.y * _StarMap01_Vspeed + u_xlat1.y;
    u_xlat1.xy = vs_TEXCOORD0.xy * _StarMap02_ST.xy + _StarMap02_ST.zw;
    u_xlat16_6.x = _Time.y * _StarMap02_Uspeed + u_xlat1.x;
    u_xlat16_6.y = _Time.y * _StarMap02_Vspeed + u_xlat1.y;
    u_xlat10_4 = texture(_StarMap01, u_xlat16_3.xy).x;
    u_xlat10_11 = texture(_StarMap02, u_xlat16_6.xy).x;
    u_xlat16_4 = u_xlat10_11 + u_xlat10_4;
    u_xlat16_14 = u_xlat10_0.z * u_xlat16_4;
    u_xlat16_3.x = u_xlat16_0 * _BorderBrightness;
    u_xlat16_10.xyz = _BaseNoiseColor.xyz * vec3(_NoiseBrightness);
    u_xlat16_10.xyz = vec3(u_xlat16_7) * u_xlat16_10.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _BorderColor.xyz + u_xlat16_10.xyz;
    u_xlat16_6.xyz = _StarColor.xyz * vec3(_StarBrightness);
    u_xlat16_3.xyz = u_xlat16_6.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    u_xlat16_24 = u_xlat16_7 * _FlowOpacity;
    u_xlat16_24 = u_xlat16_0 * _EdgeOpacity + u_xlat16_24;
    u_xlat16_24 = _StarOpacity * u_xlat16_14 + u_xlat16_24;
    u_xlat16_3.w = u_xlat10_0.w * u_xlat16_24;
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(_ColorScaler);
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_3.w;
    if(_SmoothMaskType != 0) {
        u_xlatb7.xy = equal(ivec4(_SmoothMaskType), ivec4(1, 2, 0, 0)).xy;
        u_xlatb14 = u_xlatb7.y || u_xlatb7.x;
        if(u_xlatb14){
            u_xlat14.xy = vec2(-abs(vs_TEXCOORD1.z) + float(0.5), -abs(vs_TEXCOORD1.w) + float(0.5));
            u_xlat4.xy = vec2(1.0, 1.0) / _SmoothMaskSoftRanges.xy;
            u_xlat14.xy = u_xlat14.xy * u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
            u_xlat14.xy = min(max(u_xlat14.xy, 0.0), 1.0);
#else
            u_xlat14.xy = clamp(u_xlat14.xy, 0.0, 1.0);
#endif
            u_xlat4.xy = u_xlat14.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
            u_xlat14.xy = u_xlat14.xy * u_xlat14.xy;
            u_xlat14.xy = u_xlat14.xy * u_xlat4.xy;
            u_xlat16_3.x = u_xlat14.y * u_xlat14.x;
            if(u_xlatb7.x){
                u_xlat7.xy = vec2(vs_TEXCOORD1.z + float(0.5), vs_TEXCOORD1.w + float(0.5));
                u_xlat10_7 = texture(_SmoothMaskTexture, u_xlat7.xy).w;
                u_xlat16_3.x = u_xlat10_7 * u_xlat16_3.x;
                u_xlat16_3.x = u_xlat16_3.x;
            //ENDIF
            }
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb7.x = !!(_SmoothMaskType==3);
#else
            u_xlatb7.x = _SmoothMaskType==3;
#endif
            u_xlat14.x = dot(vs_TEXCOORD1.zw, vs_TEXCOORD1.zw);
            u_xlat14.x = sqrt(u_xlat14.x);
            u_xlat14.x = (-u_xlat14.x) + 0.5;
#ifdef UNITY_ADRENO_ES3
            u_xlatb21 = !!(0.00100000005<_SmoothMaskSoftRanges.w);
#else
            u_xlatb21 = 0.00100000005<_SmoothMaskSoftRanges.w;
#endif
            u_xlat4.xy = vec2(vs_TEXCOORD1.z * _SmoothMaskSoftRanges.z, vs_TEXCOORD1.w * _SmoothMaskSoftRanges.w);
            u_xlat4.x = dot(u_xlat4.xy, u_xlat4.xy);
            u_xlat4.x = sqrt(u_xlat4.x);
            u_xlat4.x = u_xlat4.x + u_xlat4.x;
            u_xlat16_10.x = (u_xlatb21) ? u_xlat4.x : _SmoothMaskSoftRanges.z;
            u_xlat16_10.x = float(1.0) / u_xlat16_10.x;
            u_xlat16_10.x = u_xlat14.x * u_xlat16_10.x;
#ifdef UNITY_ADRENO_ES3
            u_xlat16_10.x = min(max(u_xlat16_10.x, 0.0), 1.0);
#else
            u_xlat16_10.x = clamp(u_xlat16_10.x, 0.0, 1.0);
#endif
            u_xlat16_17 = u_xlat16_10.x * -2.0 + 3.0;
            u_xlat16_10.x = u_xlat16_10.x * u_xlat16_10.x;
            u_xlat16_10.x = u_xlat16_10.x * u_xlat16_17;
            u_xlat16_3.x = (u_xlatb7.x) ? u_xlat16_10.x : 1.0;
        //ENDIF
        }
#ifdef UNITY_ADRENO_ES3
        u_xlatb7.x = !!(_SmoothMaskFillParams.x!=0.0);
#else
        u_xlatb7.x = _SmoothMaskFillParams.x!=0.0;
#endif
        if(u_xlatb7.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb7.x = !!(_SmoothMaskFillParams.x==1.0);
#else
            u_xlatb7.x = _SmoothMaskFillParams.x==1.0;
#endif
            if(u_xlatb7.x){
                u_xlat7.x = vs_TEXCOORD1.z + 0.5;
#ifdef UNITY_ADRENO_ES3
                u_xlatb14 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                u_xlatb14 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                u_xlat21 = (-u_xlat7.x) + 1.0;
                u_xlat7.x = (u_xlatb14) ? u_xlat21 : u_xlat7.x;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb14 = !!(_SmoothMaskFillParams.x==2.0);
#else
                u_xlatb14 = _SmoothMaskFillParams.x==2.0;
#endif
                if(u_xlatb14){
                    u_xlat14.x = vs_TEXCOORD1.w + 0.5;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                    u_xlat4.x = (-u_xlat14.x) + 1.0;
                    u_xlat7.x = (u_xlatb21) ? u_xlat4.x : u_xlat14.x;
                } else {
                    u_xlatb1 = equal(_SmoothMaskFillParams.zzzx, vec4(1.0, 2.0, 3.0, 3.0));
                    u_xlat2 = vec4(vs_TEXCOORD1.w * float(1.0), vs_TEXCOORD1.z * float(-1.0), vs_TEXCOORD1.w * float(-1.0), vs_TEXCOORD1.z * float(1.0));
                    u_xlat14.xy = (u_xlatb1.z) ? u_xlat2.xy : vs_TEXCOORD1.zw;
                    u_xlat14.xy = (u_xlatb1.y) ? (-vs_TEXCOORD1.zw) : u_xlat14.xy;
                    u_xlat4.xy = (u_xlatb1.x) ? u_xlat2.zw : u_xlat14.xy;
                    u_xlat14.xy = u_xlat4.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb25 = !!(_SmoothMaskFillParams.x==4.0);
#else
                    u_xlatb25 = _SmoothMaskFillParams.x==4.0;
#endif
                    u_xlat4.z = (u_xlatb25) ? u_xlat14.y : u_xlat4.y;
                    u_xlat14.xy = (u_xlatb1.w) ? u_xlat14.xy : u_xlat4.xz;
                    u_xlat14.x = u_xlat14.x * _SmoothMaskFillParams.w;
                    u_xlat4.x = min(abs(u_xlat14.y), abs(u_xlat14.x));
                    u_xlat11 = max(abs(u_xlat14.y), abs(u_xlat14.x));
                    u_xlat11 = float(1.0) / u_xlat11;
                    u_xlat4.x = u_xlat11 * u_xlat4.x;
                    u_xlat11 = u_xlat4.x * u_xlat4.x;
                    u_xlat18 = u_xlat11 * 0.0208350997 + -0.0851330012;
                    u_xlat18 = u_xlat11 * u_xlat18 + 0.180141002;
                    u_xlat18 = u_xlat11 * u_xlat18 + -0.330299497;
                    u_xlat11 = u_xlat11 * u_xlat18 + 0.999866009;
                    u_xlat18 = u_xlat11 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb25 = !!(abs(u_xlat14.y)<abs(u_xlat14.x));
#else
                    u_xlatb25 = abs(u_xlat14.y)<abs(u_xlat14.x);
#endif
                    u_xlat18 = u_xlat18 * -2.0 + 1.57079637;
                    u_xlat18 = u_xlatb25 ? u_xlat18 : float(0.0);
                    u_xlat4.x = u_xlat4.x * u_xlat11 + u_xlat18;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb11 = !!(u_xlat14.y<(-u_xlat14.y));
#else
                    u_xlatb11 = u_xlat14.y<(-u_xlat14.y);
#endif
                    u_xlat11 = u_xlatb11 ? -3.14159274 : float(0.0);
                    u_xlat4.x = u_xlat11 + u_xlat4.x;
                    u_xlat11 = min(u_xlat14.y, u_xlat14.x);
                    u_xlat14.x = max(u_xlat14.y, u_xlat14.x);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb21 = !!(u_xlat11<(-u_xlat11));
#else
                    u_xlatb21 = u_xlat11<(-u_xlat11);
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb14 = !!(u_xlat14.x>=(-u_xlat14.x));
#else
                    u_xlatb14 = u_xlat14.x>=(-u_xlat14.x);
#endif
                    u_xlatb14 = u_xlatb14 && u_xlatb21;
                    u_xlat14.x = (u_xlatb14) ? (-u_xlat4.x) : u_xlat4.x;
                    u_xlat7.x = u_xlat14.x * 0.159154996 + 0.5;
                //ENDIF
                }
            //ENDIF
            }
#ifdef UNITY_ADRENO_ES3
            u_xlatb7.x = !!(_SmoothMaskFillParams.y>=u_xlat7.x);
#else
            u_xlatb7.x = _SmoothMaskFillParams.y>=u_xlat7.x;
#endif
            u_xlat7.x = u_xlatb7.x ? 1.0 : float(0.0);
            u_xlat3 = u_xlat7.x * u_xlat16_3.x;
            u_xlat16_3.x = u_xlat3;
        //ENDIF
        }
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    SV_Target0.w = u_xlat0.x * u_xlat16_3.x;
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
uniform 	vec4 _Time;
uniform 	int _SmoothMaskType;
uniform 	vec4 _SmoothMaskSoftRanges;
uniform 	vec4 _SmoothMaskFillParams;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	vec4 _BorderMask_ST;
uniform 	vec4 _BorderNoise_ST;
uniform 	mediump float _BorderNoise_RotatorSpeed;
uniform 	mediump float _BorderNoisePower;
uniform 	mediump float _BorderBrightness;
uniform 	mediump vec4 _BorderColor;
uniform 	mediump vec4 _BaseNoiseColor;
uniform 	mediump float _NoiseBrightness;
uniform 	mediump float _BaseNoise01_Uspeed;
uniform 	vec4 _BaseNoise01_ST;
uniform 	mediump float _BaseNoise01_Vspeed;
uniform 	mediump float _BaseNoise02_Uspeed;
uniform 	vec4 _BaseNoise02_ST;
uniform 	mediump float _BaseNoise02_Vspeed;
uniform 	mediump vec4 _StarColor;
uniform 	mediump float _StarBrightness;
uniform 	mediump float _StarMap01_Uspeed;
uniform 	vec4 _StarMap01_ST;
uniform 	mediump float _StarMap01_Vspeed;
uniform 	mediump float _StarMap02_Uspeed;
uniform 	vec4 _StarMap02_ST;
uniform 	mediump float _StarMap02_Vspeed;
uniform 	mediump float _EdgeOpacity;
uniform 	mediump float _FlowOpacity;
uniform 	mediump float _StarOpacity;
uniform lowp sampler2D _BorderMask;
uniform lowp sampler2D _BorderNoise;
uniform lowp sampler2D _BaseNoise01;
uniform lowp sampler2D _BaseNoise02;
uniform lowp sampler2D _StarMap01;
uniform lowp sampler2D _StarMap02;
uniform lowp sampler2D _SmoothMaskTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec2 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
float u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
bvec2 u_xlatb7;
lowp float u_xlat10_8;
mediump vec3 u_xlat16_10;
float u_xlat11;
lowp float u_xlat10_11;
bool u_xlatb11;
vec2 u_xlat14;
mediump float u_xlat16_14;
bool u_xlatb14;
float u_xlat15;
mediump float u_xlat16_17;
float u_xlat18;
float u_xlat21;
bool u_xlatb21;
mediump float u_xlat16_24;
bool u_xlatb25;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BorderMask_ST.xy + _BorderMask_ST.zw;
    u_xlat10_0 = texture(_BorderMask, u_xlat0.xy);
    u_xlat1.xy = vs_TEXCOORD0.xy * _BorderNoise_ST.xy + _BorderNoise_ST.zw;
    u_xlat15 = _Time.y * _BorderNoise_RotatorSpeed;
    u_xlat16_2.x = sin(u_xlat15);
    u_xlat16_3.x = cos(u_xlat15);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat4.x = (-u_xlat16_2.x);
    u_xlat16_3.y = u_xlat16_2.x;
    u_xlat5.x = dot(u_xlat1.xy, u_xlat16_3.xy);
    u_xlat4.y = u_xlat16_3.x;
    u_xlat5.y = dot(u_xlat1.xy, u_xlat4.xy);
    u_xlat1.xy = u_xlat5.xy + vec2(0.5, 0.5);
    u_xlat10_1 = texture(_BorderNoise, u_xlat1.xy).x;
    u_xlat16_1 = max(u_xlat10_1, 9.99999975e-05);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _BorderNoisePower;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_0 = u_xlat10_0.x * u_xlat16_1;
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseNoise01_ST.xy + _BaseNoise01_ST.zw;
    u_xlat16_2.x = _Time.y * _BaseNoise01_Uspeed + u_xlat1.x;
    u_xlat16_2.y = _Time.y * _BaseNoise01_Vspeed + u_xlat1.y;
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseNoise02_ST.xy + _BaseNoise02_ST.zw;
    u_xlat16_3.x = _Time.y * _BaseNoise02_Uspeed + u_xlat1.x;
    u_xlat16_3.y = _Time.y * _BaseNoise02_Vspeed + u_xlat1.y;
    u_xlat16_17 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat10_1 = texture(_BaseNoise01, u_xlat16_2.xy).x;
    u_xlat10_8 = texture(_BaseNoise02, u_xlat16_3.xy).x;
    u_xlat16_1 = u_xlat10_8 * u_xlat10_1;
    u_xlat16_1 = u_xlat16_17 * u_xlat16_1;
    u_xlat16_7 = u_xlat10_0.y * u_xlat16_1;
    u_xlat1.xy = vs_TEXCOORD0.xy * _StarMap01_ST.xy + _StarMap01_ST.zw;
    u_xlat16_3.x = _Time.y * _StarMap01_Uspeed + u_xlat1.x;
    u_xlat16_3.y = _Time.y * _StarMap01_Vspeed + u_xlat1.y;
    u_xlat1.xy = vs_TEXCOORD0.xy * _StarMap02_ST.xy + _StarMap02_ST.zw;
    u_xlat16_6.x = _Time.y * _StarMap02_Uspeed + u_xlat1.x;
    u_xlat16_6.y = _Time.y * _StarMap02_Vspeed + u_xlat1.y;
    u_xlat10_4 = texture(_StarMap01, u_xlat16_3.xy).x;
    u_xlat10_11 = texture(_StarMap02, u_xlat16_6.xy).x;
    u_xlat16_4 = u_xlat10_11 + u_xlat10_4;
    u_xlat16_14 = u_xlat10_0.z * u_xlat16_4;
    u_xlat16_3.x = u_xlat16_0 * _BorderBrightness;
    u_xlat16_10.xyz = _BaseNoiseColor.xyz * vec3(_NoiseBrightness);
    u_xlat16_10.xyz = vec3(u_xlat16_7) * u_xlat16_10.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _BorderColor.xyz + u_xlat16_10.xyz;
    u_xlat16_6.xyz = _StarColor.xyz * vec3(_StarBrightness);
    u_xlat16_3.xyz = u_xlat16_6.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    u_xlat16_24 = u_xlat16_7 * _FlowOpacity;
    u_xlat16_24 = u_xlat16_0 * _EdgeOpacity + u_xlat16_24;
    u_xlat16_24 = _StarOpacity * u_xlat16_14 + u_xlat16_24;
    u_xlat16_3.w = u_xlat10_0.w * u_xlat16_24;
    u_xlat16_3 = u_xlat16_3 * vs_COLOR0;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(_ColorScaler);
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_3.w;
    if(_SmoothMaskType != 0) {
        u_xlatb7.xy = equal(ivec4(_SmoothMaskType), ivec4(1, 2, 0, 0)).xy;
        u_xlatb14 = u_xlatb7.y || u_xlatb7.x;
        if(u_xlatb14){
            u_xlat14.xy = vec2(-abs(vs_TEXCOORD1.z) + float(0.5), -abs(vs_TEXCOORD1.w) + float(0.5));
            u_xlat4.xy = vec2(1.0, 1.0) / _SmoothMaskSoftRanges.xy;
            u_xlat14.xy = u_xlat14.xy * u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
            u_xlat14.xy = min(max(u_xlat14.xy, 0.0), 1.0);
#else
            u_xlat14.xy = clamp(u_xlat14.xy, 0.0, 1.0);
#endif
            u_xlat4.xy = u_xlat14.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
            u_xlat14.xy = u_xlat14.xy * u_xlat14.xy;
            u_xlat14.xy = u_xlat14.xy * u_xlat4.xy;
            u_xlat16_3.x = u_xlat14.y * u_xlat14.x;
            if(u_xlatb7.x){
                u_xlat7.xy = vec2(vs_TEXCOORD1.z + float(0.5), vs_TEXCOORD1.w + float(0.5));
                u_xlat10_7 = texture(_SmoothMaskTexture, u_xlat7.xy).w;
                u_xlat16_3.x = u_xlat10_7 * u_xlat16_3.x;
                u_xlat16_3.x = u_xlat16_3.x;
            //ENDIF
            }
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb7.x = !!(_SmoothMaskType==3);
#else
            u_xlatb7.x = _SmoothMaskType==3;
#endif
            u_xlat14.x = dot(vs_TEXCOORD1.zw, vs_TEXCOORD1.zw);
            u_xlat14.x = sqrt(u_xlat14.x);
            u_xlat14.x = (-u_xlat14.x) + 0.5;
#ifdef UNITY_ADRENO_ES3
            u_xlatb21 = !!(0.00100000005<_SmoothMaskSoftRanges.w);
#else
            u_xlatb21 = 0.00100000005<_SmoothMaskSoftRanges.w;
#endif
            u_xlat4.xy = vec2(vs_TEXCOORD1.z * _SmoothMaskSoftRanges.z, vs_TEXCOORD1.w * _SmoothMaskSoftRanges.w);
            u_xlat4.x = dot(u_xlat4.xy, u_xlat4.xy);
            u_xlat4.x = sqrt(u_xlat4.x);
            u_xlat4.x = u_xlat4.x + u_xlat4.x;
            u_xlat16_10.x = (u_xlatb21) ? u_xlat4.x : _SmoothMaskSoftRanges.z;
            u_xlat16_10.x = float(1.0) / u_xlat16_10.x;
            u_xlat16_10.x = u_xlat14.x * u_xlat16_10.x;
#ifdef UNITY_ADRENO_ES3
            u_xlat16_10.x = min(max(u_xlat16_10.x, 0.0), 1.0);
#else
            u_xlat16_10.x = clamp(u_xlat16_10.x, 0.0, 1.0);
#endif
            u_xlat16_17 = u_xlat16_10.x * -2.0 + 3.0;
            u_xlat16_10.x = u_xlat16_10.x * u_xlat16_10.x;
            u_xlat16_10.x = u_xlat16_10.x * u_xlat16_17;
            u_xlat16_3.x = (u_xlatb7.x) ? u_xlat16_10.x : 1.0;
        //ENDIF
        }
#ifdef UNITY_ADRENO_ES3
        u_xlatb7.x = !!(_SmoothMaskFillParams.x!=0.0);
#else
        u_xlatb7.x = _SmoothMaskFillParams.x!=0.0;
#endif
        if(u_xlatb7.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb7.x = !!(_SmoothMaskFillParams.x==1.0);
#else
            u_xlatb7.x = _SmoothMaskFillParams.x==1.0;
#endif
            if(u_xlatb7.x){
                u_xlat7.x = vs_TEXCOORD1.z + 0.5;
#ifdef UNITY_ADRENO_ES3
                u_xlatb14 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                u_xlatb14 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                u_xlat21 = (-u_xlat7.x) + 1.0;
                u_xlat7.x = (u_xlatb14) ? u_xlat21 : u_xlat7.x;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb14 = !!(_SmoothMaskFillParams.x==2.0);
#else
                u_xlatb14 = _SmoothMaskFillParams.x==2.0;
#endif
                if(u_xlatb14){
                    u_xlat14.x = vs_TEXCOORD1.w + 0.5;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                    u_xlat4.x = (-u_xlat14.x) + 1.0;
                    u_xlat7.x = (u_xlatb21) ? u_xlat4.x : u_xlat14.x;
                } else {
                    u_xlatb1 = equal(_SmoothMaskFillParams.zzzx, vec4(1.0, 2.0, 3.0, 3.0));
                    u_xlat2 = vec4(vs_TEXCOORD1.w * float(1.0), vs_TEXCOORD1.z * float(-1.0), vs_TEXCOORD1.w * float(-1.0), vs_TEXCOORD1.z * float(1.0));
                    u_xlat14.xy = (u_xlatb1.z) ? u_xlat2.xy : vs_TEXCOORD1.zw;
                    u_xlat14.xy = (u_xlatb1.y) ? (-vs_TEXCOORD1.zw) : u_xlat14.xy;
                    u_xlat4.xy = (u_xlatb1.x) ? u_xlat2.zw : u_xlat14.xy;
                    u_xlat14.xy = u_xlat4.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb25 = !!(_SmoothMaskFillParams.x==4.0);
#else
                    u_xlatb25 = _SmoothMaskFillParams.x==4.0;
#endif
                    u_xlat4.z = (u_xlatb25) ? u_xlat14.y : u_xlat4.y;
                    u_xlat14.xy = (u_xlatb1.w) ? u_xlat14.xy : u_xlat4.xz;
                    u_xlat14.x = u_xlat14.x * _SmoothMaskFillParams.w;
                    u_xlat4.x = min(abs(u_xlat14.y), abs(u_xlat14.x));
                    u_xlat11 = max(abs(u_xlat14.y), abs(u_xlat14.x));
                    u_xlat11 = float(1.0) / u_xlat11;
                    u_xlat4.x = u_xlat11 * u_xlat4.x;
                    u_xlat11 = u_xlat4.x * u_xlat4.x;
                    u_xlat18 = u_xlat11 * 0.0208350997 + -0.0851330012;
                    u_xlat18 = u_xlat11 * u_xlat18 + 0.180141002;
                    u_xlat18 = u_xlat11 * u_xlat18 + -0.330299497;
                    u_xlat11 = u_xlat11 * u_xlat18 + 0.999866009;
                    u_xlat18 = u_xlat11 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb25 = !!(abs(u_xlat14.y)<abs(u_xlat14.x));
#else
                    u_xlatb25 = abs(u_xlat14.y)<abs(u_xlat14.x);
#endif
                    u_xlat18 = u_xlat18 * -2.0 + 1.57079637;
                    u_xlat18 = u_xlatb25 ? u_xlat18 : float(0.0);
                    u_xlat4.x = u_xlat4.x * u_xlat11 + u_xlat18;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb11 = !!(u_xlat14.y<(-u_xlat14.y));
#else
                    u_xlatb11 = u_xlat14.y<(-u_xlat14.y);
#endif
                    u_xlat11 = u_xlatb11 ? -3.14159274 : float(0.0);
                    u_xlat4.x = u_xlat11 + u_xlat4.x;
                    u_xlat11 = min(u_xlat14.y, u_xlat14.x);
                    u_xlat14.x = max(u_xlat14.y, u_xlat14.x);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb21 = !!(u_xlat11<(-u_xlat11));
#else
                    u_xlatb21 = u_xlat11<(-u_xlat11);
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb14 = !!(u_xlat14.x>=(-u_xlat14.x));
#else
                    u_xlatb14 = u_xlat14.x>=(-u_xlat14.x);
#endif
                    u_xlatb14 = u_xlatb14 && u_xlatb21;
                    u_xlat14.x = (u_xlatb14) ? (-u_xlat4.x) : u_xlat4.x;
                    u_xlat7.x = u_xlat14.x * 0.159154996 + 0.5;
                //ENDIF
                }
            //ENDIF
            }
#ifdef UNITY_ADRENO_ES3
            u_xlatb7.x = !!(_SmoothMaskFillParams.y>=u_xlat7.x);
#else
            u_xlatb7.x = _SmoothMaskFillParams.y>=u_xlat7.x;
#endif
            u_xlat7.x = u_xlatb7.x ? 1.0 : float(0.0);
            u_xlat3 = u_xlat7.x * u_xlat16_3.x;
            u_xlat16_3.x = u_xlat3;
        //ENDIF
        }
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_10.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3.x<0.0);
#else
    u_xlatb0.x = u_xlat16_3.x<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = u_xlat16_10.x;
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