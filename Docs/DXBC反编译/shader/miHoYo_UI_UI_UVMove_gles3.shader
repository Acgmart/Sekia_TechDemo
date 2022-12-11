//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/UI/UI_UVMove" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_ColorScaler ("Color Scaler", Float) = 1
[Header(ASE Properties)] _MainColor ("MainColor", Color) = (1,1,1,1)
_ColorBrightness ("ColorBrightness", Float) = 1
_AlphaBrightness ("AlphaBrightness", Float) = 1
_BaseTex ("BaseTex", 2D) = "bump" { }
[Enum(RGB,0,R,1,G,2,B,3,A,4)] _BaseTexColorChannelSwitch ("BaseTexColorChannelSwitch", Float) = 0
[Enum(A,0,R,1,G,2,B,3)] _BaseTexAlphaChannelSwitch ("BaseTexAlphaChannelSwitch", Float) = 0
_BaseTexAlphaBrightness ("BaseTexAlphaBrightness", Float) = 1
[MHYToggle] _BaseTexURandomToggle ("BaseTexURandomToggle", Float) = 0
[MHYToggle] _BaseTexVRandomToggle ("BaseTexVRandomToggle", Float) = 0
_BaseTex_Uspeed ("BaseTex_Uspeed", Float) = 1
_BaseTex_Vspeed ("BaseTex_Vspeed", Float) = 1
[Toggle(_NOISETEXTOGGLE_ON)] _NoiseTexToggle ("NoiseTex[Toggle]", Float) = 0
_NoiseTex ("NoiseTex", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _NoiseTexChannelSwitch ("NoiseTexChannelSwitch", Float) = 0
_NoiseTex_Uspeed ("NoiseTex_Uspeed", Float) = 1
_NoiseTex_Vspeed ("NoiseTex_Vspeed", Float) = 1
_Noise_Brightness ("Noise_Brightness", Float) = 1
_Noise_Offset ("Noise_Offset", Float) = 0
[MHYToggle] _NoiseTexUVRandomToggle ("NoiseTexUVRandomToggle", Float) = 0
[Toggle(_MASKTEXTOGGLE_ON)] _MaskTexToggle ("MaskTex[Toggle]", Float) = 0
_NoiseIntensityOnMask ("NoiseIntensityOnMask", Float) = 0
[Enum(Multiply,0,Add,1)] _MaskTexBlendModeToggle ("MaskTexBlendModeToggle", Float) = 0
_MaskTex ("MaskTex", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _MaskTexChannelSwitch ("MaskTexChannelSwitch", Float) = 2
_MaskTex_Uspeed ("MaskTex_Uspeed", Float) = 0
_MaskTex_Vspeed ("MaskTex_Vspeed", Float) = 0
_MaskTexBrightness ("MaskTexBrightness", Float) = 1
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
  GpuProgramID 45081
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
in highp vec4 in_TEXCOORD1;
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
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy;
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
uniform 	vec4 _Time;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform lowp sampler2D _BaseTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec2 u_xlat2;
bvec4 u_xlatb3;
vec2 u_xlat4;
bvec2 u_xlatb4;
float u_xlat5;
float u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(3.0, 4.0, 0.0, 0.0)).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb8 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat12 = _Time.y * _BaseTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat1.x;
    u_xlat5 = u_xlat12 + vs_TEXCOORD2.y;
    u_xlat2.y = (u_xlatb8) ? u_xlat5 : u_xlat12;
    u_xlat8 = u_xlat1.x + vs_TEXCOORD2.x;
    u_xlatb3 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat8 : u_xlat1.x;
    u_xlat1 = texture(_BaseTex, u_xlat2.xy);
    u_xlat4.x = u_xlatb0.y ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.z : u_xlat4.x;
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.y) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(_ColorScaler);
    u_xlatb0 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb0.w ? u_xlat1.z : float(0.0);
    u_xlat8 = (u_xlatb0.z) ? u_xlat1.y : u_xlat12;
    u_xlat4.x = (u_xlatb0.y) ? u_xlat1.x : u_xlat8;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat4.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat4.x = _MainColor.w * _AlphaBrightness;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat4.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb4.xy));
    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb1.xy));
    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
    u_xlat4.x = u_xlat4.y * u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
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
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy;
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
uniform 	vec4 _Time;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
vec2 u_xlat4;
float u_xlat5;
float u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _MaskTex_Vspeed + u_xlat4.y;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_MaskTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _MaskTexBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb8 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat12 = _Time.y * _BaseTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat1.x;
    u_xlat5 = u_xlat12 + vs_TEXCOORD2.y;
    u_xlat2.y = (u_xlatb8) ? u_xlat5 : u_xlat12;
    u_xlat8 = u_xlat1.x + vs_TEXCOORD2.x;
    u_xlatb3 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat8 : u_xlat1.x;
    u_xlat1 = texture(_BaseTex, u_xlat2.xy);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8 = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat8 = (u_xlatb2.z) ? u_xlat1.y : u_xlat8;
    u_xlat8 = (u_xlatb2.y) ? u_xlat1.x : u_xlat8;
    u_xlat8 = (u_xlatb2.x) ? u_xlat1.w : u_xlat8;
    u_xlat12 = u_xlat8 * _BaseTexAlphaBrightness;
    u_xlat8 = u_xlat8 * _BaseTexAlphaBrightness + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat12;
    u_xlatb2.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat8 = u_xlatb2.y ? u_xlat8 : float(0.0);
    u_xlat4.x = (u_xlatb2.x) ? u_xlat4.x : u_xlat8;
    u_xlat8 = _MainColor.w * _AlphaBrightness;
    u_xlat8 = u_xlat8 * vs_COLOR0.w;
    u_xlat4.x = u_xlat4.x * u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    SV_Target0.w = u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(3.0, 4.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.z : u_xlat4.x;
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.y) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(_ColorScaler);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_NOISETEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
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
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy;
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
uniform 	vec4 _Time;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec2 u_xlatb3;
float u_xlat4;
vec2 u_xlat6;
float u_xlat9;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat3.y;
    u_xlat3.xy = u_xlat1.xy + vs_TEXCOORD2.xy;
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat3.xy = (u_xlatb2.x) ? u_xlat3.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat3.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb3.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat6.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat9 = _Time.y * _BaseTex_Vspeed + u_xlat6.y;
    u_xlat6.x = _Time.y * _BaseTex_Uspeed + u_xlat6.x;
    u_xlat1.x = u_xlat9 + vs_TEXCOORD2.y;
    u_xlat1.y = (u_xlatb3.x) ? u_xlat1.x : u_xlat9;
    u_xlat3.x = u_xlat6.x + vs_TEXCOORD2.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat3.x : u_xlat6.x;
    u_xlat0.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xy;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
    u_xlatb1.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(3.0, 4.0, 0.0, 0.0)).xy;
    u_xlat4 = u_xlatb1.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.z : u_xlat4;
    u_xlat1.x = (u_xlatb2.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyz = (u_xlatb2.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(_ColorScaler);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat6.x = u_xlatb1.w ? u_xlat0.z : float(0.0);
    u_xlat3.x = (u_xlatb1.z) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat3.x = _MainColor.w * _AlphaBrightness;
    u_xlat3.x = u_xlat3.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb3.xy));
    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb1.xy));
    u_xlat3.xy = u_xlat3.xy * u_xlat1.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
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
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy;
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
uniform 	vec4 _Time;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
float u_xlat5;
vec2 u_xlat8;
float u_xlat9;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb4 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat8.xy = u_xlat1.xy + vs_TEXCOORD2.xy;
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb2.x) ? u_xlat8.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x + _Noise_Offset;
    u_xlat8.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _MaskTex_Vspeed + u_xlat8.y;
    u_xlat8.xy = u_xlat4.xx * vec2(vec2(_NoiseIntensityOnMask, _NoiseIntensityOnMask)) + u_xlat1.xy;
    u_xlat1 = texture(_MaskTex, u_xlat8.xy);
    u_xlatb2 = equal(vec4(_MaskTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x * _MaskTexBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb12 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat5 = _Time.y * _BaseTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat1.x;
    u_xlat9 = u_xlat5 + vs_TEXCOORD2.y;
    u_xlat2.y = (u_xlatb12) ? u_xlat9 : u_xlat5;
    u_xlat12 = u_xlat1.x + vs_TEXCOORD2.x;
    u_xlatb3 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat12 : u_xlat1.x;
    u_xlat4.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat4.xx + u_xlat2.xy;
    u_xlat1 = texture(_BaseTex, u_xlat4.xz);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat4.x;
    u_xlat12 = u_xlat4.x * _BaseTexAlphaBrightness;
    u_xlat4.x = u_xlat4.x * _BaseTexAlphaBrightness + u_xlat8.x;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlatb2.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb2.y ? u_xlat4.x : float(0.0);
    u_xlat4.x = (u_xlatb2.x) ? u_xlat8.x : u_xlat4.x;
    u_xlat8.x = _MainColor.w * _AlphaBrightness;
    u_xlat8.x = u_xlat8.x * vs_COLOR0.w;
    u_xlat4.x = u_xlat4.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    SV_Target0.w = u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(3.0, 4.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.z : u_xlat4.x;
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.y) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(_ColorScaler);
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
in highp vec4 in_TEXCOORD1;
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
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy;
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
uniform 	vec4 _Time;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform lowp sampler2D _BaseTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat6;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat5 = _MainColor.w * _AlphaBrightness;
    u_xlat5 = u_xlat5 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb10 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat15 = _Time.y * _BaseTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat1.x;
    u_xlat6 = u_xlat15 + vs_TEXCOORD2.y;
    u_xlat2.y = (u_xlatb10) ? u_xlat6 : u_xlat15;
    u_xlat10 = u_xlat1.x + vs_TEXCOORD2.x;
    u_xlatb3 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat10 : u_xlat1.x;
    u_xlat1 = texture(_BaseTex, u_xlat2.xy);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat10 = (u_xlatb2.z) ? u_xlat1.y : u_xlat10;
    u_xlat10 = (u_xlatb2.y) ? u_xlat1.x : u_xlat10;
    u_xlat10 = (u_xlatb2.x) ? u_xlat1.w : u_xlat10;
    u_xlat10 = u_xlat10 * _BaseTexAlphaBrightness;
    u_xlat5 = u_xlat10 * u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat5 * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat5;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_4<0.0);
#else
    u_xlatb0.x = u_xlat16_4<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(3.0, 4.0, 0.0, 0.0)).xy;
    u_xlat5 = u_xlatb0.y ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.z : u_xlat5;
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.y) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(_ColorScaler);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_ALPHACLIP" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
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
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy;
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
uniform 	vec4 _Time;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb5;
vec2 u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MaskTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(_MaskTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat10.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat15;
    u_xlat5.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat10.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _MaskTexBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb5.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat10.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat15 = _Time.y * _BaseTex_Vspeed + u_xlat10.y;
    u_xlat10.x = _Time.y * _BaseTex_Uspeed + u_xlat10.x;
    u_xlat1.x = u_xlat15 + vs_TEXCOORD2.y;
    u_xlat1.y = (u_xlatb5.x) ? u_xlat1.x : u_xlat15;
    u_xlat5.x = u_xlat10.x + vs_TEXCOORD2.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat5.x : u_xlat10.x;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.x = u_xlatb3.w ? u_xlat1.z : float(0.0);
    u_xlat5.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.x) ? u_xlat1.w : u_xlat5.x;
    u_xlat10.x = u_xlat5.x * _BaseTexAlphaBrightness;
    u_xlat5.x = u_xlat5.x * _BaseTexAlphaBrightness + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlatb10.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat5.x = u_xlatb10.y ? u_xlat5.x : float(0.0);
    u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : u_xlat5.x;
    u_xlat5.x = _MainColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat5.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlatb5.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat5.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb3.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb3.xy));
    u_xlat5.xy = u_xlat5.xy * u_xlat3.xy;
    u_xlat5.x = u_xlat5.y * u_xlat5.x;
    u_xlat16_4 = u_xlat0.x * u_xlat5.x + -0.00100000005;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_4<0.0);
