//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/UI/UI_Minimap_UV_Noise" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_ColorScaler ("Color Scaler", Float) = 1
[Header(ASE Properties)] _MainColor ("MainColor", Color) = (1,1,1,1)
_ColorBrightness ("ColorBrightness", Float) = 1
_ColorPower ("ColorPower", Range(0, 1)) = 1
_BaseTex ("BaseTex", 2D) = "bump" { }
[Enum(RGB,0,R,1,G,2,B,3,A,4)] _BaseTexColorChannelSwitch ("BaseTexColorChannelSwitch", Float) = 1
[Enum(A,0,R,1,G,2,B,3)] _BaseTexAlphaChannelSwitch ("BaseTexAlphaChannelSwitch", Float) = 0
_BaseTexAlphaBrightness ("BaseTexAlphaBrightness", Float) = 1
_BaseTex_Uspeed ("BaseTex_Uspeed", Float) = 1
_BaseTex_Vspeed ("BaseTex_Vspeed", Float) = 1
_NoiseTex ("NoiseTex", 2D) = "white" { }
[Enum(R,0,G,1)] _NoiseTexChannelSwitch ("NoiseTexChannelSwitch", Float) = 0
_NoiseTex_Uspeed ("NoiseTex_Uspeed", Float) = 1
_NoiseTex_Vspeed ("NoiseTex_Vspeed", Float) = 1
_Noise_OnBaseTex ("Noise_OnBaseTex", Range(0, 1)) = 1
_Noise_OnImage ("Noise_OnImage", Range(0, 1)) = 0
_Noise_OnMask ("Noise_OnMask", Range(0, 1)) = 0
_Noise_Offset ("Noise_Offset", Float) = 0
_MaskTex ("MaskTex", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _MaskTexChannelSwitch ("MaskTexChannelSwitch", Float) = 2
_MaskTexBrightness ("MaskTexBrightness", Float) = 1
_MaskTex_Uspeed ("MaskTex_Uspeed", Float) = 0
_MaskTex_Vspeed ("MaskTex_Vspeed", Float) = 0
[Toggle(_IMAGEALPHAORBASETEXSWITCH_ON)] _ImageAlphaOrBaseTexSwitch ("ImageAlphaOrBaseTexSwitch", Float) = 0
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
  GpuProgramID 21906
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_OnBaseTex;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _Noise_OnMask;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _ColorPower;
uniform 	vec4 _MainColor;
uniform 	mediump float _Noise_OnImage;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
bvec2 u_xlatb10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = texture(_NoiseTex, u_xlat1.xy).xy;
    u_xlatb10.xy = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat5.x = u_xlatb10.y ? u_xlat0.y : float(0.0);
    u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat16_2.xy = vec2(vec2(_Noise_OnBaseTex, _Noise_OnBaseTex)) * u_xlat0.xx + u_xlat1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_2.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb5 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat5.x = u_xlatb5 ? u_xlat1.w : float(0.0);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat5.x;
    u_xlat5.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat5.xxx;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat1.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat1.y;
    u_xlat1.xy = u_xlat0.xx * vec2(vec2(_Noise_OnMask, _Noise_OnMask)) + u_xlat3.xy;
    u_xlat16_4.xy = u_xlat0.xx * vec2(_Noise_OnImage) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat16_4.xy).w;
    u_xlat16_4.x = u_xlat10_0 * vs_COLOR0.w;
    u_xlat16_4.x = u_xlat16_4.x * _MainColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskTexBrightness;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorPower);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(_ColorScaler);
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_4.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_IMAGEALPHAORBASETEXSWITCH_ON" }
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_OnBaseTex;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _Noise_OnMask;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _ColorPower;
uniform 	vec4 _MainColor;
uniform 	mediump float _Noise_OnImage;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec2 u_xlat2;
bvec4 u_xlatb2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
lowp float u_xlat10_4;
vec2 u_xlat8;
mediump vec2 u_xlat16_11;
float u_xlat12;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat4.y;
    u_xlat4.xy = texture(_NoiseTex, u_xlat1.xy).xy;
    u_xlatb1.xy = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat8.x = u_xlatb1.y ? u_xlat4.y : float(0.0);
    u_xlat4.x = (u_xlatb1.x) ? u_xlat4.x : u_xlat8.x;
    u_xlat4.x = u_xlat4.x + _Noise_Offset;
    u_xlat8.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _MaskTex_Vspeed + u_xlat8.y;
    u_xlat8.xy = u_xlat4.xx * vec2(vec2(_Noise_OnMask, _Noise_OnMask)) + u_xlat1.xy;
    u_xlat1 = texture(_MaskTex, u_xlat8.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x * _MaskTexBrightness;
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2.x = _Time.y * _BaseTex_Uspeed + u_xlat1.x;
    u_xlat2.y = _Time.y * _BaseTex_Vspeed + u_xlat1.y;
    u_xlat16_3.xy = vec2(vec2(_Noise_OnBaseTex, _Noise_OnBaseTex)) * u_xlat4.xx + u_xlat2.xy;
    u_xlat16_11.xy = u_xlat4.xx * vec2(_Noise_OnImage) + vs_TEXCOORD0.xy;
    u_xlat10_4 = texture(_MainTex, u_xlat16_11.xy).w;
    u_xlat1 = texture(_BaseTex, u_xlat16_3.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat12 = (u_xlatb2.z) ? u_xlat1.y : u_xlat12;
    u_xlat12 = (u_xlatb2.y) ? u_xlat1.x : u_xlat12;
    u_xlat12 = (u_xlatb2.x) ? u_xlat1.w : u_xlat12;
    u_xlat12 = u_xlat12 * _BaseTexAlphaBrightness;
    u_xlat12 = u_xlat8.x * u_xlat12;
    u_xlat12 = u_xlat12 * _MainColor.w;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat16_3.x = u_xlat10_4 * u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb0.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0.x ? u_xlat1.w : float(0.0);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyw = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlat0.xyz = u_xlat8.xxx * u_xlat0.xyw;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorPower);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_OnBaseTex;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _Noise_OnMask;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _ColorPower;
uniform 	vec4 _MainColor;
uniform 	mediump float _Noise_OnImage;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec2 u_xlatb1;
mediump vec2 u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
mediump float u_xlat16_6;
float u_xlat8;
lowp float u_xlat10_8;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat4.y;
    u_xlat4.xy = texture(_NoiseTex, u_xlat1.xy).xy;
    u_xlatb1.xy = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat8 = u_xlatb1.y ? u_xlat4.y : float(0.0);
    u_xlat4.x = (u_xlatb1.x) ? u_xlat4.x : u_xlat8;
    u_xlat4.x = u_xlat4.x + _Noise_Offset;
    u_xlat16_2.xy = u_xlat4.xx * vec2(_Noise_OnImage) + vs_TEXCOORD0.xy;
    u_xlat10_8 = texture(_MainTex, u_xlat16_2.xy).w;
    u_xlat16_2.x = u_xlat10_8 * vs_COLOR0.w;
    u_xlat16_2.x = u_xlat16_2.x * _MainColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_2.x * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.x;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_6<0.0);
