//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Particles/VertexAni_WorldPosMapping" {
Properties {
_DayColor ("DayColor", Color) = (1,1,1,1)
_MainColor ("MainColor", Color) = (1,1,1,1)
_ColorBrightness ("ColorBrightness", Float) = 1
_AlphaBrightness ("AlphaBrightness", Float) = 1
_BaseTex ("BaseTex", 2D) = "white" { }
_BaseTexChannelNum ("BaseTexChannelNum", Range(0, 4)) = 0
_BaseTexUVPannerXY ("BaseTexUVPanner(XY)", Vector) = (0,0,0,0)
_BaseTexAlphaScaler ("BaseTexAlphaScaler", Float) = 1
_DisplacementTex ("DisplacementTex", 2D) = "white" { }
_DisplaceChannel ("DisplaceChannel", Range(0, 4)) = 1
_OffsetValueXYSpeedZ ("OffsetValue(XY)Speed(Z)", Vector) = (-0.5,0.5,0,0)
_WPS_UVScaleValue ("WPS_UVScaleValue", Vector) = (64,64,64,0)
_WPS_DisplaceScale ("WPS_DisplaceScale", Vector) = (1,1,1,0)
_VertexColorAMaskDisplace ("VertexColor(A)MaskDisplace", Range(0, 1)) = 0
_VMaskFlip ("VMaskFlip", Range(0, 1)) = 0
_VMaskThreshold ("VMaskThreshold", Range(0, 10)) = 1
_VMaskOffset ("VMaskOffset", Range(-1, 1)) = 0
_SwitchUDirectionFloor ("SwitchUDirection(Floor)", Range(0, 1)) = 0
[Header(MiHoYoDepthFade)] [Toggle(_SOFTPARTICLES_ON)] _SOFTPARTICLES ("SOFTPARTICLES", Float) = 0
_DepthThresh ("DepthThresh", Range(0.001, 20)) = 1
_DepthFade ("DepthFade", Range(0.001, 20)) = 1
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
  GpuProgramID 56728
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_4.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_8 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_8 * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat16_4.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].yz * in_POSITION0.ww + u_xlat1.yz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xy = vec2(u_xlat2.x / _WPS_UVScaleValue.y, u_xlat2.y / _WPS_UVScaleValue.z);
    u_xlat2.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat2.xy;
    u_xlat2 = textureLod(_DisplacementTex, u_xlat2.xy, 0.0);
    u_xlat16_3 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat16_3.xy;
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * u_xlat16_3.z + u_xlat2.x;
    u_xlat2.x = u_xlat2.w * u_xlat16_3.w + u_xlat2.x;
    u_xlat16_4.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat2.x = u_xlat16_4.x + u_xlat2.x;
    u_xlat16_4.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_4.xyz = u_xlat16_4.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * in_NORMAL0.xyz;
    u_xlat2.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat5 * 0.5;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3 = vs_COLOR0.w * _DayColor.w;
    u_xlat3 = u_xlat3 * _MainColor.w;
    u_xlat3 = u_xlat3 * _AlphaBrightness;
    u_xlat0.w = u_xlat16_0.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_4.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_8 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_8 * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat16_4.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].yz * in_POSITION0.ww + u_xlat1.yz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xy = vec2(u_xlat2.x / _WPS_UVScaleValue.y, u_xlat2.y / _WPS_UVScaleValue.z);
    u_xlat2.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat2.xy;
    u_xlat2 = textureLod(_DisplacementTex, u_xlat2.xy, 0.0);
    u_xlat16_3 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat16_3.xy;
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * u_xlat16_3.z + u_xlat2.x;
    u_xlat2.x = u_xlat2.w * u_xlat16_3.w + u_xlat2.x;
    u_xlat16_4.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat2.x = u_xlat16_4.x + u_xlat2.x;
    u_xlat16_4.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_4.xyz = u_xlat16_4.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * in_NORMAL0.xyz;
    u_xlat2.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat5 * 0.5;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _DayColor.w;
    u_xlat3.x = u_xlat3.x * _MainColor.w;
    u_xlat3.x = u_xlat3.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_0.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6 * u_xlat9 + u_xlat3.x;
    u_xlat0.w = u_xlat3.x * u_xlat0.x;
    u_xlat2.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * _DayColor.xyz;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat7.xy = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yz * in_POSITION0.ww + u_xlat3.yz;
    u_xlat3 = u_xlat3 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xy = vec2(u_xlat7.x / _WPS_UVScaleValue.y, u_xlat7.y / _WPS_UVScaleValue.z);
    u_xlat7.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat7.xy;
    u_xlat4 = textureLod(_DisplacementTex, u_xlat7.xy, 0.0);
    u_xlat7.xy = u_xlat16_1.xy * u_xlat4.xy;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat4.z * u_xlat16_1.z + u_xlat7.x;
    u_xlat7.x = u_xlat4.w * u_xlat16_1.w + u_xlat7.x;
    u_xlat7.x = u_xlat16_5.x + u_xlat7.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat7.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat7.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat7.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3 = vs_COLOR0.w * _DayColor.w;
    u_xlat3 = u_xlat3 * _MainColor.w;
    u_xlat3 = u_xlat3 * _AlphaBrightness;
    u_xlat0.w = u_xlat16_0.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat7.xy = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yz * in_POSITION0.ww + u_xlat3.yz;
    u_xlat3 = u_xlat3 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xy = vec2(u_xlat7.x / _WPS_UVScaleValue.y, u_xlat7.y / _WPS_UVScaleValue.z);
    u_xlat7.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat7.xy;
    u_xlat4 = textureLod(_DisplacementTex, u_xlat7.xy, 0.0);
    u_xlat7.xy = u_xlat16_1.xy * u_xlat4.xy;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat4.z * u_xlat16_1.z + u_xlat7.x;
    u_xlat7.x = u_xlat4.w * u_xlat16_1.w + u_xlat7.x;
    u_xlat7.x = u_xlat16_5.x + u_xlat7.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat7.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat7.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat7.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _DayColor.w;
    u_xlat3.x = u_xlat3.x * _MainColor.w;
    u_xlat3.x = u_xlat3.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_0.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6 * u_xlat9 + u_xlat3.x;
    u_xlat0.w = u_xlat3.x * u_xlat0.x;
    u_xlat2.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_4.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_8 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_8 * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat16_4.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].yz * in_POSITION0.ww + u_xlat1.yz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xy = vec2(u_xlat2.x / _WPS_UVScaleValue.y, u_xlat2.y / _WPS_UVScaleValue.z);
    u_xlat2.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat2.xy;
    u_xlat2 = textureLod(_DisplacementTex, u_xlat2.xy, 0.0);
    u_xlat16_3 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat16_3.xy;
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * u_xlat16_3.z + u_xlat2.x;
    u_xlat2.x = u_xlat2.w * u_xlat16_3.w + u_xlat2.x;
    u_xlat16_4.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat2.x = u_xlat16_4.x + u_xlat2.x;
    u_xlat16_4.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_4.xyz = u_xlat16_4.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * in_NORMAL0.xyz;
    u_xlat2.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat5 * 0.5;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3 = vs_COLOR0.w * _DayColor.w;
    u_xlat3 = u_xlat3 * _MainColor.w;
    u_xlat3 = u_xlat3 * _AlphaBrightness;
    u_xlat0.w = u_xlat16_0.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_4.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_8 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_8 * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat16_4.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].yz * in_POSITION0.ww + u_xlat1.yz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xy = vec2(u_xlat2.x / _WPS_UVScaleValue.y, u_xlat2.y / _WPS_UVScaleValue.z);
    u_xlat2.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat2.xy;
    u_xlat2 = textureLod(_DisplacementTex, u_xlat2.xy, 0.0);
    u_xlat16_3 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat16_3.xy;
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * u_xlat16_3.z + u_xlat2.x;
    u_xlat2.x = u_xlat2.w * u_xlat16_3.w + u_xlat2.x;
    u_xlat16_4.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat2.x = u_xlat16_4.x + u_xlat2.x;
    u_xlat16_4.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_4.xyz = u_xlat16_4.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * in_NORMAL0.xyz;
    u_xlat2.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat5 * 0.5;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _DayColor.w;
    u_xlat3.x = u_xlat3.x * _MainColor.w;
    u_xlat3.x = u_xlat3.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_0.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6 * u_xlat9 + u_xlat3.x;
    u_xlat0.w = u_xlat3.x * u_xlat0.x;
    u_xlat2.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat7.xy = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yz * in_POSITION0.ww + u_xlat3.yz;
    u_xlat3 = u_xlat3 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xy = vec2(u_xlat7.x / _WPS_UVScaleValue.y, u_xlat7.y / _WPS_UVScaleValue.z);
    u_xlat7.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat7.xy;
    u_xlat4 = textureLod(_DisplacementTex, u_xlat7.xy, 0.0);
    u_xlat7.xy = u_xlat16_1.xy * u_xlat4.xy;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat4.z * u_xlat16_1.z + u_xlat7.x;
    u_xlat7.x = u_xlat4.w * u_xlat16_1.w + u_xlat7.x;
    u_xlat7.x = u_xlat16_5.x + u_xlat7.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat7.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat7.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat7.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3 = vs_COLOR0.w * _DayColor.w;
    u_xlat3 = u_xlat3 * _MainColor.w;
    u_xlat3 = u_xlat3 * _AlphaBrightness;
    u_xlat0.w = u_xlat16_0.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat7.xy = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yz * in_POSITION0.ww + u_xlat3.yz;
    u_xlat3 = u_xlat3 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xy = vec2(u_xlat7.x / _WPS_UVScaleValue.y, u_xlat7.y / _WPS_UVScaleValue.z);
    u_xlat7.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat7.xy;
    u_xlat4 = textureLod(_DisplacementTex, u_xlat7.xy, 0.0);
    u_xlat7.xy = u_xlat16_1.xy * u_xlat4.xy;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat4.z * u_xlat16_1.z + u_xlat7.x;
    u_xlat7.x = u_xlat4.w * u_xlat16_1.w + u_xlat7.x;
    u_xlat7.x = u_xlat16_5.x + u_xlat7.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat7.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat7.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat7.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _DayColor.w;
    u_xlat3.x = u_xlat3.x * _MainColor.w;
    u_xlat3.x = u_xlat3.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_0.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6 * u_xlat9 + u_xlat3.x;
    u_xlat0.w = u_xlat3.x * u_xlat0.x;
    u_xlat2.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * _DayColor.xyz;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_4.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_8 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_8 * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat16_4.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].yz * in_POSITION0.ww + u_xlat1.yz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xy = vec2(u_xlat2.x / _WPS_UVScaleValue.y, u_xlat2.y / _WPS_UVScaleValue.z);
    u_xlat2.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat2.xy;
    u_xlat2 = textureLod(_DisplacementTex, u_xlat2.xy, 0.0);
    u_xlat16_3 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat16_3.xy;
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * u_xlat16_3.z + u_xlat2.x;
    u_xlat2.x = u_xlat2.w * u_xlat16_3.w + u_xlat2.x;
    u_xlat16_4.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat2.x = u_xlat16_4.x + u_xlat2.x;
    u_xlat16_4.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_4.xyz = u_xlat16_4.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * in_NORMAL0.xyz;
    u_xlat2.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat5 * 0.5;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
