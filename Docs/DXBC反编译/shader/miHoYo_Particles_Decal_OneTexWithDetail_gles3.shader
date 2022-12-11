//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Particles/Decal_OneTexWithDetail" {
Properties {
[Toggle(ANNULAR_UV_ON)] _TurnOnAnnularUV ("Turn On Annular UV", Float) = 0
_MaxClampAngleCos ("Cos of the Max Clamp Angle (-1: not clamp)", Range(-1, 1)) = 0.5
_VerticalFadeExp ("Vertical Fade Exponent", Range(0, 100)) = 5
_VerticalFadeStart ("Vertical Fade Start Offset", Range(0.01, 1)) = 0.5
_ColorBrightness ("ColorBrightness", Float) = 1
_AlphaBrightness ("AlphaBrightness", Float) = 1
[Toggle(_2COLORLERPTOGGLE_ON)] _2ColorLerpToggle ("2ColorLerp[Toggle]", Float) = 0
_LerpColorDark ("LerpColorDark", Color) = (1,0.2689655,0,0)
_LerpColorLight ("LerpColorLight", Color) = (1,0.9326572,0.3897059,0)
_LerpBrightness ("LerpBrightness", Range(0, 20)) = 1
_BaseColor ("BaseColor", Color) = (1,1,1,0)
_BaseTex ("BaseTex", 2D) = "black" { }
[Enum(RGB,0,R,1,G,2,B,3,A,4,WhiteColor,5)] _BaseTexColorChannelSwitch ("BaseTexColorChannelSwitch", Float) = 0
[Enum(R,0,G,1,B,2,A,3,White,4)] _BaseTexAlphaChannelSwitch ("BaseTexAlphaChannelSwitch", Float) = 0
_DetailColor ("DetailColor", Color) = (1,1,1,0)
_DetailTex ("DetailTex", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _DetailTexColorChannelSwitch ("DetailTexColorChannelSwitch", Float) = 0
[Enum(R,0,G,1,B,2,A,3)] _DetailTexAlphaChannelSwitch ("DetailTexAlphaChannelSwitch", Float) = 3
_DetailTex_Uspeed ("DetailTex_Uspeed", Float) = 0
_DetailTex_Vspeed ("DetailTex_Vspeed", Float) = 0
_MeshParticleColorArray ("MeshParticleColorArray", Vector) = (1,1,1,1)
_MaskTex ("MaskTex", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _MaskTexChannelSwitch ("MaskTexChannelSwitch", Float) = 0
_MaskTex_Uspeed ("MaskTex_Uspeed", Float) = 0
_MaskTex_Vspeed ("MaskTex_Vspeed", Float) = 0
[Toggle(_NOISETEXTOGGLEONDETAIL_ON)] _NoiseTexToggleOnDetail ("NoiseTex[Toggle](OnDetail)", Float) = 0
_NoiseTex ("NoiseTex", 2D) = "black" { }
[Enum(R,0,G,1,B,2,A,3)] _NoiseTexChannelSwitch ("NoiseTexChannelSwitch", Float) = 0
_NoiseTex_Uspeed ("NoiseTex_Uspeed", Float) = 0.1
_NoiseTex_Vspeed ("NoiseTex_Vspeed", Float) = 0.1
_Noise_Brightness ("Noise_Brightness", Float) = 1
_Noise_Offset ("Noise_Offset", Float) = 0
_DayColor ("DayColor", Color) = (1,1,1,1)
}
SubShader {
 Tags { "QUEUE" = "Transparent-3" "RenderType" = "DeferredDecal" }
 Pass {
  Tags { "QUEUE" = "Transparent-3" "RenderType" = "DeferredDecal" }
  ZTest GEqual
  ZWrite Off
  Cull Front
  GpuProgramID 2288
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
lowp float u_xlat10_8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_8 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_1 = u_xlat10_8 * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat2.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat2.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat2.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat2.xy);
    u_xlat2.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat2.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat2.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat12;
    u_xlat2.xyz = vec3(u_xlat12) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_2COLORLERPTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec2 u_xlat8;
lowp float u_xlat10_8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_8 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_1 = u_xlat10_8 * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4.x = !!(u_xlat4.x<0.0);
#else
    u_xlatb4.x = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4.x) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat2.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat2.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat2.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat2.xy);
    u_xlat2.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat2.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat2.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb0.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb0.z) ? u_xlat2.z : u_xlat12;
    u_xlat4.x = (u_xlatb0.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat4.x;
    u_xlatb4.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat8.x = u_xlatb4.y ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb4.x) ? u_xlat1.w : u_xlat8.x;
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat4.x;
    u_xlatb8 = u_xlatb2.x || u_xlatb2.y;
    u_xlat4.x = (u_xlatb8) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + _LerpColorDark.xyz;
    u_xlat0.xyz = _DetailColor.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
lowp float u_xlat10_8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_8 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_1 = u_xlat10_8 * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat2.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat2.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat2.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + _Noise_Offset;
    u_xlat10.xy = u_xlat2.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat2.xy);
    u_xlat2.x = _Time.y * _DetailTex_Uspeed + u_xlat10.x;
    u_xlat2.y = _Time.y * _DetailTex_Vspeed + u_xlat10.y;
    u_xlat8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.xy;
    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat12;
    u_xlat2.xyz = vec3(u_xlat12) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
lowp float u_xlat10_8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_8 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_1 = u_xlat10_8 * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat2.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat2.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat2.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + _Noise_Offset;
    u_xlat10.xy = u_xlat2.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat2.xy);
    u_xlat2.x = _Time.y * _DetailTex_Uspeed + u_xlat10.x;
    u_xlat2.y = _Time.y * _DetailTex_Vspeed + u_xlat10.y;
    u_xlat8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.xy;
    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlatb4 = u_xlatb3.x || u_xlatb3.y;
    u_xlat0.x = (u_xlatb4) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _LerpColorDark.xyz;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat12;
    u_xlat0.xyz = _DetailColor.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
lowp float u_xlat10_8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_8 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_1 = u_xlat10_8 * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat2.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat2.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat2.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat2.xy);
    u_xlat2.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat2.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat2.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat12;
    u_xlat2.xyz = vec3(u_xlat12) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_2COLORLERPTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec2 u_xlat8;
lowp float u_xlat10_8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_8 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_1 = u_xlat10_8 * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4.x = !!(u_xlat4.x<0.0);
#else
    u_xlatb4.x = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4.x) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat2.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat2.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat2.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat2.xy);
    u_xlat2.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat2.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat2.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb0.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb0.z) ? u_xlat2.z : u_xlat12;
    u_xlat4.x = (u_xlatb0.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat4.x;
    u_xlatb4.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat8.x = u_xlatb4.y ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb4.x) ? u_xlat1.w : u_xlat8.x;
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat4.x;
    u_xlatb8 = u_xlatb2.x || u_xlatb2.y;
    u_xlat4.x = (u_xlatb8) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + _LerpColorDark.xyz;
    u_xlat0.xyz = _DetailColor.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
lowp float u_xlat10_8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_8 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_1 = u_xlat10_8 * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat2.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat2.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat2.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + _Noise_Offset;
    u_xlat10.xy = u_xlat2.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat2.xy);
    u_xlat2.x = _Time.y * _DetailTex_Uspeed + u_xlat10.x;
    u_xlat2.y = _Time.y * _DetailTex_Vspeed + u_xlat10.y;
    u_xlat8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.xy;
    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat12;
    u_xlat2.xyz = vec3(u_xlat12) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
lowp float u_xlat10_8;
bool u_xlatb8;
vec2 u_xlat10;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_8 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_1 = u_xlat10_8 * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat2.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat2.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat2.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + _Noise_Offset;
    u_xlat10.xy = u_xlat2.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat2.xy);
    u_xlat2.x = _Time.y * _DetailTex_Uspeed + u_xlat10.x;
    u_xlat2.y = _Time.y * _DetailTex_Vspeed + u_xlat10.y;
    u_xlat8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.xy;
    u_xlat2 = texture(_DetailTex, u_xlat8.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlatb4 = u_xlatb3.x || u_xlatb3.y;
    u_xlat0.x = (u_xlatb4) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _LerpColorDark.xyz;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat12;
    u_xlat0.xyz = _DetailColor.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat1.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat1.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat2 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat8.xy = u_xlat1.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat12;
    u_xlat1.xyz = vec3(u_xlat12) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" "_2COLORLERPTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4.x = !!(u_xlat4.x<0.0);
#else
    u_xlatb4.x = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4.x) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat1.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat1.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat2 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat8.xy = u_xlat1.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb0.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb0.z) ? u_xlat2.z : u_xlat12;
    u_xlat4.x = (u_xlatb0.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat4.x;
    u_xlatb4.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat8.x = u_xlatb4.y ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb4.x) ? u_xlat1.w : u_xlat8.x;
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat4.x;
    u_xlatb8 = u_xlatb2.x || u_xlatb2.y;
    u_xlat4.x = (u_xlatb8) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz + _LerpColorDark.xyz;
    u_xlat0.xyz = _DetailColor.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
vec2 u_xlat9;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat1.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat1.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat2 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat8.xy = u_xlat1.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_NoiseTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + _Noise_Offset;
    u_xlat9.xy = u_xlat1.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat1.xy);
    u_xlat1.x = _Time.y * _DetailTex_Uspeed + u_xlat9.x;
    u_xlat1.y = _Time.y * _DetailTex_Vspeed + u_xlat9.y;
    u_xlat8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xy;
    u_xlat1 = texture(_DetailTex, u_xlat8.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat2.xyz : u_xlat0.xxx;
    u_xlatb2 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat12 = (u_xlatb2.z) ? u_xlat1.z : u_xlat12;
    u_xlat12 = (u_xlatb2.y) ? u_xlat1.y : u_xlat12;
    u_xlat12 = (u_xlatb2.x) ? u_xlat1.x : u_xlat12;
    u_xlat1.xyz = vec3(u_xlat12) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
vec2 u_xlat9;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat1.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat1.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat2 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat8.xy = u_xlat1.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_NoiseTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + _Noise_Offset;
    u_xlat9.xy = u_xlat1.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat1.xy);
    u_xlat1.x = _Time.y * _DetailTex_Uspeed + u_xlat9.x;
    u_xlat1.y = _Time.y * _DetailTex_Vspeed + u_xlat9.y;
    u_xlat8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xy;
    u_xlat1 = texture(_DetailTex, u_xlat8.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlatb4 = u_xlatb3.x || u_xlatb3.y;
    u_xlat0.x = (u_xlatb4) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _LerpColorDark.xyz;
    u_xlatb2 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat12 = (u_xlatb2.z) ? u_xlat1.z : u_xlat12;
    u_xlat12 = (u_xlatb2.y) ? u_xlat1.y : u_xlat12;
    u_xlat12 = (u_xlatb2.x) ? u_xlat1.x : u_xlat12;
    u_xlat0.xyz = _DetailColor.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat1.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat1.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat2 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat8.xy = u_xlat1.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat12;
    u_xlat1.xyz = vec3(u_xlat12) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "_2COLORLERPTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4.x = !!(u_xlat4.x<0.0);
#else
    u_xlatb4.x = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4.x) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat1.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat1.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat2 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat8.xy = u_xlat1.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb0.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb0.z) ? u_xlat2.z : u_xlat12;
    u_xlat4.x = (u_xlatb0.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat4.x;
    u_xlatb4.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat8.x = u_xlatb4.y ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb4.x) ? u_xlat1.w : u_xlat8.x;
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat4.x;
    u_xlatb8 = u_xlatb2.x || u_xlatb2.y;
    u_xlat4.x = (u_xlatb8) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz + _LerpColorDark.xyz;
    u_xlat0.xyz = _DetailColor.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
