//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/UI/UI_Minimap_Fog" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_ColorScaler ("Color Scaler", Float) = 1
[Header(ASE Properties)] _Mask ("Mask", 2D) = "white" { }
_FogRGBA ("FogRGBA", Vector) = (1,0,0,0)
_StarColor ("StarColor", Color) = (0.3602941,1,0.9735292,0)
_CloudColor1 ("CloudColor1", Color) = (0.4829152,0.6692042,0.8529412,0)
_CloudColor2 ("CloudColor2", Color) = (0.2195069,0.3665225,0.4264705,0)
_CloudColor3 ("CloudColor3", Color) = (0.3584559,0.4756339,0.5735295,0)
_StarCloudColor ("StarCloudColor", Color) = (0.4527465,0.5490692,0.5808823,0)
_OuterglowColor ("OuterglowColor", Color) = (0.1589533,1,1,0)
_LineColor ("LineColor", Color) = (0.2108563,0.7352942,0.5616872,0)
_InnerglowColor ("InnerglowColor", Color) = (0.2595155,0.2869585,0.2941176,0)
_DownColor ("DownColor", Color) = (0.318339,0.3697888,0.4705881,0)
_CloudMap01 ("CloudMap01", 2D) = "white" { }
_CloudMap02 ("CloudMap02", 2D) = "white" { }
_StarMask ("StarMask", 2D) = "white" { }
_StarMap ("StarMap", 2D) = "white" { }
_WarpMask ("WarpMask", 2D) = "bump" { }
_WarpCloud ("WarpCloud", 2D) = "bump" { }
_MiniMap ("MiniMap", 2D) = "white" { }
_NoiseMap ("NoiseMap", 2D) = "white" { }
_StarCloudMap ("StarCloudMap", 2D) = "white" { }
_FlowLine ("FlowLine", Range(0, 1)) = 0.3031195
_LineRange ("LineRange", Range(0.1, 0.8)) = 0.734
_StarOffset ("StarOffset", Float) = 0
_StarMapTiling ("StarMapTiling", Float) = 2
_LerpColor ("LerpColor", Color) = (0,0.9586205,1,0)
_LineWarpSpeed ("LineWarpSpeed", Float) = 0.3
_Cloud01Tiling ("Cloud01Tiling", Float) = 1
_Cloud02Tiling ("Cloud02Tiling", Float) = 1
_CloudOffset ("CloudOffset", Float) = 0.7
_XYPannerAndSpeed01 ("XYPannerAndSpeed01", Vector) = (0.85,0.6,0.03,0)
_XYPannerAndSpeed02 ("XYPannerAndSpeed02", Vector) = (1,0.5,0.015,0)
_texcoord ("", 2D) = "white" { }
_ASEHeader ("", Float) = 0
[Header(StencilForPass1)] [Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
[Header(StencilForPass2)] [Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp2 ("Stencil Comparison", Float) = 8
_Stencil2 ("Stencil ID", Float) = 0
[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp2 ("Stencil Operation", Float) = 0
_StencilWriteMask2 ("Stencil Write Mask", Float) = 255
_StencilReadMask2 ("Stencil Read Mask", Float) = 255
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
  Name "PASS1"
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 27542
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
float u_xlat9;
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
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	mediump vec4 _OuterglowColor;
uniform 	vec4 _MiniMap_ST;
uniform 	mediump float _LineWarpSpeed;
uniform 	vec4 _WarpMask_ST;
uniform 	mediump float _FlowLine;
uniform 	mediump vec4 _FogRGBA;
uniform 	mediump vec4 _CloudColor3;
uniform 	mediump vec4 _CloudColor1;
uniform 	mediump vec3 _XYPannerAndSpeed02;
uniform 	mediump float _Cloud01Tiling;
uniform 	mediump float _Cloud02Tiling;
uniform 	vec4 _WarpCloud_ST;
uniform 	mediump vec3 _XYPannerAndSpeed01;
uniform 	mediump float _CloudOffset;
uniform 	mediump vec4 _CloudColor2;
uniform 	mediump vec4 _DownColor;
uniform 	mediump vec4 _StarCloudColor;
uniform 	mediump vec4 _StarColor;
uniform 	mediump float _StarMapTiling;
uniform 	mediump float _StarOffset;
uniform 	mediump vec4 _InnerglowColor;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _LineRange;
uniform 	mediump vec4 _LerpColor;
uniform lowp sampler2D _WarpMask;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _MiniMap;
uniform lowp sampler2D _WarpCloud;
uniform lowp sampler2D _CloudMap02;
uniform lowp sampler2D _CloudMap01;
uniform lowp sampler2D _StarCloudMap;
uniform lowp sampler2D _NoiseMap;
uniform lowp sampler2D _StarMap;
uniform lowp sampler2D _StarMask;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec2 u_xlat16_6;
vec2 u_xlat7;
lowp float u_xlat10_7;
mediump vec3 u_xlat16_9;
float u_xlat14;
mediump vec2 u_xlat16_16;
float u_xlat21;
lowp float u_xlat10_21;
bool u_xlatb21;
mediump float u_xlat16_23;
mediump float u_xlat16_25;
void main()
{
    u_xlat10_0.x = texture(_StarMask, vs_TEXCOORD0.xy).x;
    u_xlat16_0.x = max(u_xlat10_0.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 2.25;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat7.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xy = u_xlat7.xx * vs_TEXCOORD2.xy;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(_StarMapTiling);
    u_xlat16_2.x = _StarOffset + -1.0;
    u_xlat1.xy = u_xlat16_2.xx * u_xlat7.xy + u_xlat1.xy;
    u_xlat10_21 = texture(_StarMap, u_xlat1.xy).x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat10_21;
    u_xlat21 = _Time.y * 0.300000012;
    u_xlat16_2.x = sin(u_xlat21);
    u_xlat16_1 = _Time.yyyy * vec4(0.00400000019, 0.00400000019, 0.00999999978, 0.00999999978) + vs_TEXCOORD0.xyxy;
    u_xlat10_3.xy = texture(_NoiseMap, u_xlat16_1.zw).xy;
    u_xlat10_21 = texture(_StarCloudMap, u_xlat16_1.xy).x;
    u_xlat16_2.x = abs(u_xlat16_2.x) * u_xlat10_3.y;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat10_3.x;
    u_xlat16_9.xyz = _StarColor.xyz * vec3(50.0, 50.0, 50.0);
    u_xlat16_4.xyz = _StarCloudColor.xyz * vec3(u_xlat10_21) + (-_DownColor.xyz);
    u_xlat16_4.xyz = vec3(u_xlat10_21) * u_xlat16_4.xyz + _DownColor.xyz;
    u_xlat16_3.xyz = u_xlat16_9.xyz * u_xlat16_2.xxx + (-u_xlat16_4.xyz);
    u_xlat16_3.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat0.xw = vs_TEXCOORD0.xy * _WarpCloud_ST.xy + _WarpCloud_ST.zw;
    u_xlat0.xw = _Time.yy * vec2(0.0300000012, 0.0300000012) + u_xlat0.xw;
    u_xlat10_0.xw = texture(_WarpCloud, u_xlat0.xw).xy;
    u_xlat16_2.xy = u_xlat10_0.xw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(0.0540000014, 0.0540000014);
    u_xlat16_16.xy = vs_TEXCOORD0.xy * vec2(vec2(_Cloud01Tiling, _Cloud01Tiling)) + u_xlat16_2.xy;
    u_xlat16_4.x = _CloudOffset + -1.0;
    u_xlat0.xy = (-u_xlat16_4.xx) * u_xlat7.xy + u_xlat16_16.xy;
    u_xlat14 = _Time.y * _XYPannerAndSpeed01.z;
    u_xlat16_16.xy = vec2(u_xlat14) * _XYPannerAndSpeed01.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CloudMap01, u_xlat16_16.xy).x;
    u_xlat16_16.x = _Cloud01Tiling * _Cloud02Tiling;
    u_xlat16_2.xy = vs_TEXCOORD0.xy * u_xlat16_16.xx + u_xlat16_2.xy;
    u_xlat7.x = _Time.y * _XYPannerAndSpeed02.z;
    u_xlat16_2.xy = u_xlat7.xx * _XYPannerAndSpeed02.xy + u_xlat16_2.xy;
    u_xlat10_7 = texture(_CloudMap02, u_xlat16_2.xy).x;
    u_xlat16_2.xyz = (-_CloudColor3.xyz) + _CloudColor1.xyz;
    u_xlat16_2.xyz = vec3(u_xlat10_7) * u_xlat16_2.xyz + _CloudColor3.xyz;
    u_xlat16_4.xyz = u_xlat10_0.xxx * _CloudColor2.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat10_0.xxx * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat16_23 = u_xlat10_0.x + 0.300000012;
    u_xlat16_23 = u_xlat10_7 * u_xlat16_23;
    u_xlat16_23 = u_xlat16_23 * 8.40336132;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) + u_xlat16_3.xyz;
    u_xlat16_25 = u_xlat16_23 * -2.0 + 3.0;
    u_xlat16_23 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_23 = u_xlat16_23 * u_xlat16_25;
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * _LerpColor.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _InnerglowColor.xyz;
    u_xlat0.x = _Time.y * _LineWarpSpeed;
    u_xlat1 = vs_TEXCOORD0.xyxy * _WarpMask_ST.xyxy + _WarpMask_ST.zwzw;
    u_xlat0 = u_xlat0.xxxx * vec4(0.5, 0.5, -0.5, 0.5) + u_xlat1;
    u_xlat10_0.x = texture(_WarpMask, u_xlat0.xy).x;
    u_xlat10_7 = texture(_WarpMask, u_xlat0.zw).y;
    u_xlat16_6.y = u_xlat10_7 * 2.0 + -1.0;
    u_xlat16_6.x = u_xlat10_0.x * 2.0 + -1.0;
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(_FlowLine) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_Mask, u_xlat16_6.xy);
    u_xlat16_23 = dot(u_xlat10_0, _FogRGBA);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_25 = u_xlat16_23 * 1.49600005;
    u_xlat16_5.xyz = vec3(u_xlat16_25) * u_xlat16_5.xyz;
    u_xlat16_25 = min(u_xlat16_25, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(10.0, 10.0, 10.0);
    u_xlat16_2.xyz = vec3(u_xlat16_25) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MiniMap_ST.xy + _MiniMap_ST.zw;
    u_xlat10_0.xyz = texture(_MiniMap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + (-_OuterglowColor.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_23) * u_xlat16_0.xyz + _OuterglowColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.800000012>=u_xlat16_23);
#else
    u_xlatb21 = 0.800000012>=u_xlat16_23;
#endif
    u_xlat16_25 = (u_xlatb21) ? 1.0 : 0.0;
    u_xlat16_2.xyz = vec3(u_xlat16_25) * u_xlat16_2.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_LineRange>=u_xlat16_23);
#else
    u_xlatb0.x = _LineRange>=u_xlat16_23;
#endif
    u_xlat16_5.x = (u_xlatb0.x) ? -1.0 : -0.0;
    u_xlat16_5.x = u_xlat16_25 + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _LineColor.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xyz * vec3(0.699999988, 0.699999988, 0.699999988) + u_xlat16_2.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(15.0, 15.0, 15.0) + (-u_xlat16_2.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_23) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-u_xlat16_4.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_ColorScaler);
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_25;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
float u_xlat9;
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
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	mediump vec4 _OuterglowColor;
uniform 	vec4 _MiniMap_ST;
uniform 	mediump float _LineWarpSpeed;
uniform 	vec4 _WarpMask_ST;
uniform 	mediump float _FlowLine;
uniform 	mediump vec4 _FogRGBA;
uniform 	mediump vec4 _CloudColor3;
uniform 	mediump vec4 _CloudColor1;
uniform 	mediump vec3 _XYPannerAndSpeed02;
uniform 	mediump float _Cloud01Tiling;
uniform 	mediump float _Cloud02Tiling;
uniform 	vec4 _WarpCloud_ST;
uniform 	mediump vec3 _XYPannerAndSpeed01;
uniform 	mediump float _CloudOffset;
uniform 	mediump vec4 _CloudColor2;
uniform 	mediump vec4 _DownColor;
uniform 	mediump vec4 _StarCloudColor;
uniform 	mediump vec4 _StarColor;
uniform 	mediump float _StarMapTiling;
uniform 	mediump float _StarOffset;
uniform 	mediump vec4 _InnerglowColor;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _LineRange;
uniform 	mediump vec4 _LerpColor;
uniform lowp sampler2D _WarpMask;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _MiniMap;
uniform lowp sampler2D _WarpCloud;
uniform lowp sampler2D _CloudMap02;
uniform lowp sampler2D _CloudMap01;
uniform lowp sampler2D _StarCloudMap;
uniform lowp sampler2D _NoiseMap;
uniform lowp sampler2D _StarMap;
uniform lowp sampler2D _StarMask;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
lowp float u_xlat10_6;
bool u_xlatb6;
mediump vec3 u_xlat16_8;
float u_xlat12;
lowp float u_xlat10_12;
mediump vec2 u_xlat16_14;
mediump float u_xlat16_16;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_20;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat6.x = _Time.y * _LineWarpSpeed;
    u_xlat1 = vs_TEXCOORD0.xyxy * _WarpMask_ST.xyxy + _WarpMask_ST.zwzw;
    u_xlat1 = u_xlat6.xxxx * vec4(0.5, 0.5, -0.5, 0.5) + u_xlat1;
    u_xlat10_6 = texture(_WarpMask, u_xlat1.xy).x;
    u_xlat10_12 = texture(_WarpMask, u_xlat1.zw).y;
    u_xlat16_2.y = u_xlat10_12 * 2.0 + -1.0;
    u_xlat16_2.x = u_xlat10_6 * 2.0 + -1.0;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_FlowLine) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_Mask, u_xlat16_2.xy);
    u_xlat16_2.x = dot(u_xlat10_1, _FogRGBA);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.800000012>=u_xlat16_2.x);