vec4 u_xlat3;
float u_xlat4;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2 = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat3.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4 = vs_COLOR0.w * _DayColor.w;
    u_xlat4 = u_xlat4 * _MainColor.w;
    u_xlat4 = u_xlat4 * _AlphaBrightness;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3.w = u_xlat16_0.x * u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.w = min(max(u_xlat3.w, 0.0), 1.0);
#else
    u_xlat3.w = clamp(u_xlat3.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat3;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_4.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_8 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_8 * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat16_4.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].yz * in_POSITION0.ww + u_xlat1.yz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xy = vec2(u_xlat2.x / _WPS_UVScaleValue.y, u_xlat2.y / _WPS_UVScaleValue.z);
    u_xlat2.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat2.xy;
    u_xlat2 = textureLod(_DisplacementTex, u_xlat2.xy, 0.0);
    u_xlat16_3 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat16_3.xy;
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * u_xlat16_3.z + u_xlat2.x;
    u_xlat2.x = u_xlat2.w * u_xlat16_3.w + u_xlat2.x;
    u_xlat16_4.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat2.x = u_xlat16_4.x + u_xlat2.x;
    u_xlat16_4.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_4.xyz = u_xlat16_4.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * in_NORMAL0.xyz;
    u_xlat2.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat5 * 0.5;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat8;
float u_xlat13;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2 = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat8.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat13 + u_xlat8.x;
    u_xlat8.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat8.xyz = u_xlat8.xyz * _MainColor.xyz;
    u_xlat4.xyz = u_xlat8.xyz * _DayColor.xyz;
    u_xlat8.x = vs_COLOR0.w * _DayColor.w;
    u_xlat8.x = u_xlat8.x * _MainColor.w;
    u_xlat8.x = u_xlat8.x * _AlphaBrightness;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.w = u_xlat3.x * u_xlat0.x;
    SV_Target0 = u_xlat4;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat7.xy = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yz * in_POSITION0.ww + u_xlat3.yz;
    u_xlat3 = u_xlat3 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xy = vec2(u_xlat7.x / _WPS_UVScaleValue.y, u_xlat7.y / _WPS_UVScaleValue.z);
    u_xlat7.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat7.xy;
    u_xlat4 = textureLod(_DisplacementTex, u_xlat7.xy, 0.0);
    u_xlat7.xy = u_xlat16_1.xy * u_xlat4.xy;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat4.z * u_xlat16_1.z + u_xlat7.x;
    u_xlat7.x = u_xlat4.w * u_xlat16_1.w + u_xlat7.x;
    u_xlat7.x = u_xlat16_5.x + u_xlat7.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat7.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat7.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat7.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
