//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/UI/Speedline" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_ColorScaler ("Color Scaler", Float) = 1
[Header(ASE Properties)] _Main_Color ("Main_Color", Color) = (1,1,1,1)
_Noise_Texture ("Noise_Texture", 2D) = "white" { }
[Enum(R,0,G,1,B,2)] _Noise_Channel ("Noise_Channel", Float) = 1
_Noise_Tiling_X ("Noise_Tiling_X", Range(0, 10)) = 2.770968
_Noise_Tiling_Y ("Noise_Tiling_Y", Range(0.01, 1)) = 0.01
_Noise_Intensity ("Noise_Intensity", Range(0, 10)) = 1.058824
_Soft_Switch ("Soft_Switch", Range(0, 1)) = 0
_Softness ("Softness", Range(0.01, 5)) = 0.01
_Line_Amount ("Line_Amount", Range(0, 1)) = 1
_VSpeed ("VSpeed", Float) = 20
_Offset_X ("Offset_X", Range(-0.5, 0.5)) = 0
_Offset_Y ("Offset_Y", Range(-0.5, 0.5)) = 0
_Sin_Switch ("Sin_Switch", Float) = 0
_Sin_Speed ("Sin_Speed", Float) = 1
_Sin_Min ("Sin_Min", Float) = 0
_Mask_Texture ("Mask_Texture", 2D) = "white" { }
_UV_Texture ("UV_Texture", 2D) = "white" { }
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
  GpuProgramID 8071
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
uniform 	mediump vec4 _Main_Color;
uniform 	mediump float _Softness;
uniform 	mediump float _Offset_X;
uniform 	mediump float _Offset_Y;
uniform 	mediump float _VSpeed;
uniform 	mediump float _Noise_Tiling_X;
uniform 	mediump float _Noise_Tiling_Y;
uniform 	mediump float _Line_Amount;
uniform 	mediump float _Noise_Channel;
uniform 	mediump float _Soft_Switch;
uniform 	mediump float _Noise_Intensity;
uniform 	mediump float _Sin_Speed;
uniform 	mediump float _Sin_Min;
uniform 	mediump float _Sin_Switch;
uniform lowp sampler2D _Noise_Texture;
uniform lowp sampler2D _UV_Texture;
uniform lowp sampler2D _Mask_Texture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
float u_xlat1;
bvec3 u_xlatb1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
bool u_xlatb4;
mediump vec2 u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(_Offset_X, _Offset_Y);
    u_xlat0.xy = u_xlat0.xy + vec2(-1.0, -1.0);
    u_xlat6 = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat9 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat6 = u_xlat6 * u_xlat9;
    u_xlat9 = u_xlat6 * u_xlat6;
    u_xlat1 = u_xlat9 * 0.0208350997 + -0.0851330012;
    u_xlat1 = u_xlat9 * u_xlat1 + 0.180141002;
    u_xlat1 = u_xlat9 * u_xlat1 + -0.330299497;
    u_xlat9 = u_xlat9 * u_xlat1 + 0.999866009;
    u_xlat1 = u_xlat9 * u_xlat6;
    u_xlat1 = u_xlat1 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb4 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat1 = u_xlatb4 ? u_xlat1 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat9 + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat0.y<(-u_xlat0.y));
#else
    u_xlatb9 = u_xlat0.y<(-u_xlat0.y);
#endif
    u_xlat9 = u_xlatb9 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat9 + u_xlat6;
    u_xlat9 = min(u_xlat0.y, u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9<(-u_xlat9));
#else
    u_xlatb9 = u_xlat9<(-u_xlat9);
#endif
    u_xlat1 = max(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = _Time.y * _VSpeed + u_xlat0.x;
    u_xlat0.y = u_xlat0.x * _Noise_Tiling_Y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1>=(-u_xlat1));
#else
    u_xlatb1.x = u_xlat1>=(-u_xlat1);