#else
    u_xlatb6 = 0.800000012>=u_xlat16_2.x;
#endif
    u_xlat16_8.x = (u_xlatb6) ? 1.0 : 0.0;
    u_xlat16_14.x = u_xlat16_8.x * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_8.x;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_14.x<0.0);
#else
    u_xlatb0.x = u_xlat16_14.x<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat10_0.x = texture(_StarMask, vs_TEXCOORD0.xy).x;
    u_xlat16_0.x = max(u_xlat10_0.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 2.25;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat6.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * vs_TEXCOORD2.xy;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(_StarMapTiling);
    u_xlat16_14.x = _StarOffset + -1.0;
    u_xlat1.xy = u_xlat16_14.xx * u_xlat6.xy + u_xlat1.xy;
    u_xlat10_18 = texture(_StarMap, u_xlat1.xy).x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat10_18;
    u_xlat18 = _Time.y * 0.300000012;
    u_xlat16_14.x = sin(u_xlat18);
    u_xlat16_1 = _Time.yyyy * vec4(0.00400000019, 0.00400000019, 0.00999999978, 0.00999999978) + vs_TEXCOORD0.xyxy;
    u_xlat10_3.xy = texture(_NoiseMap, u_xlat16_1.zw).xy;
    u_xlat10_18 = texture(_StarCloudMap, u_xlat16_1.xy).x;
    u_xlat16_14.x = abs(u_xlat16_14.x) * u_xlat10_3.y;
    u_xlat16_14.x = u_xlat16_14.x * u_xlat10_3.x;
    u_xlat16_4.xyz = _StarColor.xyz * vec3(50.0, 50.0, 50.0);
    u_xlat16_5.xyz = _StarCloudColor.xyz * vec3(u_xlat10_18) + (-_DownColor.xyz);
    u_xlat16_5.xyz = vec3(u_xlat10_18) * u_xlat16_5.xyz + _DownColor.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_14.xxx + (-u_xlat16_5.xyz);
    u_xlat16_3.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat0.xw = vs_TEXCOORD0.xy * _WarpCloud_ST.xy + _WarpCloud_ST.zw;
    u_xlat0.xw = _Time.yy * vec2(0.0300000012, 0.0300000012) + u_xlat0.xw;
    u_xlat10_0.xw = texture(_WarpCloud, u_xlat0.xw).xy;
    u_xlat16_14.xy = u_xlat10_0.xw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_14.xy = u_xlat16_14.xy * vec2(0.0540000014, 0.0540000014);
    u_xlat16_4.xy = vs_TEXCOORD0.xy * vec2(vec2(_Cloud01Tiling, _Cloud01Tiling)) + u_xlat16_14.xy;
    u_xlat16_16 = _CloudOffset + -1.0;
    u_xlat0.xy = (-vec2(u_xlat16_16)) * u_xlat6.xy + u_xlat16_4.xy;
    u_xlat12 = _Time.y * _XYPannerAndSpeed01.z;
    u_xlat16_4.xy = vec2(u_xlat12) * _XYPannerAndSpeed01.xy + u_xlat0.xy;
    u_xlat10_0.x = texture(_CloudMap01, u_xlat16_4.xy).x;
    u_xlat16_4.x = _Cloud01Tiling * _Cloud02Tiling;
    u_xlat16_14.xy = vs_TEXCOORD0.xy * u_xlat16_4.xx + u_xlat16_14.xy;
    u_xlat6.x = _Time.y * _XYPannerAndSpeed02.z;
    u_xlat16_14.xy = u_xlat6.xx * _XYPannerAndSpeed02.xy + u_xlat16_14.xy;
    u_xlat10_6 = texture(_CloudMap02, u_xlat16_14.xy).x;
    u_xlat16_4.xyz = (-_CloudColor3.xyz) + _CloudColor1.xyz;
    u_xlat16_4.xyz = vec3(u_xlat10_6) * u_xlat16_4.xyz + _CloudColor3.xyz;
    u_xlat16_5.xyz = u_xlat10_0.xxx * _CloudColor2.xyz + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat10_0.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_14.x = u_xlat10_0.x + 0.300000012;
    u_xlat16_14.x = u_xlat10_6 * u_xlat16_14.x;
    u_xlat16_14.x = u_xlat16_14.x * 8.40336132;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14.x = min(max(u_xlat16_14.x, 0.0), 1.0);
#else
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_3.xyz + (-u_xlat16_4.xyz);
    u_xlat16_20 = u_xlat16_14.x * -2.0 + 3.0;
    u_xlat16_14.x = u_xlat16_14.x * u_xlat16_14.x;
    u_xlat16_14.x = u_xlat16_14.x * u_xlat16_20;
    u_xlat16_4.xyz = u_xlat16_14.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz * _InnerglowColor.xyz;
    u_xlat16_14.x = u_xlat16_2.x * 1.49600005;
    u_xlat16_5.xyz = u_xlat16_14.xxx * u_xlat16_5.xyz;
    u_xlat16_14.x = min(u_xlat16_14.x, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(10.0, 10.0, 10.0);
    u_xlat16_5.xyz = u_xlat16_14.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _LerpColor.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MiniMap_ST.xy + _MiniMap_ST.zw;
    u_xlat10_0.xyz = texture(_MiniMap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + (-_OuterglowColor.xyz);
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_0.xyz + _OuterglowColor.xyz;
    u_xlat16_5.xyz = (-u_xlat16_0.xyz) + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_8.xxx * u_xlat16_5.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_LineRange>=u_xlat16_2.x);
#else
    u_xlatb0.x = _LineRange>=u_xlat16_2.x;
#endif
    u_xlat16_14.x = (u_xlatb0.x) ? -1.0 : -0.0;
    u_xlat16_8.x = u_xlat16_14.x + u_xlat16_8.x;
    u_xlat16_8.xyz = u_xlat16_8.xxx * _LineColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(0.699999988, 0.699999988, 0.699999988) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(15.0, 15.0, 15.0) + (-u_xlat16_8.xyz);
    u_xlat16_4.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + (-u_xlat16_4.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_8.xyz + u_xlat16_4.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
float u_xlat9;
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
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	mediump vec4 _OuterglowColor;
uniform 	vec4 _MiniMap_ST;
uniform 	mediump float _LineWarpSpeed;
uniform 	vec4 _WarpMask_ST;
uniform 	mediump float _FlowLine;
uniform 	mediump vec4 _FogRGBA;
uniform 	mediump vec4 _CloudColor3;
uniform 	mediump vec4 _CloudColor1;
uniform 	mediump vec3 _XYPannerAndSpeed02;
uniform 	mediump float _Cloud01Tiling;
uniform 	mediump float _Cloud02Tiling;
uniform 	vec4 _WarpCloud_ST;
uniform 	mediump vec3 _XYPannerAndSpeed01;
uniform 	mediump float _CloudOffset;
uniform 	mediump vec4 _CloudColor2;
uniform 	mediump vec4 _DownColor;
uniform 	mediump vec4 _StarCloudColor;
uniform 	mediump vec4 _StarColor;
uniform 	mediump float _StarMapTiling;
uniform 	mediump float _StarOffset;
uniform 	mediump vec4 _InnerglowColor;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _LineRange;
uniform 	mediump vec4 _LerpColor;
uniform lowp sampler2D _WarpMask;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _MiniMap;
uniform lowp sampler2D _WarpCloud;
uniform lowp sampler2D _CloudMap02;
uniform lowp sampler2D _CloudMap01;
uniform lowp sampler2D _StarCloudMap;
uniform lowp sampler2D _NoiseMap;
uniform lowp sampler2D _StarMap;
uniform lowp sampler2D _StarMask;
uniform lowp sampler2D _SmoothMaskTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
float u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
lowp float u_xlat10_6;
bvec2 u_xlatb6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
bool u_xlatb7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec2 u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat13;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
mediump vec2 u_xlat16_14;
vec2 u_xlat16;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
bool u_xlatb19;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MiniMap_ST.xy + _MiniMap_ST.zw;
    u_xlat12.x = _Time.y * _LineWarpSpeed;
    u_xlat1 = vs_TEXCOORD0.xyxy * _WarpMask_ST.xyxy + _WarpMask_ST.zwzw;
    u_xlat1 = u_xlat12.xxxx * vec4(0.5, 0.5, -0.5, 0.5) + u_xlat1;
    u_xlat10_12 = texture(_WarpMask, u_xlat1.xy).x;
    u_xlat16_2.x = u_xlat10_12 * 2.0 + -1.0;
    u_xlat10_12 = texture(_WarpMask, u_xlat1.zw).y;
    u_xlat16_2.y = u_xlat10_12 * 2.0 + -1.0;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_FlowLine) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_Mask, u_xlat16_2.xy);
    u_xlat16_2.x = dot(u_xlat10_1, _FogRGBA);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_MiniMap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + (-_OuterglowColor.xyz);
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_0.xyz + _OuterglowColor.xyz;
    u_xlat18 = _Time.y * _XYPannerAndSpeed02.z;
    u_xlat16_8.x = _Cloud01Tiling * _Cloud02Tiling;
    u_xlat1.xy = vs_TEXCOORD0.xy * _WarpCloud_ST.xy + _WarpCloud_ST.zw;
    u_xlat13 = _Time.y * 0.300000012;
    u_xlat1.xy = _Time.yy * vec2(0.0300000012, 0.0300000012) + u_xlat1.xy;
    u_xlat10_1.xy = texture(_WarpCloud, u_xlat1.xy).xy;
    u_xlat16_14.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_14.xy = u_xlat16_14.xy * vec2(0.0540000014, 0.0540000014);
    u_xlat16_3.xy = vs_TEXCOORD0.xy * u_xlat16_8.xx + u_xlat16_14.xy;
    u_xlat16_3.xy = vec2(u_xlat18) * _XYPannerAndSpeed02.xy + u_xlat16_3.xy;
    u_xlat10_18 = texture(_CloudMap02, u_xlat16_3.xy).x;
    u_xlat16_3.xyz = (-_CloudColor3.xyz) + _CloudColor1.xyz;
    u_xlat16_3.xyz = vec3(u_xlat10_18) * u_xlat16_3.xyz + _CloudColor3.xyz;
    u_xlat1.x = _Time.y * _XYPannerAndSpeed01.z;
    u_xlat7.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xz = u_xlat7.xx * vs_TEXCOORD2.xy;
    u_xlat16_8.x = _CloudOffset + -1.0;
    u_xlat16_14.xy = vs_TEXCOORD0.xy * vec2(vec2(_Cloud01Tiling, _Cloud01Tiling)) + u_xlat16_14.xy;
    u_xlat4.xy = (-u_xlat16_8.xx) * u_xlat7.xz + u_xlat16_14.xy;
    u_xlat16_8.xy = u_xlat1.xx * _XYPannerAndSpeed01.xy + u_xlat4.xy;
    u_xlat10_1.x = texture(_CloudMap01, u_xlat16_8.xy).x;
    u_xlat16_8.xyz = u_xlat10_1.xxx * _CloudColor2.xyz + (-u_xlat16_3.xyz);
    u_xlat16_8.xyz = u_xlat10_1.xxx * u_xlat16_8.xyz + u_xlat16_3.xyz;
    u_xlat16_3 = _Time.yyyy * vec4(0.00400000019, 0.00400000019, 0.00999999978, 0.00999999978) + vs_TEXCOORD0.xyxy;
    u_xlat10_4.x = texture(_StarCloudMap, u_xlat16_3.xy).x;
    u_xlat16_5.xyz = _StarCloudColor.xyz * u_xlat10_4.xxx + (-_DownColor.xyz);
    u_xlat16_5.xyz = u_xlat10_4.xxx * u_xlat16_5.xyz + _DownColor.xyz;
    u_xlat10_4.xy = texture(_NoiseMap, u_xlat16_3.zw).xy;
    u_xlat16.xy = vs_TEXCOORD0.xy * vec2(_StarMapTiling);
    u_xlat16_3.x = _StarOffset + -1.0;
    u_xlat7.xz = u_xlat16_3.xx * u_xlat7.xz + u_xlat16.xy;
    u_xlat16_3.xyz = _StarColor.xyz * vec3(50.0, 50.0, 50.0);
    u_xlat16_21 = sin(u_xlat13);
    u_xlat16_21 = abs(u_xlat16_21) * u_xlat10_4.y;
    u_xlat16_21 = u_xlat16_21 * u_xlat10_4.x;
    u_xlat10_7 = texture(_StarMap, u_xlat7.xz).x;
    u_xlat10_13 = texture(_StarMask, vs_TEXCOORD0.xy).x;
    u_xlat16_13 = max(u_xlat10_13, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * 2.25;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_7.x = u_xlat16_13 * u_xlat10_7;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(u_xlat16_21) + (-u_xlat16_5.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_4.xyz + u_xlat16_5.xyz;
    u_xlat16_3.x = u_xlat10_1.x + 0.300000012;
    u_xlat16_3.x = u_xlat10_18 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * 8.40336132;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9.x = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_9.x;
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_3.x = u_xlat16_2.x * 1.49600005;
    u_xlat16_9.xyz = u_xlat16_8.xyz * _InnerglowColor.xyz;
    u_xlat16_9.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(10.0, 10.0, 10.0);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.800000012>=u_xlat16_2.x);
#else
    u_xlatb18 = 0.800000012>=u_xlat16_2.x;
#endif
    u_xlat16_21 = (u_xlatb18) ? 1.0 : 0.0;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_LineRange>=u_xlat16_2.x);
#else
    u_xlatb0.x = _LineRange>=u_xlat16_2.x;
#endif
    u_xlat16_5.x = (u_xlatb0.x) ? -1.0 : -0.0;
    u_xlat16_5.x = u_xlat16_21 + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _LineColor.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * vec3(0.699999988, 0.699999988, 0.699999988) + u_xlat16_3.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _LerpColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(15.0, 15.0, 15.0) + (-u_xlat16_3.xyz);
    u_xlat16_8.xyz = u_xlat16_2.xxx * u_xlat16_8.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_8.xyz) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_ColorScaler);
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_21;
    if(_SmoothMaskType != 0) {
        u_xlatb6.xy = equal(ivec4(_SmoothMaskType), ivec4(1, 2, 0, 0)).xy;
        u_xlatb12 = u_xlatb6.y || u_xlatb6.x;
        if(u_xlatb12){
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
            u_xlat1.xy = vec2(vs_TEXCOORD1.z * _SmoothMaskSoftRanges.z, vs_TEXCOORD1.w * _SmoothMaskSoftRanges.w);
            u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
            u_xlat1.x = sqrt(u_xlat1.x);
            u_xlat1.x = u_xlat1.x + u_xlat1.x;
            u_xlat16_8.x = (u_xlatb18) ? u_xlat1.x : _SmoothMaskSoftRanges.z;
            u_xlat16_8.x = float(1.0) / u_xlat16_8.x;
            u_xlat16_8.x = u_xlat12.x * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
            u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
            u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
            u_xlat16_14.x = u_xlat16_8.x * -2.0 + 3.0;
            u_xlat16_8.x = u_xlat16_8.x * u_xlat16_8.x;
            u_xlat16_8.x = u_xlat16_8.x * u_xlat16_14.x;
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
                    u_xlat1.x = (-u_xlat12.x) + 1.0;
                    u_xlat6.x = (u_xlatb18) ? u_xlat1.x : u_xlat12.x;
                } else {
                    u_xlatb1 = equal(_SmoothMaskFillParams.zzzx, vec4(1.0, 2.0, 3.0, 3.0));
                    u_xlat3 = vec4(vs_TEXCOORD1.w * float(1.0), vs_TEXCOORD1.z * float(-1.0), vs_TEXCOORD1.w * float(-1.0), vs_TEXCOORD1.z * float(1.0));
                    u_xlat12.xy = (u_xlatb1.z) ? u_xlat3.xy : vs_TEXCOORD1.zw;
                    u_xlat12.xy = (u_xlatb1.y) ? (-vs_TEXCOORD1.zw) : u_xlat12.xy;
                    u_xlat1.xy = (u_xlatb1.x) ? u_xlat3.zw : u_xlat12.xy;
                    u_xlat12.xy = u_xlat1.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb4 = !!(_SmoothMaskFillParams.x==4.0);
#else
                    u_xlatb4 = _SmoothMaskFillParams.x==4.0;
#endif
                    u_xlat1.z = (u_xlatb4) ? u_xlat12.y : u_xlat1.y;
                    u_xlat12.xy = (u_xlatb1.w) ? u_xlat12.xy : u_xlat1.xz;
                    u_xlat12.x = u_xlat12.x * _SmoothMaskFillParams.w;
                    u_xlat1.x = min(abs(u_xlat12.y), abs(u_xlat12.x));
                    u_xlat7.x = max(abs(u_xlat12.y), abs(u_xlat12.x));
                    u_xlat7.x = float(1.0) / u_xlat7.x;
                    u_xlat1.x = u_xlat7.x * u_xlat1.x;
                    u_xlat7.x = u_xlat1.x * u_xlat1.x;
                    u_xlat13 = u_xlat7.x * 0.0208350997 + -0.0851330012;
                    u_xlat13 = u_xlat7.x * u_xlat13 + 0.180141002;
                    u_xlat13 = u_xlat7.x * u_xlat13 + -0.330299497;
                    u_xlat7.x = u_xlat7.x * u_xlat13 + 0.999866009;
                    u_xlat13 = u_xlat7.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb19 = !!(abs(u_xlat12.y)<abs(u_xlat12.x));
#else
                    u_xlatb19 = abs(u_xlat12.y)<abs(u_xlat12.x);
#endif
                    u_xlat13 = u_xlat13 * -2.0 + 1.57079637;
                    u_xlat13 = u_xlatb19 ? u_xlat13 : float(0.0);
                    u_xlat1.x = u_xlat1.x * u_xlat7.x + u_xlat13;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb7 = !!(u_xlat12.y<(-u_xlat12.y));
#else
                    u_xlatb7 = u_xlat12.y<(-u_xlat12.y);
#endif
                    u_xlat7.x = u_xlatb7 ? -3.14159274 : float(0.0);
                    u_xlat1.x = u_xlat7.x + u_xlat1.x;
                    u_xlat7.x = min(u_xlat12.y, u_xlat12.x);
                    u_xlat12.x = max(u_xlat12.y, u_xlat12.x);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb18 = !!(u_xlat7.x<(-u_xlat7.x));
#else
                    u_xlatb18 = u_xlat7.x<(-u_xlat7.x);
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb12 = !!(u_xlat12.x>=(-u_xlat12.x));
#else
                    u_xlatb12 = u_xlat12.x>=(-u_xlat12.x);
#endif
                    u_xlatb12 = u_xlatb12 && u_xlatb18;
                    u_xlat12.x = (u_xlatb12) ? (-u_xlat1.x) : u_xlat1.x;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
float u_xlat9;
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
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD2.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	mediump vec4 _OuterglowColor;
uniform 	vec4 _MiniMap_ST;
uniform 	mediump float _LineWarpSpeed;
uniform 	vec4 _WarpMask_ST;
uniform 	mediump float _FlowLine;
uniform 	mediump vec4 _FogRGBA;
uniform 	mediump vec4 _CloudColor3;
uniform 	mediump vec4 _CloudColor1;
uniform 	mediump vec3 _XYPannerAndSpeed02;
uniform 	mediump float _Cloud01Tiling;
uniform 	mediump float _Cloud02Tiling;
uniform 	vec4 _WarpCloud_ST;
uniform 	mediump vec3 _XYPannerAndSpeed01;
uniform 	mediump float _CloudOffset;
uniform 	mediump vec4 _CloudColor2;
uniform 	mediump vec4 _DownColor;
uniform 	mediump vec4 _StarCloudColor;
uniform 	mediump vec4 _StarColor;
uniform 	mediump float _StarMapTiling;
uniform 	mediump float _StarOffset;
uniform 	mediump vec4 _InnerglowColor;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _LineRange;
uniform 	mediump vec4 _LerpColor;
uniform lowp sampler2D _WarpMask;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _MiniMap;
uniform lowp sampler2D _WarpCloud;
uniform lowp sampler2D _CloudMap02;
uniform lowp sampler2D _CloudMap01;
uniform lowp sampler2D _StarCloudMap;
uniform lowp sampler2D _NoiseMap;
uniform lowp sampler2D _StarMap;
uniform lowp sampler2D _StarMask;
uniform lowp sampler2D _SmoothMaskTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
float u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
lowp float u_xlat10_6;
bvec2 u_xlatb6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
bool u_xlatb7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec2 u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat13;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
mediump vec2 u_xlat16_14;
vec2 u_xlat16;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
bool u_xlatb19;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MiniMap_ST.xy + _MiniMap_ST.zw;
    u_xlat12.x = _Time.y * _LineWarpSpeed;
    u_xlat1 = vs_TEXCOORD0.xyxy * _WarpMask_ST.xyxy + _WarpMask_ST.zwzw;
    u_xlat1 = u_xlat12.xxxx * vec4(0.5, 0.5, -0.5, 0.5) + u_xlat1;
    u_xlat10_12 = texture(_WarpMask, u_xlat1.xy).x;
    u_xlat16_2.x = u_xlat10_12 * 2.0 + -1.0;
    u_xlat10_12 = texture(_WarpMask, u_xlat1.zw).y;
    u_xlat16_2.y = u_xlat10_12 * 2.0 + -1.0;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_FlowLine) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_Mask, u_xlat16_2.xy);
    u_xlat16_2.x = dot(u_xlat10_1, _FogRGBA);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_MiniMap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + (-_OuterglowColor.xyz);
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_0.xyz + _OuterglowColor.xyz;
    u_xlat18 = _Time.y * _XYPannerAndSpeed02.z;
    u_xlat16_8.x = _Cloud01Tiling * _Cloud02Tiling;
    u_xlat1.xy = vs_TEXCOORD0.xy * _WarpCloud_ST.xy + _WarpCloud_ST.zw;
    u_xlat13 = _Time.y * 0.300000012;
    u_xlat1.xy = _Time.yy * vec2(0.0300000012, 0.0300000012) + u_xlat1.xy;
    u_xlat10_1.xy = texture(_WarpCloud, u_xlat1.xy).xy;
    u_xlat16_14.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_14.xy = u_xlat16_14.xy * vec2(0.0540000014, 0.0540000014);
    u_xlat16_3.xy = vs_TEXCOORD0.xy * u_xlat16_8.xx + u_xlat16_14.xy;
    u_xlat16_3.xy = vec2(u_xlat18) * _XYPannerAndSpeed02.xy + u_xlat16_3.xy;
    u_xlat10_18 = texture(_CloudMap02, u_xlat16_3.xy).x;
    u_xlat16_3.xyz = (-_CloudColor3.xyz) + _CloudColor1.xyz;
    u_xlat16_3.xyz = vec3(u_xlat10_18) * u_xlat16_3.xyz + _CloudColor3.xyz;
    u_xlat1.x = _Time.y * _XYPannerAndSpeed01.z;
    u_xlat7.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xz = u_xlat7.xx * vs_TEXCOORD2.xy;
    u_xlat16_8.x = _CloudOffset + -1.0;
    u_xlat16_14.xy = vs_TEXCOORD0.xy * vec2(vec2(_Cloud01Tiling, _Cloud01Tiling)) + u_xlat16_14.xy;
    u_xlat4.xy = (-u_xlat16_8.xx) * u_xlat7.xz + u_xlat16_14.xy;
    u_xlat16_8.xy = u_xlat1.xx * _XYPannerAndSpeed01.xy + u_xlat4.xy;
    u_xlat10_1.x = texture(_CloudMap01, u_xlat16_8.xy).x;
    u_xlat16_8.xyz = u_xlat10_1.xxx * _CloudColor2.xyz + (-u_xlat16_3.xyz);
    u_xlat16_8.xyz = u_xlat10_1.xxx * u_xlat16_8.xyz + u_xlat16_3.xyz;
    u_xlat16_3 = _Time.yyyy * vec4(0.00400000019, 0.00400000019, 0.00999999978, 0.00999999978) + vs_TEXCOORD0.xyxy;
    u_xlat10_4.x = texture(_StarCloudMap, u_xlat16_3.xy).x;
    u_xlat16_5.xyz = _StarCloudColor.xyz * u_xlat10_4.xxx + (-_DownColor.xyz);
    u_xlat16_5.xyz = u_xlat10_4.xxx * u_xlat16_5.xyz + _DownColor.xyz;
    u_xlat10_4.xy = texture(_NoiseMap, u_xlat16_3.zw).xy;
    u_xlat16.xy = vs_TEXCOORD0.xy * vec2(_StarMapTiling);
    u_xlat16_3.x = _StarOffset + -1.0;
    u_xlat7.xz = u_xlat16_3.xx * u_xlat7.xz + u_xlat16.xy;
    u_xlat16_3.xyz = _StarColor.xyz * vec3(50.0, 50.0, 50.0);
    u_xlat16_21 = sin(u_xlat13);
    u_xlat16_21 = abs(u_xlat16_21) * u_xlat10_4.y;
    u_xlat16_21 = u_xlat16_21 * u_xlat10_4.x;
    u_xlat10_7 = texture(_StarMap, u_xlat7.xz).x;
    u_xlat10_13 = texture(_StarMask, vs_TEXCOORD0.xy).x;
    u_xlat16_13 = max(u_xlat10_13, 9.99999975e-05);
    u_xlat16_13 = log2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * 2.25;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_7.x = u_xlat16_13 * u_xlat10_7;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(u_xlat16_21) + (-u_xlat16_5.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_4.xyz + u_xlat16_5.xyz;
    u_xlat16_3.x = u_xlat10_1.x + 0.300000012;
    u_xlat16_3.x = u_xlat10_18 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * 8.40336132;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9.x = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_9.x;
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_3.x = u_xlat16_2.x * 1.49600005;
    u_xlat16_9.xyz = u_xlat16_8.xyz * _InnerglowColor.xyz;
    u_xlat16_9.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(10.0, 10.0, 10.0);
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.800000012>=u_xlat16_2.x);
#else
    u_xlatb18 = 0.800000012>=u_xlat16_2.x;