#else
    u_xlatb0.x = u_xlat16_4<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(3.0, 4.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.z : u_xlat5.x;
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb2.y) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(_ColorScaler);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_ALPHACLIP" "_NOISETEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
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
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy;
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
uniform 	vec4 _Time;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
bool u_xlatb5;
float u_xlat6;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb5 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat10.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat10.y;
    u_xlat10.xy = u_xlat1.xy + vs_TEXCOORD2.xy;
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = (u_xlatb2.x) ? u_xlat10.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat10.xy);
    u_xlat5.x = u_xlatb5 ? u_xlat1.w : float(0.0);
    u_xlat5.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x + _Noise_Offset;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb10 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat15 = _Time.y * _BaseTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat1.x;
    u_xlat6 = u_xlat15 + vs_TEXCOORD2.y;
    u_xlat2.y = (u_xlatb10) ? u_xlat6 : u_xlat15;
    u_xlat10.x = u_xlat1.x + vs_TEXCOORD2.x;
    u_xlatb3 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat10.x : u_xlat1.x;
    u_xlat5.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat5.xx + u_xlat2.xy;
    u_xlat1 = texture(_BaseTex, u_xlat5.xy);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.x = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat5.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat5.x;
    u_xlat5.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _BaseTexAlphaBrightness;
    u_xlat10.x = _MainColor.w * _AlphaBrightness;
    u_xlat10.x = u_xlat10.x * vs_COLOR0.w;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat5.x * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_4<0.0);
#else
    u_xlatb0.x = u_xlat16_4<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(3.0, 4.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.z : u_xlat5.x;
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.y) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(_ColorScaler);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_ALPHACLIP" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
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
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy;
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
uniform 	vec4 _Time;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
bvec2 u_xlatb5;
float u_xlat6;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat5.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat5.y;
    u_xlat5.xy = u_xlat1.xy + vs_TEXCOORD2.xy;
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = (u_xlatb2.x) ? u_xlat5.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat5.xy);
    u_xlat0.x = u_xlatb0.x ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat5.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat5.x;
    u_xlat1.y = _Time.y * _MaskTex_Vspeed + u_xlat5.y;
    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_NoiseIntensityOnMask, _NoiseIntensityOnMask)) + u_xlat1.xy;
    u_xlat1 = texture(_MaskTex, u_xlat5.xy);
    u_xlatb2 = equal(vec4(_MaskTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat5.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MaskTexBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb10.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat15 = _Time.y * _BaseTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat1.x;
    u_xlat6 = u_xlat15 + vs_TEXCOORD2.y;
    u_xlat2.y = (u_xlatb10.x) ? u_xlat6 : u_xlat15;
    u_xlat10 = u_xlat1.x + vs_TEXCOORD2.x;
    u_xlatb3 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat10 : u_xlat1.x;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.xy;
    u_xlat1 = texture(_BaseTex, u_xlat0.xz);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat0.x;
    u_xlat10 = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * u_xlat10;
    u_xlatb10.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlatb10.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb10.x) ? u_xlat5.x : u_xlat0.x;
    u_xlat5.x = _MainColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat5.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlatb5.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat5.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat5.xy = u_xlat5.xy * u_xlat2.xy;
    u_xlat5.x = u_xlat5.y * u_xlat5.x;
    u_xlat16_4 = u_xlat0.x * u_xlat5.x + -0.00100000005;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_4<0.0);