vec4 u_xlat3;
float u_xlat4;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2 = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat3.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4 = vs_COLOR0.w * _DayColor.w;
    u_xlat4 = u_xlat4 * _MainColor.w;
    u_xlat4 = u_xlat4 * _AlphaBrightness;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3.w = u_xlat16_0.x * u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.w = min(max(u_xlat3.w, 0.0), 1.0);
#else
    u_xlat3.w = clamp(u_xlat3.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat3;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat7.xy = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yz * in_POSITION0.ww + u_xlat3.yz;
    u_xlat3 = u_xlat3 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xy = vec2(u_xlat7.x / _WPS_UVScaleValue.y, u_xlat7.y / _WPS_UVScaleValue.z);
    u_xlat7.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat7.xy;
    u_xlat4 = textureLod(_DisplacementTex, u_xlat7.xy, 0.0);
    u_xlat7.xy = u_xlat16_1.xy * u_xlat4.xy;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat4.z * u_xlat16_1.z + u_xlat7.x;
    u_xlat7.x = u_xlat4.w * u_xlat16_1.w + u_xlat7.x;
    u_xlat7.x = u_xlat16_5.x + u_xlat7.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat7.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat7.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat7.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat8;
float u_xlat13;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2 = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat8.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat13 + u_xlat8.x;
    u_xlat8.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat8.xyz = u_xlat8.xyz * _MainColor.xyz;
    u_xlat4.xyz = u_xlat8.xyz * _DayColor.xyz;
    u_xlat8.x = vs_COLOR0.w * _DayColor.w;
    u_xlat8.x = u_xlat8.x * _MainColor.w;
    u_xlat8.x = u_xlat8.x * _AlphaBrightness;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.w = u_xlat3.x * u_xlat0.x;
    SV_Target0 = u_xlat4;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_4.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_8 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_8 * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat16_4.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].yz * in_POSITION0.ww + u_xlat1.yz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xy = vec2(u_xlat2.x / _WPS_UVScaleValue.y, u_xlat2.y / _WPS_UVScaleValue.z);
    u_xlat2.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat2.xy;
    u_xlat2 = textureLod(_DisplacementTex, u_xlat2.xy, 0.0);
    u_xlat16_3 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat16_3.xy;
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * u_xlat16_3.z + u_xlat2.x;
    u_xlat2.x = u_xlat2.w * u_xlat16_3.w + u_xlat2.x;
    u_xlat16_4.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat2.x = u_xlat16_4.x + u_xlat2.x;
    u_xlat16_4.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_4.xyz = u_xlat16_4.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * in_NORMAL0.xyz;
    u_xlat2.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat5 * 0.5;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
vec4 u_xlat3;
float u_xlat4;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2 = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat3.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4 = vs_COLOR0.w * _DayColor.w;
    u_xlat4 = u_xlat4 * _MainColor.w;
    u_xlat4 = u_xlat4 * _AlphaBrightness;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3.w = u_xlat16_0.x * u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.w = min(max(u_xlat3.w, 0.0), 1.0);
#else
    u_xlat3.w = clamp(u_xlat3.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat3;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_4.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_8 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_8 * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat16_4.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].yz * in_POSITION0.ww + u_xlat1.yz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xy = vec2(u_xlat2.x / _WPS_UVScaleValue.y, u_xlat2.y / _WPS_UVScaleValue.z);
    u_xlat2.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat2.xy;
    u_xlat2 = textureLod(_DisplacementTex, u_xlat2.xy, 0.0);
    u_xlat16_3 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat16_3.xy;
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * u_xlat16_3.z + u_xlat2.x;
    u_xlat2.x = u_xlat2.w * u_xlat16_3.w + u_xlat2.x;
    u_xlat16_4.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat2.x = u_xlat16_4.x + u_xlat2.x;
    u_xlat16_4.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_4.xyz = u_xlat16_4.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * in_NORMAL0.xyz;
    u_xlat2.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat5 * 0.5;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat8;
float u_xlat13;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2 = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat8.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat13 + u_xlat8.x;
    u_xlat8.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat8.xyz = u_xlat8.xyz * _MainColor.xyz;
    u_xlat4.xyz = u_xlat8.xyz * _DayColor.xyz;
    u_xlat8.x = vs_COLOR0.w * _DayColor.w;
    u_xlat8.x = u_xlat8.x * _MainColor.w;
    u_xlat8.x = u_xlat8.x * _AlphaBrightness;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.w = u_xlat3.x * u_xlat0.x;
    SV_Target0 = u_xlat4;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat7.xy = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yz * in_POSITION0.ww + u_xlat3.yz;
    u_xlat3 = u_xlat3 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xy = vec2(u_xlat7.x / _WPS_UVScaleValue.y, u_xlat7.y / _WPS_UVScaleValue.z);
    u_xlat7.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat7.xy;
    u_xlat4 = textureLod(_DisplacementTex, u_xlat7.xy, 0.0);
    u_xlat7.xy = u_xlat16_1.xy * u_xlat4.xy;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat4.z * u_xlat16_1.z + u_xlat7.x;
    u_xlat7.x = u_xlat4.w * u_xlat16_1.w + u_xlat7.x;
    u_xlat7.x = u_xlat16_5.x + u_xlat7.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat7.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat7.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat7.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
vec4 u_xlat3;
float u_xlat4;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2 = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat3.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4 = vs_COLOR0.w * _DayColor.w;
    u_xlat4 = u_xlat4 * _MainColor.w;
    u_xlat4 = u_xlat4 * _AlphaBrightness;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3.w = u_xlat16_0.x * u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.w = min(max(u_xlat3.w, 0.0), 1.0);