#endif
    u_xlatb9 = u_xlatb9 && u_xlatb1.x;
    u_xlat6 = (u_xlatb9) ? (-u_xlat6) : u_xlat6;
    u_xlat6 = u_xlat6 * 0.159154937;
    u_xlat6 = fract(u_xlat6);
    u_xlat16_2.x = floor(_Noise_Tiling_X);
    u_xlat0.x = u_xlat6 * u_xlat16_2.x;
    u_xlat0.xyz = texture(_Noise_Texture, u_xlat0.xy).xyz;
    u_xlatb1.xyz = equal(vec4(vec4(_Noise_Channel, _Noise_Channel, _Noise_Channel, _Noise_Channel)), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : 0.0;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_5.x = (-u_xlat0.z) + 1.0;
    u_xlat16_5.x = _Line_Amount * u_xlat16_5.x + u_xlat0.z;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_5.x;
    u_xlat10_0 = texture(_UV_Texture, vec2(u_xlat16_8)).y;
    u_xlat16_3 = u_xlat16_5.x * u_xlat16_2.x + (-u_xlat10_0);
    u_xlat16_0 = _Soft_Switch * u_xlat16_3 + u_xlat10_0;
    u_xlat16_5.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.xy = u_xlat16_5.xy * u_xlat16_2.xx;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_Noise_Intensity, _Noise_Intensity)) + vs_TEXCOORD0.xy;
    u_xlat16_2.xy = vec2(u_xlat16_2.x + float(_Offset_X), u_xlat16_2.y + float(_Offset_Y));
    u_xlat10_3 = texture(_Mask_Texture, u_xlat16_2.xy).y;
    u_xlat16_3 = (-u_xlat10_3) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * 30.0;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_0 = u_xlat16_3 * u_xlat16_0;
    u_xlat16_3 = float(1.0) / _Softness;
    u_xlat16_0 = u_xlat16_3 * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_0 * -2.0 + 3.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3;
    u_xlat16_2.x = u_xlat16_0 * _Main_Color.w;
    u_xlat0.x = _Time.y * _Sin_Speed;
    u_xlat16_5.x = sin(u_xlat0.x);
    u_xlat16_8 = (-_Sin_Min) + 1.0;
    u_xlat16_5.x = abs(u_xlat16_5.x) * u_xlat16_8 + _Sin_Min;
    u_xlat16_5.x = u_xlat16_5.x + -1.0;
    u_xlat16_5.x = _Sin_Switch * u_xlat16_5.x + 1.0;
    u_xlat16_2.x = u_xlat16_5.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.x;
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vec3(_ColorScaler) * _Main_Color.xyz;
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
uniform 	mediump vec4 _Main_Color;
uniform 	mediump float _Softness;
uniform 	mediump float _Offset_X;
uniform 	mediump float _Offset_Y;
uniform 	mediump float _VSpeed;
uniform 	mediump float _Noise_Tiling_X;
uniform 	mediump float _Noise_Tiling_Y;
uniform 	mediump float _Line_Amount;
uniform 	mediump float _Noise_Channel;
uniform 	mediump float _Soft_Switch;
uniform 	mediump float _Noise_Intensity;
uniform 	mediump float _Sin_Speed;
uniform 	mediump float _Sin_Min;
uniform 	mediump float _Sin_Switch;
uniform lowp sampler2D _Noise_Texture;
uniform lowp sampler2D _UV_Texture;
uniform lowp sampler2D _Mask_Texture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
float u_xlat1;
bvec3 u_xlatb1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
bool u_xlatb4;
mediump vec2 u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_8;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(_Offset_X, _Offset_Y);
    u_xlat0.xy = u_xlat0.xy + vec2(-1.0, -1.0);
    u_xlat6 = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat6 = float(1.0) / u_xlat6;
    u_xlat9 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat6 = u_xlat6 * u_xlat9;
    u_xlat9 = u_xlat6 * u_xlat6;
    u_xlat1 = u_xlat9 * 0.0208350997 + -0.0851330012;
    u_xlat1 = u_xlat9 * u_xlat1 + 0.180141002;
    u_xlat1 = u_xlat9 * u_xlat1 + -0.330299497;
    u_xlat9 = u_xlat9 * u_xlat1 + 0.999866009;
    u_xlat1 = u_xlat9 * u_xlat6;
    u_xlat1 = u_xlat1 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb4 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat1 = u_xlatb4 ? u_xlat1 : float(0.0);
    u_xlat6 = u_xlat6 * u_xlat9 + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat0.y<(-u_xlat0.y));
#else
    u_xlatb9 = u_xlat0.y<(-u_xlat0.y);
#endif
    u_xlat9 = u_xlatb9 ? -3.14159274 : float(0.0);
    u_xlat6 = u_xlat9 + u_xlat6;
    u_xlat9 = min(u_xlat0.y, u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9<(-u_xlat9));
#else
    u_xlatb9 = u_xlat9<(-u_xlat9);