#else
    u_xlatb0.x = u_xlat16_6<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.z;
    u_xlat16_2.xy = vec2(vec2(_Noise_OnBaseTex, _Noise_OnBaseTex)) * u_xlat4.xx + u_xlat1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_2.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb0.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0.x ? u_xlat1.w : float(0.0);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xzw = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat1.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat1.y;
    u_xlat1.xy = u_xlat4.xx * vec2(vec2(_Noise_OnMask, _Noise_OnMask)) + u_xlat3.xy;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _MaskTexBrightness;
    u_xlat0.xyz = u_xlat4.xxx * u_xlat0.xzw;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorPower);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(_ColorScaler);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_ALPHACLIP" "_IMAGEALPHAORBASETEXSWITCH_ON" }
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_OnBaseTex;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _Noise_OnMask;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _ColorPower;
uniform 	vec4 _MainColor;
uniform 	mediump float _Noise_OnImage;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec3 u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
bvec4 u_xlatb2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bvec2 u_xlatb8;
mediump vec2 u_xlat16_11;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = texture(_NoiseTex, u_xlat1.xy).xy;
    u_xlatb8.xy = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat4.x = u_xlatb8.y ? u_xlat0.y : float(0.0);
    u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _MaskTex_Vspeed + u_xlat4.y;
    u_xlat4.xy = u_xlat0.xx * vec2(vec2(_Noise_OnMask, _Noise_OnMask)) + u_xlat1.xy;
    u_xlat1 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _MaskTexBrightness;
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat8.y;
    u_xlat16_3.xy = vec2(vec2(_Noise_OnBaseTex, _Noise_OnBaseTex)) * u_xlat0.xx + u_xlat1.xy;
    u_xlat16_11.xy = u_xlat0.xx * vec2(_Noise_OnImage) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat16_11.xy).w;
    u_xlat1 = texture(_BaseTex, u_xlat16_3.xy);
    u_xlatb2 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = u_xlat8.x * _BaseTexAlphaBrightness;
    u_xlat8.x = u_xlat4.x * u_xlat8.x;
    u_xlat8.x = u_xlat8.x * _MainColor.w;
    u_xlat8.x = u_xlat8.x * vs_COLOR0.w;
    u_xlat16_3.x = u_xlat10_0 * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlatb0.xz = greaterThanEqual(vs_TEXCOORD1.xxyx, _ClipRect.xxyx).xz;
    u_xlat0.xz = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb0.xz));
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1.0), vec2(u_xlatb2.xy));
    u_xlat0.xz = u_xlat0.xz * u_xlat2.xy;
    u_xlat0.x = u_xlat0.z * u_xlat0.x;
    u_xlat16_7 = u_xlat16_3.x * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7<0.0);