#else
    u_xlat3.w = clamp(u_xlat3.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat3;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat7.xy = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yz * in_POSITION0.ww + u_xlat3.yz;
    u_xlat3 = u_xlat3 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xy = vec2(u_xlat7.x / _WPS_UVScaleValue.y, u_xlat7.y / _WPS_UVScaleValue.z);
    u_xlat7.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat7.xy;
    u_xlat4 = textureLod(_DisplacementTex, u_xlat7.xy, 0.0);
    u_xlat7.xy = u_xlat16_1.xy * u_xlat4.xy;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat4.z * u_xlat16_1.z + u_xlat7.x;
    u_xlat7.x = u_xlat4.w * u_xlat16_1.w + u_xlat7.x;
    u_xlat7.x = u_xlat16_5.x + u_xlat7.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat7.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat7.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat7.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat8;
float u_xlat13;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2 = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat8.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat13 + u_xlat8.x;
    u_xlat8.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat8.xyz = u_xlat8.xyz * _MainColor.xyz;
    u_xlat4.xyz = u_xlat8.xyz * _DayColor.xyz;
    u_xlat8.x = vs_COLOR0.w * _DayColor.w;
    u_xlat8.x = u_xlat8.x * _MainColor.w;
    u_xlat8.x = u_xlat8.x * _AlphaBrightness;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.w = u_xlat3.x * u_xlat0.x;
    SV_Target0 = u_xlat4;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_4.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_8 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_8 * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat16_4.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].yz * in_POSITION0.ww + u_xlat1.yz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xy = vec2(u_xlat2.x / _WPS_UVScaleValue.y, u_xlat2.y / _WPS_UVScaleValue.z);
    u_xlat2.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat2.xy;
    u_xlat2 = textureLod(_DisplacementTex, u_xlat2.xy, 0.0);
    u_xlat16_3 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat16_3.xy;
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * u_xlat16_3.z + u_xlat2.x;
    u_xlat2.x = u_xlat2.w * u_xlat16_3.w + u_xlat2.x;
    u_xlat16_4.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat2.x = u_xlat16_4.x + u_xlat2.x;
    u_xlat16_4.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_4.xyz = u_xlat16_4.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * in_NORMAL0.xyz;
    u_xlat2.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat5 * 0.5;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3 = vs_COLOR0.w * _DayColor.w;
    u_xlat3 = u_xlat3 * _MainColor.w;
    u_xlat3 = u_xlat3 * _AlphaBrightness;
    u_xlat0.w = u_xlat16_0.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_4.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_8 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_8 * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat16_4.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].yz * in_POSITION0.ww + u_xlat1.yz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xy = vec2(u_xlat2.x / _WPS_UVScaleValue.y, u_xlat2.y / _WPS_UVScaleValue.z);
    u_xlat2.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat2.xy;
    u_xlat2 = textureLod(_DisplacementTex, u_xlat2.xy, 0.0);
    u_xlat16_3 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat16_3.xy;
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * u_xlat16_3.z + u_xlat2.x;
    u_xlat2.x = u_xlat2.w * u_xlat16_3.w + u_xlat2.x;
    u_xlat16_4.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat2.x = u_xlat16_4.x + u_xlat2.x;
    u_xlat16_4.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_4.xyz = u_xlat16_4.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * in_NORMAL0.xyz;
    u_xlat2.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat5 * 0.5;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _DayColor.w;
    u_xlat3.x = u_xlat3.x * _MainColor.w;
    u_xlat3.x = u_xlat3.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_0.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6 * u_xlat9 + u_xlat3.x;
    u_xlat0.w = u_xlat3.x * u_xlat0.x;
    u_xlat2.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * _DayColor.xyz;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat7.xy = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yz * in_POSITION0.ww + u_xlat3.yz;
    u_xlat3 = u_xlat3 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xy = vec2(u_xlat7.x / _WPS_UVScaleValue.y, u_xlat7.y / _WPS_UVScaleValue.z);
    u_xlat7.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat7.xy;
    u_xlat4 = textureLod(_DisplacementTex, u_xlat7.xy, 0.0);
    u_xlat7.xy = u_xlat16_1.xy * u_xlat4.xy;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat4.z * u_xlat16_1.z + u_xlat7.x;
    u_xlat7.x = u_xlat4.w * u_xlat16_1.w + u_xlat7.x;
    u_xlat7.x = u_xlat16_5.x + u_xlat7.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat7.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat7.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat7.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3 = vs_COLOR0.w * _DayColor.w;
    u_xlat3 = u_xlat3 * _MainColor.w;
    u_xlat3 = u_xlat3 * _AlphaBrightness;
    u_xlat0.w = u_xlat16_0.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat7.xy = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yz * in_POSITION0.ww + u_xlat3.yz;
    u_xlat3 = u_xlat3 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xy = vec2(u_xlat7.x / _WPS_UVScaleValue.y, u_xlat7.y / _WPS_UVScaleValue.z);
    u_xlat7.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat7.xy;
    u_xlat4 = textureLod(_DisplacementTex, u_xlat7.xy, 0.0);
    u_xlat7.xy = u_xlat16_1.xy * u_xlat4.xy;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat4.z * u_xlat16_1.z + u_xlat7.x;
    u_xlat7.x = u_xlat4.w * u_xlat16_1.w + u_xlat7.x;
    u_xlat7.x = u_xlat16_5.x + u_xlat7.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat7.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat7.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat7.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _DayColor.w;
    u_xlat3.x = u_xlat3.x * _MainColor.w;
    u_xlat3.x = u_xlat3.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_0.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6 * u_xlat9 + u_xlat3.x;
    u_xlat0.w = u_xlat3.x * u_xlat0.x;
    u_xlat2.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_4.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_8 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_8 * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat16_4.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].yz * in_POSITION0.ww + u_xlat1.yz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xy = vec2(u_xlat2.x / _WPS_UVScaleValue.y, u_xlat2.y / _WPS_UVScaleValue.z);
    u_xlat2.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat2.xy;
    u_xlat2 = textureLod(_DisplacementTex, u_xlat2.xy, 0.0);
    u_xlat16_3 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat16_3.xy;
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * u_xlat16_3.z + u_xlat2.x;
    u_xlat2.x = u_xlat2.w * u_xlat16_3.w + u_xlat2.x;
    u_xlat16_4.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat2.x = u_xlat16_4.x + u_xlat2.x;
    u_xlat16_4.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_4.xyz = u_xlat16_4.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * in_NORMAL0.xyz;
    u_xlat2.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat5 * 0.5;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3 = vs_COLOR0.w * _DayColor.w;
    u_xlat3 = u_xlat3 * _MainColor.w;
    u_xlat3 = u_xlat3 * _AlphaBrightness;
    u_xlat0.w = u_xlat16_0.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_4.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_8 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_8 * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat16_4.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].yz * in_POSITION0.ww + u_xlat1.yz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xy = vec2(u_xlat2.x / _WPS_UVScaleValue.y, u_xlat2.y / _WPS_UVScaleValue.z);
    u_xlat2.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat2.xy;
    u_xlat2 = textureLod(_DisplacementTex, u_xlat2.xy, 0.0);
    u_xlat16_3 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat16_3.xy;
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * u_xlat16_3.z + u_xlat2.x;
    u_xlat2.x = u_xlat2.w * u_xlat16_3.w + u_xlat2.x;
    u_xlat16_4.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat2.x = u_xlat16_4.x + u_xlat2.x;
    u_xlat16_4.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_4.xyz = u_xlat16_4.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * in_NORMAL0.xyz;
    u_xlat2.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat5 * 0.5;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _DayColor.w;
    u_xlat3.x = u_xlat3.x * _MainColor.w;
    u_xlat3.x = u_xlat3.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_0.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6 * u_xlat9 + u_xlat3.x;
    u_xlat0.w = u_xlat3.x * u_xlat0.x;
    u_xlat2.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat7.xy = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yz * in_POSITION0.ww + u_xlat3.yz;
    u_xlat3 = u_xlat3 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xy = vec2(u_xlat7.x / _WPS_UVScaleValue.y, u_xlat7.y / _WPS_UVScaleValue.z);
    u_xlat7.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat7.xy;
    u_xlat4 = textureLod(_DisplacementTex, u_xlat7.xy, 0.0);
    u_xlat7.xy = u_xlat16_1.xy * u_xlat4.xy;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat4.z * u_xlat16_1.z + u_xlat7.x;
    u_xlat7.x = u_xlat4.w * u_xlat16_1.w + u_xlat7.x;
    u_xlat7.x = u_xlat16_5.x + u_xlat7.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat7.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat7.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat7.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3 = vs_COLOR0.w * _DayColor.w;
    u_xlat3 = u_xlat3 * _MainColor.w;
    u_xlat3 = u_xlat3 * _AlphaBrightness;
    u_xlat0.w = u_xlat16_0.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat7.xy = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yz * in_POSITION0.ww + u_xlat3.yz;
    u_xlat3 = u_xlat3 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xy = vec2(u_xlat7.x / _WPS_UVScaleValue.y, u_xlat7.y / _WPS_UVScaleValue.z);
    u_xlat7.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat7.xy;
    u_xlat4 = textureLod(_DisplacementTex, u_xlat7.xy, 0.0);
    u_xlat7.xy = u_xlat16_1.xy * u_xlat4.xy;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat4.z * u_xlat16_1.z + u_xlat7.x;
    u_xlat7.x = u_xlat4.w * u_xlat16_1.w + u_xlat7.x;
    u_xlat7.x = u_xlat16_5.x + u_xlat7.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat7.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat7.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat7.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _DayColor.w;
    u_xlat3.x = u_xlat3.x * _MainColor.w;
    u_xlat3.x = u_xlat3.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_0.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6 * u_xlat9 + u_xlat3.x;
    u_xlat0.w = u_xlat3.x * u_xlat0.x;
    u_xlat2.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat2.xyz * _DayColor.xyz;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_4.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_8 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_8 * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat16_4.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].yz * in_POSITION0.ww + u_xlat1.yz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xy = vec2(u_xlat2.x / _WPS_UVScaleValue.y, u_xlat2.y / _WPS_UVScaleValue.z);
    u_xlat2.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat2.xy;
    u_xlat2 = textureLod(_DisplacementTex, u_xlat2.xy, 0.0);
    u_xlat16_3 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat16_3.xy;
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * u_xlat16_3.z + u_xlat2.x;
    u_xlat2.x = u_xlat2.w * u_xlat16_3.w + u_xlat2.x;
    u_xlat16_4.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat2.x = u_xlat16_4.x + u_xlat2.x;
    u_xlat16_4.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_4.xyz = u_xlat16_4.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * in_NORMAL0.xyz;
    u_xlat2.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat5 * 0.5;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