#endif
    u_xlat1 = max(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = _Time.y * _VSpeed + u_xlat0.x;
    u_xlat0.y = u_xlat0.x * _Noise_Tiling_Y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1>=(-u_xlat1));
#else
    u_xlatb1.x = u_xlat1>=(-u_xlat1);
#endif
    u_xlatb9 = u_xlatb9 && u_xlatb1.x;
    u_xlat6 = (u_xlatb9) ? (-u_xlat6) : u_xlat6;
    u_xlat6 = u_xlat6 * 0.159154937;
    u_xlat6 = fract(u_xlat6);
    u_xlat16_2.x = floor(_Noise_Tiling_X);
    u_xlat0.x = u_xlat6 * u_xlat16_2.x;
    u_xlat0.xyz = texture(_Noise_Texture, u_xlat0.xy).xyz;
    u_xlatb1.xyz = equal(vec4(vec4(_Noise_Channel, _Noise_Channel, _Noise_Channel, _Noise_Channel)), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat16_2.x = (u_xlatb1.z) ? u_xlat0.z : 0.0;
    u_xlat16_2.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2.x;
    u_xlat16_5.x = (-u_xlat0.z) + 1.0;
    u_xlat16_5.x = _Line_Amount * u_xlat16_5.x + u_xlat0.z;
    u_xlat16_8 = u_xlat16_2.x * u_xlat16_5.x;
    u_xlat10_0 = texture(_UV_Texture, vec2(u_xlat16_8)).y;
    u_xlat16_3 = u_xlat16_5.x * u_xlat16_2.x + (-u_xlat10_0);
    u_xlat16_0 = _Soft_Switch * u_xlat16_3 + u_xlat10_0;
    u_xlat16_5.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.xy = u_xlat16_5.xy * u_xlat16_2.xx;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_Noise_Intensity, _Noise_Intensity)) + vs_TEXCOORD0.xy;
    u_xlat16_2.xy = vec2(u_xlat16_2.x + float(_Offset_X), u_xlat16_2.y + float(_Offset_Y));
    u_xlat10_3 = texture(_Mask_Texture, u_xlat16_2.xy).y;
    u_xlat16_3 = (-u_xlat10_3) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 9.99999975e-05);
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * 30.0;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_0 = u_xlat16_3 * u_xlat16_0;
    u_xlat16_3 = float(1.0) / _Softness;
    u_xlat16_0 = u_xlat16_3 * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_0 * -2.0 + 3.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3;
    u_xlat16_2.x = u_xlat16_0 * _Main_Color.w;
    u_xlat0.x = _Time.y * _Sin_Speed;
    u_xlat16_5.x = sin(u_xlat0.x);
    u_xlat16_8 = (-_Sin_Min) + 1.0;
    u_xlat16_5.x = abs(u_xlat16_5.x) * u_xlat16_8 + _Sin_Min;
    u_xlat16_5.x = u_xlat16_5.x + -1.0;
    u_xlat16_5.x = _Sin_Switch * u_xlat16_5.x + 1.0;
    u_xlat16_2.x = u_xlat16_5.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_5.x = u_xlat16_2.x * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.x;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_5.x<0.0);
#else
    u_xlatb0.x = u_xlat16_5.x<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vec3(_ColorScaler) * _Main_Color.xyz;
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
uniform 	mediump vec4 _Main_Color;
uniform 	mediump float _Softness;
uniform 	mediump float _Offset_X;
uniform 	mediump float _Offset_Y;
uniform 	mediump float _VSpeed;
uniform 	mediump float _Noise_Tiling_X;
uniform 	mediump float _Noise_Tiling_Y;
uniform 	mediump float _Line_Amount;
uniform 	mediump float _Noise_Channel;
uniform 	mediump float _Soft_Switch;
uniform 	mediump float _Noise_Intensity;
uniform 	mediump float _Sin_Speed;
uniform 	mediump float _Sin_Min;
uniform 	mediump float _Sin_Switch;
uniform lowp sampler2D _Noise_Texture;
uniform lowp sampler2D _UV_Texture;
uniform lowp sampler2D _Mask_Texture;
uniform lowp sampler2D _SmoothMaskTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
float u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bool u_xlatb3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
bvec2 u_xlatb4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_6;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat12;
bool u_xlatb12;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(_Offset_X, _Offset_Y);
    u_xlat0.xy = u_xlat0.xy + vec2(-1.0, -1.0);
    u_xlat8.x = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat12 = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat8.x = u_xlat12 * u_xlat8.x;
    u_xlat12 = u_xlat8.x * u_xlat8.x;
    u_xlat1.x = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat12 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat12 * u_xlat1.x + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat12 * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb5 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
    u_xlat1.x = u_xlatb5 ? u_xlat1.x : float(0.0);
    u_xlat8.x = u_xlat8.x * u_xlat12 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.y<(-u_xlat0.y));