vec2 u_xlat9;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat1.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat1.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat2 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat8.xy = u_xlat1.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_NoiseTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + _Noise_Offset;
    u_xlat9.xy = u_xlat1.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat1.xy);
    u_xlat1.x = _Time.y * _DetailTex_Uspeed + u_xlat9.x;
    u_xlat1.y = _Time.y * _DetailTex_Vspeed + u_xlat9.y;
    u_xlat8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xy;
    u_xlat1 = texture(_DetailTex, u_xlat8.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat2.xyz : u_xlat0.xxx;
    u_xlatb2 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat12 = (u_xlatb2.z) ? u_xlat1.z : u_xlat12;
    u_xlat12 = (u_xlatb2.y) ? u_xlat1.y : u_xlat12;
    u_xlat12 = (u_xlatb2.x) ? u_xlat1.x : u_xlat12;
    u_xlat1.xyz = vec3(u_xlat12) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
vec2 u_xlat9;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat1.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat1.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat2 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat8.xy = u_xlat1.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_NoiseTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + _Noise_Offset;
    u_xlat9.xy = u_xlat1.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat1.xy);
    u_xlat1.x = _Time.y * _DetailTex_Uspeed + u_xlat9.x;
    u_xlat1.y = _Time.y * _DetailTex_Vspeed + u_xlat9.y;
    u_xlat8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xy;
    u_xlat1 = texture(_DetailTex, u_xlat8.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlatb4 = u_xlatb3.x || u_xlatb3.y;
    u_xlat0.x = (u_xlatb4) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _LerpColorDark.xyz;
    u_xlatb2 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat12 = (u_xlatb2.z) ? u_xlat1.z : u_xlat12;
    u_xlat12 = (u_xlatb2.y) ? u_xlat1.y : u_xlat12;
    u_xlat12 = (u_xlatb2.x) ? u_xlat1.x : u_xlat12;
    u_xlat0.xyz = _DetailColor.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "ANNULAR_UV_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
bool u_xlatb13;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_10 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_1 = u_xlat10_10 * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat10.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.x = u_xlat0.x * u_xlat0.x;
    u_xlat15 = u_xlat10.x * 0.0208350997 + -0.0851330012;
    u_xlat15 = u_xlat10.x * u_xlat15 + 0.180141002;
    u_xlat15 = u_xlat10.x * u_xlat15 + -0.330299497;
    u_xlat10.x = u_xlat10.x * u_xlat15 + 0.999866009;
    u_xlat15 = u_xlat10.x * u_xlat0.x;
    u_xlat15 = u_xlat15 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb13 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat15 = u_xlatb13 ? u_xlat15 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat10.x + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb10 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat10.x = u_xlatb10 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat10.x + u_xlat0.x;
    u_xlat10.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat15 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=(-u_xlat15));
#else
    u_xlatb15 = u_xlat15>=(-u_xlat15);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10.x<(-u_xlat10.x));
#else
    u_xlatb10 = u_xlat10.x<(-u_xlat10.x);
#endif
    u_xlatb10 = u_xlatb15 && u_xlatb10;
    u_xlat0.x = (u_xlatb10) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat4.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat10.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat3.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat10.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat10.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat10.x;
    u_xlat15 = _DayColor.w * _AlphaBrightness;
    u_xlat15 = u_xlat15 * vs_COLOR0.w;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat5.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat15;
    u_xlat3.xyz = vec3(u_xlat15) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
bvec2 u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
bool u_xlatb13;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_10 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_1 = u_xlat10_10 * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat5.x<0.0);
#else
    u_xlatb5.x = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat10.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.x = u_xlat0.x * u_xlat0.x;
    u_xlat15 = u_xlat10.x * 0.0208350997 + -0.0851330012;
    u_xlat15 = u_xlat10.x * u_xlat15 + 0.180141002;
    u_xlat15 = u_xlat10.x * u_xlat15 + -0.330299497;
    u_xlat10.x = u_xlat10.x * u_xlat15 + 0.999866009;
    u_xlat15 = u_xlat10.x * u_xlat0.x;
    u_xlat15 = u_xlat15 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb13 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat15 = u_xlatb13 ? u_xlat15 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat10.x + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb10 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat10.x = u_xlatb10 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat10.x + u_xlat0.x;
    u_xlat10.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat15 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=(-u_xlat15));
#else
    u_xlatb15 = u_xlat15>=(-u_xlat15);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10.x<(-u_xlat10.x));
#else
    u_xlatb10 = u_xlat10.x<(-u_xlat10.x);
#endif
    u_xlatb10 = u_xlatb15 && u_xlatb10;
    u_xlat0.x = (u_xlatb10) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat4.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat10.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat3.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat10.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat10.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat10.x;
    u_xlat15 = _DayColor.w * _AlphaBrightness;
    u_xlat15 = u_xlat15 * vs_COLOR0.w;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb0.w ? u_xlat2.w : float(0.0);
    u_xlat10.x = (u_xlatb0.z) ? u_xlat2.z : u_xlat15;
    u_xlat5.x = (u_xlatb0.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat5.x;
    u_xlatb5.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat10.x = u_xlatb5.y ? 1.0 : float(0.0);
    u_xlat5.x = (u_xlatb5.x) ? u_xlat1.w : u_xlat10.x;
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat5.x;
    u_xlatb10 = u_xlatb2.x || u_xlatb2.y;
    u_xlat5.x = (u_xlatb10) ? u_xlat1.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat3.xyz + _LerpColorDark.xyz;
    u_xlat0.xyz = _DetailColor.xyz * u_xlat0.xxx + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "ANNULAR_UV_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat13;
bool u_xlatb13;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_10 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_1 = u_xlat10_10 * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat10.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.x = u_xlat0.x * u_xlat0.x;
    u_xlat15 = u_xlat10.x * 0.0208350997 + -0.0851330012;
    u_xlat15 = u_xlat10.x * u_xlat15 + 0.180141002;
    u_xlat15 = u_xlat10.x * u_xlat15 + -0.330299497;
    u_xlat10.x = u_xlat10.x * u_xlat15 + 0.999866009;
    u_xlat15 = u_xlat10.x * u_xlat0.x;
    u_xlat15 = u_xlat15 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb13 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat15 = u_xlatb13 ? u_xlat15 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat10.x + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb10 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat10.x = u_xlatb10 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat10.x + u_xlat0.x;
    u_xlat10.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat15 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=(-u_xlat15));
#else
    u_xlatb15 = u_xlat15>=(-u_xlat15);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10.x<(-u_xlat10.x));
#else
    u_xlatb10 = u_xlat10.x<(-u_xlat10.x);
#endif
    u_xlatb10 = u_xlatb15 && u_xlatb10;
    u_xlat0.x = (u_xlatb10) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat4.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat10.xy = u_xlat3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat4.x = _Time.y * _NoiseTex_Uspeed + u_xlat10.x;
    u_xlat4.y = _Time.y * _NoiseTex_Vspeed + u_xlat10.y;
    u_xlat1 = texture(_NoiseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat10.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat10.x = u_xlat10.x + _Noise_Offset;
    u_xlat13.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat3.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat13.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat13.y;
    u_xlat10.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat10.xx + u_xlat3.xy;
    u_xlat2 = texture(_DetailTex, u_xlat10.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat10.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat10.x;
    u_xlat15 = _DayColor.w * _AlphaBrightness;
    u_xlat15 = u_xlat15 * vs_COLOR0.w;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat5.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat15;
    u_xlat3.xyz = vec3(u_xlat15) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat13;
bool u_xlatb13;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_10 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_1 = u_xlat10_10 * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat10.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.x = u_xlat0.x * u_xlat0.x;
    u_xlat15 = u_xlat10.x * 0.0208350997 + -0.0851330012;
    u_xlat15 = u_xlat10.x * u_xlat15 + 0.180141002;
    u_xlat15 = u_xlat10.x * u_xlat15 + -0.330299497;
    u_xlat10.x = u_xlat10.x * u_xlat15 + 0.999866009;
    u_xlat15 = u_xlat10.x * u_xlat0.x;
    u_xlat15 = u_xlat15 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb13 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat15 = u_xlatb13 ? u_xlat15 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat10.x + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb10 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat10.x = u_xlatb10 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat10.x + u_xlat0.x;
    u_xlat10.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat15 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=(-u_xlat15));
#else
    u_xlatb15 = u_xlat15>=(-u_xlat15);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10.x<(-u_xlat10.x));
#else
    u_xlatb10 = u_xlat10.x<(-u_xlat10.x);
#endif
    u_xlatb10 = u_xlatb15 && u_xlatb10;
    u_xlat0.x = (u_xlatb10) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat4.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat10.xy = u_xlat3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat4.x = _Time.y * _NoiseTex_Uspeed + u_xlat10.x;
    u_xlat4.y = _Time.y * _NoiseTex_Vspeed + u_xlat10.y;
    u_xlat1 = texture(_NoiseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat10.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat10.x = u_xlat10.x + _Noise_Offset;
    u_xlat13.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat3.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat13.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat13.y;
    u_xlat10.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat10.xx + u_xlat3.xy;
    u_xlat2 = texture(_DetailTex, u_xlat10.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat10.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat10.x;
    u_xlat15 = _DayColor.w * _AlphaBrightness;
    u_xlat15 = u_xlat15 * vs_COLOR0.w;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat5.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlatb5 = u_xlatb3.x || u_xlatb3.y;
    u_xlat0.x = (u_xlatb5) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + _LerpColorDark.xyz;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat15;
    u_xlat0.xyz = _DetailColor.xyz * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "ANNULAR_UV_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
bool u_xlatb13;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_10 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_1 = u_xlat10_10 * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat10.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.x = u_xlat0.x * u_xlat0.x;
    u_xlat15 = u_xlat10.x * 0.0208350997 + -0.0851330012;
    u_xlat15 = u_xlat10.x * u_xlat15 + 0.180141002;
    u_xlat15 = u_xlat10.x * u_xlat15 + -0.330299497;
    u_xlat10.x = u_xlat10.x * u_xlat15 + 0.999866009;
    u_xlat15 = u_xlat10.x * u_xlat0.x;
    u_xlat15 = u_xlat15 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb13 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat15 = u_xlatb13 ? u_xlat15 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat10.x + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb10 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat10.x = u_xlatb10 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat10.x + u_xlat0.x;
    u_xlat10.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat15 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=(-u_xlat15));
#else
    u_xlatb15 = u_xlat15>=(-u_xlat15);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10.x<(-u_xlat10.x));
#else
    u_xlatb10 = u_xlat10.x<(-u_xlat10.x);
#endif
    u_xlatb10 = u_xlatb15 && u_xlatb10;
    u_xlat0.x = (u_xlatb10) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat4.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat10.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat3.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat10.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat10.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat10.x;
    u_xlat15 = _DayColor.w * _AlphaBrightness;
    u_xlat15 = u_xlat15 * vs_COLOR0.w;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat5.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat15;
    u_xlat3.xyz = vec3(u_xlat15) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