vec4 u_xlat3;
float u_xlat4;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2 = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat3.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4 = vs_COLOR0.w * _DayColor.w;
    u_xlat4 = u_xlat4 * _MainColor.w;
    u_xlat4 = u_xlat4 * _AlphaBrightness;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3.w = u_xlat16_0.x * u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.w = min(max(u_xlat3.w, 0.0), 1.0);
#else
    u_xlat3.w = clamp(u_xlat3.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat3;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_4.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_8 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_8 * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat16_4.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].yz * in_POSITION0.ww + u_xlat1.yz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xy = vec2(u_xlat2.x / _WPS_UVScaleValue.y, u_xlat2.y / _WPS_UVScaleValue.z);
    u_xlat2.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat2.xy;
    u_xlat2 = textureLod(_DisplacementTex, u_xlat2.xy, 0.0);
    u_xlat16_3 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat16_3.xy;
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * u_xlat16_3.z + u_xlat2.x;
    u_xlat2.x = u_xlat2.w * u_xlat16_3.w + u_xlat2.x;
    u_xlat16_4.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat2.x = u_xlat16_4.x + u_xlat2.x;
    u_xlat16_4.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_4.xyz = u_xlat16_4.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * in_NORMAL0.xyz;
    u_xlat2.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat5 * 0.5;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat8;
float u_xlat13;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2 = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat8.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat13 + u_xlat8.x;
    u_xlat8.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat8.xyz = u_xlat8.xyz * _MainColor.xyz;
    u_xlat4.xyz = u_xlat8.xyz * _DayColor.xyz;
    u_xlat8.x = vs_COLOR0.w * _DayColor.w;
    u_xlat8.x = u_xlat8.x * _MainColor.w;
    u_xlat8.x = u_xlat8.x * _AlphaBrightness;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.w = u_xlat3.x * u_xlat0.x;
    SV_Target0 = u_xlat4;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat7.xy = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yz * in_POSITION0.ww + u_xlat3.yz;
    u_xlat3 = u_xlat3 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xy = vec2(u_xlat7.x / _WPS_UVScaleValue.y, u_xlat7.y / _WPS_UVScaleValue.z);
    u_xlat7.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat7.xy;
    u_xlat4 = textureLod(_DisplacementTex, u_xlat7.xy, 0.0);
    u_xlat7.xy = u_xlat16_1.xy * u_xlat4.xy;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat4.z * u_xlat16_1.z + u_xlat7.x;
    u_xlat7.x = u_xlat4.w * u_xlat16_1.w + u_xlat7.x;
    u_xlat7.x = u_xlat16_5.x + u_xlat7.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat7.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat7.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat7.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
vec4 u_xlat3;
float u_xlat4;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2 = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat3.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4 = vs_COLOR0.w * _DayColor.w;
    u_xlat4 = u_xlat4 * _MainColor.w;
    u_xlat4 = u_xlat4 * _AlphaBrightness;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3.w = u_xlat16_0.x * u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.w = min(max(u_xlat3.w, 0.0), 1.0);
#else
    u_xlat3.w = clamp(u_xlat3.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat3;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat7.xy = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yz * in_POSITION0.ww + u_xlat3.yz;
    u_xlat3 = u_xlat3 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xy = vec2(u_xlat7.x / _WPS_UVScaleValue.y, u_xlat7.y / _WPS_UVScaleValue.z);
    u_xlat7.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat7.xy;
    u_xlat4 = textureLod(_DisplacementTex, u_xlat7.xy, 0.0);
    u_xlat7.xy = u_xlat16_1.xy * u_xlat4.xy;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat4.z * u_xlat16_1.z + u_xlat7.x;
    u_xlat7.x = u_xlat4.w * u_xlat16_1.w + u_xlat7.x;
    u_xlat7.x = u_xlat16_5.x + u_xlat7.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat7.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat7.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat7.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat8;
float u_xlat13;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2 = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat8.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat13 + u_xlat8.x;
    u_xlat8.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat8.xyz = u_xlat8.xyz * _MainColor.xyz;
    u_xlat4.xyz = u_xlat8.xyz * _DayColor.xyz;
    u_xlat8.x = vs_COLOR0.w * _DayColor.w;
    u_xlat8.x = u_xlat8.x * _MainColor.w;
    u_xlat8.x = u_xlat8.x * _AlphaBrightness;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.w = u_xlat3.x * u_xlat0.x;
    SV_Target0 = u_xlat4;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_4.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_8 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_8 * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat16_4.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].yz * in_POSITION0.ww + u_xlat1.yz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xy = vec2(u_xlat2.x / _WPS_UVScaleValue.y, u_xlat2.y / _WPS_UVScaleValue.z);
    u_xlat2.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat2.xy;
    u_xlat2 = textureLod(_DisplacementTex, u_xlat2.xy, 0.0);
    u_xlat16_3 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat16_3.xy;
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * u_xlat16_3.z + u_xlat2.x;
    u_xlat2.x = u_xlat2.w * u_xlat16_3.w + u_xlat2.x;
    u_xlat16_4.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat2.x = u_xlat16_4.x + u_xlat2.x;
    u_xlat16_4.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_4.xyz = u_xlat16_4.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * in_NORMAL0.xyz;
    u_xlat2.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat5 * 0.5;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
