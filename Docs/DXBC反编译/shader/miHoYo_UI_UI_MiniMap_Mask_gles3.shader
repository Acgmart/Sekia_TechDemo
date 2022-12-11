//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/UI/UI_MiniMap_Mask" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_ColorScaler ("Color Scaler", Float) = 1
[Header(ASE Properties)] _Dissolve ("Dissolve", Range(0, 1)) = 0
_DissolveMap ("DissolveMap", 2D) = "white" { }
_Noise_Speed_V ("Noise_Speed_V", Range(0, 1)) = 0
_Noise_Speed_U ("Noise_Speed_U", Range(0, 1)) = 0
_Noise ("Noise", 2D) = "white" { }
_Intensity ("Intensity", Float) = 0.05
_Tiling ("Tiling", Float) = 1
_Offset ("Offset", Float) = -0.01
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
  GpuProgramID 11816
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
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
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
uniform 	mediump float _Noise_Speed_U;
uniform 	mediump float _Tiling;
uniform 	mediump float _Noise_Speed_V;
uniform 	mediump float _Intensity;
uniform 	mediump float _Offset;
uniform 	mediump float _Dissolve;
uniform 	vec4 _DissolveMap_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _DissolveMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
lowp float u_xlat10_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * vec2(vec2(_Tiling, _Tiling));
    u_xlat16_1.xy = _Time.yy * vec2(_Noise_Speed_U, _Noise_Speed_V) + u_xlat0.xy;
    u_xlat10_0.x = texture(_Noise, u_xlat16_1.xy).x;
    u_xlat16_0.x = u_xlat10_0.x * _Intensity + _Offset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveMap_ST.xy + _DissolveMap_ST.zw;
    u_xlat16_1.xy = u_xlat3.xy + u_xlat16_0.xx;
    u_xlat16_7.xy = u_xlat16_0.xx + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat16_7.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    u_xlat10_2 = texture(_DissolveMap, u_xlat16_1.xy).x;
    u_xlat16_2 = u_xlat10_2 + (-_Dissolve);
    u_xlat16_2 = u_xlat16_2 * 33.3333359;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat16_2 * -2.0 + 3.0;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_5;
    u_xlat16_1.x = min(u_xlat16_2, 1.0);
    u_xlat16_1.x = u_xlat16_0.w * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_ColorScaler);
    u_xlatb2.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb2.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat2.xy = vec2(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat2.x = u_xlat16_1.x * u_xlat2.x;
    SV_Target0.w = u_xlat2.x;
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
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
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
uniform 	mediump float _Noise_Speed_U;
uniform 	mediump float _Tiling;
uniform 	mediump float _Noise_Speed_V;
uniform 	mediump float _Intensity;
uniform 	mediump float _Offset;
uniform 	mediump float _Dissolve;
uniform 	vec4 _DissolveMap_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _DissolveMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
lowp float u_xlat10_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * vec2(vec2(_Tiling, _Tiling));
    u_xlat16_1.xy = _Time.yy * vec2(_Noise_Speed_U, _Noise_Speed_V) + u_xlat0.xy;
    u_xlat10_0.x = texture(_Noise, u_xlat16_1.xy).x;
    u_xlat16_0.x = u_xlat10_0.x * _Intensity + _Offset;
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveMap_ST.xy + _DissolveMap_ST.zw;
    u_xlat16_1.xy = u_xlat3.xy + u_xlat16_0.xx;
    u_xlat16_7.xy = u_xlat16_0.xx + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat16_7.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    u_xlat10_2 = texture(_DissolveMap, u_xlat16_1.xy).x;
    u_xlat16_2 = u_xlat10_2 + (-_Dissolve);
    u_xlat16_2 = u_xlat16_2 * 33.3333359;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat16_2 * -2.0 + 3.0;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_5;
    u_xlat16_1.x = min(u_xlat16_2, 1.0);
    u_xlat16_1.x = u_xlat16_0.w * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_ColorScaler);
    u_xlatb2.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb2.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat2.xy = vec2(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat16_4 = u_xlat16_1.x * u_xlat2.x + -0.00100000005;
    u_xlat2.x = u_xlat16_1.x * u_xlat2.x;
    SV_Target0.w = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(u_xlat16_4<0.0);
#else
    u_xlatb2.x = u_xlat16_4<0.0;
#endif
    if((int(u_xlatb2.x) * int(0xffffffffu))!=0){discard;}
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
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
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
uniform 	mediump float _Noise_Speed_U;
uniform 	mediump float _Tiling;
uniform 	mediump float _Noise_Speed_V;
uniform 	mediump float _Intensity;
uniform 	mediump float _Offset;
uniform 	mediump float _Dissolve;
uniform 	vec4 _DissolveMap_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _DissolveMap;
uniform lowp sampler2D _SmoothMaskTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_3;
vec2 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat6;
mediump float u_xlat16_6;
bvec2 u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat11;
mediump float u_xlat16_15;
vec2 u_xlat16;
bool u_xlatb16;
bool u_xlatb17;
float u_xlat22;
bool u_xlatb22;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * vec2(vec2(_Tiling, _Tiling));
    u_xlat16_1.xy = _Time.yy * vec2(_Noise_Speed_U, _Noise_Speed_V) + u_xlat0.xy;
    u_xlat10_0 = texture(_Noise, u_xlat16_1.xy).x;
    u_xlat16_0 = u_xlat10_0 * _Intensity + _Offset;
    u_xlat16_1.xy = vec2(u_xlat16_0) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat16_1.xy);
    u_xlat6.xy = vs_TEXCOORD0.xy * _DissolveMap_ST.xy + _DissolveMap_ST.zw;
    u_xlat16_2.xy = u_xlat6.xy + vec2(u_xlat16_0);
    u_xlat10_0 = texture(_DissolveMap, u_xlat16_2.xy).x;
    u_xlat16_0 = u_xlat10_0 + (-_Dissolve);
    u_xlat16_0 = u_xlat16_0 * 33.3333359;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_0 * -2.0 + 3.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
    u_xlat16_3 = min(u_xlat16_0, 1.0);
    u_xlat16_3 = u_xlat16_1.w * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(_ColorScaler);
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_3;
    if(_SmoothMaskType != 0) {
        u_xlatb6.xy = equal(ivec4(_SmoothMaskType), ivec4(1, 2, 0, 0)).xy;
        u_xlatb4 = u_xlatb6.y || u_xlatb6.x;
        if(u_xlatb4){
            u_xlat4.xy = vec2(-abs(vs_TEXCOORD1.z) + float(0.5), -abs(vs_TEXCOORD1.w) + float(0.5));
            u_xlat16.xy = vec2(1.0, 1.0) / _SmoothMaskSoftRanges.xy;
            u_xlat4.xy = u_xlat16.xy * u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
            u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
            u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
            u_xlat16.xy = u_xlat4.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
            u_xlat4.xy = u_xlat4.xy * u_xlat4.xy;
            u_xlat4.xy = u_xlat4.xy * u_xlat16.xy;
            u_xlat16_3 = u_xlat4.y * u_xlat4.x;
            if(u_xlatb6.x){
                u_xlat4.xy = vec2(vs_TEXCOORD1.z + float(0.5), vs_TEXCOORD1.w + float(0.5));
                u_xlat10_4 = texture(_SmoothMaskTexture, u_xlat4.xy).w;
                u_xlat16_3 = u_xlat16_3 * u_xlat10_4;
                u_xlat16_3 = u_xlat16_3;
            //ENDIF
            }
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb4 = !!(_SmoothMaskType==3);
#else
            u_xlatb4 = _SmoothMaskType==3;
#endif
            u_xlat10.x = dot(vs_TEXCOORD1.zw, vs_TEXCOORD1.zw);
            u_xlat10.x = sqrt(u_xlat10.x);
            u_xlat10.x = (-u_xlat10.x) + 0.5;
#ifdef UNITY_ADRENO_ES3
            u_xlatb16 = !!(0.00100000005<_SmoothMaskSoftRanges.w);
#else
            u_xlatb16 = 0.00100000005<_SmoothMaskSoftRanges.w;
#endif
            u_xlat5.xy = vec2(vs_TEXCOORD1.z * _SmoothMaskSoftRanges.z, vs_TEXCOORD1.w * _SmoothMaskSoftRanges.w);
            u_xlat22 = dot(u_xlat5.xy, u_xlat5.xy);
            u_xlat22 = sqrt(u_xlat22);
            u_xlat22 = u_xlat22 + u_xlat22;
            u_xlat16_9 = (u_xlatb16) ? u_xlat22 : _SmoothMaskSoftRanges.z;
            u_xlat16_9 = float(1.0) / u_xlat16_9;
            u_xlat16_9 = u_xlat16_9 * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
            u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
            u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
            u_xlat16_15 = u_xlat16_9 * -2.0 + 3.0;
            u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
            u_xlat16_9 = u_xlat16_9 * u_xlat16_15;
            u_xlat16_3 = (u_xlatb4) ? u_xlat16_9 : 1.0;
        //ENDIF
        }
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(_SmoothMaskFillParams.x!=0.0);
#else
        u_xlatb4 = _SmoothMaskFillParams.x!=0.0;
#endif
        if(u_xlatb4){
#ifdef UNITY_ADRENO_ES3
            u_xlatb4 = !!(_SmoothMaskFillParams.x==1.0);
#else
            u_xlatb4 = _SmoothMaskFillParams.x==1.0;
#endif
            if(u_xlatb4){
                u_xlat4.x = vs_TEXCOORD1.z + 0.5;
#ifdef UNITY_ADRENO_ES3
                u_xlatb10 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                u_xlatb10 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                u_xlat16.x = (-u_xlat4.x) + 1.0;
                u_xlat4.x = (u_xlatb10) ? u_xlat16.x : u_xlat4.x;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb10 = !!(_SmoothMaskFillParams.x==2.0);
#else
                u_xlatb10 = _SmoothMaskFillParams.x==2.0;
#endif
                if(u_xlatb10){
                    u_xlat10.x = vs_TEXCOORD1.w + 0.5;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                    u_xlat22 = (-u_xlat10.x) + 1.0;
                    u_xlat4.x = (u_xlatb16) ? u_xlat22 : u_xlat10.x;
                } else {
                    u_xlatb1 = equal(_SmoothMaskFillParams.zzzx, vec4(1.0, 2.0, 3.0, 3.0));
                    u_xlat2 = vec4(vs_TEXCOORD1.w * float(1.0), vs_TEXCOORD1.z * float(-1.0), vs_TEXCOORD1.w * float(-1.0), vs_TEXCOORD1.z * float(1.0));
                    u_xlat10.xy = (u_xlatb1.z) ? u_xlat2.xy : vs_TEXCOORD1.zw;
                    u_xlat10.xy = (u_xlatb1.y) ? (-vs_TEXCOORD1.zw) : u_xlat10.xy;
                    u_xlat5.xy = (u_xlatb1.x) ? u_xlat2.zw : u_xlat10.xy;
                    u_xlat10.xy = u_xlat5.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb22 = !!(_SmoothMaskFillParams.x==4.0);
#else
                    u_xlatb22 = _SmoothMaskFillParams.x==4.0;
#endif
                    u_xlat5.z = (u_xlatb22) ? u_xlat10.y : u_xlat5.y;
                    u_xlat10.xy = (u_xlatb1.w) ? u_xlat10.xy : u_xlat5.xz;
                    u_xlat10.x = u_xlat10.x * _SmoothMaskFillParams.w;
                    u_xlat22 = min(abs(u_xlat10.y), abs(u_xlat10.x));
                    u_xlat5.x = max(abs(u_xlat10.y), abs(u_xlat10.x));
                    u_xlat5.x = float(1.0) / u_xlat5.x;
                    u_xlat22 = u_xlat22 * u_xlat5.x;
                    u_xlat5.x = u_xlat22 * u_xlat22;
                    u_xlat11 = u_xlat5.x * 0.0208350997 + -0.0851330012;
                    u_xlat11 = u_xlat5.x * u_xlat11 + 0.180141002;
                    u_xlat11 = u_xlat5.x * u_xlat11 + -0.330299497;
                    u_xlat5.x = u_xlat5.x * u_xlat11 + 0.999866009;
                    u_xlat11 = u_xlat22 * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb17 = !!(abs(u_xlat10.y)<abs(u_xlat10.x));
#else
                    u_xlatb17 = abs(u_xlat10.y)<abs(u_xlat10.x);
#endif
                    u_xlat11 = u_xlat11 * -2.0 + 1.57079637;
                    u_xlat11 = u_xlatb17 ? u_xlat11 : float(0.0);
                    u_xlat22 = u_xlat22 * u_xlat5.x + u_xlat11;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb5 = !!(u_xlat10.y<(-u_xlat10.y));
#else
                    u_xlatb5 = u_xlat10.y<(-u_xlat10.y);
#endif
                    u_xlat5.x = u_xlatb5 ? -3.14159274 : float(0.0);
                    u_xlat22 = u_xlat22 + u_xlat5.x;
                    u_xlat5.x = min(u_xlat10.y, u_xlat10.x);
                    u_xlat10.x = max(u_xlat10.y, u_xlat10.x);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb16 = !!(u_xlat5.x<(-u_xlat5.x));
#else
                    u_xlatb16 = u_xlat5.x<(-u_xlat5.x);
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb10 = !!(u_xlat10.x>=(-u_xlat10.x));
#else
                    u_xlatb10 = u_xlat10.x>=(-u_xlat10.x);
#endif
                    u_xlatb10 = u_xlatb10 && u_xlatb16;
                    u_xlat10.x = (u_xlatb10) ? (-u_xlat22) : u_xlat22;
                    u_xlat4.x = u_xlat10.x * 0.159154996 + 0.5;
                //ENDIF
                }
            //ENDIF
            }
#ifdef UNITY_ADRENO_ES3
            u_xlatb4 = !!(_SmoothMaskFillParams.y>=u_xlat4.x);
#else
            u_xlatb4 = _SmoothMaskFillParams.y>=u_xlat4.x;
#endif
            u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
            u_xlat3 = u_xlat16_3 * u_xlat4.x;
            u_xlat16_3 = u_xlat3;
        //ENDIF
        }
    } else {
        u_xlat16_3 = 1.0;
    //ENDIF
    }
    SV_Target0.w = u_xlat0.x * u_xlat16_3;
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
out highp vec4 vs_TEXCOORD2;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
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
uniform 	mediump float _Noise_Speed_U;
uniform 	mediump float _Tiling;
uniform 	mediump float _Noise_Speed_V;
uniform 	mediump float _Intensity;
uniform 	mediump float _Offset;
uniform 	mediump float _Dissolve;
uniform 	vec4 _DissolveMap_ST;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _DissolveMap;
uniform lowp sampler2D _SmoothMaskTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_3;
vec2 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat6;
mediump float u_xlat16_6;
bvec2 u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat11;
mediump float u_xlat16_15;
vec2 u_xlat16;
bool u_xlatb16;
bool u_xlatb17;
float u_xlat22;
bool u_xlatb22;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * vec2(vec2(_Tiling, _Tiling));
    u_xlat16_1.xy = _Time.yy * vec2(_Noise_Speed_U, _Noise_Speed_V) + u_xlat0.xy;
    u_xlat10_0 = texture(_Noise, u_xlat16_1.xy).x;
    u_xlat16_0 = u_xlat10_0 * _Intensity + _Offset;
    u_xlat16_1.xy = vec2(u_xlat16_0) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat16_1.xy);
    u_xlat6.xy = vs_TEXCOORD0.xy * _DissolveMap_ST.xy + _DissolveMap_ST.zw;
    u_xlat16_2.xy = u_xlat6.xy + vec2(u_xlat16_0);
    u_xlat10_0 = texture(_DissolveMap, u_xlat16_2.xy).x;
    u_xlat16_0 = u_xlat10_0 + (-_Dissolve);
    u_xlat16_0 = u_xlat16_0 * 33.3333359;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_0 * -2.0 + 3.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_6;
    u_xlat16_1 = u_xlat10_1 * vs_COLOR0;
    u_xlat16_3 = min(u_xlat16_0, 1.0);
    u_xlat16_3 = u_xlat16_1.w * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(_ColorScaler);
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_3;
    if(_SmoothMaskType != 0) {
        u_xlatb6.xy = equal(ivec4(_SmoothMaskType), ivec4(1, 2, 0, 0)).xy;
        u_xlatb4 = u_xlatb6.y || u_xlatb6.x;
        if(u_xlatb4){
            u_xlat4.xy = vec2(-abs(vs_TEXCOORD1.z) + float(0.5), -abs(vs_TEXCOORD1.w) + float(0.5));
            u_xlat16.xy = vec2(1.0, 1.0) / _SmoothMaskSoftRanges.xy;
            u_xlat4.xy = u_xlat16.xy * u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
            u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
            u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
            u_xlat16.xy = u_xlat4.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
            u_xlat4.xy = u_xlat4.xy * u_xlat4.xy;
            u_xlat4.xy = u_xlat4.xy * u_xlat16.xy;
            u_xlat16_3 = u_xlat4.y * u_xlat4.x;
            if(u_xlatb6.x){
                u_xlat4.xy = vec2(vs_TEXCOORD1.z + float(0.5), vs_TEXCOORD1.w + float(0.5));
                u_xlat10_4 = texture(_SmoothMaskTexture, u_xlat4.xy).w;
                u_xlat16_3 = u_xlat16_3 * u_xlat10_4;
                u_xlat16_3 = u_xlat16_3;
            //ENDIF
            }
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb4 = !!(_SmoothMaskType==3);
#else
            u_xlatb4 = _SmoothMaskType==3;
#endif
            u_xlat10.x = dot(vs_TEXCOORD1.zw, vs_TEXCOORD1.zw);
            u_xlat10.x = sqrt(u_xlat10.x);
            u_xlat10.x = (-u_xlat10.x) + 0.5;
#ifdef UNITY_ADRENO_ES3
            u_xlatb16 = !!(0.00100000005<_SmoothMaskSoftRanges.w);
#else
            u_xlatb16 = 0.00100000005<_SmoothMaskSoftRanges.w;
#endif
            u_xlat5.xy = vec2(vs_TEXCOORD1.z * _SmoothMaskSoftRanges.z, vs_TEXCOORD1.w * _SmoothMaskSoftRanges.w);
            u_xlat22 = dot(u_xlat5.xy, u_xlat5.xy);
            u_xlat22 = sqrt(u_xlat22);
            u_xlat22 = u_xlat22 + u_xlat22;
            u_xlat16_9 = (u_xlatb16) ? u_xlat22 : _SmoothMaskSoftRanges.z;
            u_xlat16_9 = float(1.0) / u_xlat16_9;
            u_xlat16_9 = u_xlat16_9 * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
            u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
            u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
            u_xlat16_15 = u_xlat16_9 * -2.0 + 3.0;
            u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
            u_xlat16_9 = u_xlat16_9 * u_xlat16_15;
            u_xlat16_3 = (u_xlatb4) ? u_xlat16_9 : 1.0;
        //ENDIF
        }
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(_SmoothMaskFillParams.x!=0.0);
#else
        u_xlatb4 = _SmoothMaskFillParams.x!=0.0;
#endif
        if(u_xlatb4){
#ifdef UNITY_ADRENO_ES3
            u_xlatb4 = !!(_SmoothMaskFillParams.x==1.0);
#else
            u_xlatb4 = _SmoothMaskFillParams.x==1.0;
#endif
            if(u_xlatb4){
                u_xlat4.x = vs_TEXCOORD1.z + 0.5;
#ifdef UNITY_ADRENO_ES3
                u_xlatb10 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                u_xlatb10 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                u_xlat16.x = (-u_xlat4.x) + 1.0;
                u_xlat4.x = (u_xlatb10) ? u_xlat16.x : u_xlat4.x;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb10 = !!(_SmoothMaskFillParams.x==2.0);
#else
                u_xlatb10 = _SmoothMaskFillParams.x==2.0;
#endif
                if(u_xlatb10){
                    u_xlat10.x = vs_TEXCOORD1.w + 0.5;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb16 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                    u_xlatb16 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                    u_xlat22 = (-u_xlat10.x) + 1.0;
                    u_xlat4.x = (u_xlatb16) ? u_xlat22 : u_xlat10.x;
                } else {
                    u_xlatb1 = equal(_SmoothMaskFillParams.zzzx, vec4(1.0, 2.0, 3.0, 3.0));
                    u_xlat2 = vec4(vs_TEXCOORD1.w * float(1.0), vs_TEXCOORD1.z * float(-1.0), vs_TEXCOORD1.w * float(-1.0), vs_TEXCOORD1.z * float(1.0));
                    u_xlat10.xy = (u_xlatb1.z) ? u_xlat2.xy : vs_TEXCOORD1.zw;
                    u_xlat10.xy = (u_xlatb1.y) ? (-vs_TEXCOORD1.zw) : u_xlat10.xy;
                    u_xlat5.xy = (u_xlatb1.x) ? u_xlat2.zw : u_xlat10.xy;
                    u_xlat10.xy = u_xlat5.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb22 = !!(_SmoothMaskFillParams.x==4.0);
#else
                    u_xlatb22 = _SmoothMaskFillParams.x==4.0;
#endif
                    u_xlat5.z = (u_xlatb22) ? u_xlat10.y : u_xlat5.y;
                    u_xlat10.xy = (u_xlatb1.w) ? u_xlat10.xy : u_xlat5.xz;
                    u_xlat10.x = u_xlat10.x * _SmoothMaskFillParams.w;
                    u_xlat22 = min(abs(u_xlat10.y), abs(u_xlat10.x));
                    u_xlat5.x = max(abs(u_xlat10.y), abs(u_xlat10.x));
                    u_xlat5.x = float(1.0) / u_xlat5.x;
                    u_xlat22 = u_xlat22 * u_xlat5.x;
                    u_xlat5.x = u_xlat22 * u_xlat22;
                    u_xlat11 = u_xlat5.x * 0.0208350997 + -0.0851330012;
                    u_xlat11 = u_xlat5.x * u_xlat11 + 0.180141002;
                    u_xlat11 = u_xlat5.x * u_xlat11 + -0.330299497;
                    u_xlat5.x = u_xlat5.x * u_xlat11 + 0.999866009;
                    u_xlat11 = u_xlat22 * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb17 = !!(abs(u_xlat10.y)<abs(u_xlat10.x));
#else
                    u_xlatb17 = abs(u_xlat10.y)<abs(u_xlat10.x);
#endif
                    u_xlat11 = u_xlat11 * -2.0 + 1.57079637;
                    u_xlat11 = u_xlatb17 ? u_xlat11 : float(0.0);
                    u_xlat22 = u_xlat22 * u_xlat5.x + u_xlat11;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb5 = !!(u_xlat10.y<(-u_xlat10.y));
#else
                    u_xlatb5 = u_xlat10.y<(-u_xlat10.y);
#endif
                    u_xlat5.x = u_xlatb5 ? -3.14159274 : float(0.0);
                    u_xlat22 = u_xlat22 + u_xlat5.x;
                    u_xlat5.x = min(u_xlat10.y, u_xlat10.x);
                    u_xlat10.x = max(u_xlat10.y, u_xlat10.x);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb16 = !!(u_xlat5.x<(-u_xlat5.x));
#else
                    u_xlatb16 = u_xlat5.x<(-u_xlat5.x);
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb10 = !!(u_xlat10.x>=(-u_xlat10.x));
#else
                    u_xlatb10 = u_xlat10.x>=(-u_xlat10.x);
#endif
                    u_xlatb10 = u_xlatb10 && u_xlatb16;
                    u_xlat10.x = (u_xlatb10) ? (-u_xlat22) : u_xlat22;
                    u_xlat4.x = u_xlat10.x * 0.159154996 + 0.5;
                //ENDIF
                }
            //ENDIF
            }
#ifdef UNITY_ADRENO_ES3
            u_xlatb4 = !!(_SmoothMaskFillParams.y>=u_xlat4.x);
#else
            u_xlatb4 = _SmoothMaskFillParams.y>=u_xlat4.x;
#endif
            u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
            u_xlat3 = u_xlat16_3 * u_xlat4.x;
            u_xlat16_3 = u_xlat3;
        //ENDIF
        }
    } else {
        u_xlat16_3 = 1.0;
    //ENDIF
    }
    u_xlat16_9 = u_xlat0.x * u_xlat16_3;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3 + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat16_3<0.0);
#else
    u_xlatb4 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = u_xlat16_9;
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