bvec2 u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
bool u_xlatb13;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_10 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_1 = u_xlat10_10 * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat5.x<0.0);
#else
    u_xlatb5.x = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat10.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.x = u_xlat0.x * u_xlat0.x;
    u_xlat15 = u_xlat10.x * 0.0208350997 + -0.0851330012;
    u_xlat15 = u_xlat10.x * u_xlat15 + 0.180141002;
    u_xlat15 = u_xlat10.x * u_xlat15 + -0.330299497;
    u_xlat10.x = u_xlat10.x * u_xlat15 + 0.999866009;
    u_xlat15 = u_xlat10.x * u_xlat0.x;
    u_xlat15 = u_xlat15 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb13 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat15 = u_xlatb13 ? u_xlat15 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat10.x + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb10 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat10.x = u_xlatb10 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat10.x + u_xlat0.x;
    u_xlat10.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat15 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=(-u_xlat15));
#else
    u_xlatb15 = u_xlat15>=(-u_xlat15);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10.x<(-u_xlat10.x));
#else
    u_xlatb10 = u_xlat10.x<(-u_xlat10.x);
#endif
    u_xlatb10 = u_xlatb15 && u_xlatb10;
    u_xlat0.x = (u_xlatb10) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat4.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat10.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat3.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat10.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat10.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat10.x;
    u_xlat15 = _DayColor.w * _AlphaBrightness;
    u_xlat15 = u_xlat15 * vs_COLOR0.w;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb0.w ? u_xlat2.w : float(0.0);
    u_xlat10.x = (u_xlatb0.z) ? u_xlat2.z : u_xlat15;
    u_xlat5.x = (u_xlatb0.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat5.x;
    u_xlatb5.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat10.x = u_xlatb5.y ? 1.0 : float(0.0);
    u_xlat5.x = (u_xlatb5.x) ? u_xlat1.w : u_xlat10.x;
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat5.x;
    u_xlatb10 = u_xlatb2.x || u_xlatb2.y;
    u_xlat5.x = (u_xlatb10) ? u_xlat1.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat3.xyz + _LerpColorDark.xyz;
    u_xlat0.xyz = _DetailColor.xyz * u_xlat0.xxx + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "ANNULAR_UV_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat13;
bool u_xlatb13;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_10 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_1 = u_xlat10_10 * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat10.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.x = u_xlat0.x * u_xlat0.x;
    u_xlat15 = u_xlat10.x * 0.0208350997 + -0.0851330012;
    u_xlat15 = u_xlat10.x * u_xlat15 + 0.180141002;
    u_xlat15 = u_xlat10.x * u_xlat15 + -0.330299497;
    u_xlat10.x = u_xlat10.x * u_xlat15 + 0.999866009;
    u_xlat15 = u_xlat10.x * u_xlat0.x;
    u_xlat15 = u_xlat15 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb13 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat15 = u_xlatb13 ? u_xlat15 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat10.x + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb10 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat10.x = u_xlatb10 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat10.x + u_xlat0.x;
    u_xlat10.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat15 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=(-u_xlat15));
#else
    u_xlatb15 = u_xlat15>=(-u_xlat15);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10.x<(-u_xlat10.x));
#else
    u_xlatb10 = u_xlat10.x<(-u_xlat10.x);
#endif
    u_xlatb10 = u_xlatb15 && u_xlatb10;
    u_xlat0.x = (u_xlatb10) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat4.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat10.xy = u_xlat3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat4.x = _Time.y * _NoiseTex_Uspeed + u_xlat10.x;
    u_xlat4.y = _Time.y * _NoiseTex_Vspeed + u_xlat10.y;
    u_xlat1 = texture(_NoiseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat10.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat10.x = u_xlat10.x + _Noise_Offset;
    u_xlat13.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat3.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat13.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat13.y;
    u_xlat10.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat10.xx + u_xlat3.xy;
    u_xlat2 = texture(_DetailTex, u_xlat10.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat10.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat10.x;
    u_xlat15 = _DayColor.w * _AlphaBrightness;
    u_xlat15 = u_xlat15 * vs_COLOR0.w;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat5.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat15;
    u_xlat3.xyz = vec3(u_xlat15) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat13;
bool u_xlatb13;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_10 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat16_1 = u_xlat10_10 * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat10.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.x = u_xlat0.x * u_xlat0.x;
    u_xlat15 = u_xlat10.x * 0.0208350997 + -0.0851330012;
    u_xlat15 = u_xlat10.x * u_xlat15 + 0.180141002;
    u_xlat15 = u_xlat10.x * u_xlat15 + -0.330299497;
    u_xlat10.x = u_xlat10.x * u_xlat15 + 0.999866009;
    u_xlat15 = u_xlat10.x * u_xlat0.x;
    u_xlat15 = u_xlat15 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb13 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat15 = u_xlatb13 ? u_xlat15 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat10.x + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb10 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat10.x = u_xlatb10 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat10.x + u_xlat0.x;
    u_xlat10.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat15 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=(-u_xlat15));
#else
    u_xlatb15 = u_xlat15>=(-u_xlat15);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10.x<(-u_xlat10.x));
#else
    u_xlatb10 = u_xlat10.x<(-u_xlat10.x);
#endif
    u_xlatb10 = u_xlatb15 && u_xlatb10;
    u_xlat0.x = (u_xlatb10) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat4.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat10.xy = u_xlat3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat4.x = _Time.y * _NoiseTex_Uspeed + u_xlat10.x;
    u_xlat4.y = _Time.y * _NoiseTex_Vspeed + u_xlat10.y;
    u_xlat1 = texture(_NoiseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat10.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat10.x = u_xlat10.x + _Noise_Offset;
    u_xlat13.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat3.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat13.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat13.y;
    u_xlat10.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat10.xx + u_xlat3.xy;
    u_xlat2 = texture(_DetailTex, u_xlat10.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat10.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat10.x;
    u_xlat15 = _DayColor.w * _AlphaBrightness;
    u_xlat15 = u_xlat15 * vs_COLOR0.w;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat5.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlatb5 = u_xlatb3.x || u_xlatb3.y;
    u_xlat0.x = (u_xlatb5) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + _LerpColorDark.xyz;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat15;
    u_xlat0.xyz = _DetailColor.xyz * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" "ANNULAR_UV_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
bool u_xlatb9;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat8.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
    u_xlat8.x = u_xlat0.x * u_xlat0.x;
    u_xlat12 = u_xlat8.x * 0.0208350997 + -0.0851330012;
    u_xlat12 = u_xlat8.x * u_xlat12 + 0.180141002;
    u_xlat12 = u_xlat8.x * u_xlat12 + -0.330299497;
    u_xlat8.x = u_xlat8.x * u_xlat12 + 0.999866009;
    u_xlat12 = u_xlat8.x * u_xlat0.x;
    u_xlat12 = u_xlat12 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb9 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat12 = u_xlatb9 ? u_xlat12 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat8.x + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb8 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat8.x = u_xlatb8 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat8.x + u_xlat0.x;
    u_xlat8.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat12 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12>=(-u_xlat12));
#else
    u_xlatb12 = u_xlat12>=(-u_xlat12);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8.x<(-u_xlat8.x));
#else
    u_xlatb8 = u_xlat8.x<(-u_xlat8.x);
#endif
    u_xlatb8 = u_xlatb12 && u_xlatb8;
    u_xlat0.x = (u_xlatb8) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat12;
    u_xlat1.xyz = vec3(u_xlat12) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
bool u_xlatb9;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4.x = !!(u_xlat4.x<0.0);
#else
    u_xlatb4.x = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4.x) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat8.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
    u_xlat8.x = u_xlat0.x * u_xlat0.x;
    u_xlat12 = u_xlat8.x * 0.0208350997 + -0.0851330012;
    u_xlat12 = u_xlat8.x * u_xlat12 + 0.180141002;
    u_xlat12 = u_xlat8.x * u_xlat12 + -0.330299497;
    u_xlat8.x = u_xlat8.x * u_xlat12 + 0.999866009;
    u_xlat12 = u_xlat8.x * u_xlat0.x;
    u_xlat12 = u_xlat12 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb9 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat12 = u_xlatb9 ? u_xlat12 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat8.x + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb8 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat8.x = u_xlatb8 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat8.x + u_xlat0.x;
    u_xlat8.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat12 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12>=(-u_xlat12));
#else
    u_xlatb12 = u_xlat12>=(-u_xlat12);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8.x<(-u_xlat8.x));
#else
    u_xlatb8 = u_xlat8.x<(-u_xlat8.x);
#endif
    u_xlatb8 = u_xlatb12 && u_xlatb8;
    u_xlat0.x = (u_xlatb8) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb0.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb0.z) ? u_xlat2.z : u_xlat12;
    u_xlat4.x = (u_xlatb0.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat4.x;
    u_xlatb4.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat8.x = u_xlatb4.y ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb4.x) ? u_xlat1.w : u_xlat8.x;
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat4.x;
    u_xlatb8 = u_xlatb2.x || u_xlatb2.y;
    u_xlat4.x = (u_xlatb8) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz + _LerpColorDark.xyz;
    u_xlat0.xyz = _DetailColor.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
vec2 u_xlat9;
bool u_xlatb9;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat8.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
    u_xlat8.x = u_xlat0.x * u_xlat0.x;
    u_xlat12 = u_xlat8.x * 0.0208350997 + -0.0851330012;
    u_xlat12 = u_xlat8.x * u_xlat12 + 0.180141002;
    u_xlat12 = u_xlat8.x * u_xlat12 + -0.330299497;
    u_xlat8.x = u_xlat8.x * u_xlat12 + 0.999866009;
    u_xlat12 = u_xlat8.x * u_xlat0.x;
    u_xlat12 = u_xlat12 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb9 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat12 = u_xlatb9 ? u_xlat12 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat8.x + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb8 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat8.x = u_xlatb8 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat8.x + u_xlat0.x;
    u_xlat8.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat12 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12>=(-u_xlat12));
#else
    u_xlatb12 = u_xlat12>=(-u_xlat12);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8.x<(-u_xlat8.x));
#else
    u_xlatb8 = u_xlat8.x<(-u_xlat8.x);
#endif
    u_xlatb8 = u_xlatb12 && u_xlatb8;
    u_xlat0.x = (u_xlatb8) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + _Noise_Offset;
    u_xlat1.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat9.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat9.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat1.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat1.y;
    u_xlat8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat3.xy;
    u_xlat1 = texture(_DetailTex, u_xlat8.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat2.xyz : u_xlat0.xxx;
    u_xlatb2 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat12 = (u_xlatb2.z) ? u_xlat1.z : u_xlat12;
    u_xlat12 = (u_xlatb2.y) ? u_xlat1.y : u_xlat12;
    u_xlat12 = (u_xlatb2.x) ? u_xlat1.x : u_xlat12;
    u_xlat1.xyz = vec3(u_xlat12) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
vec2 u_xlat9;
bool u_xlatb9;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat8.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
    u_xlat8.x = u_xlat0.x * u_xlat0.x;
    u_xlat12 = u_xlat8.x * 0.0208350997 + -0.0851330012;
    u_xlat12 = u_xlat8.x * u_xlat12 + 0.180141002;
    u_xlat12 = u_xlat8.x * u_xlat12 + -0.330299497;
    u_xlat8.x = u_xlat8.x * u_xlat12 + 0.999866009;
    u_xlat12 = u_xlat8.x * u_xlat0.x;
    u_xlat12 = u_xlat12 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb9 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat12 = u_xlatb9 ? u_xlat12 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat8.x + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb8 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat8.x = u_xlatb8 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat8.x + u_xlat0.x;
    u_xlat8.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat12 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12>=(-u_xlat12));