vec4 u_xlat3;
float u_xlat4;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2 = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat3.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4 = vs_COLOR0.w * _DayColor.w;
    u_xlat4 = u_xlat4 * _MainColor.w;
    u_xlat4 = u_xlat4 * _AlphaBrightness;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3.w = u_xlat16_0.x * u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.w = min(max(u_xlat3.w, 0.0), 1.0);
#else
    u_xlat3.w = clamp(u_xlat3.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat3;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_8;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_4.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_8 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_8 * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat16_4.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].yz * in_POSITION0.ww + u_xlat1.yz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xy = vec2(u_xlat2.x / _WPS_UVScaleValue.y, u_xlat2.y / _WPS_UVScaleValue.z);
    u_xlat2.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat2.xy;
    u_xlat2 = textureLod(_DisplacementTex, u_xlat2.xy, 0.0);
    u_xlat16_3 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat16_3.xy;
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * u_xlat16_3.z + u_xlat2.x;
    u_xlat2.x = u_xlat2.w * u_xlat16_3.w + u_xlat2.x;
    u_xlat16_4.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat2.x = u_xlat16_4.x + u_xlat2.x;
    u_xlat16_4.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_4.xyz = u_xlat16_4.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * in_NORMAL0.xyz;
    u_xlat2.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat5 * 0.5;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat8;
float u_xlat13;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2 = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat8.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat13 + u_xlat8.x;
    u_xlat8.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat8.xyz = u_xlat8.xyz * _MainColor.xyz;
    u_xlat4.xyz = u_xlat8.xyz * _DayColor.xyz;
    u_xlat8.x = vs_COLOR0.w * _DayColor.w;
    u_xlat8.x = u_xlat8.x * _MainColor.w;
    u_xlat8.x = u_xlat8.x * _AlphaBrightness;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.w = u_xlat3.x * u_xlat0.x;
    SV_Target0 = u_xlat4;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat7.xy = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yz * in_POSITION0.ww + u_xlat3.yz;
    u_xlat3 = u_xlat3 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xy = vec2(u_xlat7.x / _WPS_UVScaleValue.y, u_xlat7.y / _WPS_UVScaleValue.z);
    u_xlat7.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat7.xy;
    u_xlat4 = textureLod(_DisplacementTex, u_xlat7.xy, 0.0);
    u_xlat7.xy = u_xlat16_1.xy * u_xlat4.xy;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat4.z * u_xlat16_1.z + u_xlat7.x;
    u_xlat7.x = u_xlat4.w * u_xlat16_1.w + u_xlat7.x;
    u_xlat7.x = u_xlat16_5.x + u_xlat7.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat7.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat7.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat7.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
vec4 u_xlat3;
float u_xlat4;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2 = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat3.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * _MainColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat4 = vs_COLOR0.w * _DayColor.w;
    u_xlat4 = u_xlat4 * _MainColor.w;
    u_xlat4 = u_xlat4 * _AlphaBrightness;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3.w = u_xlat16_0.x * u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.w = min(max(u_xlat3.w, 0.0), 1.0);
#else
    u_xlat3.w = clamp(u_xlat3.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat3;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat7.xy = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yz * in_POSITION0.ww + u_xlat3.yz;
    u_xlat3 = u_xlat3 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xy = vec2(u_xlat7.x / _WPS_UVScaleValue.y, u_xlat7.y / _WPS_UVScaleValue.z);
    u_xlat7.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat7.xy;
    u_xlat4 = textureLod(_DisplacementTex, u_xlat7.xy, 0.0);
    u_xlat7.xy = u_xlat16_1.xy * u_xlat4.xy;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat4.z * u_xlat16_1.z + u_xlat7.x;
    u_xlat7.x = u_xlat4.w * u_xlat16_1.w + u_xlat7.x;
    u_xlat7.x = u_xlat16_5.x + u_xlat7.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat7.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat7.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat0.zw;
    u_xlat2.w = u_xlat7.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
vec2 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat8;
float u_xlat13;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_2 = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat8.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat13 + u_xlat8.x;
    u_xlat8.xyz = vs_COLOR0.xyz * vec3(_ColorBrightness);
    u_xlat8.xyz = u_xlat8.xyz * _MainColor.xyz;
    u_xlat4.xyz = u_xlat8.xyz * _DayColor.xyz;
    u_xlat8.x = vs_COLOR0.w * _DayColor.w;
    u_xlat8.x = u_xlat8.x * _MainColor.w;
    u_xlat8.x = u_xlat8.x * _AlphaBrightness;
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_2 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.w = u_xlat3.x * u_xlat0.x;
    SV_Target0 = u_xlat4;
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
Keywords { "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
}
}
 Pass {
  Name "DISTORTIONVECTORS"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DISTORTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 73049
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump float u_xlat16_5;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.y * hlslcc_mtx4x4unity_ObjectToWorld[1].y, in_POSITION0.y * hlslcc_mtx4x4unity_ObjectToWorld[1].z);
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].yz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].yz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].yz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = vec2(u_xlat0.x / _WPS_UVScaleValue.y, u_xlat0.y / _WPS_UVScaleValue.z);
    u_xlat0.xy = _Time.yy * _OffsetValueXYSpeedZ.zz + u_xlat0.xy;
    u_xlat0 = textureLod(_DisplacementTex, u_xlat0.xy, 0.0);
    u_xlat16_1 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.xy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat16_1.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat16_1.w + u_xlat0.x;
    u_xlat16_1.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = (-_OffsetValueXYSpeedZ.x) + _OffsetValueXYSpeedZ.y;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _OffsetValueXYSpeedZ.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * in_NORMAL0.xyz;
    u_xlat16_2.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_2.xy = vec2(vec2(_VMaskFlip, _VMaskFlip)) * u_xlat16_2.xy + in_TEXCOORD0.yx;
    u_xlat16_2.xy = u_xlat16_2.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_2.xy = log2(u_xlat16_2.xy);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_2.xy = exp2(u_xlat16_2.xy);
    u_xlat16_2.xy = min(u_xlat16_2.xy, vec2(1.0, 1.0));
    u_xlat16_10 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_5 = floor(_SwitchUDirectionFloor);
    u_xlat16_10 = u_xlat16_5 * u_xlat16_10 + u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_10) + in_COLOR0.w;
    u_xlat16_10 = _VertexColorAMaskDisplace * u_xlat16_2.x + u_xlat16_10;
    u_xlat0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_8;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(vec2(_VMaskFlip, _VMaskFlip)) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_4.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_8 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_8 * u_xlat16_4.x + u_xlat16_0.x;
    u_xlat16_4.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_4.x + u_xlat16_0.x;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 3;
    u_xlat5.xy = vec2(in_POSITION0.y * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y, in_POSITION0.y * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z);
    u_xlat5.xy = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yz * in_POSITION0.xx + u_xlat5.xy;
    u_xlat5.xy = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yz * in_POSITION0.zz + u_xlat5.xy;
    u_xlat5.xy = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yz * in_POSITION0.ww + u_xlat5.xy;
    u_xlat5.xy = vec2(u_xlat5.x / _WPS_UVScaleValue.y, u_xlat5.y / _WPS_UVScaleValue.z);
    u_xlat5.xy = _Time.yy * _OffsetValueXYSpeedZ.zz + u_xlat5.xy;
    u_xlat2 = textureLod(_DisplacementTex, u_xlat5.xy, 0.0);
    u_xlat16_3 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat5.xy = u_xlat2.xy * u_xlat16_3.xy;
    u_xlat5.x = u_xlat5.y + u_xlat5.x;
    u_xlat5.x = u_xlat2.z * u_xlat16_3.z + u_xlat5.x;
    u_xlat5.x = u_xlat2.w * u_xlat16_3.w + u_xlat5.x;
    u_xlat16_4.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat5.x = u_xlat16_4.x + u_xlat5.x;
    u_xlat16_4.x = (-_OffsetValueXYSpeedZ.x) + _OffsetValueXYSpeedZ.y;
    u_xlat16_4.x = u_xlat5.x * u_xlat16_4.x + _OffsetValueXYSpeedZ.x;
    u_xlat16_4.xyz = u_xlat16_4.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * in_NORMAL0.xyz;
    u_xlat5.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat5.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat5.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat5.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
  GpuProgramID 171980
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].yz * in_POSITION0.ww + u_xlat1.yz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xy = vec2(u_xlat2.x / _WPS_UVScaleValue.y, u_xlat2.y / _WPS_UVScaleValue.z);
    u_xlat2.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat2.xy;
    u_xlat2 = textureLod(_DisplacementTex, u_xlat2.xy, 0.0);
    u_xlat16_3 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat16_3.xy;
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * u_xlat16_3.z + u_xlat2.x;
    u_xlat2.x = u_xlat2.w * u_xlat16_3.w + u_xlat2.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat2.x = u_xlat16_5.x + u_xlat2.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat2.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat2.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat4 = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat4 * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.x = u_xlat1.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat1.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