#else
    u_xlatb0.x = u_xlat16_4<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(3.0, 4.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.z : u_xlat5.x;
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.y) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(_ColorScaler);
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
in highp vec4 in_TEXCOORD1;
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
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy;
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
uniform 	vec4 _Time;
uniform 	int _SmoothMaskType;
uniform 	vec4 _SmoothMaskSoftRanges;
uniform 	vec4 _SmoothMaskFillParams;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _SmoothMaskTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
float u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bvec2 u_xlatb4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat9;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.x = u_xlat0.x + vs_TEXCOORD2.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat8.x : u_xlat0.x;
    u_xlat0.x = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb4.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat8.x = u_xlat0.x + vs_TEXCOORD2.y;
    u_xlat2.y = (u_xlatb4.x) ? u_xlat8.x : u_xlat0.x;
    u_xlat0 = texture(_BaseTex, u_xlat2.xy);
    u_xlatb2.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(3.0, 4.0, 0.0, 0.0)).xy;
    u_xlat1.x = u_xlatb2.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat0.z : float(0.0);
    u_xlat4.x = (u_xlatb2.z) ? u_xlat0.y : u_xlat8.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat4.x = _MainColor.w * _AlphaBrightness;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat4.xyz * vec3(_ColorScaler);
    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat4.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb4.xy));
    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb1.xy));
    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
    u_xlat4.x = u_xlat4.y * u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    if(_SmoothMaskType != 0) {
        u_xlatb4.xy = equal(ivec4(_SmoothMaskType), ivec4(1, 2, 0, 0)).xy;
        u_xlatb8 = u_xlatb4.y || u_xlatb4.x;
        if(u_xlatb8){
            u_xlat8.xy = vec2(-abs(vs_TEXCOORD1.z) + float(0.5), -abs(vs_TEXCOORD1.w) + float(0.5));
            u_xlat1.xy = vec2(1.0, 1.0) / _SmoothMaskSoftRanges.xy;
            u_xlat8.xy = u_xlat8.xy * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
            u_xlat8.xy = min(max(u_xlat8.xy, 0.0), 1.0);
#else
            u_xlat8.xy = clamp(u_xlat8.xy, 0.0, 1.0);
#endif
            u_xlat1.xy = u_xlat8.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
            u_xlat8.xy = u_xlat8.xy * u_xlat8.xy;
            u_xlat8.xy = u_xlat8.xy * u_xlat1.xy;
            u_xlat16_3 = u_xlat8.y * u_xlat8.x;
            if(u_xlatb4.x){
                u_xlat4.xy = vec2(vs_TEXCOORD1.z + float(0.5), vs_TEXCOORD1.w + float(0.5));
                u_xlat10_4 = texture(_SmoothMaskTexture, u_xlat4.xy).w;
                u_xlat16_3 = u_xlat10_4 * u_xlat16_3;
                u_xlat16_3 = u_xlat16_3;
            //ENDIF
            }
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb4.x = !!(_SmoothMaskType==3);
#else
            u_xlatb4.x = _SmoothMaskType==3;
#endif
            u_xlat8.x = dot(vs_TEXCOORD1.zw, vs_TEXCOORD1.zw);
            u_xlat8.x = sqrt(u_xlat8.x);
            u_xlat8.x = (-u_xlat8.x) + 0.5;
#ifdef UNITY_ADRENO_ES3
            u_xlatb12 = !!(0.00100000005<_SmoothMaskSoftRanges.w);
#else
            u_xlatb12 = 0.00100000005<_SmoothMaskSoftRanges.w;
#endif
            u_xlat1.xy = vec2(vs_TEXCOORD1.z * _SmoothMaskSoftRanges.z, vs_TEXCOORD1.w * _SmoothMaskSoftRanges.w);
            u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
            u_xlat1.x = sqrt(u_xlat1.x);
            u_xlat1.x = u_xlat1.x + u_xlat1.x;
            u_xlat16_7 = (u_xlatb12) ? u_xlat1.x : _SmoothMaskSoftRanges.z;
            u_xlat16_7 = float(1.0) / u_xlat16_7;
            u_xlat16_7 = u_xlat8.x * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
            u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
            u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
            u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
            u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
            u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
            u_xlat16_3 = (u_xlatb4.x) ? u_xlat16_7 : 1.0;
        //ENDIF
        }
#ifdef UNITY_ADRENO_ES3
        u_xlatb4.x = !!(_SmoothMaskFillParams.x!=0.0);
#else
        u_xlatb4.x = _SmoothMaskFillParams.x!=0.0;
#endif
        if(u_xlatb4.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb4.x = !!(_SmoothMaskFillParams.x==1.0);
#else
            u_xlatb4.x = _SmoothMaskFillParams.x==1.0;
#endif
            if(u_xlatb4.x){
                u_xlat4.x = vs_TEXCOORD1.z + 0.5;
#ifdef UNITY_ADRENO_ES3
                u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                u_xlat12 = (-u_xlat4.x) + 1.0;
                u_xlat4.x = (u_xlatb8) ? u_xlat12 : u_xlat4.x;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb8 = !!(_SmoothMaskFillParams.x==2.0);
#else
                u_xlatb8 = _SmoothMaskFillParams.x==2.0;
#endif
                if(u_xlatb8){
                    u_xlat8.x = vs_TEXCOORD1.w + 0.5;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                    u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                    u_xlat1.x = (-u_xlat8.x) + 1.0;
                    u_xlat4.x = (u_xlatb12) ? u_xlat1.x : u_xlat8.x;
                } else {
                    u_xlatb1 = equal(_SmoothMaskFillParams.zzzx, vec4(1.0, 2.0, 3.0, 3.0));
                    u_xlat2 = vec4(vs_TEXCOORD1.w * float(1.0), vs_TEXCOORD1.z * float(-1.0), vs_TEXCOORD1.w * float(-1.0), vs_TEXCOORD1.z * float(1.0));
                    u_xlat8.xy = (u_xlatb1.z) ? u_xlat2.xy : vs_TEXCOORD1.zw;
                    u_xlat8.xy = (u_xlatb1.y) ? (-vs_TEXCOORD1.zw) : u_xlat8.xy;
                    u_xlat1.xy = (u_xlatb1.x) ? u_xlat2.zw : u_xlat8.xy;
                    u_xlat8.xy = u_xlat1.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb2.x = !!(_SmoothMaskFillParams.x==4.0);
#else
                    u_xlatb2.x = _SmoothMaskFillParams.x==4.0;
#endif
                    u_xlat1.z = (u_xlatb2.x) ? u_xlat8.y : u_xlat1.y;
                    u_xlat8.xy = (u_xlatb1.w) ? u_xlat8.xy : u_xlat1.xz;
                    u_xlat8.x = u_xlat8.x * _SmoothMaskFillParams.w;
                    u_xlat1.x = min(abs(u_xlat8.y), abs(u_xlat8.x));
                    u_xlat5 = max(abs(u_xlat8.y), abs(u_xlat8.x));
                    u_xlat5 = float(1.0) / u_xlat5;
                    u_xlat1.x = u_xlat5 * u_xlat1.x;
                    u_xlat5 = u_xlat1.x * u_xlat1.x;
                    u_xlat9 = u_xlat5 * 0.0208350997 + -0.0851330012;
                    u_xlat9 = u_xlat5 * u_xlat9 + 0.180141002;
                    u_xlat9 = u_xlat5 * u_xlat9 + -0.330299497;
                    u_xlat5 = u_xlat5 * u_xlat9 + 0.999866009;
                    u_xlat9 = u_xlat5 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb13 = !!(abs(u_xlat8.y)<abs(u_xlat8.x));
#else
                    u_xlatb13 = abs(u_xlat8.y)<abs(u_xlat8.x);
#endif
                    u_xlat9 = u_xlat9 * -2.0 + 1.57079637;
                    u_xlat9 = u_xlatb13 ? u_xlat9 : float(0.0);
                    u_xlat1.x = u_xlat1.x * u_xlat5 + u_xlat9;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb5 = !!(u_xlat8.y<(-u_xlat8.y));
#else
                    u_xlatb5 = u_xlat8.y<(-u_xlat8.y);
#endif
                    u_xlat5 = u_xlatb5 ? -3.14159274 : float(0.0);
                    u_xlat1.x = u_xlat5 + u_xlat1.x;
                    u_xlat5 = min(u_xlat8.y, u_xlat8.x);
                    u_xlat8.x = max(u_xlat8.y, u_xlat8.x);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb12 = !!(u_xlat5<(-u_xlat5));
#else
                    u_xlatb12 = u_xlat5<(-u_xlat5);
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb8 = !!(u_xlat8.x>=(-u_xlat8.x));
#else
                    u_xlatb8 = u_xlat8.x>=(-u_xlat8.x);
#endif
                    u_xlatb8 = u_xlatb8 && u_xlatb12;
                    u_xlat8.x = (u_xlatb8) ? (-u_xlat1.x) : u_xlat1.x;
                    u_xlat4.x = u_xlat8.x * 0.159154996 + 0.5;
                //ENDIF
                }
            //ENDIF
            }
#ifdef UNITY_ADRENO_ES3
            u_xlatb4.x = !!(_SmoothMaskFillParams.y>=u_xlat4.x);
#else
            u_xlatb4.x = _SmoothMaskFillParams.y>=u_xlat4.x;
#endif
            u_xlat4.x = u_xlatb4.x ? 1.0 : float(0.0);
            u_xlat3 = u_xlat4.x * u_xlat16_3;
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
Keywords { "UNITY_UI_SMOOTHMASK" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_SmoothMaskTransform[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
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
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy;
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
uniform 	vec4 _Time;
uniform 	int _SmoothMaskType;
uniform 	vec4 _SmoothMaskSoftRanges;
uniform 	vec4 _SmoothMaskFillParams;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _SmoothMaskTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
float u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat5;
lowp float u_xlat10_5;
bvec2 u_xlatb5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat11;
mediump float u_xlat16_14;
float u_xlat15;
bool u_xlatb15;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.x = u_xlat0.x + vs_TEXCOORD2.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat10.x : u_xlat0.x;
    u_xlat0.x = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb5.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat10.x = u_xlat0.x + vs_TEXCOORD2.y;
    u_xlat2.y = (u_xlatb5.x) ? u_xlat10.x : u_xlat0.x;
    u_xlat0 = texture(_BaseTex, u_xlat2.xy);
    u_xlatb2.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(3.0, 4.0, 0.0, 0.0)).xy;
    u_xlat1.x = u_xlatb2.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb2.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb2.z) ? u_xlat0.y : u_xlat10.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat5.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat10.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.x = _Time.y * _MaskTex_Uspeed + u_xlat10.x;
    u_xlat2.y = _Time.y * _MaskTex_Vspeed + u_xlat10.y;
    u_xlat2 = texture(_MaskTex, u_xlat2.xy);
    u_xlatb3 = equal(vec4(_MaskTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat10.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat10.x;
    u_xlat10.x = u_xlat10.x * _MaskTexBrightness;
    u_xlat5.x = u_xlat10.x * u_xlat5.x;
    u_xlatb2.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat10.x;
    u_xlat0.x = u_xlatb2.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb2.x) ? u_xlat5.x : u_xlat0.x;
    u_xlat5.x = _MainColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat5.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat5.xyz = u_xlat5.xyz * vs_COLOR0.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat5.xyz * vec3(_ColorScaler);
    u_xlatb5.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat5.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb1.xy));
    u_xlat5.xy = u_xlat5.xy * u_xlat1.xy;
    u_xlat5.x = u_xlat5.y * u_xlat5.x;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    if(_SmoothMaskType != 0) {
        u_xlatb5.xy = equal(ivec4(_SmoothMaskType), ivec4(1, 2, 0, 0)).xy;
        u_xlatb10 = u_xlatb5.y || u_xlatb5.x;
        if(u_xlatb10){
            u_xlat10.xy = vec2(-abs(vs_TEXCOORD1.z) + float(0.5), -abs(vs_TEXCOORD1.w) + float(0.5));
            u_xlat1.xy = vec2(1.0, 1.0) / _SmoothMaskSoftRanges.xy;
            u_xlat10.xy = u_xlat10.xy * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
            u_xlat10.xy = min(max(u_xlat10.xy, 0.0), 1.0);
#else
            u_xlat10.xy = clamp(u_xlat10.xy, 0.0, 1.0);
#endif
            u_xlat1.xy = u_xlat10.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
            u_xlat10.xy = u_xlat10.xy * u_xlat10.xy;
            u_xlat10.xy = u_xlat10.xy * u_xlat1.xy;
            u_xlat16_4 = u_xlat10.y * u_xlat10.x;
            if(u_xlatb5.x){
                u_xlat5.xy = vec2(vs_TEXCOORD1.z + float(0.5), vs_TEXCOORD1.w + float(0.5));
                u_xlat10_5 = texture(_SmoothMaskTexture, u_xlat5.xy).w;
                u_xlat16_4 = u_xlat10_5 * u_xlat16_4;
                u_xlat16_4 = u_xlat16_4;
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
            u_xlat1.xy = vec2(vs_TEXCOORD1.z * _SmoothMaskSoftRanges.z, vs_TEXCOORD1.w * _SmoothMaskSoftRanges.w);
            u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
            u_xlat1.x = sqrt(u_xlat1.x);
            u_xlat1.x = u_xlat1.x + u_xlat1.x;
            u_xlat16_9 = (u_xlatb15) ? u_xlat1.x : _SmoothMaskSoftRanges.z;
            u_xlat16_9 = float(1.0) / u_xlat16_9;
            u_xlat16_9 = u_xlat10.x * u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
            u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
            u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
            u_xlat16_14 = u_xlat16_9 * -2.0 + 3.0;
            u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
            u_xlat16_9 = u_xlat16_9 * u_xlat16_14;
            u_xlat16_4 = (u_xlatb5.x) ? u_xlat16_9 : 1.0;
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
                    u_xlat1.x = (-u_xlat10.x) + 1.0;
                    u_xlat5.x = (u_xlatb15) ? u_xlat1.x : u_xlat10.x;
                } else {
                    u_xlatb1 = equal(_SmoothMaskFillParams.zzzx, vec4(1.0, 2.0, 3.0, 3.0));
                    u_xlat2 = vec4(vs_TEXCOORD1.w * float(1.0), vs_TEXCOORD1.z * float(-1.0), vs_TEXCOORD1.w * float(-1.0), vs_TEXCOORD1.z * float(1.0));
                    u_xlat10.xy = (u_xlatb1.z) ? u_xlat2.xy : vs_TEXCOORD1.zw;
                    u_xlat10.xy = (u_xlatb1.y) ? (-vs_TEXCOORD1.zw) : u_xlat10.xy;
                    u_xlat1.xy = (u_xlatb1.x) ? u_xlat2.zw : u_xlat10.xy;
                    u_xlat10.xy = u_xlat1.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb2.x = !!(_SmoothMaskFillParams.x==4.0);
#else
                    u_xlatb2.x = _SmoothMaskFillParams.x==4.0;
#endif
                    u_xlat1.z = (u_xlatb2.x) ? u_xlat10.y : u_xlat1.y;
                    u_xlat10.xy = (u_xlatb1.w) ? u_xlat10.xy : u_xlat1.xz;
                    u_xlat10.x = u_xlat10.x * _SmoothMaskFillParams.w;
                    u_xlat1.x = min(abs(u_xlat10.y), abs(u_xlat10.x));
                    u_xlat6 = max(abs(u_xlat10.y), abs(u_xlat10.x));
                    u_xlat6 = float(1.0) / u_xlat6;
                    u_xlat1.x = u_xlat6 * u_xlat1.x;
                    u_xlat6 = u_xlat1.x * u_xlat1.x;
                    u_xlat11 = u_xlat6 * 0.0208350997 + -0.0851330012;
                    u_xlat11 = u_xlat6 * u_xlat11 + 0.180141002;
                    u_xlat11 = u_xlat6 * u_xlat11 + -0.330299497;
                    u_xlat6 = u_xlat6 * u_xlat11 + 0.999866009;
                    u_xlat11 = u_xlat6 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb16 = !!(abs(u_xlat10.y)<abs(u_xlat10.x));
#else
                    u_xlatb16 = abs(u_xlat10.y)<abs(u_xlat10.x);
#endif
                    u_xlat11 = u_xlat11 * -2.0 + 1.57079637;
                    u_xlat11 = u_xlatb16 ? u_xlat11 : float(0.0);
                    u_xlat1.x = u_xlat1.x * u_xlat6 + u_xlat11;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb6 = !!(u_xlat10.y<(-u_xlat10.y));
#else
                    u_xlatb6 = u_xlat10.y<(-u_xlat10.y);
#endif
                    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
                    u_xlat1.x = u_xlat6 + u_xlat1.x;
                    u_xlat6 = min(u_xlat10.y, u_xlat10.x);
                    u_xlat10.x = max(u_xlat10.y, u_xlat10.x);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15 = !!(u_xlat6<(-u_xlat6));
#else
                    u_xlatb15 = u_xlat6<(-u_xlat6);
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb10 = !!(u_xlat10.x>=(-u_xlat10.x));
#else
                    u_xlatb10 = u_xlat10.x>=(-u_xlat10.x);
#endif
                    u_xlatb10 = u_xlatb10 && u_xlatb15;
                    u_xlat10.x = (u_xlatb10) ? (-u_xlat1.x) : u_xlat1.x;
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
            u_xlat4 = u_xlat5.x * u_xlat16_4;
            u_xlat16_4 = u_xlat4;
        //ENDIF
        }
    } else {
        u_xlat16_4 = 1.0;
    //ENDIF
    }
    SV_Target0.w = u_xlat0.x * u_xlat16_4;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_SMOOTHMASK" "_NOISETEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_SmoothMaskTransform[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
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
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy;
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
uniform 	vec4 _Time;
uniform 	int _SmoothMaskType;
uniform 	vec4 _SmoothMaskSoftRanges;
uniform 	vec4 _SmoothMaskFillParams;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _SmoothMaskTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
float u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat5;
lowp float u_xlat10_5;
bvec2 u_xlatb5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat11;
vec2 u_xlat12;
mediump float u_xlat16_14;
float u_xlat15;
bool u_xlatb15;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.x = u_xlat0.x + vs_TEXCOORD2.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat10.x : u_xlat0.x;
    u_xlat0.x = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb5.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat10.x = u_xlat0.x + vs_TEXCOORD2.y;
    u_xlat2.y = (u_xlatb5.x) ? u_xlat10.x : u_xlat0.x;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlatb0 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat12.xy = u_xlat3.xy + vs_TEXCOORD2.xy;
    u_xlat12.xy = (u_xlatb0.x) ? u_xlat12.xy : u_xlat3.xy;
    u_xlat3 = texture(_NoiseTex, u_xlat12.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat0.x = u_xlatb0.x ? u_xlat3.w : float(0.0);
    u_xlat0.x = (u_xlatb0.w) ? u_xlat3.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.z) ? u_xlat3.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.y) ? u_xlat3.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat0.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.xy;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
    u_xlatb2.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(3.0, 4.0, 0.0, 0.0)).xy;
    u_xlat1.x = u_xlatb2.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb2.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb2.z) ? u_xlat0.y : u_xlat10.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat5.x = _MainColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat5.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat5.xyz = u_xlat5.xyz * vs_COLOR0.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat5.xyz * vec3(_ColorScaler);
    u_xlatb5.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat5.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb1.xy));
    u_xlat5.xy = u_xlat5.xy * u_xlat1.xy;
    u_xlat5.x = u_xlat5.y * u_xlat5.x;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    if(_SmoothMaskType != 0) {
        u_xlatb5.xy = equal(ivec4(_SmoothMaskType), ivec4(1, 2, 0, 0)).xy;
        u_xlatb10 = u_xlatb5.y || u_xlatb5.x;
        if(u_xlatb10){
            u_xlat10.xy = vec2(-abs(vs_TEXCOORD1.z) + float(0.5), -abs(vs_TEXCOORD1.w) + float(0.5));
            u_xlat1.xy = vec2(1.0, 1.0) / _SmoothMaskSoftRanges.xy;
            u_xlat10.xy = u_xlat10.xy * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
            u_xlat10.xy = min(max(u_xlat10.xy, 0.0), 1.0);
#else
            u_xlat10.xy = clamp(u_xlat10.xy, 0.0, 1.0);
#endif
            u_xlat1.xy = u_xlat10.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
            u_xlat10.xy = u_xlat10.xy * u_xlat10.xy;
            u_xlat10.xy = u_xlat10.xy * u_xlat1.xy;
            u_xlat16_4 = u_xlat10.y * u_xlat10.x;
            if(u_xlatb5.x){
                u_xlat5.xy = vec2(vs_TEXCOORD1.z + float(0.5), vs_TEXCOORD1.w + float(0.5));
                u_xlat10_5 = texture(_SmoothMaskTexture, u_xlat5.xy).w;
                u_xlat16_4 = u_xlat10_5 * u_xlat16_4;
                u_xlat16_4 = u_xlat16_4;
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
            u_xlat1.xy = vec2(vs_TEXCOORD1.z * _SmoothMaskSoftRanges.z, vs_TEXCOORD1.w * _SmoothMaskSoftRanges.w);
            u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
            u_xlat1.x = sqrt(u_xlat1.x);
            u_xlat1.x = u_xlat1.x + u_xlat1.x;
            u_xlat16_9 = (u_xlatb15) ? u_xlat1.x : _SmoothMaskSoftRanges.z;
            u_xlat16_9 = float(1.0) / u_xlat16_9;
            u_xlat16_9 = u_xlat10.x * u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
            u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
            u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
            u_xlat16_14 = u_xlat16_9 * -2.0 + 3.0;
            u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
            u_xlat16_9 = u_xlat16_9 * u_xlat16_14;
            u_xlat16_4 = (u_xlatb5.x) ? u_xlat16_9 : 1.0;
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
                    u_xlat1.x = (-u_xlat10.x) + 1.0;
                    u_xlat5.x = (u_xlatb15) ? u_xlat1.x : u_xlat10.x;
                } else {
                    u_xlatb1 = equal(_SmoothMaskFillParams.zzzx, vec4(1.0, 2.0, 3.0, 3.0));
                    u_xlat2 = vec4(vs_TEXCOORD1.w * float(1.0), vs_TEXCOORD1.z * float(-1.0), vs_TEXCOORD1.w * float(-1.0), vs_TEXCOORD1.z * float(1.0));
                    u_xlat10.xy = (u_xlatb1.z) ? u_xlat2.xy : vs_TEXCOORD1.zw;
                    u_xlat10.xy = (u_xlatb1.y) ? (-vs_TEXCOORD1.zw) : u_xlat10.xy;
                    u_xlat1.xy = (u_xlatb1.x) ? u_xlat2.zw : u_xlat10.xy;
                    u_xlat10.xy = u_xlat1.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb2.x = !!(_SmoothMaskFillParams.x==4.0);
#else
                    u_xlatb2.x = _SmoothMaskFillParams.x==4.0;
#endif
                    u_xlat1.z = (u_xlatb2.x) ? u_xlat10.y : u_xlat1.y;
                    u_xlat10.xy = (u_xlatb1.w) ? u_xlat10.xy : u_xlat1.xz;
                    u_xlat10.x = u_xlat10.x * _SmoothMaskFillParams.w;
                    u_xlat1.x = min(abs(u_xlat10.y), abs(u_xlat10.x));
                    u_xlat6 = max(abs(u_xlat10.y), abs(u_xlat10.x));
                    u_xlat6 = float(1.0) / u_xlat6;
                    u_xlat1.x = u_xlat6 * u_xlat1.x;
                    u_xlat6 = u_xlat1.x * u_xlat1.x;
                    u_xlat11 = u_xlat6 * 0.0208350997 + -0.0851330012;
                    u_xlat11 = u_xlat6 * u_xlat11 + 0.180141002;
                    u_xlat11 = u_xlat6 * u_xlat11 + -0.330299497;
                    u_xlat6 = u_xlat6 * u_xlat11 + 0.999866009;
                    u_xlat11 = u_xlat6 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb16 = !!(abs(u_xlat10.y)<abs(u_xlat10.x));
#else
                    u_xlatb16 = abs(u_xlat10.y)<abs(u_xlat10.x);
#endif
                    u_xlat11 = u_xlat11 * -2.0 + 1.57079637;
                    u_xlat11 = u_xlatb16 ? u_xlat11 : float(0.0);
                    u_xlat1.x = u_xlat1.x * u_xlat6 + u_xlat11;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb6 = !!(u_xlat10.y<(-u_xlat10.y));
#else
                    u_xlatb6 = u_xlat10.y<(-u_xlat10.y);
#endif
                    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
                    u_xlat1.x = u_xlat6 + u_xlat1.x;
                    u_xlat6 = min(u_xlat10.y, u_xlat10.x);
                    u_xlat10.x = max(u_xlat10.y, u_xlat10.x);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15 = !!(u_xlat6<(-u_xlat6));
#else
                    u_xlatb15 = u_xlat6<(-u_xlat6);
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb10 = !!(u_xlat10.x>=(-u_xlat10.x));
#else
                    u_xlatb10 = u_xlat10.x>=(-u_xlat10.x);
#endif
                    u_xlatb10 = u_xlatb10 && u_xlatb15;
                    u_xlat10.x = (u_xlatb10) ? (-u_xlat1.x) : u_xlat1.x;
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
            u_xlat4 = u_xlat5.x * u_xlat16_4;
            u_xlat16_4 = u_xlat4;
        //ENDIF
        }
    } else {
        u_xlat16_4 = 1.0;
    //ENDIF
    }
    SV_Target0.w = u_xlat0.x * u_xlat16_4;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_SMOOTHMASK" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_SmoothMaskTransform[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
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
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy;
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
uniform 	vec4 _Time;
uniform 	int _SmoothMaskType;
uniform 	vec4 _SmoothMaskSoftRanges;
uniform 	vec4 _SmoothMaskFillParams;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _SmoothMaskTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec4 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
float u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat5;
lowp float u_xlat10_5;
bvec2 u_xlatb5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
vec2 u_xlat11;
bvec2 u_xlatb11;
vec2 u_xlat12;
mediump float u_xlat16_14;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.x = u_xlat0.x + vs_TEXCOORD2.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat10.x : u_xlat0.x;
    u_xlat0.x = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb5.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat10.x = u_xlat0.x + vs_TEXCOORD2.y;
    u_xlat2.y = (u_xlatb5.x) ? u_xlat10.x : u_xlat0.x;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlatb0 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat12.xy = u_xlat3.xy + vs_TEXCOORD2.xy;
    u_xlat12.xy = (u_xlatb0.x) ? u_xlat12.xy : u_xlat3.xy;
    u_xlat3 = texture(_NoiseTex, u_xlat12.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat0.x = u_xlatb0.x ? u_xlat3.w : float(0.0);
    u_xlat0.x = (u_xlatb0.w) ? u_xlat3.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.z) ? u_xlat3.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.y) ? u_xlat3.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat5.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.xy;
    u_xlat2 = texture(_BaseTex, u_xlat5.xy);
    u_xlatb5.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(3.0, 4.0, 0.0, 0.0)).xy;
    u_xlat10.x = u_xlatb5.y ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb5.x) ? u_xlat2.z : u_xlat10.x;
    u_xlat5.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat5.x;
    u_xlat5.xyz = (u_xlatb1.y) ? u_xlat2.xyz : u_xlat5.xxx;
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16 = u_xlatb1.w ? u_xlat2.z : float(0.0);
    u_xlat11.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat16;
    u_xlat6 = (u_xlatb1.y) ? u_xlat2.x : u_xlat11.x;
    u_xlat1.x = (u_xlatb1.x) ? u_xlat2.w : u_xlat6;
    u_xlat6 = u_xlat1.x * _BaseTexAlphaBrightness;
    u_xlat11.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.x = _Time.y * _MaskTex_Uspeed + u_xlat11.x;
    u_xlat2.y = _Time.y * _MaskTex_Vspeed + u_xlat11.y;
    u_xlat11.xy = u_xlat0.xx * vec2(vec2(_NoiseIntensityOnMask, _NoiseIntensityOnMask)) + u_xlat2.xy;
    u_xlat2 = texture(_MaskTex, u_xlat11.xy);
    u_xlatb3 = equal(vec4(_MaskTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskTexBrightness;
    u_xlat6 = u_xlat0.x * u_xlat6;
    u_xlatb11.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlat1.x * _BaseTexAlphaBrightness + u_xlat0.x;
    u_xlat0.x = u_xlatb11.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb11.x) ? u_xlat6 : u_xlat0.x;
    u_xlat1.x = _MainColor.w * _AlphaBrightness;
    u_xlat1.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat5.xyz * vec3(_ColorBrightness);
    u_xlat5.xyz = u_xlat5.xyz * vs_COLOR0.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat5.xyz * vec3(_ColorScaler);
    u_xlatb5.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat5.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb1.xy));
    u_xlat5.xy = u_xlat5.xy * u_xlat1.xy;
    u_xlat5.x = u_xlat5.y * u_xlat5.x;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    if(_SmoothMaskType != 0) {
        u_xlatb5.xy = equal(ivec4(_SmoothMaskType), ivec4(1, 2, 0, 0)).xy;
        u_xlatb10 = u_xlatb5.y || u_xlatb5.x;
        if(u_xlatb10){
            u_xlat10.xy = vec2(-abs(vs_TEXCOORD1.z) + float(0.5), -abs(vs_TEXCOORD1.w) + float(0.5));
            u_xlat1.xy = vec2(1.0, 1.0) / _SmoothMaskSoftRanges.xy;
            u_xlat10.xy = u_xlat10.xy * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
            u_xlat10.xy = min(max(u_xlat10.xy, 0.0), 1.0);
#else
            u_xlat10.xy = clamp(u_xlat10.xy, 0.0, 1.0);
#endif
            u_xlat1.xy = u_xlat10.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
            u_xlat10.xy = u_xlat10.xy * u_xlat10.xy;
            u_xlat10.xy = u_xlat10.xy * u_xlat1.xy;
            u_xlat16_4 = u_xlat10.y * u_xlat10.x;
            if(u_xlatb5.x){
                u_xlat5.xy = vec2(vs_TEXCOORD1.z + float(0.5), vs_TEXCOORD1.w + float(0.5));
                u_xlat10_5 = texture(_SmoothMaskTexture, u_xlat5.xy).w;
                u_xlat16_4 = u_xlat10_5 * u_xlat16_4;
                u_xlat16_4 = u_xlat16_4;
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
            u_xlat1.xy = vec2(vs_TEXCOORD1.z * _SmoothMaskSoftRanges.z, vs_TEXCOORD1.w * _SmoothMaskSoftRanges.w);
            u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
            u_xlat1.x = sqrt(u_xlat1.x);
            u_xlat1.x = u_xlat1.x + u_xlat1.x;
            u_xlat16_9 = (u_xlatb15) ? u_xlat1.x : _SmoothMaskSoftRanges.z;
            u_xlat16_9 = float(1.0) / u_xlat16_9;
            u_xlat16_9 = u_xlat10.x * u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
            u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
            u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
            u_xlat16_14 = u_xlat16_9 * -2.0 + 3.0;
            u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
            u_xlat16_9 = u_xlat16_9 * u_xlat16_14;
            u_xlat16_4 = (u_xlatb5.x) ? u_xlat16_9 : 1.0;
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
                    u_xlat1.x = (-u_xlat10.x) + 1.0;
                    u_xlat5.x = (u_xlatb15) ? u_xlat1.x : u_xlat10.x;
                } else {
                    u_xlatb1 = equal(_SmoothMaskFillParams.zzzx, vec4(1.0, 2.0, 3.0, 3.0));
                    u_xlat2 = vec4(vs_TEXCOORD1.w * float(1.0), vs_TEXCOORD1.z * float(-1.0), vs_TEXCOORD1.w * float(-1.0), vs_TEXCOORD1.z * float(1.0));
                    u_xlat10.xy = (u_xlatb1.z) ? u_xlat2.xy : vs_TEXCOORD1.zw;
                    u_xlat10.xy = (u_xlatb1.y) ? (-vs_TEXCOORD1.zw) : u_xlat10.xy;
                    u_xlat1.xy = (u_xlatb1.x) ? u_xlat2.zw : u_xlat10.xy;
                    u_xlat10.xy = u_xlat1.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb2 = !!(_SmoothMaskFillParams.x==4.0);
#else
                    u_xlatb2 = _SmoothMaskFillParams.x==4.0;
#endif
                    u_xlat1.z = (u_xlatb2) ? u_xlat10.y : u_xlat1.y;
                    u_xlat10.xy = (u_xlatb1.w) ? u_xlat10.xy : u_xlat1.xz;
                    u_xlat10.x = u_xlat10.x * _SmoothMaskFillParams.w;
                    u_xlat1.x = min(abs(u_xlat10.y), abs(u_xlat10.x));
                    u_xlat6 = max(abs(u_xlat10.y), abs(u_xlat10.x));
                    u_xlat6 = float(1.0) / u_xlat6;
                    u_xlat1.x = u_xlat6 * u_xlat1.x;
                    u_xlat6 = u_xlat1.x * u_xlat1.x;
                    u_xlat11.x = u_xlat6 * 0.0208350997 + -0.0851330012;
                    u_xlat11.x = u_xlat6 * u_xlat11.x + 0.180141002;
                    u_xlat11.x = u_xlat6 * u_xlat11.x + -0.330299497;
                    u_xlat6 = u_xlat6 * u_xlat11.x + 0.999866009;
                    u_xlat11.x = u_xlat6 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb16 = !!(abs(u_xlat10.y)<abs(u_xlat10.x));
#else
                    u_xlatb16 = abs(u_xlat10.y)<abs(u_xlat10.x);
#endif
                    u_xlat11.x = u_xlat11.x * -2.0 + 1.57079637;
                    u_xlat11.x = u_xlatb16 ? u_xlat11.x : float(0.0);
                    u_xlat1.x = u_xlat1.x * u_xlat6 + u_xlat11.x;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb6 = !!(u_xlat10.y<(-u_xlat10.y));
#else
                    u_xlatb6 = u_xlat10.y<(-u_xlat10.y);
#endif
                    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
                    u_xlat1.x = u_xlat6 + u_xlat1.x;
                    u_xlat6 = min(u_xlat10.y, u_xlat10.x);
                    u_xlat10.x = max(u_xlat10.y, u_xlat10.x);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15 = !!(u_xlat6<(-u_xlat6));
#else
                    u_xlatb15 = u_xlat6<(-u_xlat6);
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb10 = !!(u_xlat10.x>=(-u_xlat10.x));
#else
                    u_xlatb10 = u_xlat10.x>=(-u_xlat10.x);
#endif
                    u_xlatb10 = u_xlatb10 && u_xlatb15;
                    u_xlat10.x = (u_xlatb10) ? (-u_xlat1.x) : u_xlat1.x;
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
            u_xlat4 = u_xlat5.x * u_xlat16_4;
            u_xlat16_4 = u_xlat4;
        //ENDIF
        }
    } else {
        u_xlat16_4 = 1.0;
    //ENDIF
    }
    SV_Target0.w = u_xlat0.x * u_xlat16_4;
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
in highp vec4 in_TEXCOORD1;
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
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy;
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
uniform 	vec4 _Time;
uniform 	int _SmoothMaskType;
uniform 	vec4 _SmoothMaskSoftRanges;
uniform 	vec4 _SmoothMaskFillParams;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _SmoothMaskTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
float u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bvec2 u_xlatb4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat9;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.x = u_xlat0.x + vs_TEXCOORD2.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat8.x : u_xlat0.x;
    u_xlat0.x = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb4.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat8.x = u_xlat0.x + vs_TEXCOORD2.y;
    u_xlat2.y = (u_xlatb4.x) ? u_xlat8.x : u_xlat0.x;
    u_xlat0 = texture(_BaseTex, u_xlat2.xy);
    u_xlatb2.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(3.0, 4.0, 0.0, 0.0)).xy;
    u_xlat1.x = u_xlatb2.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat0.z : float(0.0);
    u_xlat4.x = (u_xlatb2.z) ? u_xlat0.y : u_xlat8.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat4.x = _MainColor.w * _AlphaBrightness;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat4.xyz = u_xlat4.xyz * vs_COLOR0.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat4.xyz * vec3(_ColorScaler);
    u_xlatb4.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat4.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb4.xy));
    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb1.xy));
    u_xlat4.xy = u_xlat4.xy * u_xlat1.xy;
    u_xlat4.x = u_xlat4.y * u_xlat4.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    if(_SmoothMaskType != 0) {
        u_xlatb4.xy = equal(ivec4(_SmoothMaskType), ivec4(1, 2, 0, 0)).xy;
        u_xlatb8 = u_xlatb4.y || u_xlatb4.x;
        if(u_xlatb8){
            u_xlat8.xy = vec2(-abs(vs_TEXCOORD1.z) + float(0.5), -abs(vs_TEXCOORD1.w) + float(0.5));
            u_xlat1.xy = vec2(1.0, 1.0) / _SmoothMaskSoftRanges.xy;
            u_xlat8.xy = u_xlat8.xy * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
            u_xlat8.xy = min(max(u_xlat8.xy, 0.0), 1.0);
#else
            u_xlat8.xy = clamp(u_xlat8.xy, 0.0, 1.0);
#endif
            u_xlat1.xy = u_xlat8.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
            u_xlat8.xy = u_xlat8.xy * u_xlat8.xy;
            u_xlat8.xy = u_xlat8.xy * u_xlat1.xy;
            u_xlat16_3 = u_xlat8.y * u_xlat8.x;
            if(u_xlatb4.x){
                u_xlat4.xy = vec2(vs_TEXCOORD1.z + float(0.5), vs_TEXCOORD1.w + float(0.5));
                u_xlat10_4 = texture(_SmoothMaskTexture, u_xlat4.xy).w;
                u_xlat16_3 = u_xlat10_4 * u_xlat16_3;
                u_xlat16_3 = u_xlat16_3;
            //ENDIF
            }
        } else {
#ifdef UNITY_ADRENO_ES3
            u_xlatb4.x = !!(_SmoothMaskType==3);
#else
            u_xlatb4.x = _SmoothMaskType==3;
#endif
            u_xlat8.x = dot(vs_TEXCOORD1.zw, vs_TEXCOORD1.zw);
            u_xlat8.x = sqrt(u_xlat8.x);
            u_xlat8.x = (-u_xlat8.x) + 0.5;
#ifdef UNITY_ADRENO_ES3
            u_xlatb12 = !!(0.00100000005<_SmoothMaskSoftRanges.w);
#else
            u_xlatb12 = 0.00100000005<_SmoothMaskSoftRanges.w;
#endif
            u_xlat1.xy = vec2(vs_TEXCOORD1.z * _SmoothMaskSoftRanges.z, vs_TEXCOORD1.w * _SmoothMaskSoftRanges.w);
            u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
            u_xlat1.x = sqrt(u_xlat1.x);
            u_xlat1.x = u_xlat1.x + u_xlat1.x;
            u_xlat16_7 = (u_xlatb12) ? u_xlat1.x : _SmoothMaskSoftRanges.z;
            u_xlat16_7 = float(1.0) / u_xlat16_7;
            u_xlat16_7 = u_xlat8.x * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
            u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
            u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
            u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
            u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
            u_xlat16_7 = u_xlat16_7 * u_xlat16_11;
            u_xlat16_3 = (u_xlatb4.x) ? u_xlat16_7 : 1.0;
        //ENDIF
        }
#ifdef UNITY_ADRENO_ES3
        u_xlatb4.x = !!(_SmoothMaskFillParams.x!=0.0);
#else
        u_xlatb4.x = _SmoothMaskFillParams.x!=0.0;
#endif
        if(u_xlatb4.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb4.x = !!(_SmoothMaskFillParams.x==1.0);
#else
            u_xlatb4.x = _SmoothMaskFillParams.x==1.0;
#endif
            if(u_xlatb4.x){
                u_xlat4.x = vs_TEXCOORD1.z + 0.5;
#ifdef UNITY_ADRENO_ES3
                u_xlatb8 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                u_xlatb8 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                u_xlat12 = (-u_xlat4.x) + 1.0;
                u_xlat4.x = (u_xlatb8) ? u_xlat12 : u_xlat4.x;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb8 = !!(_SmoothMaskFillParams.x==2.0);
#else
                u_xlatb8 = _SmoothMaskFillParams.x==2.0;
#endif
                if(u_xlatb8){
                    u_xlat8.x = vs_TEXCOORD1.w + 0.5;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                    u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                    u_xlat1.x = (-u_xlat8.x) + 1.0;
                    u_xlat4.x = (u_xlatb12) ? u_xlat1.x : u_xlat8.x;
                } else {
                    u_xlatb1 = equal(_SmoothMaskFillParams.zzzx, vec4(1.0, 2.0, 3.0, 3.0));
                    u_xlat2 = vec4(vs_TEXCOORD1.w * float(1.0), vs_TEXCOORD1.z * float(-1.0), vs_TEXCOORD1.w * float(-1.0), vs_TEXCOORD1.z * float(1.0));
                    u_xlat8.xy = (u_xlatb1.z) ? u_xlat2.xy : vs_TEXCOORD1.zw;
                    u_xlat8.xy = (u_xlatb1.y) ? (-vs_TEXCOORD1.zw) : u_xlat8.xy;
                    u_xlat1.xy = (u_xlatb1.x) ? u_xlat2.zw : u_xlat8.xy;
                    u_xlat8.xy = u_xlat1.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb2.x = !!(_SmoothMaskFillParams.x==4.0);
#else
                    u_xlatb2.x = _SmoothMaskFillParams.x==4.0;
#endif
                    u_xlat1.z = (u_xlatb2.x) ? u_xlat8.y : u_xlat1.y;
                    u_xlat8.xy = (u_xlatb1.w) ? u_xlat8.xy : u_xlat1.xz;
                    u_xlat8.x = u_xlat8.x * _SmoothMaskFillParams.w;
                    u_xlat1.x = min(abs(u_xlat8.y), abs(u_xlat8.x));
                    u_xlat5 = max(abs(u_xlat8.y), abs(u_xlat8.x));
                    u_xlat5 = float(1.0) / u_xlat5;
                    u_xlat1.x = u_xlat5 * u_xlat1.x;
                    u_xlat5 = u_xlat1.x * u_xlat1.x;
                    u_xlat9 = u_xlat5 * 0.0208350997 + -0.0851330012;
                    u_xlat9 = u_xlat5 * u_xlat9 + 0.180141002;
                    u_xlat9 = u_xlat5 * u_xlat9 + -0.330299497;
                    u_xlat5 = u_xlat5 * u_xlat9 + 0.999866009;
                    u_xlat9 = u_xlat5 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb13 = !!(abs(u_xlat8.y)<abs(u_xlat8.x));
#else
                    u_xlatb13 = abs(u_xlat8.y)<abs(u_xlat8.x);
#endif
                    u_xlat9 = u_xlat9 * -2.0 + 1.57079637;
                    u_xlat9 = u_xlatb13 ? u_xlat9 : float(0.0);
                    u_xlat1.x = u_xlat1.x * u_xlat5 + u_xlat9;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb5 = !!(u_xlat8.y<(-u_xlat8.y));
#else
                    u_xlatb5 = u_xlat8.y<(-u_xlat8.y);
#endif
                    u_xlat5 = u_xlatb5 ? -3.14159274 : float(0.0);
                    u_xlat1.x = u_xlat5 + u_xlat1.x;
                    u_xlat5 = min(u_xlat8.y, u_xlat8.x);
                    u_xlat8.x = max(u_xlat8.y, u_xlat8.x);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb12 = !!(u_xlat5<(-u_xlat5));
#else
                    u_xlatb12 = u_xlat5<(-u_xlat5);
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb8 = !!(u_xlat8.x>=(-u_xlat8.x));
#else
                    u_xlatb8 = u_xlat8.x>=(-u_xlat8.x);
#endif
                    u_xlatb8 = u_xlatb8 && u_xlatb12;
                    u_xlat8.x = (u_xlatb8) ? (-u_xlat1.x) : u_xlat1.x;
                    u_xlat4.x = u_xlat8.x * 0.159154996 + 0.5;
                //ENDIF
                }
            //ENDIF
            }
#ifdef UNITY_ADRENO_ES3
            u_xlatb4.x = !!(_SmoothMaskFillParams.y>=u_xlat4.x);
#else
            u_xlatb4.x = _SmoothMaskFillParams.y>=u_xlat4.x;
#endif
            u_xlat4.x = u_xlatb4.x ? 1.0 : float(0.0);
            u_xlat3 = u_xlat4.x * u_xlat16_3;
            u_xlat16_3 = u_xlat3;
        //ENDIF
        }
    } else {
        u_xlat16_3 = 1.0;
    //ENDIF
    }
    u_xlat16_7 = u_xlat0.x * u_xlat16_3;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3 + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = u_xlat16_7;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_SMOOTHMASK" "UNITY_UI_ALPHACLIP" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_SmoothMaskTransform[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
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
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy;
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
uniform 	vec4 _Time;
uniform 	int _SmoothMaskType;
uniform 	vec4 _SmoothMaskSoftRanges;
uniform 	vec4 _SmoothMaskFillParams;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _SmoothMaskTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
float u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat5;
lowp float u_xlat10_5;
bvec2 u_xlatb5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat11;
mediump float u_xlat16_14;
float u_xlat15;
bool u_xlatb15;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.x = u_xlat0.x + vs_TEXCOORD2.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat10.x : u_xlat0.x;
    u_xlat0.x = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb5.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat10.x = u_xlat0.x + vs_TEXCOORD2.y;
    u_xlat2.y = (u_xlatb5.x) ? u_xlat10.x : u_xlat0.x;
    u_xlat0 = texture(_BaseTex, u_xlat2.xy);
    u_xlatb2.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(3.0, 4.0, 0.0, 0.0)).xy;
    u_xlat1.x = u_xlatb2.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb2.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb2.z) ? u_xlat0.y : u_xlat10.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat5.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat10.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.x = _Time.y * _MaskTex_Uspeed + u_xlat10.x;
    u_xlat2.y = _Time.y * _MaskTex_Vspeed + u_xlat10.y;
    u_xlat2 = texture(_MaskTex, u_xlat2.xy);
    u_xlatb3 = equal(vec4(_MaskTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat10.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat10.x;
    u_xlat10.x = u_xlat10.x * _MaskTexBrightness;
    u_xlat5.x = u_xlat10.x * u_xlat5.x;
    u_xlatb2.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat10.x;
    u_xlat0.x = u_xlatb2.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb2.x) ? u_xlat5.x : u_xlat0.x;
    u_xlat5.x = _MainColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat5.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat5.xyz = u_xlat5.xyz * vs_COLOR0.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat5.xyz * vec3(_ColorScaler);
    u_xlatb5.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat5.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb1.xy));
    u_xlat5.xy = u_xlat5.xy * u_xlat1.xy;
    u_xlat5.x = u_xlat5.y * u_xlat5.x;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    if(_SmoothMaskType != 0) {
        u_xlatb5.xy = equal(ivec4(_SmoothMaskType), ivec4(1, 2, 0, 0)).xy;
        u_xlatb10 = u_xlatb5.y || u_xlatb5.x;
        if(u_xlatb10){
            u_xlat10.xy = vec2(-abs(vs_TEXCOORD1.z) + float(0.5), -abs(vs_TEXCOORD1.w) + float(0.5));
            u_xlat1.xy = vec2(1.0, 1.0) / _SmoothMaskSoftRanges.xy;
            u_xlat10.xy = u_xlat10.xy * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
            u_xlat10.xy = min(max(u_xlat10.xy, 0.0), 1.0);
#else
            u_xlat10.xy = clamp(u_xlat10.xy, 0.0, 1.0);
#endif
            u_xlat1.xy = u_xlat10.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
            u_xlat10.xy = u_xlat10.xy * u_xlat10.xy;
            u_xlat10.xy = u_xlat10.xy * u_xlat1.xy;
            u_xlat16_4 = u_xlat10.y * u_xlat10.x;
            if(u_xlatb5.x){
                u_xlat5.xy = vec2(vs_TEXCOORD1.z + float(0.5), vs_TEXCOORD1.w + float(0.5));
                u_xlat10_5 = texture(_SmoothMaskTexture, u_xlat5.xy).w;
                u_xlat16_4 = u_xlat10_5 * u_xlat16_4;
                u_xlat16_4 = u_xlat16_4;
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
            u_xlat1.xy = vec2(vs_TEXCOORD1.z * _SmoothMaskSoftRanges.z, vs_TEXCOORD1.w * _SmoothMaskSoftRanges.w);
            u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
            u_xlat1.x = sqrt(u_xlat1.x);
            u_xlat1.x = u_xlat1.x + u_xlat1.x;
            u_xlat16_9 = (u_xlatb15) ? u_xlat1.x : _SmoothMaskSoftRanges.z;
            u_xlat16_9 = float(1.0) / u_xlat16_9;
            u_xlat16_9 = u_xlat10.x * u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
            u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
            u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
            u_xlat16_14 = u_xlat16_9 * -2.0 + 3.0;
            u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
            u_xlat16_9 = u_xlat16_9 * u_xlat16_14;
            u_xlat16_4 = (u_xlatb5.x) ? u_xlat16_9 : 1.0;
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
                    u_xlat1.x = (-u_xlat10.x) + 1.0;
                    u_xlat5.x = (u_xlatb15) ? u_xlat1.x : u_xlat10.x;
                } else {
                    u_xlatb1 = equal(_SmoothMaskFillParams.zzzx, vec4(1.0, 2.0, 3.0, 3.0));
                    u_xlat2 = vec4(vs_TEXCOORD1.w * float(1.0), vs_TEXCOORD1.z * float(-1.0), vs_TEXCOORD1.w * float(-1.0), vs_TEXCOORD1.z * float(1.0));
                    u_xlat10.xy = (u_xlatb1.z) ? u_xlat2.xy : vs_TEXCOORD1.zw;
                    u_xlat10.xy = (u_xlatb1.y) ? (-vs_TEXCOORD1.zw) : u_xlat10.xy;
                    u_xlat1.xy = (u_xlatb1.x) ? u_xlat2.zw : u_xlat10.xy;
                    u_xlat10.xy = u_xlat1.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb2.x = !!(_SmoothMaskFillParams.x==4.0);
#else
                    u_xlatb2.x = _SmoothMaskFillParams.x==4.0;
#endif
                    u_xlat1.z = (u_xlatb2.x) ? u_xlat10.y : u_xlat1.y;
                    u_xlat10.xy = (u_xlatb1.w) ? u_xlat10.xy : u_xlat1.xz;
                    u_xlat10.x = u_xlat10.x * _SmoothMaskFillParams.w;
                    u_xlat1.x = min(abs(u_xlat10.y), abs(u_xlat10.x));
                    u_xlat6 = max(abs(u_xlat10.y), abs(u_xlat10.x));
                    u_xlat6 = float(1.0) / u_xlat6;
                    u_xlat1.x = u_xlat6 * u_xlat1.x;
                    u_xlat6 = u_xlat1.x * u_xlat1.x;
                    u_xlat11 = u_xlat6 * 0.0208350997 + -0.0851330012;
                    u_xlat11 = u_xlat6 * u_xlat11 + 0.180141002;
                    u_xlat11 = u_xlat6 * u_xlat11 + -0.330299497;
                    u_xlat6 = u_xlat6 * u_xlat11 + 0.999866009;
                    u_xlat11 = u_xlat6 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb16 = !!(abs(u_xlat10.y)<abs(u_xlat10.x));
#else
                    u_xlatb16 = abs(u_xlat10.y)<abs(u_xlat10.x);
#endif
                    u_xlat11 = u_xlat11 * -2.0 + 1.57079637;
                    u_xlat11 = u_xlatb16 ? u_xlat11 : float(0.0);
                    u_xlat1.x = u_xlat1.x * u_xlat6 + u_xlat11;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb6 = !!(u_xlat10.y<(-u_xlat10.y));
#else
                    u_xlatb6 = u_xlat10.y<(-u_xlat10.y);
#endif
                    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
                    u_xlat1.x = u_xlat6 + u_xlat1.x;
                    u_xlat6 = min(u_xlat10.y, u_xlat10.x);
                    u_xlat10.x = max(u_xlat10.y, u_xlat10.x);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15 = !!(u_xlat6<(-u_xlat6));
#else
                    u_xlatb15 = u_xlat6<(-u_xlat6);
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb10 = !!(u_xlat10.x>=(-u_xlat10.x));
#else
                    u_xlatb10 = u_xlat10.x>=(-u_xlat10.x);
#endif
                    u_xlatb10 = u_xlatb10 && u_xlatb15;
                    u_xlat10.x = (u_xlatb10) ? (-u_xlat1.x) : u_xlat1.x;
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
            u_xlat4 = u_xlat5.x * u_xlat16_4;
            u_xlat16_4 = u_xlat4;
        //ENDIF
        }
    } else {
        u_xlat16_4 = 1.0;
    //ENDIF
    }
    u_xlat16_9 = u_xlat0.x * u_xlat16_4;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4 + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4<0.0);