#else
    u_xlatb12 = u_xlat12>=(-u_xlat12);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8.x<(-u_xlat8.x));
#else
    u_xlatb8 = u_xlat8.x<(-u_xlat8.x);
#endif
    u_xlatb8 = u_xlatb12 && u_xlatb8;
    u_xlat0.x = (u_xlatb8) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + _Noise_Offset;
    u_xlat1.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat9.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat9.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat1.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat1.y;
    u_xlat8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat3.xy;
    u_xlat1 = texture(_DetailTex, u_xlat8.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlatb4 = u_xlatb3.x || u_xlatb3.y;
    u_xlat0.x = (u_xlatb4) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _LerpColorDark.xyz;
    u_xlatb2 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat12 = (u_xlatb2.z) ? u_xlat1.z : u_xlat12;
    u_xlat12 = (u_xlatb2.y) ? u_xlat1.y : u_xlat12;
    u_xlat12 = (u_xlatb2.x) ? u_xlat1.x : u_xlat12;
    u_xlat0.xyz = _DetailColor.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
bool u_xlatb9;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat8.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
    u_xlat8.x = u_xlat0.x * u_xlat0.x;
    u_xlat12 = u_xlat8.x * 0.0208350997 + -0.0851330012;
    u_xlat12 = u_xlat8.x * u_xlat12 + 0.180141002;
    u_xlat12 = u_xlat8.x * u_xlat12 + -0.330299497;
    u_xlat8.x = u_xlat8.x * u_xlat12 + 0.999866009;
    u_xlat12 = u_xlat8.x * u_xlat0.x;
    u_xlat12 = u_xlat12 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb9 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat12 = u_xlatb9 ? u_xlat12 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat8.x + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb8 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat8.x = u_xlatb8 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat8.x + u_xlat0.x;
    u_xlat8.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat12 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12>=(-u_xlat12));
#else
    u_xlatb12 = u_xlat12>=(-u_xlat12);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8.x<(-u_xlat8.x));
#else
    u_xlatb8 = u_xlat8.x<(-u_xlat8.x);
#endif
    u_xlatb8 = u_xlatb12 && u_xlatb8;
    u_xlat0.x = (u_xlatb8) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat12;
    u_xlat1.xyz = vec3(u_xlat12) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
bool u_xlatb9;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4.x = !!(u_xlat4.x<0.0);
#else
    u_xlatb4.x = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4.x) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat8.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
    u_xlat8.x = u_xlat0.x * u_xlat0.x;
    u_xlat12 = u_xlat8.x * 0.0208350997 + -0.0851330012;
    u_xlat12 = u_xlat8.x * u_xlat12 + 0.180141002;
    u_xlat12 = u_xlat8.x * u_xlat12 + -0.330299497;
    u_xlat8.x = u_xlat8.x * u_xlat12 + 0.999866009;
    u_xlat12 = u_xlat8.x * u_xlat0.x;
    u_xlat12 = u_xlat12 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb9 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat12 = u_xlatb9 ? u_xlat12 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat8.x + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb8 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat8.x = u_xlatb8 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat8.x + u_xlat0.x;
    u_xlat8.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat12 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12>=(-u_xlat12));
#else
    u_xlatb12 = u_xlat12>=(-u_xlat12);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8.x<(-u_xlat8.x));
#else
    u_xlatb8 = u_xlat8.x<(-u_xlat8.x);
#endif
    u_xlatb8 = u_xlatb12 && u_xlatb8;
    u_xlat0.x = (u_xlatb8) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb0.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb0.z) ? u_xlat2.z : u_xlat12;
    u_xlat4.x = (u_xlatb0.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat4.x;
    u_xlatb4.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat8.x = u_xlatb4.y ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb4.x) ? u_xlat1.w : u_xlat8.x;
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat4.x;
    u_xlatb8 = u_xlatb2.x || u_xlatb2.y;
    u_xlat4.x = (u_xlatb8) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz + _LerpColorDark.xyz;
    u_xlat0.xyz = _DetailColor.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
vec2 u_xlat9;
bool u_xlatb9;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat8.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
    u_xlat8.x = u_xlat0.x * u_xlat0.x;
    u_xlat12 = u_xlat8.x * 0.0208350997 + -0.0851330012;
    u_xlat12 = u_xlat8.x * u_xlat12 + 0.180141002;
    u_xlat12 = u_xlat8.x * u_xlat12 + -0.330299497;
    u_xlat8.x = u_xlat8.x * u_xlat12 + 0.999866009;
    u_xlat12 = u_xlat8.x * u_xlat0.x;
    u_xlat12 = u_xlat12 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb9 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat12 = u_xlatb9 ? u_xlat12 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat8.x + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb8 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat8.x = u_xlatb8 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat8.x + u_xlat0.x;
    u_xlat8.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat12 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12>=(-u_xlat12));
#else
    u_xlatb12 = u_xlat12>=(-u_xlat12);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8.x<(-u_xlat8.x));
#else
    u_xlatb8 = u_xlat8.x<(-u_xlat8.x);
#endif
    u_xlatb8 = u_xlatb12 && u_xlatb8;
    u_xlat0.x = (u_xlatb8) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + _Noise_Offset;
    u_xlat1.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat9.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat9.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat1.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat1.y;
    u_xlat8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat3.xy;
    u_xlat1 = texture(_DetailTex, u_xlat8.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat2.xyz : u_xlat0.xxx;
    u_xlatb2 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat12 = (u_xlatb2.z) ? u_xlat1.z : u_xlat12;
    u_xlat12 = (u_xlatb2.y) ? u_xlat1.y : u_xlat12;
    u_xlat12 = (u_xlatb2.x) ? u_xlat1.x : u_xlat12;
    u_xlat1.xyz = vec3(u_xlat12) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
vec2 u_xlat9;
bool u_xlatb9;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat8.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
    u_xlat8.x = u_xlat0.x * u_xlat0.x;
    u_xlat12 = u_xlat8.x * 0.0208350997 + -0.0851330012;
    u_xlat12 = u_xlat8.x * u_xlat12 + 0.180141002;
    u_xlat12 = u_xlat8.x * u_xlat12 + -0.330299497;
    u_xlat8.x = u_xlat8.x * u_xlat12 + 0.999866009;
    u_xlat12 = u_xlat8.x * u_xlat0.x;
    u_xlat12 = u_xlat12 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb9 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat12 = u_xlatb9 ? u_xlat12 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat8.x + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb8 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat8.x = u_xlatb8 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat8.x + u_xlat0.x;
    u_xlat8.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat12 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12>=(-u_xlat12));
#else
    u_xlatb12 = u_xlat12>=(-u_xlat12);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8.x<(-u_xlat8.x));
#else
    u_xlatb8 = u_xlat8.x<(-u_xlat8.x);
#endif
    u_xlatb8 = u_xlatb12 && u_xlatb8;
    u_xlat0.x = (u_xlatb8) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + _Noise_Offset;
    u_xlat1.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat9.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat9.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat1.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat1.y;
    u_xlat8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat3.xy;
    u_xlat1 = texture(_DetailTex, u_xlat8.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlatb4 = u_xlatb3.x || u_xlatb3.y;
    u_xlat0.x = (u_xlatb4) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _LerpColorDark.xyz;
    u_xlatb2 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat12 = (u_xlatb2.z) ? u_xlat1.z : u_xlat12;
    u_xlat12 = (u_xlatb2.y) ? u_xlat1.y : u_xlat12;
    u_xlat12 = (u_xlatb2.x) ? u_xlat1.x : u_xlat12;
    u_xlat0.xyz = _DetailColor.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
lowp float u_xlat10_8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_8 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat16_1 = u_xlat10_8 * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat2.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat2.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat2.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat2.xy);
    u_xlat2.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat2.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat2.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat12;
    u_xlat2.xyz = vec3(u_xlat12) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_2COLORLERPTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec2 u_xlat8;
lowp float u_xlat10_8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_8 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat16_1 = u_xlat10_8 * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4.x = !!(u_xlat4.x<0.0);
#else
    u_xlatb4.x = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4.x) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat2.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat2.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat2.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat2.xy);
    u_xlat2.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat2.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat2.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb0.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb0.z) ? u_xlat2.z : u_xlat12;
    u_xlat4.x = (u_xlatb0.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat4.x;
    u_xlatb4.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat8.x = u_xlatb4.y ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb4.x) ? u_xlat1.w : u_xlat8.x;
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat4.x;
    u_xlatb8 = u_xlatb2.x || u_xlatb2.y;
    u_xlat4.x = (u_xlatb8) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + _LerpColorDark.xyz;
    u_xlat0.xyz = _DetailColor.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
bvec4 u_xlatb4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_10 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat16_1 = u_xlat10_10 * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat2.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat2.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_NoiseTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat10.xy = u_xlat2.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat10.y;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat3.xy;
    u_xlat1 = texture(_DetailTex, u_xlat0.xz);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat10.x = _DayColor.w * _AlphaBrightness;
    u_xlat10.x = u_xlat10.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.xy = u_xlat2.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat2.xy);
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat10.y;
    u_xlat3 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb4.w ? u_xlat3.w : float(0.0);
    u_xlat10.x = (u_xlatb4.z) ? u_xlat3.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb4.y) ? u_xlat3.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb4.x) ? u_xlat3.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.w : u_xlat5.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat2.xyz : u_xlat0.xxx;
    u_xlatb2 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat15 = (u_xlatb2.z) ? u_xlat1.z : u_xlat15;
    u_xlat15 = (u_xlatb2.y) ? u_xlat1.y : u_xlat15;
    u_xlat15 = (u_xlatb2.x) ? u_xlat1.x : u_xlat15;
    u_xlat2.xyz = vec3(u_xlat15) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
bvec4 u_xlatb4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_10 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat16_1 = u_xlat10_10 * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat2.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat2.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_NoiseTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat10.xy = u_xlat2.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat10.y;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat3.xy;
    u_xlat1 = texture(_DetailTex, u_xlat0.xz);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat10.x = _DayColor.w * _AlphaBrightness;
    u_xlat10.x = u_xlat10.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.xy = u_xlat2.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat2.xy);
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat10.y;
    u_xlat3 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb4.w ? u_xlat3.w : float(0.0);
    u_xlat10.x = (u_xlatb4.z) ? u_xlat3.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb4.y) ? u_xlat3.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb4.x) ? u_xlat3.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.w : u_xlat5.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlatb5 = u_xlatb3.x || u_xlatb3.y;
    u_xlat0.x = (u_xlatb5) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + _LerpColorDark.xyz;
    u_xlatb2 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat15 = (u_xlatb2.z) ? u_xlat1.z : u_xlat15;
    u_xlat15 = (u_xlatb2.y) ? u_xlat1.y : u_xlat15;
    u_xlat15 = (u_xlatb2.x) ? u_xlat1.x : u_xlat15;
    u_xlat0.xyz = _DetailColor.xyz * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