ivec2 u_xlati2;
float u_xlat3;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3 = vs_COLOR0.w * _DayColor.w;
    u_xlat3 = u_xlat3 * _MainColor.w;
    u_xlat3 = u_xlat3 * _AlphaBrightness;
    u_xlat0.x = u_xlat16_0.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati2.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat0.xy;
    SV_Target0.zw = vec2(0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].yz * in_POSITION0.ww + u_xlat1.yz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xy = vec2(u_xlat2.x / _WPS_UVScaleValue.y, u_xlat2.y / _WPS_UVScaleValue.z);
    u_xlat2.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat2.xy;
    u_xlat2 = textureLod(_DisplacementTex, u_xlat2.xy, 0.0);
    u_xlat16_3 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat16_3.xy;
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * u_xlat16_3.z + u_xlat2.x;
    u_xlat2.x = u_xlat2.w * u_xlat16_3.w + u_xlat2.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat2.x = u_xlat16_5.x + u_xlat2.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat2.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat2.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat4 = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat4 * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.x = u_xlat1.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat1.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
ivec2 u_xlati2;
vec2 u_xlat3;
vec2 u_xlat6;
ivec2 u_xlati6;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _DayColor.w;
    u_xlat3.x = u_xlat3.x * _MainColor.w;
    u_xlat3.x = u_xlat3.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_0.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
    u_xlat6.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6.x * u_xlat9 + u_xlat3.x;
    u_xlat16_1.x = u_xlat0.x * u_xlat3.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati2.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat0.xy;
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

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat7.xy = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yz * in_POSITION0.ww + u_xlat3.yz;
    u_xlat3 = u_xlat3 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xy = vec2(u_xlat7.x / _WPS_UVScaleValue.y, u_xlat7.y / _WPS_UVScaleValue.z);
    u_xlat7.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat7.xy;
    u_xlat4 = textureLod(_DisplacementTex, u_xlat7.xy, 0.0);
    u_xlat7.xy = u_xlat16_1.xy * u_xlat4.xy;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat4.z * u_xlat16_1.z + u_xlat7.x;
    u_xlat7.x = u_xlat4.w * u_xlat16_1.w + u_xlat7.x;
    u_xlat7.x = u_xlat16_5.x + u_xlat7.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat7.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat2.x * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat1 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat1;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat7.x = u_xlat1.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat7.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