#else
    u_xlatb0 = u_xlat16_4<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = u_xlat16_9;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_SMOOTHMASK" "UNITY_UI_ALPHACLIP" "_NOISETEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_SmoothMaskTransform[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
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
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy;
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
uniform 	vec4 _Time;
uniform 	int _SmoothMaskType;
uniform 	vec4 _SmoothMaskSoftRanges;
uniform 	vec4 _SmoothMaskFillParams;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _SmoothMaskTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
float u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat5;
lowp float u_xlat10_5;
bvec2 u_xlatb5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat11;
vec2 u_xlat12;
mediump float u_xlat16_14;
float u_xlat15;
bool u_xlatb15;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.x = u_xlat0.x + vs_TEXCOORD2.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat10.x : u_xlat0.x;
    u_xlat0.x = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb5.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat10.x = u_xlat0.x + vs_TEXCOORD2.y;
    u_xlat2.y = (u_xlatb5.x) ? u_xlat10.x : u_xlat0.x;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlatb0 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat12.xy = u_xlat3.xy + vs_TEXCOORD2.xy;
    u_xlat12.xy = (u_xlatb0.x) ? u_xlat12.xy : u_xlat3.xy;
    u_xlat3 = texture(_NoiseTex, u_xlat12.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat0.x = u_xlatb0.x ? u_xlat3.w : float(0.0);
    u_xlat0.x = (u_xlatb0.w) ? u_xlat3.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.z) ? u_xlat3.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.y) ? u_xlat3.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat0.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.xy;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
    u_xlatb2.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(3.0, 4.0, 0.0, 0.0)).xy;
    u_xlat1.x = u_xlatb2.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb2.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb2.z) ? u_xlat0.y : u_xlat10.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat5.x = _MainColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat5.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat5.xyz = u_xlat5.xyz * vs_COLOR0.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat5.xyz * vec3(_ColorScaler);
    u_xlatb5.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat5.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb1.xy));
    u_xlat5.xy = u_xlat5.xy * u_xlat1.xy;
    u_xlat5.x = u_xlat5.y * u_xlat5.x;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    if(_SmoothMaskType != 0) {
        u_xlatb5.xy = equal(ivec4(_SmoothMaskType), ivec4(1, 2, 0, 0)).xy;
        u_xlatb10 = u_xlatb5.y || u_xlatb5.x;
        if(u_xlatb10){
            u_xlat10.xy = vec2(-abs(vs_TEXCOORD1.z) + float(0.5), -abs(vs_TEXCOORD1.w) + float(0.5));
            u_xlat1.xy = vec2(1.0, 1.0) / _SmoothMaskSoftRanges.xy;
            u_xlat10.xy = u_xlat10.xy * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
            u_xlat10.xy = min(max(u_xlat10.xy, 0.0), 1.0);
#else
            u_xlat10.xy = clamp(u_xlat10.xy, 0.0, 1.0);
#endif
            u_xlat1.xy = u_xlat10.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
            u_xlat10.xy = u_xlat10.xy * u_xlat10.xy;
            u_xlat10.xy = u_xlat10.xy * u_xlat1.xy;
            u_xlat16_4 = u_xlat10.y * u_xlat10.x;
            if(u_xlatb5.x){
                u_xlat5.xy = vec2(vs_TEXCOORD1.z + float(0.5), vs_TEXCOORD1.w + float(0.5));
                u_xlat10_5 = texture(_SmoothMaskTexture, u_xlat5.xy).w;
                u_xlat16_4 = u_xlat10_5 * u_xlat16_4;
                u_xlat16_4 = u_xlat16_4;
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
            u_xlat1.xy = vec2(vs_TEXCOORD1.z * _SmoothMaskSoftRanges.z, vs_TEXCOORD1.w * _SmoothMaskSoftRanges.w);
            u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
            u_xlat1.x = sqrt(u_xlat1.x);
            u_xlat1.x = u_xlat1.x + u_xlat1.x;
            u_xlat16_9 = (u_xlatb15) ? u_xlat1.x : _SmoothMaskSoftRanges.z;
            u_xlat16_9 = float(1.0) / u_xlat16_9;
            u_xlat16_9 = u_xlat10.x * u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
            u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
            u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
            u_xlat16_14 = u_xlat16_9 * -2.0 + 3.0;
            u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
            u_xlat16_9 = u_xlat16_9 * u_xlat16_14;
            u_xlat16_4 = (u_xlatb5.x) ? u_xlat16_9 : 1.0;
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
                    u_xlat1.x = (-u_xlat10.x) + 1.0;
                    u_xlat5.x = (u_xlatb15) ? u_xlat1.x : u_xlat10.x;
                } else {
                    u_xlatb1 = equal(_SmoothMaskFillParams.zzzx, vec4(1.0, 2.0, 3.0, 3.0));
                    u_xlat2 = vec4(vs_TEXCOORD1.w * float(1.0), vs_TEXCOORD1.z * float(-1.0), vs_TEXCOORD1.w * float(-1.0), vs_TEXCOORD1.z * float(1.0));
                    u_xlat10.xy = (u_xlatb1.z) ? u_xlat2.xy : vs_TEXCOORD1.zw;
                    u_xlat10.xy = (u_xlatb1.y) ? (-vs_TEXCOORD1.zw) : u_xlat10.xy;
                    u_xlat1.xy = (u_xlatb1.x) ? u_xlat2.zw : u_xlat10.xy;
                    u_xlat10.xy = u_xlat1.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb2.x = !!(_SmoothMaskFillParams.x==4.0);
#else
                    u_xlatb2.x = _SmoothMaskFillParams.x==4.0;
#endif
                    u_xlat1.z = (u_xlatb2.x) ? u_xlat10.y : u_xlat1.y;
                    u_xlat10.xy = (u_xlatb1.w) ? u_xlat10.xy : u_xlat1.xz;
                    u_xlat10.x = u_xlat10.x * _SmoothMaskFillParams.w;
                    u_xlat1.x = min(abs(u_xlat10.y), abs(u_xlat10.x));
                    u_xlat6 = max(abs(u_xlat10.y), abs(u_xlat10.x));
                    u_xlat6 = float(1.0) / u_xlat6;
                    u_xlat1.x = u_xlat6 * u_xlat1.x;
                    u_xlat6 = u_xlat1.x * u_xlat1.x;
                    u_xlat11 = u_xlat6 * 0.0208350997 + -0.0851330012;
                    u_xlat11 = u_xlat6 * u_xlat11 + 0.180141002;
                    u_xlat11 = u_xlat6 * u_xlat11 + -0.330299497;
                    u_xlat6 = u_xlat6 * u_xlat11 + 0.999866009;
                    u_xlat11 = u_xlat6 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb16 = !!(abs(u_xlat10.y)<abs(u_xlat10.x));
#else
                    u_xlatb16 = abs(u_xlat10.y)<abs(u_xlat10.x);
#endif
                    u_xlat11 = u_xlat11 * -2.0 + 1.57079637;
                    u_xlat11 = u_xlatb16 ? u_xlat11 : float(0.0);
                    u_xlat1.x = u_xlat1.x * u_xlat6 + u_xlat11;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb6 = !!(u_xlat10.y<(-u_xlat10.y));
#else
                    u_xlatb6 = u_xlat10.y<(-u_xlat10.y);
#endif
                    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
                    u_xlat1.x = u_xlat6 + u_xlat1.x;
                    u_xlat6 = min(u_xlat10.y, u_xlat10.x);
                    u_xlat10.x = max(u_xlat10.y, u_xlat10.x);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15 = !!(u_xlat6<(-u_xlat6));
#else
                    u_xlatb15 = u_xlat6<(-u_xlat6);
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb10 = !!(u_xlat10.x>=(-u_xlat10.x));
#else
                    u_xlatb10 = u_xlat10.x>=(-u_xlat10.x);
#endif
                    u_xlatb10 = u_xlatb10 && u_xlatb15;
                    u_xlat10.x = (u_xlatb10) ? (-u_xlat1.x) : u_xlat1.x;
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
            u_xlat4 = u_xlat5.x * u_xlat16_4;
            u_xlat16_4 = u_xlat4;
        //ENDIF
        }
    } else {
        u_xlat16_4 = 1.0;
    //ENDIF
    }
    u_xlat16_9 = u_xlat0.x * u_xlat16_4;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4 + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_4<0.0);