lowp float u_xlat10_8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_8 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat16_1 = u_xlat10_8 * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat2.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat2.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat2.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat2.xy);
    u_xlat2.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat2.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat2.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat12;
    u_xlat2.xyz = vec3(u_xlat12) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_2COLORLERPTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec2 u_xlat8;
lowp float u_xlat10_8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_8 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat16_1 = u_xlat10_8 * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4.x = !!(u_xlat4.x<0.0);
#else
    u_xlatb4.x = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4.x) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat2.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat2.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat2.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat2.xy);
    u_xlat2.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat2.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat2.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb0.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb0.z) ? u_xlat2.z : u_xlat12;
    u_xlat4.x = (u_xlatb0.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat4.x;
    u_xlatb4.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat8.x = u_xlatb4.y ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb4.x) ? u_xlat1.w : u_xlat8.x;
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat4.x;
    u_xlatb8 = u_xlatb2.x || u_xlatb2.y;
    u_xlat4.x = (u_xlatb8) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + _LerpColorDark.xyz;
    u_xlat0.xyz = _DetailColor.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
bvec4 u_xlatb4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_10 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat16_1 = u_xlat10_10 * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat2.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat2.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_NoiseTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat10.xy = u_xlat2.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat10.y;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat3.xy;
    u_xlat1 = texture(_DetailTex, u_xlat0.xz);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat10.x = _DayColor.w * _AlphaBrightness;
    u_xlat10.x = u_xlat10.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.xy = u_xlat2.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat2.xy);
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat10.y;
    u_xlat3 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb4.w ? u_xlat3.w : float(0.0);
    u_xlat10.x = (u_xlatb4.z) ? u_xlat3.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb4.y) ? u_xlat3.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb4.x) ? u_xlat3.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.w : u_xlat5.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat2.xyz : u_xlat0.xxx;
    u_xlatb2 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat15 = (u_xlatb2.z) ? u_xlat1.z : u_xlat15;
    u_xlat15 = (u_xlatb2.y) ? u_xlat1.y : u_xlat15;
    u_xlat15 = (u_xlatb2.x) ? u_xlat1.x : u_xlat15;
    u_xlat2.xyz = vec3(u_xlat15) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
bvec4 u_xlatb4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_10 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat16_1 = u_xlat10_10 * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat2.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat2.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_NoiseTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat10.xy = u_xlat2.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat10.y;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat3.xy;
    u_xlat1 = texture(_DetailTex, u_xlat0.xz);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat10.x = _DayColor.w * _AlphaBrightness;
    u_xlat10.x = u_xlat10.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.xy = u_xlat2.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xy = u_xlat2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat2.xy);
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat10.y;
    u_xlat3 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb4.w ? u_xlat3.w : float(0.0);
    u_xlat10.x = (u_xlatb4.z) ? u_xlat3.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb4.y) ? u_xlat3.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb4.x) ? u_xlat3.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.w : u_xlat5.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlatb5 = u_xlatb3.x || u_xlatb3.y;
    u_xlat0.x = (u_xlatb5) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + _LerpColorDark.xyz;
    u_xlatb2 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat15 = (u_xlatb2.z) ? u_xlat1.z : u_xlat15;
    u_xlat15 = (u_xlatb2.y) ? u_xlat1.y : u_xlat15;
    u_xlat15 = (u_xlatb2.x) ? u_xlat1.x : u_xlat15;
    u_xlat0.xyz = _DetailColor.xyz * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ScreenParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat1.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat1.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat2 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat8.xy = u_xlat1.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat12;
    u_xlat1.xyz = vec3(u_xlat12) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_2COLORLERPTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ScreenParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4.x = !!(u_xlat4.x<0.0);
#else
    u_xlatb4.x = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4.x) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat1.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat1.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat2 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat8.xy = u_xlat1.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb0.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb0.z) ? u_xlat2.z : u_xlat12;
    u_xlat4.x = (u_xlatb0.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat4.x;
    u_xlatb4.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat8.x = u_xlatb4.y ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb4.x) ? u_xlat1.w : u_xlat8.x;
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat4.x;
    u_xlatb8 = u_xlatb2.x || u_xlatb2.y;
    u_xlat4.x = (u_xlatb8) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz + _LerpColorDark.xyz;
    u_xlat0.xyz = _DetailColor.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ScreenParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
bvec4 u_xlatb3;
bvec4 u_xlatb4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat5.xy = floor(u_xlat10.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat5.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat5.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat5.x * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat1.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat1.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.z;
    u_xlat2 = texture(_NoiseTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat10.xy = u_xlat1.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat10.y;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat3.xy;
    u_xlat2 = texture(_DetailTex, u_xlat0.xz);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat10.x = _DayColor.w * _AlphaBrightness;
    u_xlat10.x = u_xlat10.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.xy = u_xlat1.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat10.y;
    u_xlat3 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb4.w ? u_xlat3.w : float(0.0);
    u_xlat10.x = (u_xlatb4.z) ? u_xlat3.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb4.y) ? u_xlat3.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb4.x) ? u_xlat3.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat5.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat15;
    u_xlat1.xyz = vec3(u_xlat15) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ScreenParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
bvec4 u_xlatb3;
bvec4 u_xlatb4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat5.xy = floor(u_xlat10.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat5.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat5.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat5.x * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat1.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat1.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.z;
    u_xlat2 = texture(_NoiseTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat10.xy = u_xlat1.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat10.y;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat3.xy;
    u_xlat2 = texture(_DetailTex, u_xlat0.xz);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat10.x = _DayColor.w * _AlphaBrightness;
    u_xlat10.x = u_xlat10.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.xy = u_xlat1.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat10.y;
    u_xlat3 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb4.w ? u_xlat3.w : float(0.0);
    u_xlat10.x = (u_xlatb4.z) ? u_xlat3.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb4.y) ? u_xlat3.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb4.x) ? u_xlat3.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat5.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlatb5 = u_xlatb3.x || u_xlatb3.y;
    u_xlat0.x = (u_xlatb5) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + _LerpColorDark.xyz;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat15;
    u_xlat0.xyz = _DetailColor.xyz * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat1.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat1.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat2 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat8.xy = u_xlat1.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat12;
    u_xlat1.xyz = vec3(u_xlat12) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_2COLORLERPTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4.x = !!(u_xlat4.x<0.0);
#else
    u_xlatb4.x = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4.x) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat1.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat1.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat2 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat8.xy = u_xlat1.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb0.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb0.z) ? u_xlat2.z : u_xlat12;
    u_xlat4.x = (u_xlatb0.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat4.x;
    u_xlatb4.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat8.x = u_xlatb4.y ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb4.x) ? u_xlat1.w : u_xlat8.x;
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat4.x;
    u_xlatb8 = u_xlatb2.x || u_xlatb2.y;
    u_xlat4.x = (u_xlatb8) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz + _LerpColorDark.xyz;
    u_xlat0.xyz = _DetailColor.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
bvec4 u_xlatb3;
bvec4 u_xlatb4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat5.xy = floor(u_xlat10.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat5.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat5.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat5.x * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat1.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat1.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.z;
    u_xlat2 = texture(_NoiseTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat10.xy = u_xlat1.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat10.y;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat3.xy;
    u_xlat2 = texture(_DetailTex, u_xlat0.xz);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat10.x = _DayColor.w * _AlphaBrightness;
    u_xlat10.x = u_xlat10.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.xy = u_xlat1.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat10.y;
    u_xlat3 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb4.w ? u_xlat3.w : float(0.0);
    u_xlat10.x = (u_xlatb4.z) ? u_xlat3.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb4.y) ? u_xlat3.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb4.x) ? u_xlat3.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat5.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat15;
    u_xlat1.xyz = vec3(u_xlat15) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
bvec4 u_xlatb3;
bvec4 u_xlatb4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat5.xy = floor(u_xlat10.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat5.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat5.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat5.x * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.y = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.z = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat1.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xz = u_xlat1.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.z;
    u_xlat2 = texture(_NoiseTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat10.xy = u_xlat1.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat10.y;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat3.xy;
    u_xlat2 = texture(_DetailTex, u_xlat0.xz);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat10.x = _DayColor.w * _AlphaBrightness;
    u_xlat10.x = u_xlat10.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.xy = u_xlat1.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat3.x = _Time.y * _MaskTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _MaskTex_Vspeed + u_xlat10.y;
    u_xlat3 = texture(_MaskTex, u_xlat3.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb4.w ? u_xlat3.w : float(0.0);
    u_xlat10.x = (u_xlatb4.z) ? u_xlat3.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb4.y) ? u_xlat3.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb4.x) ? u_xlat3.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat5.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlatb5 = u_xlatb3.x || u_xlatb3.y;
    u_xlat0.x = (u_xlatb5) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + _LerpColorDark.xyz;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat15;
    u_xlat0.xyz = _DetailColor.xyz * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "ANNULAR_UV_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
bool u_xlatb13;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_10 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat16_1 = u_xlat10_10 * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat10.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.x = u_xlat0.x * u_xlat0.x;
    u_xlat15 = u_xlat10.x * 0.0208350997 + -0.0851330012;
    u_xlat15 = u_xlat10.x * u_xlat15 + 0.180141002;
    u_xlat15 = u_xlat10.x * u_xlat15 + -0.330299497;
    u_xlat10.x = u_xlat10.x * u_xlat15 + 0.999866009;
    u_xlat15 = u_xlat10.x * u_xlat0.x;
    u_xlat15 = u_xlat15 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb13 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat15 = u_xlatb13 ? u_xlat15 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat10.x + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb10 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat10.x = u_xlatb10 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat10.x + u_xlat0.x;
    u_xlat10.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat15 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=(-u_xlat15));
#else
    u_xlatb15 = u_xlat15>=(-u_xlat15);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10.x<(-u_xlat10.x));
#else
    u_xlatb10 = u_xlat10.x<(-u_xlat10.x);
#endif
    u_xlatb10 = u_xlatb15 && u_xlatb10;
    u_xlat0.x = (u_xlatb10) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat4.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat10.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat3.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat10.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat10.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat10.x;
    u_xlat15 = _DayColor.w * _AlphaBrightness;
    u_xlat15 = u_xlat15 * vs_COLOR0.w;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat5.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat15;
    u_xlat3.xyz = vec3(u_xlat15) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
bvec2 u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
bool u_xlatb13;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_10 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat16_1 = u_xlat10_10 * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat5.x<0.0);
#else
    u_xlatb5.x = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat10.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.x = u_xlat0.x * u_xlat0.x;
    u_xlat15 = u_xlat10.x * 0.0208350997 + -0.0851330012;
    u_xlat15 = u_xlat10.x * u_xlat15 + 0.180141002;
    u_xlat15 = u_xlat10.x * u_xlat15 + -0.330299497;
    u_xlat10.x = u_xlat10.x * u_xlat15 + 0.999866009;
    u_xlat15 = u_xlat10.x * u_xlat0.x;
    u_xlat15 = u_xlat15 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb13 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat15 = u_xlatb13 ? u_xlat15 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat10.x + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb10 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat10.x = u_xlatb10 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat10.x + u_xlat0.x;
    u_xlat10.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat15 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=(-u_xlat15));
#else
    u_xlatb15 = u_xlat15>=(-u_xlat15);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10.x<(-u_xlat10.x));
#else
    u_xlatb10 = u_xlat10.x<(-u_xlat10.x);