ivec2 u_xlati2;
float u_xlat3;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3 = vs_COLOR0.w * _DayColor.w;
    u_xlat3 = u_xlat3 * _MainColor.w;
    u_xlat3 = u_xlat3 * _AlphaBrightness;
    u_xlat0.x = u_xlat16_0.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati2.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat0.xy;
    SV_Target0.zw = vec2(0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat7.xy = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yz * in_POSITION0.ww + u_xlat3.yz;
    u_xlat3 = u_xlat3 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xy = vec2(u_xlat7.x / _WPS_UVScaleValue.y, u_xlat7.y / _WPS_UVScaleValue.z);
    u_xlat7.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat7.xy;
    u_xlat4 = textureLod(_DisplacementTex, u_xlat7.xy, 0.0);
    u_xlat7.xy = u_xlat16_1.xy * u_xlat4.xy;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat4.z * u_xlat16_1.z + u_xlat7.x;
    u_xlat7.x = u_xlat4.w * u_xlat16_1.w + u_xlat7.x;
    u_xlat7.x = u_xlat16_5.x + u_xlat7.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat7.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat2.x * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat1 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat1;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat7.x = u_xlat1.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat7.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
ivec2 u_xlati2;
vec2 u_xlat3;
vec2 u_xlat6;
ivec2 u_xlati6;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _DayColor.w;
    u_xlat3.x = u_xlat3.x * _MainColor.w;
    u_xlat3.x = u_xlat3.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_0.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
    u_xlat6.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6.x * u_xlat9 + u_xlat3.x;
    u_xlat16_1.x = u_xlat0.x * u_xlat3.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati2.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat0.xy;
    SV_Target0.zw = vec2(0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].yz * in_POSITION0.ww + u_xlat1.yz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xy = vec2(u_xlat2.x / _WPS_UVScaleValue.y, u_xlat2.y / _WPS_UVScaleValue.z);
    u_xlat2.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat2.xy;
    u_xlat2 = textureLod(_DisplacementTex, u_xlat2.xy, 0.0);
    u_xlat16_3 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat16_3.xy;
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * u_xlat16_3.z + u_xlat2.x;
    u_xlat2.x = u_xlat2.w * u_xlat16_3.w + u_xlat2.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat2.x = u_xlat16_5.x + u_xlat2.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat2.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat2.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat4 = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat4 * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.x = u_xlat1.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat1.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
ivec2 u_xlati2;
float u_xlat3;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3 = vs_COLOR0.w * _DayColor.w;
    u_xlat3 = u_xlat3 * _MainColor.w;
    u_xlat3 = u_xlat3 * _AlphaBrightness;
    u_xlat0.x = u_xlat16_0.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati2.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat0.xy;
    SV_Target0.zw = vec2(0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].yz * in_POSITION0.ww + u_xlat1.yz;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.xy = vec2(u_xlat2.x / _WPS_UVScaleValue.y, u_xlat2.y / _WPS_UVScaleValue.z);
    u_xlat2.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat2.xy;
    u_xlat2 = textureLod(_DisplacementTex, u_xlat2.xy, 0.0);
    u_xlat16_3 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat16_3.xy;
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * u_xlat16_3.z + u_xlat2.x;
    u_xlat2.x = u_xlat2.w * u_xlat16_3.w + u_xlat2.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat2.x = u_xlat16_5.x + u_xlat2.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat2.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat2.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat4 = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat4 * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.x = u_xlat1.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat1.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	vec4 _ProjectionParams;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
ivec2 u_xlati2;
vec2 u_xlat3;
vec2 u_xlat6;
ivec2 u_xlati6;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _DayColor.w;
    u_xlat3.x = u_xlat3.x * _MainColor.w;
    u_xlat3.x = u_xlat3.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_0.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat6.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6.x * u_xlat9 + u_xlat3.x;
    u_xlat16_1.x = u_xlat0.x * u_xlat3.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati2.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat0.xy;
    SV_Target0.zw = vec2(0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat7.xy = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yz * in_POSITION0.ww + u_xlat3.yz;
    u_xlat3 = u_xlat3 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xy = vec2(u_xlat7.x / _WPS_UVScaleValue.y, u_xlat7.y / _WPS_UVScaleValue.z);
    u_xlat7.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat7.xy;
    u_xlat4 = textureLod(_DisplacementTex, u_xlat7.xy, 0.0);
    u_xlat7.xy = u_xlat16_1.xy * u_xlat4.xy;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat4.z * u_xlat16_1.z + u_xlat7.x;
    u_xlat7.x = u_xlat4.w * u_xlat16_1.w + u_xlat7.x;
    u_xlat7.x = u_xlat16_5.x + u_xlat7.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat7.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat2.x * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat1 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat1;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat7.x = u_xlat1.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat7.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
ivec2 u_xlati2;
float u_xlat3;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3 = vs_COLOR0.w * _DayColor.w;
    u_xlat3 = u_xlat3 * _MainColor.w;
    u_xlat3 = u_xlat3 * _AlphaBrightness;
    u_xlat0.x = u_xlat16_0.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati2.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat0.xy;
    SV_Target0.zw = vec2(0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump float _VMaskFlip;
uniform 	mediump float _VMaskOffset;
uniform 	mediump float _VMaskThreshold;
uniform 	mediump float _SwitchUDirectionFloor;
uniform 	mediump float _VertexColorAMaskDisplace;
uniform 	mediump vec3 _OffsetValueXYSpeedZ;
uniform 	mediump vec3 _WPS_UVScaleValue;
uniform 	mediump float _DisplaceChannel;
uniform 	mediump vec3 _WPS_DisplaceScale;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DisplacementTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.yx * vec2(-2.0, -2.0) + vec2(1.0, 1.0);
    u_xlat16_0.xy = vec2(_VMaskFlip) * u_xlat16_0.xy + in_TEXCOORD0.yx;
    u_xlat16_0.xy = u_xlat16_0.xy + (-vec2(vec2(_VMaskOffset, _VMaskOffset)));
    u_xlat16_0.xy = max(u_xlat16_0.xy, vec2(9.99999975e-05, 9.99999975e-05));
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(vec2(_VMaskThreshold, _VMaskThreshold));
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_0.y;
    u_xlat16_10 = floor(_SwitchUDirectionFloor);
    u_xlat16_0.x = u_xlat16_10 * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + in_COLOR0.w;
    u_xlat16_0.x = _VertexColorAMaskDisplace * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_5.x = min(abs(_DisplaceChannel), 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1 = (-vec4(vec4(_DisplaceChannel, _DisplaceChannel, _DisplaceChannel, _DisplaceChannel))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat7.xy = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yz * in_POSITION0.ww + u_xlat3.yz;
    u_xlat3 = u_xlat3 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xy = vec2(u_xlat7.x / _WPS_UVScaleValue.y, u_xlat7.y / _WPS_UVScaleValue.z);
    u_xlat7.xy = _Time.yy * vec2(_OffsetValueXYSpeedZ.z, _OffsetValueXYSpeedZ.z) + u_xlat7.xy;
    u_xlat4 = textureLod(_DisplacementTex, u_xlat7.xy, 0.0);
    u_xlat7.xy = u_xlat16_1.xy * u_xlat4.xy;
    u_xlat7.x = u_xlat7.y + u_xlat7.x;
    u_xlat7.x = u_xlat4.z * u_xlat16_1.z + u_xlat7.x;
    u_xlat7.x = u_xlat4.w * u_xlat16_1.w + u_xlat7.x;
    u_xlat7.x = u_xlat16_5.x + u_xlat7.x;
    u_xlat16_5.x = (-_OffsetValueXYSpeedZ.xxyz.y) + _OffsetValueXYSpeedZ.xxyz.z;
    u_xlat16_5.x = u_xlat7.x * u_xlat16_5.x + _OffsetValueXYSpeedZ.xxyz.y;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _WPS_DisplaceScale.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * in_NORMAL0.xyz;
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat0;
    u_xlat0 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat2.x * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat1 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat1;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat7.x = u_xlat1.y * _ProjectionParams.x;
    vs_TEXCOORD5.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat7.x * 0.5;
    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	vec4 _ProjectionParams;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	float _AlphaBrightness;
uniform 	mediump vec2 _BaseTexUVPannerXY;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexChannelNum;
uniform 	mediump float _BaseTexAlphaScaler;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
ivec2 u_xlati2;
vec2 u_xlat3;
vec2 u_xlat6;
ivec2 u_xlati6;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xy = _Time.yy * _BaseTexUVPannerXY.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_BaseTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_BaseTexChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_BaseTexChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_0.x * _BaseTexAlphaScaler;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _DayColor.w;
    u_xlat3.x = u_xlat3.x * _MainColor.w;
    u_xlat3.x = u_xlat3.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_0.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat6.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat6.x * u_xlat9 + u_xlat3.x;
    u_xlat16_1.x = u_xlat0.x * u_xlat3.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati2.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat0.xy;
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
Keywords { "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}