#else
    u_xlatb12 = u_xlat0.y<(-u_xlat0.y);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat8.x = u_xlat12 + u_xlat8.x;
    u_xlat12 = min(u_xlat0.y, u_xlat0.x);
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb12 = u_xlat12<(-u_xlat12);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb1.x = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb12 = u_xlatb12 && u_xlatb1.x;
    u_xlat8.x = (u_xlatb12) ? (-u_xlat8.x) : u_xlat8.x;
    u_xlat8.x = u_xlat8.x * 0.159154937;
    u_xlat8.x = fract(u_xlat8.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = _Time.y * _VSpeed + u_xlat0.x;
    u_xlat16_2.x = floor(_Noise_Tiling_X);
    u_xlat1.x = u_xlat8.x * u_xlat16_2.x;
    u_xlat1.y = u_xlat0.x * _Noise_Tiling_Y;
    u_xlat0.xyz = texture(_Noise_Texture, u_xlat1.xy).xyz;
    u_xlat16_2.x = (-u_xlat0.z) + 1.0;
    u_xlat16_2.x = _Line_Amount * u_xlat16_2.x + u_xlat0.z;
    u_xlatb1.xyz = equal(vec4(vec4(_Noise_Channel, _Noise_Channel, _Noise_Channel, _Noise_Channel)), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : 0.0;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat16_10 = u_xlat16_6 * u_xlat16_2.x;
    u_xlat10_0 = texture(_UV_Texture, vec2(u_xlat16_10)).y;
    u_xlat16_4 = u_xlat16_2.x * u_xlat16_6 + (-u_xlat10_0);
    u_xlat16_0 = _Soft_Switch * u_xlat16_4 + u_xlat10_0;
    u_xlat16_2.xz = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.xy = u_xlat16_2.xz * vec2(u_xlat16_6);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_Noise_Intensity, _Noise_Intensity)) + vs_TEXCOORD0.xy;
    u_xlat16_2.xy = vec2(u_xlat16_2.x + float(_Offset_X), u_xlat16_2.y + float(_Offset_Y));
    u_xlat10_4 = texture(_Mask_Texture, u_xlat16_2.xy).y;
    u_xlat16_4 = (-u_xlat10_4) + 1.0;
    u_xlat16_4 = max(u_xlat16_4, 9.99999975e-05);
    u_xlat16_4 = log2(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * 30.0;
    u_xlat16_4 = exp2(u_xlat16_4);
    u_xlat16_0 = u_xlat16_4 * u_xlat16_0;
    u_xlat16_4 = float(1.0) / _Softness;
    u_xlat16_0 = u_xlat16_4 * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat16_0 * -2.0 + 3.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_4;
    u_xlat4.x = _Time.y * _Sin_Speed;
    u_xlat16_2.x = sin(u_xlat4.x);
    u_xlat16_6 = (-_Sin_Min) + 1.0;
    u_xlat16_2.x = abs(u_xlat16_2.x) * u_xlat16_6 + _Sin_Min;
    u_xlat16_2.x = u_xlat16_2.x + -1.0;
    u_xlat16_2.x = _Sin_Switch * u_xlat16_2.x + 1.0;
    u_xlat16_6 = u_xlat16_0 * _Main_Color.w;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(_ColorScaler) * _Main_Color.xyz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.x;
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
            u_xlat16_2.x = u_xlat8.y * u_xlat8.x;
            if(u_xlatb4.x){
                u_xlat4.xy = vec2(vs_TEXCOORD1.z + float(0.5), vs_TEXCOORD1.w + float(0.5));
                u_xlat10_4 = texture(_SmoothMaskTexture, u_xlat4.xy).w;
                u_xlat16_2.x = u_xlat10_4 * u_xlat16_2.x;
                u_xlat16_2.x = u_xlat16_2.x;
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
            u_xlat16_6 = (u_xlatb12) ? u_xlat1.x : _SmoothMaskSoftRanges.z;
            u_xlat16_6 = float(1.0) / u_xlat16_6;
            u_xlat16_6 = u_xlat8.x * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
            u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
            u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
            u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
            u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
            u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
            u_xlat16_2.x = (u_xlatb4.x) ? u_xlat16_6 : 1.0;
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
                    u_xlat3 = vec4(vs_TEXCOORD1.w * float(1.0), vs_TEXCOORD1.z * float(-1.0), vs_TEXCOORD1.w * float(-1.0), vs_TEXCOORD1.z * float(1.0));
                    u_xlat8.xy = (u_xlatb1.z) ? u_xlat3.xy : vs_TEXCOORD1.zw;
                    u_xlat8.xy = (u_xlatb1.y) ? (-vs_TEXCOORD1.zw) : u_xlat8.xy;
                    u_xlat1.xy = (u_xlatb1.x) ? u_xlat3.zw : u_xlat8.xy;
                    u_xlat8.xy = u_xlat1.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb3 = !!(_SmoothMaskFillParams.x==4.0);
#else
                    u_xlatb3 = _SmoothMaskFillParams.x==4.0;
#endif
                    u_xlat1.z = (u_xlatb3) ? u_xlat8.y : u_xlat1.y;
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
            u_xlat2 = u_xlat4.x * u_xlat16_2.x;
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
uniform 	vec4 _Time;
uniform 	int _SmoothMaskType;
uniform 	vec4 _SmoothMaskSoftRanges;
uniform 	vec4 _SmoothMaskFillParams;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	mediump vec4 _Main_Color;
uniform 	mediump float _Softness;
uniform 	mediump float _Offset_X;
uniform 	mediump float _Offset_Y;
uniform 	mediump float _VSpeed;
uniform 	mediump float _Noise_Tiling_X;
uniform 	mediump float _Noise_Tiling_Y;
uniform 	mediump float _Line_Amount;
uniform 	mediump float _Noise_Channel;
uniform 	mediump float _Soft_Switch;
uniform 	mediump float _Noise_Intensity;
uniform 	mediump float _Sin_Speed;
uniform 	mediump float _Sin_Min;
uniform 	mediump float _Sin_Switch;
uniform lowp sampler2D _Noise_Texture;
uniform lowp sampler2D _UV_Texture;
uniform lowp sampler2D _Mask_Texture;
uniform lowp sampler2D _SmoothMaskTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
float u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bool u_xlatb3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
bvec2 u_xlatb4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_6;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat12;
bool u_xlatb12;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(_Offset_X, _Offset_Y);
    u_xlat0.xy = u_xlat0.xy + vec2(-1.0, -1.0);
    u_xlat8.x = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat12 = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat8.x = u_xlat12 * u_xlat8.x;
    u_xlat12 = u_xlat8.x * u_xlat8.x;
    u_xlat1.x = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat12 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat12 * u_xlat1.x + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat12 * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb5 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
    u_xlat1.x = u_xlatb5 ? u_xlat1.x : float(0.0);
    u_xlat8.x = u_xlat8.x * u_xlat12 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.y<(-u_xlat0.y));
#else
    u_xlatb12 = u_xlat0.y<(-u_xlat0.y);
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat8.x = u_xlat12 + u_xlat8.x;
    u_xlat12 = min(u_xlat0.y, u_xlat0.x);
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb12 = u_xlat12<(-u_xlat12);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb1.x = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb12 = u_xlatb12 && u_xlatb1.x;
    u_xlat8.x = (u_xlatb12) ? (-u_xlat8.x) : u_xlat8.x;
    u_xlat8.x = u_xlat8.x * 0.159154937;
    u_xlat8.x = fract(u_xlat8.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = _Time.y * _VSpeed + u_xlat0.x;
    u_xlat16_2.x = floor(_Noise_Tiling_X);
    u_xlat1.x = u_xlat8.x * u_xlat16_2.x;
    u_xlat1.y = u_xlat0.x * _Noise_Tiling_Y;
    u_xlat0.xyz = texture(_Noise_Texture, u_xlat1.xy).xyz;
    u_xlat16_2.x = (-u_xlat0.z) + 1.0;
    u_xlat16_2.x = _Line_Amount * u_xlat16_2.x + u_xlat0.z;
    u_xlatb1.xyz = equal(vec4(vec4(_Noise_Channel, _Noise_Channel, _Noise_Channel, _Noise_Channel)), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat16_6 = (u_xlatb1.z) ? u_xlat0.z : 0.0;
    u_xlat16_6 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_6;
    u_xlat16_6 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_6;
    u_xlat16_10 = u_xlat16_6 * u_xlat16_2.x;
    u_xlat10_0 = texture(_UV_Texture, vec2(u_xlat16_10)).y;
    u_xlat16_4 = u_xlat16_2.x * u_xlat16_6 + (-u_xlat10_0);
    u_xlat16_0 = _Soft_Switch * u_xlat16_4 + u_xlat10_0;
    u_xlat16_2.xz = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.xy = u_xlat16_2.xz * vec2(u_xlat16_6);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_Noise_Intensity, _Noise_Intensity)) + vs_TEXCOORD0.xy;
    u_xlat16_2.xy = vec2(u_xlat16_2.x + float(_Offset_X), u_xlat16_2.y + float(_Offset_Y));
    u_xlat10_4 = texture(_Mask_Texture, u_xlat16_2.xy).y;
    u_xlat16_4 = (-u_xlat10_4) + 1.0;
    u_xlat16_4 = max(u_xlat16_4, 9.99999975e-05);
    u_xlat16_4 = log2(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * 30.0;
    u_xlat16_4 = exp2(u_xlat16_4);
    u_xlat16_0 = u_xlat16_4 * u_xlat16_0;
    u_xlat16_4 = float(1.0) / _Softness;
    u_xlat16_0 = u_xlat16_4 * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat16_0 * -2.0 + 3.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_4;
    u_xlat4.x = _Time.y * _Sin_Speed;
    u_xlat16_2.x = sin(u_xlat4.x);
    u_xlat16_6 = (-_Sin_Min) + 1.0;
    u_xlat16_2.x = abs(u_xlat16_2.x) * u_xlat16_6 + _Sin_Min;
    u_xlat16_2.x = u_xlat16_2.x + -1.0;
    u_xlat16_2.x = _Sin_Switch * u_xlat16_2.x + 1.0;
    u_xlat16_6 = u_xlat16_0 * _Main_Color.w;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(_ColorScaler) * _Main_Color.xyz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.x;
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
            u_xlat16_2.x = u_xlat8.y * u_xlat8.x;
            if(u_xlatb4.x){
                u_xlat4.xy = vec2(vs_TEXCOORD1.z + float(0.5), vs_TEXCOORD1.w + float(0.5));
                u_xlat10_4 = texture(_SmoothMaskTexture, u_xlat4.xy).w;
                u_xlat16_2.x = u_xlat10_4 * u_xlat16_2.x;
                u_xlat16_2.x = u_xlat16_2.x;
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
            u_xlat16_6 = (u_xlatb12) ? u_xlat1.x : _SmoothMaskSoftRanges.z;
            u_xlat16_6 = float(1.0) / u_xlat16_6;
            u_xlat16_6 = u_xlat8.x * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
            u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
            u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
            u_xlat16_10 = u_xlat16_6 * -2.0 + 3.0;
            u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
            u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
            u_xlat16_2.x = (u_xlatb4.x) ? u_xlat16_6 : 1.0;
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
                    u_xlat3 = vec4(vs_TEXCOORD1.w * float(1.0), vs_TEXCOORD1.z * float(-1.0), vs_TEXCOORD1.w * float(-1.0), vs_TEXCOORD1.z * float(1.0));
                    u_xlat8.xy = (u_xlatb1.z) ? u_xlat3.xy : vs_TEXCOORD1.zw;
                    u_xlat8.xy = (u_xlatb1.y) ? (-vs_TEXCOORD1.zw) : u_xlat8.xy;
                    u_xlat1.xy = (u_xlatb1.x) ? u_xlat3.zw : u_xlat8.xy;
                    u_xlat8.xy = u_xlat1.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb3 = !!(_SmoothMaskFillParams.x==4.0);
#else
                    u_xlatb3 = _SmoothMaskFillParams.x==4.0;
#endif
                    u_xlat1.z = (u_xlatb3) ? u_xlat8.y : u_xlat1.y;
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
            u_xlat2 = u_xlat4.x * u_xlat16_2.x;
            u_xlat16_2.x = u_xlat2;
        //ENDIF
        }
    } else {
        u_xlat16_2.x = 1.0;
    //ENDIF
    }
    u_xlat16_6 = u_xlat0.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x<0.0);
#else
    u_xlatb0.x = u_xlat16_2.x<0.0;
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