#endif
    u_xlatb10 = u_xlatb15 && u_xlatb10;
    u_xlat0.x = (u_xlatb10) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat4.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat10.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat3.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat10.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat10.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat10.x;
    u_xlat15 = _DayColor.w * _AlphaBrightness;
    u_xlat15 = u_xlat15 * vs_COLOR0.w;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb0.w ? u_xlat2.w : float(0.0);
    u_xlat10.x = (u_xlatb0.z) ? u_xlat2.z : u_xlat15;
    u_xlat5.x = (u_xlatb0.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat5.x;
    u_xlatb5.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat10.x = u_xlatb5.y ? 1.0 : float(0.0);
    u_xlat5.x = (u_xlatb5.x) ? u_xlat1.w : u_xlat10.x;
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat5.x;
    u_xlatb10 = u_xlatb2.x || u_xlatb2.y;
    u_xlat5.x = (u_xlatb10) ? u_xlat1.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat3.xyz + _LerpColorDark.xyz;
    u_xlat0.xyz = _DetailColor.xyz * u_xlat0.xxx + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "ANNULAR_UV_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat13;
bool u_xlatb13;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_10 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat16_1 = u_xlat10_10 * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat10.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.x = u_xlat0.x * u_xlat0.x;
    u_xlat15 = u_xlat10.x * 0.0208350997 + -0.0851330012;
    u_xlat15 = u_xlat10.x * u_xlat15 + 0.180141002;
    u_xlat15 = u_xlat10.x * u_xlat15 + -0.330299497;
    u_xlat10.x = u_xlat10.x * u_xlat15 + 0.999866009;
    u_xlat15 = u_xlat10.x * u_xlat0.x;
    u_xlat15 = u_xlat15 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb13 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat15 = u_xlatb13 ? u_xlat15 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat10.x + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb10 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat10.x = u_xlatb10 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat10.x + u_xlat0.x;
    u_xlat10.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat15 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=(-u_xlat15));
#else
    u_xlatb15 = u_xlat15>=(-u_xlat15);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10.x<(-u_xlat10.x));
#else
    u_xlatb10 = u_xlat10.x<(-u_xlat10.x);
#endif
    u_xlatb10 = u_xlatb15 && u_xlatb10;
    u_xlat0.x = (u_xlatb10) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat4.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat10.xy = u_xlat3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat4.x = _Time.y * _NoiseTex_Uspeed + u_xlat10.x;
    u_xlat4.y = _Time.y * _NoiseTex_Vspeed + u_xlat10.y;
    u_xlat1 = texture(_NoiseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat10.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat10.x = u_xlat10.x + _Noise_Offset;
    u_xlat13.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat3.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat13.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat13.y;
    u_xlat10.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat10.xx + u_xlat3.xy;
    u_xlat2 = texture(_DetailTex, u_xlat10.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat10.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat10.x;
    u_xlat15 = _DayColor.w * _AlphaBrightness;
    u_xlat15 = u_xlat15 * vs_COLOR0.w;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat5.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat15;
    u_xlat3.xyz = vec3(u_xlat15) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat13;
bool u_xlatb13;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_10 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat16_1 = u_xlat10_10 * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat10.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.x = u_xlat0.x * u_xlat0.x;
    u_xlat15 = u_xlat10.x * 0.0208350997 + -0.0851330012;
    u_xlat15 = u_xlat10.x * u_xlat15 + 0.180141002;
    u_xlat15 = u_xlat10.x * u_xlat15 + -0.330299497;
    u_xlat10.x = u_xlat10.x * u_xlat15 + 0.999866009;
    u_xlat15 = u_xlat10.x * u_xlat0.x;
    u_xlat15 = u_xlat15 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb13 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat15 = u_xlatb13 ? u_xlat15 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat10.x + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb10 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat10.x = u_xlatb10 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat10.x + u_xlat0.x;
    u_xlat10.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat15 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=(-u_xlat15));
#else
    u_xlatb15 = u_xlat15>=(-u_xlat15);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10.x<(-u_xlat10.x));
#else
    u_xlatb10 = u_xlat10.x<(-u_xlat10.x);
#endif
    u_xlatb10 = u_xlatb15 && u_xlatb10;
    u_xlat0.x = (u_xlatb10) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat4.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat10.xy = u_xlat3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat4.x = _Time.y * _NoiseTex_Uspeed + u_xlat10.x;
    u_xlat4.y = _Time.y * _NoiseTex_Vspeed + u_xlat10.y;
    u_xlat1 = texture(_NoiseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat10.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat10.x = u_xlat10.x + _Noise_Offset;
    u_xlat13.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat3.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat13.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat13.y;
    u_xlat10.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat10.xx + u_xlat3.xy;
    u_xlat2 = texture(_DetailTex, u_xlat10.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat10.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat10.x;
    u_xlat15 = _DayColor.w * _AlphaBrightness;
    u_xlat15 = u_xlat15 * vs_COLOR0.w;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat5.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlatb5 = u_xlatb3.x || u_xlatb3.y;
    u_xlat0.x = (u_xlatb5) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + _LerpColorDark.xyz;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat15;
    u_xlat0.xyz = _DetailColor.xyz * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "ANNULAR_UV_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
bool u_xlatb13;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_10 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat16_1 = u_xlat10_10 * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat10.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.x = u_xlat0.x * u_xlat0.x;
    u_xlat15 = u_xlat10.x * 0.0208350997 + -0.0851330012;
    u_xlat15 = u_xlat10.x * u_xlat15 + 0.180141002;
    u_xlat15 = u_xlat10.x * u_xlat15 + -0.330299497;
    u_xlat10.x = u_xlat10.x * u_xlat15 + 0.999866009;
    u_xlat15 = u_xlat10.x * u_xlat0.x;
    u_xlat15 = u_xlat15 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb13 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat15 = u_xlatb13 ? u_xlat15 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat10.x + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb10 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat10.x = u_xlatb10 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat10.x + u_xlat0.x;
    u_xlat10.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat15 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=(-u_xlat15));
#else
    u_xlatb15 = u_xlat15>=(-u_xlat15);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10.x<(-u_xlat10.x));
#else
    u_xlatb10 = u_xlat10.x<(-u_xlat10.x);
#endif
    u_xlatb10 = u_xlatb15 && u_xlatb10;
    u_xlat0.x = (u_xlatb10) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat4.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat10.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat3.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat10.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat10.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat10.x;
    u_xlat15 = _DayColor.w * _AlphaBrightness;
    u_xlat15 = u_xlat15 * vs_COLOR0.w;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat5.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat15;
    u_xlat3.xyz = vec3(u_xlat15) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
bvec2 u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
bool u_xlatb13;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_10 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat16_1 = u_xlat10_10 * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5.x = !!(u_xlat5.x<0.0);
#else
    u_xlatb5.x = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5.x) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat10.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.x = u_xlat0.x * u_xlat0.x;
    u_xlat15 = u_xlat10.x * 0.0208350997 + -0.0851330012;
    u_xlat15 = u_xlat10.x * u_xlat15 + 0.180141002;
    u_xlat15 = u_xlat10.x * u_xlat15 + -0.330299497;
    u_xlat10.x = u_xlat10.x * u_xlat15 + 0.999866009;
    u_xlat15 = u_xlat10.x * u_xlat0.x;
    u_xlat15 = u_xlat15 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb13 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat15 = u_xlatb13 ? u_xlat15 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat10.x + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb10 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat10.x = u_xlatb10 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat10.x + u_xlat0.x;
    u_xlat10.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat15 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=(-u_xlat15));
#else
    u_xlatb15 = u_xlat15>=(-u_xlat15);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10.x<(-u_xlat10.x));
#else
    u_xlatb10 = u_xlat10.x<(-u_xlat10.x);
#endif
    u_xlatb10 = u_xlatb15 && u_xlatb10;
    u_xlat0.x = (u_xlatb10) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat4.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat10.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat3.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat10.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat10.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat10.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat10.x;
    u_xlat15 = _DayColor.w * _AlphaBrightness;
    u_xlat15 = u_xlat15 * vs_COLOR0.w;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb0.w ? u_xlat2.w : float(0.0);
    u_xlat10.x = (u_xlatb0.z) ? u_xlat2.z : u_xlat15;
    u_xlat5.x = (u_xlatb0.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat5.x;
    u_xlatb5.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat10.x = u_xlatb5.y ? 1.0 : float(0.0);
    u_xlat5.x = (u_xlatb5.x) ? u_xlat1.w : u_xlat10.x;
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat5.x;
    u_xlatb10 = u_xlatb2.x || u_xlatb2.y;
    u_xlat5.x = (u_xlatb10) ? u_xlat1.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat3.xyz + _LerpColorDark.xyz;
    u_xlat0.xyz = _DetailColor.xyz * u_xlat0.xxx + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "ANNULAR_UV_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat13;
bool u_xlatb13;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_10 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat16_1 = u_xlat10_10 * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat10.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.x = u_xlat0.x * u_xlat0.x;
    u_xlat15 = u_xlat10.x * 0.0208350997 + -0.0851330012;
    u_xlat15 = u_xlat10.x * u_xlat15 + 0.180141002;
    u_xlat15 = u_xlat10.x * u_xlat15 + -0.330299497;
    u_xlat10.x = u_xlat10.x * u_xlat15 + 0.999866009;
    u_xlat15 = u_xlat10.x * u_xlat0.x;
    u_xlat15 = u_xlat15 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb13 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat15 = u_xlatb13 ? u_xlat15 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat10.x + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb10 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat10.x = u_xlatb10 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat10.x + u_xlat0.x;
    u_xlat10.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat15 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=(-u_xlat15));
#else
    u_xlatb15 = u_xlat15>=(-u_xlat15);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10.x<(-u_xlat10.x));
#else
    u_xlatb10 = u_xlat10.x<(-u_xlat10.x);
#endif
    u_xlatb10 = u_xlatb15 && u_xlatb10;
    u_xlat0.x = (u_xlatb10) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat4.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat10.xy = u_xlat3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat4.x = _Time.y * _NoiseTex_Uspeed + u_xlat10.x;
    u_xlat4.y = _Time.y * _NoiseTex_Vspeed + u_xlat10.y;
    u_xlat1 = texture(_NoiseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat10.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat10.x = u_xlat10.x + _Noise_Offset;
    u_xlat13.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat3.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat13.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat13.y;
    u_xlat10.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat10.xx + u_xlat3.xy;
    u_xlat2 = texture(_DetailTex, u_xlat10.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat10.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat10.x;
    u_xlat15 = _DayColor.w * _AlphaBrightness;
    u_xlat15 = u_xlat15 * vs_COLOR0.w;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat5.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat15;
    u_xlat3.xyz = vec3(u_xlat15) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform lowp sampler2D _CameraNormalsTexture;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat13;
bool u_xlatb13;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_10 = texture(_CameraNormalsTexture, u_xlat0.xy).y;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat16_1 = u_xlat10_10 * 2.0 + -1.0;
    u_xlat5.x = u_xlat16_1 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat5.x = u_xlat0.y + u_xlat0.y;
    u_xlat5.x = u_xlat5.x / _VerticalFadeStart;
    u_xlat5.x = max(u_xlat5.x, 0.00999999978);
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _VerticalFadeExp;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat10.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlat10.x = u_xlat0.x * u_xlat0.x;
    u_xlat15 = u_xlat10.x * 0.0208350997 + -0.0851330012;
    u_xlat15 = u_xlat10.x * u_xlat15 + 0.180141002;
    u_xlat15 = u_xlat10.x * u_xlat15 + -0.330299497;
    u_xlat10.x = u_xlat10.x * u_xlat15 + 0.999866009;
    u_xlat15 = u_xlat10.x * u_xlat0.x;
    u_xlat15 = u_xlat15 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb13 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat15 = u_xlatb13 ? u_xlat15 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat10.x + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb10 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat10.x = u_xlatb10 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat10.x + u_xlat0.x;
    u_xlat10.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat15 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15>=(-u_xlat15));
#else
    u_xlatb15 = u_xlat15>=(-u_xlat15);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10.x<(-u_xlat10.x));