#else
    u_xlatb0.x = u_xlat16_7<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb0.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0.x ? u_xlat1.w : float(0.0);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xzw = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlat0.xyz = u_xlat4.xxx * u_xlat0.xzw;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorPower);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_OnBaseTex;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _Noise_OnMask;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _ColorPower;
uniform 	vec4 _MainColor;
uniform 	mediump float _Noise_OnImage;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _SmoothMaskTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
float u_xlat3;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bvec2 u_xlatb4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_7;
vec2 u_xlat8;
bvec2 u_xlatb8;
float u_xlat9;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlatb8.xy = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat4.x = u_xlatb8.y ? u_xlat0.y : float(0.0);
    u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat16_3.xy = vec2(vec2(_Noise_OnBaseTex, _Noise_OnBaseTex)) * u_xlat0.xx + u_xlat1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_3.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb4.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb4.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat4.x = u_xlatb4.x ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat4.xxx;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.x = _Time.y * _MaskTex_Uspeed + u_xlat1.x;
    u_xlat2.y = _Time.y * _MaskTex_Vspeed + u_xlat1.y;
    u_xlat1.xy = u_xlat0.xx * vec2(vec2(_Noise_OnMask, _Noise_OnMask)) + u_xlat2.xy;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat9 = (u_xlatb2.z) ? u_xlat1.z : u_xlat13;
    u_xlat5 = (u_xlatb2.y) ? u_xlat1.y : u_xlat9;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat5;
    u_xlat1.x = u_xlat1.x * _MaskTexBrightness;
    u_xlat16_3.xy = u_xlat0.xx * vec2(_Noise_OnImage) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat16_3.xy).w;
    u_xlat16_3.x = u_xlat10_0 * vs_COLOR0.w;
    u_xlat16_3.x = u_xlat16_3.x * _MainColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xxx;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorPower);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(_ColorScaler);
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
    if(_SmoothMaskType != 0) {
        u_xlatb4.xy = equal(ivec4(_SmoothMaskType), ivec4(1, 2, 0, 0)).xy;
        u_xlatb8.x = u_xlatb4.y || u_xlatb4.x;
        if(u_xlatb8.x){
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
            u_xlat16_3.x = u_xlat8.y * u_xlat8.x;
            if(u_xlatb4.x){
                u_xlat4.xy = vec2(vs_TEXCOORD1.z + float(0.5), vs_TEXCOORD1.w + float(0.5));
                u_xlat10_4 = texture(_SmoothMaskTexture, u_xlat4.xy).w;
                u_xlat16_3.x = u_xlat10_4 * u_xlat16_3.x;
                u_xlat16_3.x = u_xlat16_3.x;
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
            u_xlat16_3.x = (u_xlatb4.x) ? u_xlat16_7 : 1.0;
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
                u_xlatb8.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                u_xlatb8.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                u_xlat12 = (-u_xlat4.x) + 1.0;
                u_xlat4.x = (u_xlatb8.x) ? u_xlat12 : u_xlat4.x;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb8.x = !!(_SmoothMaskFillParams.x==2.0);
#else
                u_xlatb8.x = _SmoothMaskFillParams.x==2.0;
#endif
                if(u_xlatb8.x){
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
                    u_xlatb8.x = !!(u_xlat8.x>=(-u_xlat8.x));
#else
                    u_xlatb8.x = u_xlat8.x>=(-u_xlat8.x);
#endif
                    u_xlatb8.x = u_xlatb8.x && u_xlatb12;
                    u_xlat8.x = (u_xlatb8.x) ? (-u_xlat1.x) : u_xlat1.x;
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
            u_xlat3 = u_xlat4.x * u_xlat16_3.x;
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
Keywords { "UNITY_UI_SMOOTHMASK" "_IMAGEALPHAORBASETEXSWITCH_ON" }
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_OnBaseTex;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _Noise_OnMask;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _ColorPower;
uniform 	vec4 _MainColor;
uniform 	mediump float _Noise_OnImage;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _SmoothMaskTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump vec2 u_xlat16_3;
bvec4 u_xlatb3;
vec2 u_xlat4;
float u_xlat5;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
bvec2 u_xlatb6;
float u_xlat7;
bool u_xlatb7;
float u_xlat8;
mediump float u_xlat16_11;
vec2 u_xlat12;
bvec2 u_xlatb12;
float u_xlat13;
float u_xlat14;
mediump float u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
bool u_xlatb19;
float u_xlat20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlatb12.xy = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat6.x = u_xlatb12.y ? u_xlat0.y : float(0.0);
    u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : u_xlat6.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat16_3.xy = vec2(vec2(_Noise_OnBaseTex, _Noise_OnBaseTex)) * u_xlat0.xx + u_xlat1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_3.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb6.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat6.x = u_xlatb6.x ? u_xlat1.w : float(0.0);
    u_xlat6.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat6.x;
    u_xlat6.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat6.xxx;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.x = _Time.y * _MaskTex_Uspeed + u_xlat2.x;
    u_xlat4.y = _Time.y * _MaskTex_Vspeed + u_xlat2.y;
    u_xlat2.xy = u_xlat0.xx * vec2(vec2(_Noise_OnMask, _Noise_OnMask)) + u_xlat4.xy;
    u_xlat2 = texture(_MaskTex, u_xlat2.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat20 = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat14 = (u_xlatb3.z) ? u_xlat2.z : u_xlat20;
    u_xlat8 = (u_xlatb3.y) ? u_xlat2.y : u_xlat14;
    u_xlat2.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8;
    u_xlat2.x = u_xlat2.x * _MaskTexBrightness;
    u_xlat16_5.xy = u_xlat0.xx * vec2(_Noise_OnImage) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat16_5.xy).w;
    u_xlatb3 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb3.w ? u_xlat1.z : float(0.0);
    u_xlat7 = (u_xlatb3.z) ? u_xlat1.y : u_xlat13;
    u_xlat1.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat7;
    u_xlat1.x = (u_xlatb3.x) ? u_xlat1.w : u_xlat1.x;
    u_xlat1.x = u_xlat1.x * _BaseTexAlphaBrightness;
    u_xlat1.x = u_xlat2.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * _MainColor.w;
    u_xlat1.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat16_5.x = u_xlat10_0 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat6.xyz * u_xlat2.xxx;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorPower);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(_ColorScaler);
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_5.x;
    if(_SmoothMaskType != 0) {
        u_xlatb6.xy = equal(ivec4(_SmoothMaskType), ivec4(1, 2, 0, 0)).xy;
        u_xlatb12.x = u_xlatb6.y || u_xlatb6.x;
        if(u_xlatb12.x){
            u_xlat12.xy = vec2(-abs(vs_TEXCOORD1.z) + float(0.5), -abs(vs_TEXCOORD1.w) + float(0.5));
            u_xlat1.xy = vec2(1.0, 1.0) / _SmoothMaskSoftRanges.xy;
            u_xlat12.xy = u_xlat12.xy * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
            u_xlat12.xy = min(max(u_xlat12.xy, 0.0), 1.0);
#else
            u_xlat12.xy = clamp(u_xlat12.xy, 0.0, 1.0);
#endif
            u_xlat1.xy = u_xlat12.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
            u_xlat12.xy = u_xlat12.xy * u_xlat12.xy;
            u_xlat12.xy = u_xlat12.xy * u_xlat1.xy;
            u_xlat16_5.x = u_xlat12.y * u_xlat12.x;
            if(u_xlatb6.x){
                u_xlat6.xy = vec2(vs_TEXCOORD1.z + float(0.5), vs_TEXCOORD1.w + float(0.5));
                u_xlat10_6 = texture(_SmoothMaskTexture, u_xlat6.xy).w;
                u_xlat16_5.x = u_xlat10_6 * u_xlat16_5.x;
                u_xlat16_5.x = u_xlat16_5.x;
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
            u_xlat1.xy = vec2(vs_TEXCOORD1.z * _SmoothMaskSoftRanges.z, vs_TEXCOORD1.w * _SmoothMaskSoftRanges.w);
            u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
            u_xlat1.x = sqrt(u_xlat1.x);
            u_xlat1.x = u_xlat1.x + u_xlat1.x;
            u_xlat16_11 = (u_xlatb18) ? u_xlat1.x : _SmoothMaskSoftRanges.z;
            u_xlat16_11 = float(1.0) / u_xlat16_11;
            u_xlat16_11 = u_xlat12.x * u_xlat16_11;
#ifdef UNITY_ADRENO_ES3
            u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
            u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
            u_xlat16_17 = u_xlat16_11 * -2.0 + 3.0;
            u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
            u_xlat16_11 = u_xlat16_11 * u_xlat16_17;
            u_xlat16_5.x = (u_xlatb6.x) ? u_xlat16_11 : 1.0;
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
                u_xlatb12.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                u_xlatb12.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                u_xlat18 = (-u_xlat6.x) + 1.0;
                u_xlat6.x = (u_xlatb12.x) ? u_xlat18 : u_xlat6.x;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb12.x = !!(_SmoothMaskFillParams.x==2.0);
#else
                u_xlatb12.x = _SmoothMaskFillParams.x==2.0;
#endif
                if(u_xlatb12.x){
                    u_xlat12.x = vs_TEXCOORD1.w + 0.5;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb18 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                    u_xlatb18 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                    u_xlat1.x = (-u_xlat12.x) + 1.0;
                    u_xlat6.x = (u_xlatb18) ? u_xlat1.x : u_xlat12.x;
                } else {
                    u_xlatb1 = equal(_SmoothMaskFillParams.zzzx, vec4(1.0, 2.0, 3.0, 3.0));
                    u_xlat2 = vec4(vs_TEXCOORD1.w * float(1.0), vs_TEXCOORD1.z * float(-1.0), vs_TEXCOORD1.w * float(-1.0), vs_TEXCOORD1.z * float(1.0));
                    u_xlat12.xy = (u_xlatb1.z) ? u_xlat2.xy : vs_TEXCOORD1.zw;
                    u_xlat12.xy = (u_xlatb1.y) ? (-vs_TEXCOORD1.zw) : u_xlat12.xy;
                    u_xlat1.xy = (u_xlatb1.x) ? u_xlat2.zw : u_xlat12.xy;
                    u_xlat12.xy = u_xlat1.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb2.x = !!(_SmoothMaskFillParams.x==4.0);
#else
                    u_xlatb2.x = _SmoothMaskFillParams.x==4.0;
#endif
                    u_xlat1.z = (u_xlatb2.x) ? u_xlat12.y : u_xlat1.y;
                    u_xlat12.xy = (u_xlatb1.w) ? u_xlat12.xy : u_xlat1.xz;
                    u_xlat12.x = u_xlat12.x * _SmoothMaskFillParams.w;
                    u_xlat1.x = min(abs(u_xlat12.y), abs(u_xlat12.x));
                    u_xlat7 = max(abs(u_xlat12.y), abs(u_xlat12.x));
                    u_xlat7 = float(1.0) / u_xlat7;
                    u_xlat1.x = u_xlat7 * u_xlat1.x;
                    u_xlat7 = u_xlat1.x * u_xlat1.x;
                    u_xlat13 = u_xlat7 * 0.0208350997 + -0.0851330012;
                    u_xlat13 = u_xlat7 * u_xlat13 + 0.180141002;
                    u_xlat13 = u_xlat7 * u_xlat13 + -0.330299497;
                    u_xlat7 = u_xlat7 * u_xlat13 + 0.999866009;
                    u_xlat13 = u_xlat7 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb19 = !!(abs(u_xlat12.y)<abs(u_xlat12.x));
#else
                    u_xlatb19 = abs(u_xlat12.y)<abs(u_xlat12.x);
#endif
                    u_xlat13 = u_xlat13 * -2.0 + 1.57079637;
                    u_xlat13 = u_xlatb19 ? u_xlat13 : float(0.0);
                    u_xlat1.x = u_xlat1.x * u_xlat7 + u_xlat13;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb7 = !!(u_xlat12.y<(-u_xlat12.y));
#else
                    u_xlatb7 = u_xlat12.y<(-u_xlat12.y);
#endif
                    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
                    u_xlat1.x = u_xlat7 + u_xlat1.x;
                    u_xlat7 = min(u_xlat12.y, u_xlat12.x);
                    u_xlat12.x = max(u_xlat12.y, u_xlat12.x);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb18 = !!(u_xlat7<(-u_xlat7));
#else
                    u_xlatb18 = u_xlat7<(-u_xlat7);
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb12.x = !!(u_xlat12.x>=(-u_xlat12.x));
#else
                    u_xlatb12.x = u_xlat12.x>=(-u_xlat12.x);
#endif
                    u_xlatb12.x = u_xlatb12.x && u_xlatb18;
                    u_xlat12.x = (u_xlatb12.x) ? (-u_xlat1.x) : u_xlat1.x;
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
            u_xlat5 = u_xlat6.x * u_xlat16_5.x;
            u_xlat16_5.x = u_xlat5;
        //ENDIF
        }
    } else {
        u_xlat16_5.x = 1.0;
    //ENDIF
    }
    SV_Target0.w = u_xlat0.x * u_xlat16_5.x;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_OnBaseTex;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _Noise_OnMask;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _ColorPower;
uniform 	vec4 _MainColor;
uniform 	mediump float _Noise_OnImage;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _SmoothMaskTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
float u_xlat3;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bvec2 u_xlatb4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_7;
vec2 u_xlat8;
bvec2 u_xlatb8;
float u_xlat9;
mediump float u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlatb8.xy = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat4.x = u_xlatb8.y ? u_xlat0.y : float(0.0);
    u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat16_3.xy = vec2(vec2(_Noise_OnBaseTex, _Noise_OnBaseTex)) * u_xlat0.xx + u_xlat1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_3.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb4.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb4.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat4.x = u_xlatb4.x ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat4.xxx;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.x = _Time.y * _MaskTex_Uspeed + u_xlat1.x;
    u_xlat2.y = _Time.y * _MaskTex_Vspeed + u_xlat1.y;
    u_xlat1.xy = u_xlat0.xx * vec2(vec2(_Noise_OnMask, _Noise_OnMask)) + u_xlat2.xy;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat9 = (u_xlatb2.z) ? u_xlat1.z : u_xlat13;
    u_xlat5 = (u_xlatb2.y) ? u_xlat1.y : u_xlat9;
    u_xlat1.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat5;
    u_xlat1.x = u_xlat1.x * _MaskTexBrightness;
    u_xlat16_3.xy = u_xlat0.xx * vec2(_Noise_OnImage) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat16_3.xy).w;
    u_xlat16_3.x = u_xlat10_0 * vs_COLOR0.w;
    u_xlat16_3.x = u_xlat16_3.x * _MainColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xxx;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorPower);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(_ColorScaler);
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
    if(_SmoothMaskType != 0) {
        u_xlatb4.xy = equal(ivec4(_SmoothMaskType), ivec4(1, 2, 0, 0)).xy;
        u_xlatb8.x = u_xlatb4.y || u_xlatb4.x;
        if(u_xlatb8.x){
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
            u_xlat16_3.x = u_xlat8.y * u_xlat8.x;
            if(u_xlatb4.x){
                u_xlat4.xy = vec2(vs_TEXCOORD1.z + float(0.5), vs_TEXCOORD1.w + float(0.5));
                u_xlat10_4 = texture(_SmoothMaskTexture, u_xlat4.xy).w;
                u_xlat16_3.x = u_xlat10_4 * u_xlat16_3.x;
                u_xlat16_3.x = u_xlat16_3.x;
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
            u_xlat16_3.x = (u_xlatb4.x) ? u_xlat16_7 : 1.0;
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
                u_xlatb8.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                u_xlatb8.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                u_xlat12 = (-u_xlat4.x) + 1.0;
                u_xlat4.x = (u_xlatb8.x) ? u_xlat12 : u_xlat4.x;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb8.x = !!(_SmoothMaskFillParams.x==2.0);
#else
                u_xlatb8.x = _SmoothMaskFillParams.x==2.0;
#endif
                if(u_xlatb8.x){
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
                    u_xlatb8.x = !!(u_xlat8.x>=(-u_xlat8.x));
#else
                    u_xlatb8.x = u_xlat8.x>=(-u_xlat8.x);
#endif
                    u_xlatb8.x = u_xlatb8.x && u_xlatb12;
                    u_xlat8.x = (u_xlatb8.x) ? (-u_xlat1.x) : u_xlat1.x;
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
            u_xlat3 = u_xlat4.x * u_xlat16_3.x;
            u_xlat16_3.x = u_xlat3;
        //ENDIF
        }
    } else {
        u_xlat16_3.x = 1.0;
    //ENDIF
    }
    u_xlat16_7 = u_xlat0.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3.x<0.0);
#else
    u_xlatb0.x = u_xlat16_3.x<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = u_xlat16_7;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_SMOOTHMASK" "UNITY_UI_ALPHACLIP" "_IMAGEALPHAORBASETEXSWITCH_ON" }
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
uniform 	float _ColorBrightness;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_OnBaseTex;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _Noise_OnMask;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _ColorPower;
uniform 	vec4 _MainColor;
uniform 	mediump float _Noise_OnImage;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _SmoothMaskTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump vec2 u_xlat16_3;
bvec4 u_xlatb3;
vec2 u_xlat4;
float u_xlat5;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
bvec2 u_xlatb6;
float u_xlat7;
bool u_xlatb7;
float u_xlat8;
mediump float u_xlat16_11;
vec2 u_xlat12;
bvec2 u_xlatb12;
float u_xlat13;
float u_xlat14;
mediump float u_xlat16_17;
float u_xlat18;
bool u_xlatb18;
bool u_xlatb19;
float u_xlat20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat2.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat0.xy = texture(_NoiseTex, u_xlat2.xy).xy;
    u_xlatb12.xy = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat6.x = u_xlatb12.y ? u_xlat0.y : float(0.0);
    u_xlat0.x = (u_xlatb12.x) ? u_xlat0.x : u_xlat6.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat16_3.xy = vec2(vec2(_Noise_OnBaseTex, _Noise_OnBaseTex)) * u_xlat0.xx + u_xlat1.xy;
    u_xlat1 = texture(_BaseTex, u_xlat16_3.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb6.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb6.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat6.x = u_xlatb6.x ? u_xlat1.w : float(0.0);
    u_xlat6.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat6.x;
    u_xlat6.xyz = (u_xlatb2.x) ? u_xlat1.xyz : u_xlat6.xxx;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.x = _Time.y * _MaskTex_Uspeed + u_xlat2.x;
    u_xlat4.y = _Time.y * _MaskTex_Vspeed + u_xlat2.y;
    u_xlat2.xy = u_xlat0.xx * vec2(vec2(_Noise_OnMask, _Noise_OnMask)) + u_xlat4.xy;
    u_xlat2 = texture(_MaskTex, u_xlat2.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat20 = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat14 = (u_xlatb3.z) ? u_xlat2.z : u_xlat20;
    u_xlat8 = (u_xlatb3.y) ? u_xlat2.y : u_xlat14;
    u_xlat2.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8;
    u_xlat2.x = u_xlat2.x * _MaskTexBrightness;
    u_xlat16_5.xy = u_xlat0.xx * vec2(_Noise_OnImage) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat16_5.xy).w;
    u_xlatb3 = equal(vec4(vec4(_BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb3.w ? u_xlat1.z : float(0.0);
    u_xlat7 = (u_xlatb3.z) ? u_xlat1.y : u_xlat13;
    u_xlat1.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat7;
    u_xlat1.x = (u_xlatb3.x) ? u_xlat1.w : u_xlat1.x;
    u_xlat1.x = u_xlat1.x * _BaseTexAlphaBrightness;
    u_xlat1.x = u_xlat2.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * _MainColor.w;
    u_xlat1.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat16_5.x = u_xlat10_0 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat6.xyz * u_xlat2.xxx;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorPower);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(_ColorScaler);
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_5.x;
    if(_SmoothMaskType != 0) {
        u_xlatb6.xy = equal(ivec4(_SmoothMaskType), ivec4(1, 2, 0, 0)).xy;
        u_xlatb12.x = u_xlatb6.y || u_xlatb6.x;
        if(u_xlatb12.x){
            u_xlat12.xy = vec2(-abs(vs_TEXCOORD1.z) + float(0.5), -abs(vs_TEXCOORD1.w) + float(0.5));
            u_xlat1.xy = vec2(1.0, 1.0) / _SmoothMaskSoftRanges.xy;
            u_xlat12.xy = u_xlat12.xy * u_xlat1.xy;
#ifdef UNITY_ADRENO_ES3
            u_xlat12.xy = min(max(u_xlat12.xy, 0.0), 1.0);
#else
            u_xlat12.xy = clamp(u_xlat12.xy, 0.0, 1.0);
#endif
            u_xlat1.xy = u_xlat12.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
            u_xlat12.xy = u_xlat12.xy * u_xlat12.xy;
            u_xlat12.xy = u_xlat12.xy * u_xlat1.xy;
            u_xlat16_5.x = u_xlat12.y * u_xlat12.x;
            if(u_xlatb6.x){
                u_xlat6.xy = vec2(vs_TEXCOORD1.z + float(0.5), vs_TEXCOORD1.w + float(0.5));
                u_xlat10_6 = texture(_SmoothMaskTexture, u_xlat6.xy).w;
                u_xlat16_5.x = u_xlat10_6 * u_xlat16_5.x;
                u_xlat16_5.x = u_xlat16_5.x;
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
            u_xlat1.xy = vec2(vs_TEXCOORD1.z * _SmoothMaskSoftRanges.z, vs_TEXCOORD1.w * _SmoothMaskSoftRanges.w);
            u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
            u_xlat1.x = sqrt(u_xlat1.x);
            u_xlat1.x = u_xlat1.x + u_xlat1.x;
            u_xlat16_11 = (u_xlatb18) ? u_xlat1.x : _SmoothMaskSoftRanges.z;
            u_xlat16_11 = float(1.0) / u_xlat16_11;
            u_xlat16_11 = u_xlat12.x * u_xlat16_11;
#ifdef UNITY_ADRENO_ES3
            u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
            u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
            u_xlat16_17 = u_xlat16_11 * -2.0 + 3.0;
            u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
            u_xlat16_11 = u_xlat16_11 * u_xlat16_17;
            u_xlat16_5.x = (u_xlatb6.x) ? u_xlat16_11 : 1.0;
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
                u_xlatb12.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                u_xlatb12.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                u_xlat18 = (-u_xlat6.x) + 1.0;
                u_xlat6.x = (u_xlatb12.x) ? u_xlat18 : u_xlat6.x;
            } else {
#ifdef UNITY_ADRENO_ES3
                u_xlatb12.x = !!(_SmoothMaskFillParams.x==2.0);
#else
                u_xlatb12.x = _SmoothMaskFillParams.x==2.0;
#endif
                if(u_xlatb12.x){
                    u_xlat12.x = vs_TEXCOORD1.w + 0.5;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb18 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z));
#else
                    u_xlatb18 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SmoothMaskFillParams.z);
#endif
                    u_xlat1.x = (-u_xlat12.x) + 1.0;
                    u_xlat6.x = (u_xlatb18) ? u_xlat1.x : u_xlat12.x;
                } else {
                    u_xlatb1 = equal(_SmoothMaskFillParams.zzzx, vec4(1.0, 2.0, 3.0, 3.0));
                    u_xlat2 = vec4(vs_TEXCOORD1.w * float(1.0), vs_TEXCOORD1.z * float(-1.0), vs_TEXCOORD1.w * float(-1.0), vs_TEXCOORD1.z * float(1.0));
                    u_xlat12.xy = (u_xlatb1.z) ? u_xlat2.xy : vs_TEXCOORD1.zw;
                    u_xlat12.xy = (u_xlatb1.y) ? (-vs_TEXCOORD1.zw) : u_xlat12.xy;
                    u_xlat1.xy = (u_xlatb1.x) ? u_xlat2.zw : u_xlat12.xy;
                    u_xlat12.xy = u_xlat1.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb2.x = !!(_SmoothMaskFillParams.x==4.0);
#else
                    u_xlatb2.x = _SmoothMaskFillParams.x==4.0;
#endif
                    u_xlat1.z = (u_xlatb2.x) ? u_xlat12.y : u_xlat1.y;
                    u_xlat12.xy = (u_xlatb1.w) ? u_xlat12.xy : u_xlat1.xz;
                    u_xlat12.x = u_xlat12.x * _SmoothMaskFillParams.w;
                    u_xlat1.x = min(abs(u_xlat12.y), abs(u_xlat12.x));
                    u_xlat7 = max(abs(u_xlat12.y), abs(u_xlat12.x));
                    u_xlat7 = float(1.0) / u_xlat7;
                    u_xlat1.x = u_xlat7 * u_xlat1.x;
                    u_xlat7 = u_xlat1.x * u_xlat1.x;
                    u_xlat13 = u_xlat7 * 0.0208350997 + -0.0851330012;
                    u_xlat13 = u_xlat7 * u_xlat13 + 0.180141002;
                    u_xlat13 = u_xlat7 * u_xlat13 + -0.330299497;
                    u_xlat7 = u_xlat7 * u_xlat13 + 0.999866009;
                    u_xlat13 = u_xlat7 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb19 = !!(abs(u_xlat12.y)<abs(u_xlat12.x));
#else
                    u_xlatb19 = abs(u_xlat12.y)<abs(u_xlat12.x);
#endif
                    u_xlat13 = u_xlat13 * -2.0 + 1.57079637;
                    u_xlat13 = u_xlatb19 ? u_xlat13 : float(0.0);
                    u_xlat1.x = u_xlat1.x * u_xlat7 + u_xlat13;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb7 = !!(u_xlat12.y<(-u_xlat12.y));
#else
                    u_xlatb7 = u_xlat12.y<(-u_xlat12.y);
#endif
                    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
                    u_xlat1.x = u_xlat7 + u_xlat1.x;
                    u_xlat7 = min(u_xlat12.y, u_xlat12.x);
                    u_xlat12.x = max(u_xlat12.y, u_xlat12.x);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb18 = !!(u_xlat7<(-u_xlat7));
#else
                    u_xlatb18 = u_xlat7<(-u_xlat7);
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb12.x = !!(u_xlat12.x>=(-u_xlat12.x));
#else
                    u_xlatb12.x = u_xlat12.x>=(-u_xlat12.x);
#endif
                    u_xlatb12.x = u_xlatb12.x && u_xlatb18;
                    u_xlat12.x = (u_xlatb12.x) ? (-u_xlat1.x) : u_xlat1.x;
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
            u_xlat5 = u_xlat6.x * u_xlat16_5.x;
            u_xlat16_5.x = u_xlat5;
        //ENDIF
        }
    } else {
        u_xlat16_5.x = 1.0;
    //ENDIF
    }
    u_xlat16_11 = u_xlat0.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat0.x * u_xlat16_5.x + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_5.x<0.0);
#else
    u_xlatb0.x = u_xlat16_5.x<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    SV_Target0.w = u_xlat16_11;
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
Keywords { "_IMAGEALPHAORBASETEXSWITCH_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_ALPHACLIP" "_IMAGEALPHAORBASETEXSWITCH_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_SMOOTHMASK" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_SMOOTHMASK" "_IMAGEALPHAORBASETEXSWITCH_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_SMOOTHMASK" "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_UI_SMOOTHMASK" "UNITY_UI_ALPHACLIP" "_IMAGEALPHAORBASETEXSWITCH_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}