#endif
    u_xlat16_21 = (u_xlatb18) ? 1.0 : 0.0;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_LineRange>=u_xlat16_2.x);
#else
    u_xlatb0.x = _LineRange>=u_xlat16_2.x;
#endif
    u_xlat16_5.x = (u_xlatb0.x) ? -1.0 : -0.0;
    u_xlat16_5.x = u_xlat16_21 + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _LineColor.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * vec3(0.699999988, 0.699999988, 0.699999988) + u_xlat16_3.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * _LerpColor.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(15.0, 15.0, 15.0) + (-u_xlat16_3.xyz);
    u_xlat16_8.xyz = u_xlat16_2.xxx * u_xlat16_8.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_8.xyz) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_ColorScaler);
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_21;
    if(_SmoothMaskType != 0) {
        u_xlatb6.xy = equal(ivec4(_SmoothMaskType), ivec4(1, 2, 0, 0)).xy;
        u_xlatb12 = u_xlatb6.y || u_xlatb6.x;
        if(u_xlatb12){
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
            u_xlat1.xy = vec2(vs_TEXCOORD1.z * _SmoothMaskSoftRanges.z, vs_TEXCOORD1.w * _SmoothMaskSoftRanges.w);
            u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
            u_xlat1.x = sqrt(u_xlat1.x);
            u_xlat1.x = u_xlat1.x + u_xlat1.x;
            u_xlat16_8.x = (u_xlatb18) ? u_xlat1.x : _SmoothMaskSoftRanges.z;
            u_xlat16_8.x = float(1.0) / u_xlat16_8.x;
            u_xlat16_8.x = u_xlat12.x * u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
            u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
            u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
            u_xlat16_14.x = u_xlat16_8.x * -2.0 + 3.0;
            u_xlat16_8.x = u_xlat16_8.x * u_xlat16_8.x;
            u_xlat16_8.x = u_xlat16_8.x * u_xlat16_14.x;
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
                    u_xlat1.x = (-u_xlat12.x) + 1.0;
                    u_xlat6.x = (u_xlatb18) ? u_xlat1.x : u_xlat12.x;
                } else {
                    u_xlatb1 = equal(_SmoothMaskFillParams.zzzx, vec4(1.0, 2.0, 3.0, 3.0));
                    u_xlat3 = vec4(vs_TEXCOORD1.w * float(1.0), vs_TEXCOORD1.z * float(-1.0), vs_TEXCOORD1.w * float(-1.0), vs_TEXCOORD1.z * float(1.0));
                    u_xlat12.xy = (u_xlatb1.z) ? u_xlat3.xy : vs_TEXCOORD1.zw;
                    u_xlat12.xy = (u_xlatb1.y) ? (-vs_TEXCOORD1.zw) : u_xlat12.xy;
                    u_xlat1.xy = (u_xlatb1.x) ? u_xlat3.zw : u_xlat12.xy;
                    u_xlat12.xy = u_xlat1.xy + vec2(0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb4 = !!(_SmoothMaskFillParams.x==4.0);
#else
                    u_xlatb4 = _SmoothMaskFillParams.x==4.0;
#endif
                    u_xlat1.z = (u_xlatb4) ? u_xlat12.y : u_xlat1.y;
                    u_xlat12.xy = (u_xlatb1.w) ? u_xlat12.xy : u_xlat1.xz;
                    u_xlat12.x = u_xlat12.x * _SmoothMaskFillParams.w;
                    u_xlat1.x = min(abs(u_xlat12.y), abs(u_xlat12.x));
                    u_xlat7.x = max(abs(u_xlat12.y), abs(u_xlat12.x));
                    u_xlat7.x = float(1.0) / u_xlat7.x;
                    u_xlat1.x = u_xlat7.x * u_xlat1.x;
                    u_xlat7.x = u_xlat1.x * u_xlat1.x;
                    u_xlat13 = u_xlat7.x * 0.0208350997 + -0.0851330012;
                    u_xlat13 = u_xlat7.x * u_xlat13 + 0.180141002;
                    u_xlat13 = u_xlat7.x * u_xlat13 + -0.330299497;
                    u_xlat7.x = u_xlat7.x * u_xlat13 + 0.999866009;
                    u_xlat13 = u_xlat7.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb19 = !!(abs(u_xlat12.y)<abs(u_xlat12.x));
#else
                    u_xlatb19 = abs(u_xlat12.y)<abs(u_xlat12.x);
#endif
                    u_xlat13 = u_xlat13 * -2.0 + 1.57079637;
                    u_xlat13 = u_xlatb19 ? u_xlat13 : float(0.0);
                    u_xlat1.x = u_xlat1.x * u_xlat7.x + u_xlat13;
#ifdef UNITY_ADRENO_ES3
                    u_xlatb7 = !!(u_xlat12.y<(-u_xlat12.y));
#else
                    u_xlatb7 = u_xlat12.y<(-u_xlat12.y);
#endif
                    u_xlat7.x = u_xlatb7 ? -3.14159274 : float(0.0);
                    u_xlat1.x = u_xlat7.x + u_xlat1.x;
                    u_xlat7.x = min(u_xlat12.y, u_xlat12.x);
                    u_xlat12.x = max(u_xlat12.y, u_xlat12.x);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb18 = !!(u_xlat7.x<(-u_xlat7.x));
#else
                    u_xlatb18 = u_xlat7.x<(-u_xlat7.x);
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb12 = !!(u_xlat12.x>=(-u_xlat12.x));
#else
                    u_xlatb12 = u_xlat12.x>=(-u_xlat12.x);
#endif
                    u_xlatb12 = u_xlatb12 && u_xlatb18;
                    u_xlat12.x = (u_xlatb12) ? (-u_xlat1.x) : u_xlat1.x;
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
 Pass {
  Name "PASS2"
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 101113
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
uniform 	mediump vec4 _OuterglowColor;
uniform 	vec4 _MiniMap_ST;
uniform 	mediump float _LineWarpSpeed;
uniform 	vec4 _WarpMask_ST;
uniform 	mediump float _FlowLine;
uniform 	mediump vec4 _FogRGBA;
uniform lowp sampler2D _WarpMask;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _MiniMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
lowp float u_xlat10_3;
void main()
{
    u_xlat0.x = _Time.y * _LineWarpSpeed;
    u_xlat1 = vs_TEXCOORD0.xyxy * _WarpMask_ST.xyxy + _WarpMask_ST.zwzw;
    u_xlat0 = u_xlat0.xxxx * vec4(0.5, 0.5, -0.5, 0.5) + u_xlat1;
    u_xlat10_0.x = texture(_WarpMask, u_xlat0.xy).x;
    u_xlat10_3 = texture(_WarpMask, u_xlat0.zw).y;
    u_xlat16_2.y = u_xlat10_3 * 2.0 + -1.0;
    u_xlat16_2.x = u_xlat10_0.x * 2.0 + -1.0;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_FlowLine) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_Mask, u_xlat16_2.xy);
    u_xlat16_2.x = dot(u_xlat10_0, _FogRGBA);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat0.xy = vs_TEXCOORD0.xy * _MiniMap_ST.xy + _MiniMap_ST.zw;
    u_xlat10_0.xyz = texture(_MiniMap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + (-_OuterglowColor.xyz);
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_0.xyz + _OuterglowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_ColorScaler);
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
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
uniform 	vec4 _Time;
uniform 	mediump float _ColorScaler;
uniform 	vec4 _ClipRect;
uniform 	mediump vec4 _OuterglowColor;
uniform 	vec4 _MiniMap_ST;
uniform 	mediump float _LineWarpSpeed;
uniform 	vec4 _WarpMask_ST;
uniform 	mediump float _FlowLine;
uniform 	mediump vec4 _FogRGBA;
uniform lowp sampler2D _WarpMask;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _MiniMap;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
lowp float u_xlat10_3;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat16_1 = u_xlat0.x * u_xlat0.y + -0.00100000005;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_1<0.0);
#else
    u_xlatb0.x = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = _Time.y * _LineWarpSpeed;
    u_xlat1 = vs_TEXCOORD0.xyxy * _WarpMask_ST.xyxy + _WarpMask_ST.zwzw;
    u_xlat0 = u_xlat0.xxxx * vec4(0.5, 0.5, -0.5, 0.5) + u_xlat1;
    u_xlat10_0.x = texture(_WarpMask, u_xlat0.xy).x;
    u_xlat10_3 = texture(_WarpMask, u_xlat0.zw).y;
    u_xlat16_2.y = u_xlat10_3 * 2.0 + -1.0;
    u_xlat16_2.x = u_xlat10_0.x * 2.0 + -1.0;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_FlowLine) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_Mask, u_xlat16_2.xy);
    u_xlat16_2.x = dot(u_xlat10_0, _FogRGBA);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat0.xy = vs_TEXCOORD0.xy * _MiniMap_ST.xy + _MiniMap_ST.zw;
    u_xlat10_0.xyz = texture(_MiniMap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + (-_OuterglowColor.xyz);
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_0.xyz + _OuterglowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_ColorScaler);
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
uniform 	mediump vec4 _OuterglowColor;
uniform 	vec4 _MiniMap_ST;
uniform 	mediump float _LineWarpSpeed;
uniform 	vec4 _WarpMask_ST;
uniform 	mediump float _FlowLine;
uniform 	mediump vec4 _FogRGBA;
uniform lowp sampler2D _WarpMask;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _MiniMap;
uniform lowp sampler2D _SmoothMaskTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
float u_xlat2;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
bool u_xlatb3;
vec2 u_xlat4;
lowp float u_xlat10_4;
bvec2 u_xlatb4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_6;
vec2 u_xlat8;
lowp float u_xlat10_8;
bool u_xlatb8;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat12;
bool u_xlatb12;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MiniMap_ST.xy + _MiniMap_ST.zw;
    u_xlat8.x = _Time.y * _LineWarpSpeed;
    u_xlat1 = vs_TEXCOORD0.xyxy * _WarpMask_ST.xyxy + _WarpMask_ST.zwzw;
    u_xlat1 = u_xlat8.xxxx * vec4(0.5, 0.5, -0.5, 0.5) + u_xlat1;
    u_xlat10_8 = texture(_WarpMask, u_xlat1.xy).x;
    u_xlat16_2.x = u_xlat10_8 * 2.0 + -1.0;
    u_xlat10_8 = texture(_WarpMask, u_xlat1.zw).y;
    u_xlat16_2.y = u_xlat10_8 * 2.0 + -1.0;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_FlowLine) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_Mask, u_xlat16_2.xy);
    u_xlat16_2.x = dot(u_xlat10_1, _FogRGBA);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_MiniMap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + (-_OuterglowColor.xyz);
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_0.xyz + _OuterglowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_ColorScaler);
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
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
uniform 	mediump vec4 _OuterglowColor;
uniform 	vec4 _MiniMap_ST;
uniform 	mediump float _LineWarpSpeed;
uniform 	vec4 _WarpMask_ST;
uniform 	mediump float _FlowLine;
uniform 	mediump vec4 _FogRGBA;
uniform lowp sampler2D _WarpMask;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _MiniMap;
uniform lowp sampler2D _SmoothMaskTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
float u_xlat2;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
bool u_xlatb3;
vec2 u_xlat4;
lowp float u_xlat10_4;
bvec2 u_xlatb4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_6;
vec2 u_xlat8;
lowp float u_xlat10_8;
bool u_xlatb8;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat12;
bool u_xlatb12;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MiniMap_ST.xy + _MiniMap_ST.zw;
    u_xlat8.x = _Time.y * _LineWarpSpeed;
    u_xlat1 = vs_TEXCOORD0.xyxy * _WarpMask_ST.xyxy + _WarpMask_ST.zwzw;
    u_xlat1 = u_xlat8.xxxx * vec4(0.5, 0.5, -0.5, 0.5) + u_xlat1;
    u_xlat10_8 = texture(_WarpMask, u_xlat1.xy).x;
    u_xlat16_2.x = u_xlat10_8 * 2.0 + -1.0;
    u_xlat10_8 = texture(_WarpMask, u_xlat1.zw).y;
    u_xlat16_2.y = u_xlat10_8 * 2.0 + -1.0;
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_FlowLine) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_Mask, u_xlat16_2.xy);
    u_xlat16_2.x = dot(u_xlat10_1, _FogRGBA);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_MiniMap, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + (-_OuterglowColor.xyz);
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_0.xyz + _OuterglowColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(_ColorScaler);
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb0));
    u_xlat0.xy = vec2(u_xlat0.z * u_xlat0.x, u_xlat0.w * u_xlat0.y);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
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