#else
    u_xlatb10 = u_xlat10.x<(-u_xlat10.x);
#endif
    u_xlatb10 = u_xlatb15 && u_xlatb10;
    u_xlat0.x = (u_xlatb10) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat4.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat10.xy = u_xlat3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat4.x = _Time.y * _NoiseTex_Uspeed + u_xlat10.x;
    u_xlat4.y = _Time.y * _NoiseTex_Vspeed + u_xlat10.y;
    u_xlat1 = texture(_NoiseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat10.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat10.x = u_xlat10.x + _Noise_Offset;
    u_xlat13.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat3.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat3.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat13.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat13.y;
    u_xlat10.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat10.xx + u_xlat3.xy;
    u_xlat2 = texture(_DetailTex, u_xlat10.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat10.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat10.x;
    u_xlat15 = _DayColor.w * _AlphaBrightness;
    u_xlat15 = u_xlat15 * vs_COLOR0.w;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat10.x;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat5.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat5.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat5.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlatb5 = u_xlatb3.x || u_xlatb3.y;
    u_xlat0.x = (u_xlatb5) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz + _LerpColorDark.xyz;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb1.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb1.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb1.x) ? u_xlat2.x : u_xlat15;
    u_xlat0.xyz = _DetailColor.xyz * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ScreenParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
bool u_xlatb9;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat8.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
    u_xlat8.x = u_xlat0.x * u_xlat0.x;
    u_xlat12 = u_xlat8.x * 0.0208350997 + -0.0851330012;
    u_xlat12 = u_xlat8.x * u_xlat12 + 0.180141002;
    u_xlat12 = u_xlat8.x * u_xlat12 + -0.330299497;
    u_xlat8.x = u_xlat8.x * u_xlat12 + 0.999866009;
    u_xlat12 = u_xlat8.x * u_xlat0.x;
    u_xlat12 = u_xlat12 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb9 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat12 = u_xlatb9 ? u_xlat12 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat8.x + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb8 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat8.x = u_xlatb8 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat8.x + u_xlat0.x;
    u_xlat8.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat12 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12>=(-u_xlat12));
#else
    u_xlatb12 = u_xlat12>=(-u_xlat12);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8.x<(-u_xlat8.x));
#else
    u_xlatb8 = u_xlat8.x<(-u_xlat8.x);
#endif
    u_xlatb8 = u_xlatb12 && u_xlatb8;
    u_xlat0.x = (u_xlatb8) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat12;
    u_xlat1.xyz = vec3(u_xlat12) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ScreenParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
bool u_xlatb9;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4.x = !!(u_xlat4.x<0.0);
#else
    u_xlatb4.x = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4.x) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat8.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
    u_xlat8.x = u_xlat0.x * u_xlat0.x;
    u_xlat12 = u_xlat8.x * 0.0208350997 + -0.0851330012;
    u_xlat12 = u_xlat8.x * u_xlat12 + 0.180141002;
    u_xlat12 = u_xlat8.x * u_xlat12 + -0.330299497;
    u_xlat8.x = u_xlat8.x * u_xlat12 + 0.999866009;
    u_xlat12 = u_xlat8.x * u_xlat0.x;
    u_xlat12 = u_xlat12 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb9 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat12 = u_xlatb9 ? u_xlat12 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat8.x + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb8 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat8.x = u_xlatb8 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat8.x + u_xlat0.x;
    u_xlat8.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat12 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12>=(-u_xlat12));
#else
    u_xlatb12 = u_xlat12>=(-u_xlat12);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8.x<(-u_xlat8.x));
#else
    u_xlatb8 = u_xlat8.x<(-u_xlat8.x);
#endif
    u_xlatb8 = u_xlatb12 && u_xlatb8;
    u_xlat0.x = (u_xlatb8) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb0.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb0.z) ? u_xlat2.z : u_xlat12;
    u_xlat4.x = (u_xlatb0.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat4.x;
    u_xlatb4.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat8.x = u_xlatb4.y ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb4.x) ? u_xlat1.w : u_xlat8.x;
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat4.x;
    u_xlatb8 = u_xlatb2.x || u_xlatb2.y;
    u_xlat4.x = (u_xlatb8) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz + _LerpColorDark.xyz;
    u_xlat0.xyz = _DetailColor.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ScreenParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
vec2 u_xlat9;
bool u_xlatb9;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat8.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
    u_xlat8.x = u_xlat0.x * u_xlat0.x;
    u_xlat12 = u_xlat8.x * 0.0208350997 + -0.0851330012;
    u_xlat12 = u_xlat8.x * u_xlat12 + 0.180141002;
    u_xlat12 = u_xlat8.x * u_xlat12 + -0.330299497;
    u_xlat8.x = u_xlat8.x * u_xlat12 + 0.999866009;
    u_xlat12 = u_xlat8.x * u_xlat0.x;
    u_xlat12 = u_xlat12 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb9 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat12 = u_xlatb9 ? u_xlat12 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat8.x + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb8 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat8.x = u_xlatb8 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat8.x + u_xlat0.x;
    u_xlat8.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat12 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12>=(-u_xlat12));
#else
    u_xlatb12 = u_xlat12>=(-u_xlat12);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8.x<(-u_xlat8.x));
#else
    u_xlatb8 = u_xlat8.x<(-u_xlat8.x);
#endif
    u_xlatb8 = u_xlatb12 && u_xlatb8;
    u_xlat0.x = (u_xlatb8) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + _Noise_Offset;
    u_xlat1.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat9.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat9.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat1.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat1.y;
    u_xlat8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat3.xy;
    u_xlat1 = texture(_DetailTex, u_xlat8.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat2.xyz : u_xlat0.xxx;
    u_xlatb2 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat12 = (u_xlatb2.z) ? u_xlat1.z : u_xlat12;
    u_xlat12 = (u_xlatb2.y) ? u_xlat1.y : u_xlat12;
    u_xlat12 = (u_xlatb2.x) ? u_xlat1.x : u_xlat12;
    u_xlat1.xyz = vec3(u_xlat12) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _EulerAngleY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _ScreenParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
vec2 u_xlat9;
bool u_xlatb9;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat8.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
    u_xlat8.x = u_xlat0.x * u_xlat0.x;
    u_xlat12 = u_xlat8.x * 0.0208350997 + -0.0851330012;
    u_xlat12 = u_xlat8.x * u_xlat12 + 0.180141002;
    u_xlat12 = u_xlat8.x * u_xlat12 + -0.330299497;
    u_xlat8.x = u_xlat8.x * u_xlat12 + 0.999866009;
    u_xlat12 = u_xlat8.x * u_xlat0.x;
    u_xlat12 = u_xlat12 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb9 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat12 = u_xlatb9 ? u_xlat12 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat8.x + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb8 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat8.x = u_xlatb8 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat8.x + u_xlat0.x;
    u_xlat8.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat12 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12>=(-u_xlat12));
#else
    u_xlatb12 = u_xlat12>=(-u_xlat12);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8.x<(-u_xlat8.x));
#else
    u_xlatb8 = u_xlat8.x<(-u_xlat8.x);
#endif
    u_xlatb8 = u_xlatb12 && u_xlatb8;
    u_xlat0.x = (u_xlatb8) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + _Noise_Offset;
    u_xlat1.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat9.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat9.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat1.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat1.y;
    u_xlat8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat3.xy;
    u_xlat1 = texture(_DetailTex, u_xlat8.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlatb4 = u_xlatb3.x || u_xlatb3.y;
    u_xlat0.x = (u_xlatb4) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _LerpColorDark.xyz;
    u_xlatb2 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat12 = (u_xlatb2.z) ? u_xlat1.z : u_xlat12;
    u_xlat12 = (u_xlatb2.y) ? u_xlat1.y : u_xlat12;
    u_xlat12 = (u_xlatb2.x) ? u_xlat1.x : u_xlat12;
    u_xlat0.xyz = _DetailColor.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
bool u_xlatb9;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat8.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
    u_xlat8.x = u_xlat0.x * u_xlat0.x;
    u_xlat12 = u_xlat8.x * 0.0208350997 + -0.0851330012;
    u_xlat12 = u_xlat8.x * u_xlat12 + 0.180141002;
    u_xlat12 = u_xlat8.x * u_xlat12 + -0.330299497;
    u_xlat8.x = u_xlat8.x * u_xlat12 + 0.999866009;
    u_xlat12 = u_xlat8.x * u_xlat0.x;
    u_xlat12 = u_xlat12 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb9 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat12 = u_xlatb9 ? u_xlat12 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat8.x + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb8 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat8.x = u_xlatb8 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat8.x + u_xlat0.x;
    u_xlat8.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat12 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12>=(-u_xlat12));
#else
    u_xlatb12 = u_xlat12>=(-u_xlat12);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8.x<(-u_xlat8.x));
#else
    u_xlatb8 = u_xlat8.x<(-u_xlat8.x);
#endif
    u_xlatb8 = u_xlatb12 && u_xlatb8;
    u_xlat0.x = (u_xlatb8) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat1.xyz : u_xlat0.xxx;
    u_xlatb1 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb1.w ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.x) ? u_xlat2.x : u_xlat12;
    u_xlat1.xyz = vec3(u_xlat12) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
bool u_xlatb9;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4.x = !!(u_xlat4.x<0.0);
#else
    u_xlatb4.x = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4.x) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat8.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
    u_xlat8.x = u_xlat0.x * u_xlat0.x;
    u_xlat12 = u_xlat8.x * 0.0208350997 + -0.0851330012;
    u_xlat12 = u_xlat8.x * u_xlat12 + 0.180141002;
    u_xlat12 = u_xlat8.x * u_xlat12 + -0.330299497;
    u_xlat8.x = u_xlat8.x * u_xlat12 + 0.999866009;
    u_xlat12 = u_xlat8.x * u_xlat0.x;
    u_xlat12 = u_xlat12 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb9 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat12 = u_xlatb9 ? u_xlat12 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat8.x + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb8 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat8.x = u_xlatb8 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat8.x + u_xlat0.x;
    u_xlat8.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat12 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12>=(-u_xlat12));
#else
    u_xlatb12 = u_xlat12>=(-u_xlat12);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8.x<(-u_xlat8.x));
#else
    u_xlatb8 = u_xlat8.x<(-u_xlat8.x);