#else
    u_xlatb0.x = u_xlat16_4<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = u_xlat16_9;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_SMOOTHMASK" "UNITY_UI_ALPHACLIP" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_SmoothMaskTransform[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
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
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy;
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
uniform 	vec4 _Time;
uniform 	int _SmoothMaskType;
uniform 	vec4 _SmoothMaskSoftRanges;
uniform 	vec4 _SmoothMaskFillParams;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _SmoothMaskTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec4 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
float u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat5;
lowp float u_xlat10_5;
bvec2 u_xlatb5;
float u_xlat6;
bool u_xlatb6;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
vec2 u_xlat11;
bvec2 u_xlatb11;
vec2 u_xlat12;
mediump float u_xlat16_14;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.x = u_xlat0.x + vs_TEXCOORD2.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat10.x : u_xlat0.x;
    u_xlat0.x = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb5.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat10.x = u_xlat0.x + vs_TEXCOORD2.y;
    u_xlat2.y = (u_xlatb5.x) ? u_xlat10.x : u_xlat0.x;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlatb0 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat12.xy = u_xlat3.xy + vs_TEXCOORD2.xy;
    u_xlat12.xy = (u_xlatb0.x) ? u_xlat12.xy : u_xlat3.xy;
    u_xlat3 = texture(_NoiseTex, u_xlat12.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat0.x = u_xlatb0.x ? u_xlat3.w : float(0.0);
    u_xlat0.x = (u_xlatb0.w) ? u_xlat3.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.z) ? u_xlat3.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.y) ? u_xlat3.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat5.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.xy;
    u_xlat2 = texture(_BaseTex, u_xlat5.xy);
    u_xlatb5.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(3.0, 4.0, 0.0, 0.0)).xy;
    u_xlat10.x = u_xlatb5.y ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb5.x) ? u_xlat2.z : u_xlat10.x;
    u_xlat5.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat5.x;
    u_xlat5.xyz = (u_xlatb1.y) ? u_xlat2.xyz : u_xlat5.xxx;
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16 = u_xlatb1.w ? u_xlat2.z : float(0.0);
    u_xlat11.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat16;
    u_xlat6 = (u_xlatb1.y) ? u_xlat2.x : u_xlat11.x;
    u_xlat1.x = (u_xlatb1.x) ? u_xlat2.w : u_xlat6;
    u_xlat6 = u_xlat1.x * _BaseTexAlphaBrightness;
    u_xlat11.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.x = _Time.y * _MaskTex_Uspeed + u_xlat11.x;
    u_xlat2.y = _Time.y * _MaskTex_Vspeed + u_xlat11.y;
    u_xlat11.xy = u_xlat0.xx * vec2(vec2(_NoiseIntensityOnMask, _NoiseIntensityOnMask)) + u_xlat2.xy;
    u_xlat2 = texture(_MaskTex, u_xlat11.xy);
    u_xlatb3 = equal(vec4(_MaskTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskTexBrightness;
    u_xlat6 = u_xlat0.x * u_xlat6;
    u_xlatb11.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlat1.x * _BaseTexAlphaBrightness + u_xlat0.x;
    u_xlat0.x = u_xlatb11.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb11.x) ? u_xlat6 : u_xlat0.x;
    u_xlat1.x = _MainColor.w * _AlphaBrightness;
    u_xlat1.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat5.xyz * vec3(_ColorBrightness);
    u_xlat5.xyz = u_xlat5.xyz * vs_COLOR0.xyz;
    u_xlat5.xyz = u_xlat5.xyz * _MainColor.xyz;
    SV_Target0.xyz = u_xlat5.xyz * vec3(_ColorScaler);
    u_xlatb5.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat5.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb5.xy));
    u_xlatb1.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat1.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb1.xy));
    u_xlat5.xy = u_xlat5.xy * u_xlat1.xy;
    u_xlat5.x = u_xlat5.y * u_xlat5.x;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    if(_SmoothMaskType != 0) {
        u_xlatb5.xy = equal(ivec4(_SmoothMaskType), ivec4(1, 2, 0, 0)).xy;
        u_xlatb10 = u_xlatb5.y || u_xlatb5.x;
        if(u_xlatb10){
            u_xlat10.xy = vec2(-abs(vs_TEXCOORD1.z) + float(0.5), -abs(vs_TEXCOORD1.w) + float(0.5));
            u_xlat1.xy = vec2(1.0, 1.0) / _SmoothMaskSoftRanges.xy;
            u_xlat10.xy = u_xlat10.xy * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
            u_xlat10.xy = min(max(u_xlat10.xy, 0.0), 1.0);
#else
            u_xlat10.xy = clamp(u_xlat10.xy, 0.0, 1.0);
#endif
            u_xlat1.xy = u_xlat10.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
            u_xlat10.xy = u_xlat10.xy * u_xlat10.xy;
            u_xlat10.xy = u_xlat10.xy * u_xlat1.xy;
            u_xlat16_4 = u_xlat10.y * u_xlat10.x;
            if(u_xlatb5.x){
                u_xlat5.xy = vec2(vs_TEXCOORD1.z + float(0.5), vs_TEXCOORD1.w + float(0.5));
                u_xlat10_5 = texture(_SmoothMaskTexture, u_xlat5.xy).w;
                u_xlat16_4 = u_xlat10_5 * u_xlat16_4;
                u_xlat16_4 = u_xlat16_4;
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
            u_xlat1.xy = vec2(vs_TEXCOORD1.z * _SmoothMaskSoftRanges.z, vs_TEXCOORD1.w * _SmoothMaskSoftRanges.w);
            u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
            u_xlat1.x = sqrt(u_xlat1.x);
            u_xlat1.x = u_xlat1.x + u_xlat1.x;
            u_xlat16_9 = (u_xlatb15) ? u_xlat1.x : _SmoothMaskSoftRanges.z;
            u_xlat16_9 = float(1.0) / u_xlat16_9;
            u_xlat16_9 = u_xlat10.x * u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
            u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
            u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
            u_xlat16_14 = u_xlat16_9 * -2.0 + 3.0;
            u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
            u_xlat16_9 = u_xlat16_9 * u_xlat16_14;
            u_xlat16_4 = (u_xlatb5.x) ? u_xlat16_9 : 1.0;
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
                    u_xlat1.x = (-u_xlat10.x) + 1.0;
                    u_xlat5.x = (u_xlatb15) ? u_xlat1.x : u_xlat10.x;
                } else {
                    u_xlatb1 = equal(_SmoothMaskFillParams.zzzx, vec4(1.0, 2.0, 3.0, 3.0));
                    u_xlat2 = vec4(vs_TEXCOORD1.w * float(1.0), vs_TEXCOORD1.z * float(-1.0), vs_TEXCOORD1.w * float(-1.0), vs_TEXCOORD1.z * float(1.0));
                    u_xlat10.xy = (u_xlatb1.z) ? u_xlat2.xy : vs_TEXCOORD1.zw;
                    u_xlat10.xy = (u_xlatb1.y) ? (-vs_TEXCOORD1.zw) : u_xlat10.xy;
                    u_xlat1.xy = (u_xlatb1.x) ? u_xlat2.zw : u_xlat10.xy;
                    u_xlat10.xy = u_xlat1.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb2 = !!(_SmoothMaskFillParams.x==4.0);
#else
                    u_xlatb2 = _SmoothMaskFillParams.x==4.0;
#endif
                    u_xlat1.z = (u_xlatb2) ? u_xlat10.y : u_xlat1.y;
                    u_xlat10.xy = (u_xlatb1.w) ? u_xlat10.xy : u_xlat1.xz;
                    u_xlat10.x = u_xlat10.x * _SmoothMaskFillParams.w;
                    u_xlat1.x = min(abs(u_xlat10.y), abs(u_xlat10.x));
                    u_xlat6 = max(abs(u_xlat10.y), abs(u_xlat10.x));
                    u_xlat6 = float(1.0) / u_xlat6;
                    u_xlat1.x = u_xlat6 * u_xlat1.x;
                    u_xlat6 = u_xlat1.x * u_xlat1.x;
                    u_xlat11.x = u_xlat6 * 0.0208350997 + -0.0851330012;
                    u_xlat11.x = u_xlat6 * u_xlat11.x + 0.180141002;
                    u_xlat11.x = u_xlat6 * u_xlat11.x + -0.330299497;
                    u_xlat6 = u_xlat6 * u_xlat11.x + 0.999866009;
                    u_xlat11.x = u_xlat6 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb16 = !!(abs(u_xlat10.y)<abs(u_xlat10.x));
#else
                    u_xlatb16 = abs(u_xlat10.y)<abs(u_xlat10.x);
#endif
                    u_xlat11.x = u_xlat11.x * -2.0 + 1.57079637;
                    u_xlat11.x = u_xlatb16 ? u_xlat11.x : float(0.0);
                    u_xlat1.x = u_xlat1.x * u_xlat6 + u_xlat11.x;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb6 = !!(u_xlat10.y<(-u_xlat10.y));
#else
                    u_xlatb6 = u_xlat10.y<(-u_xlat10.y);
#endif
                    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
                    u_xlat1.x = u_xlat6 + u_xlat1.x;
                    u_xlat6 = min(u_xlat10.y, u_xlat10.x);
                    u_xlat10.x = max(u_xlat10.y, u_xlat10.x);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15 = !!(u_xlat6<(-u_xlat6));
#else
                    u_xlatb15 = u_xlat6<(-u_xlat6);
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb10 = !!(u_xlat10.x>=(-u_xlat10.x));
#else
                    u_xlatb10 = u_xlat10.x>=(-u_xlat10.x);
#endif
                    u_xlatb10 = u_xlatb10 && u_xlatb15;
                    u_xlat10.x = (u_xlatb10) ? (-u_xlat1.x) : u_xlat1.x;
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
            u_xlat4 = u_xlat5.x * u_xlat16_4;
            u_xlat16_4 = u_xlat4;
        //ENDIF
        }
    } else {
        u_xlat16_4 = 1.0;
    //ENDIF
    }
    u_xlat16_9 = u_xlat0.x * u_xlat16_4;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4 + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_4<0.0);
#else
    u_xlatb0.x = u_xlat16_4<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
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
Keywords { "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_ALPHACLIP" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_ALPHACLIP" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_ALPHACLIP" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_SMOOTHMASK" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_SMOOTHMASK" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_SMOOTHMASK" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_SMOOTHMASK" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_SMOOTHMASK" "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_SMOOTHMASK" "UNITY_UI_ALPHACLIP" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_SMOOTHMASK" "UNITY_UI_ALPHACLIP" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_SMOOTHMASK" "UNITY_UI_ALPHACLIP" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}