#endif
    u_xlatb8 = u_xlatb12 && u_xlatb8;
    u_xlat0.x = (u_xlatb8) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat1.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat8.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat8.y;
    u_xlat2 = texture(_DetailTex, u_xlat3.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat1.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb0.w ? u_xlat2.w : float(0.0);
    u_xlat8.x = (u_xlatb0.z) ? u_xlat2.z : u_xlat12;
    u_xlat4.x = (u_xlatb0.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.x : u_xlat4.x;
    u_xlatb4.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat8.x = u_xlatb4.y ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb4.x) ? u_xlat1.w : u_xlat8.x;
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat4.x;
    u_xlatb8 = u_xlatb2.x || u_xlatb2.y;
    u_xlat4.x = (u_xlatb8) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz + _LerpColorDark.xyz;
    u_xlat0.xyz = _DetailColor.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _BaseColor;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
vec2 u_xlat9;
bool u_xlatb9;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat8.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
    u_xlat8.x = u_xlat0.x * u_xlat0.x;
    u_xlat12 = u_xlat8.x * 0.0208350997 + -0.0851330012;
    u_xlat12 = u_xlat8.x * u_xlat12 + 0.180141002;
    u_xlat12 = u_xlat8.x * u_xlat12 + -0.330299497;
    u_xlat8.x = u_xlat8.x * u_xlat12 + 0.999866009;
    u_xlat12 = u_xlat8.x * u_xlat0.x;
    u_xlat12 = u_xlat12 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb9 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat12 = u_xlatb9 ? u_xlat12 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat8.x + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb8 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat8.x = u_xlatb8 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat8.x + u_xlat0.x;
    u_xlat8.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat12 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12>=(-u_xlat12));
#else
    u_xlatb12 = u_xlat12>=(-u_xlat12);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8.x<(-u_xlat8.x));
#else
    u_xlatb8 = u_xlat8.x<(-u_xlat8.x);
#endif
    u_xlatb8 = u_xlatb12 && u_xlatb8;
    u_xlat0.x = (u_xlatb8) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + _Noise_Offset;
    u_xlat1.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat9.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat9.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat1.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat1.y;
    u_xlat8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat3.xy;
    u_xlat1 = texture(_DetailTex, u_xlat8.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.xyz = (u_xlatb3.x) ? u_xlat2.xyz : u_xlat0.xxx;
    u_xlatb2 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat12 = (u_xlatb2.z) ? u_xlat1.z : u_xlat12;
    u_xlat12 = (u_xlatb2.y) ? u_xlat1.y : u_xlat12;
    u_xlat12 = (u_xlatb2.x) ? u_xlat1.x : u_xlat12;
    u_xlat1.xyz = vec3(u_xlat12) * _DetailColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _BaseColor.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _EulerAngleY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp float in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec2 u_xlat9;
float u_xlat16;
float u_xlat24;
float u_xlat25;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x + _EulerAngleY;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = sin(in_TEXCOORD1.y);
    u_xlat3 = cos(in_TEXCOORD1.y);
    u_xlat8.x = u_xlat0.x * u_xlat2.x;
    u_xlat16 = u_xlat1.x * u_xlat3;
    u_xlat4 = sin(in_TEXCOORD0.w);
    u_xlat5 = cos(in_TEXCOORD0.w);
    u_xlat24 = u_xlat8.x * u_xlat4 + u_xlat16;
    u_xlat8.x = u_xlat16 * u_xlat4 + u_xlat8.x;
    u_xlat9.xy = vec2(float(1.0) / in_TEXCOORD1.z, float(1.0) / in_TEXCOORD1.w);
    u_xlat6.x = u_xlat24 * u_xlat9.x;
    u_xlat16 = u_xlat1.x * u_xlat2.x;
    u_xlat24 = u_xlat0.x * u_xlat3;
    u_xlat25 = u_xlat16 * u_xlat4 + (-u_xlat24);
    u_xlat16 = u_xlat24 * u_xlat4 + (-u_xlat16);
    u_xlat7.x = u_xlat9.y * u_xlat16;
    u_xlat6.z = u_xlat9.x * u_xlat25;
    u_xlat16 = u_xlat2.x * u_xlat5;
    u_xlat8.z = u_xlat3 * u_xlat5;
    u_xlat6.y = u_xlat9.x * u_xlat16;
    u_xlat7.yz = u_xlat8.zx * u_xlat9.yy;
    vs_TEXCOORD3.x = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD3.y = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD3.z = dot(u_xlat6.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat8.xyz = (-in_TEXCOORD0.xyz) + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    vs_TEXCOORD3.w = dot(u_xlat6.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.w = dot(u_xlat7.xyz, u_xlat8.xyz);
    vs_TEXCOORD4.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD4.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD4.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
    u_xlat0.x = u_xlat0.x * u_xlat5;
    u_xlat1.x = u_xlat1.x * u_xlat5;
    u_xlat9.x = float(1.0) / in_TEXCOORD2;
    u_xlat2.x = u_xlat0.x * u_xlat9.x;
    u_xlat2.z = u_xlat9.x * u_xlat1.x;
    u_xlat2.y = u_xlat9.x * (-u_xlat4);
    vs_TEXCOORD5.w = dot(u_xlat2.xyz, u_xlat8.xyz);
    vs_TEXCOORD5.x = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[0].xyz);
    vs_TEXCOORD5.y = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[1].xyz);
    vs_TEXCOORD5.z = dot(u_xlat2.xyz, hlslcc_mtx4x4unity_CameraToWorld[2].xyz);
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
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	float _MaxClampAngleCos;
uniform 	float _VerticalFadeExp;
uniform 	float _VerticalFadeStart;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _LerpColorDark;
uniform 	vec4 _LerpColorLight;
uniform 	float _LerpBrightness;
uniform 	vec4 _DetailColor;
uniform 	mediump float _DetailTexColorChannelSwitch;
uniform 	float _DetailTex_Uspeed;
uniform 	vec4 _DetailTex_ST;
uniform 	float _DetailTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _DetailTexAlphaChannelSwitch;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	float _MaskTex_Vspeed;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
uvec4 u_xlatu1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
vec2 u_xlat9;
bool u_xlatb9;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat8.xy = u_xlat0.xy * _ScreenParams.xy;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat4.xy = floor(u_xlat8.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat4.xy));
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat4.x = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).y;
    u_xlat16_2 = u_xlat4.x * 2.0 + -1.0;
    u_xlat4.x = u_xlat16_2 + (-_MaxClampAngleCos);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat4.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.w = 1.0;
    u_xlat1.z = dot(vs_TEXCOORD4, u_xlat0);
    u_xlat1.x = dot(vs_TEXCOORD3, u_xlat0);
    u_xlat1.y = dot(vs_TEXCOORD5, u_xlat0);
    u_xlat0.xyz = -abs(u_xlat1.xzy) + vec3(0.5, 0.5, 0.5);
    u_xlatb0.xzw = lessThan(u_xlat0.xxyz, vec4(0.0, 0.0, 0.0, 0.0)).xzw;
    u_xlat4.x = u_xlat0.y + u_xlat0.y;
    u_xlat4.x = u_xlat4.x / _VerticalFadeStart;
    u_xlat4.x = max(u_xlat4.x, 0.00999999978);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _VerticalFadeExp;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.w || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.w = (-u_xlat1.x);
    u_xlat0.xz = u_xlat1.xy * vec2(-1.0, 1.0);
    u_xlat0.x = dot(u_xlat1.wy, u_xlat0.xz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2 = (-u_xlat0.x) * 2.01999998 + 1.0;
    u_xlat3.y = u_xlat0.x * 2.01999998;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = max(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat8.x = min(abs(u_xlat1.y), abs(u_xlat1.x));
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
    u_xlat8.x = u_xlat0.x * u_xlat0.x;
    u_xlat12 = u_xlat8.x * 0.0208350997 + -0.0851330012;
    u_xlat12 = u_xlat8.x * u_xlat12 + 0.180141002;
    u_xlat12 = u_xlat8.x * u_xlat12 + -0.330299497;
    u_xlat8.x = u_xlat8.x * u_xlat12 + 0.999866009;
    u_xlat12 = u_xlat8.x * u_xlat0.x;
    u_xlat12 = u_xlat12 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(u_xlat1.y)<abs(u_xlat1.x));
#else
    u_xlatb9 = abs(u_xlat1.y)<abs(u_xlat1.x);
#endif
    u_xlat12 = u_xlatb9 ? u_xlat12 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat8.x + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.y<(-u_xlat1.y));
#else
    u_xlatb8 = u_xlat1.y<(-u_xlat1.y);
#endif
    u_xlat8.x = u_xlatb8 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat8.x + u_xlat0.x;
    u_xlat8.x = min(u_xlat1.y, (-u_xlat1.x));
    u_xlat12 = max(u_xlat1.y, (-u_xlat1.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12>=(-u_xlat12));
#else
    u_xlatb12 = u_xlat12>=(-u_xlat12);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8.x<(-u_xlat8.x));
#else
    u_xlatb8 = u_xlat8.x<(-u_xlat8.x);
#endif
    u_xlatb8 = u_xlatb12 && u_xlatb8;
    u_xlat0.x = (u_xlatb8) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat3.x = u_xlat0.x * 0.159154952 + 0.5;
    u_xlat0.xz = u_xlat3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _MaskTex_Vspeed + u_xlat0.z;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat8.xy = u_xlat3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(_NoiseTexChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + _Noise_Offset;
    u_xlat1.xy = u_xlat3.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat9.xy = u_xlat3.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat9.xy);
    u_xlat3.x = _Time.y * _DetailTex_Uspeed + u_xlat1.x;
    u_xlat3.y = _Time.y * _DetailTex_Vspeed + u_xlat1.y;
    u_xlat8.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat3.xy;
    u_xlat1 = texture(_DetailTex, u_xlat8.xy);
    u_xlatb3 = equal(vec4(_DetailTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb3.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb3.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat12 = _DayColor.w * _AlphaBrightness;
    u_xlat12 = u_xlat12 * vs_COLOR0.w;
    u_xlat8.x = u_xlat8.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb8 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat8.x;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat4.x * u_xlat0.x;
    u_xlatb0.xy = equal(vec4(_BaseTexColorChannelSwitch), vec4(4.0, 5.0, 0.0, 0.0)).xy;
    u_xlat4.x = u_xlatb0.y ? 1.0 : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.w : u_xlat4.x;
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlatb4 = u_xlatb3.x || u_xlatb3.y;
    u_xlat0.x = (u_xlatb4) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _LerpBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_LerpColorDark.xyz) + _LerpColorLight.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _LerpColorDark.xyz;
    u_xlatb2 = equal(vec4(_DetailTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat12 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat12 = (u_xlatb2.z) ? u_xlat1.z : u_xlat12;
    u_xlat12 = (u_xlatb2.y) ? u_xlat1.y : u_xlat12;
    u_xlat12 = (u_xlatb2.x) ? u_xlat1.x : u_xlat12;
    u_xlat0.xyz = _DetailColor.xyz * vec3(u_xlat12) + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
Keywords { "_2COLORLERPTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_2COLORLERPTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" "_2COLORLERPTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "_2COLORLERPTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "ANNULAR_UV_ON" }
""
}
SubProgram "gles3 " {
Keywords { "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "ANNULAR_UV_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "ANNULAR_UV_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "ANNULAR_UV_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" "ANNULAR_UV_ON" }
""
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_2COLORLERPTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_2COLORLERPTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_2COLORLERPTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_2COLORLERPTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "ANNULAR_UV_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "ANNULAR_UV_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "ANNULAR_UV_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "ANNULAR_UV_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "ANNULAR_UV_ON" "_2COLORLERPTOGGLE_ON" "_NOISETEXTOGGLEONDETAIL_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}