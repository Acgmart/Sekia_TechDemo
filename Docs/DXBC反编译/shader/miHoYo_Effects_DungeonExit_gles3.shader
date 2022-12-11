//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/DungeonExit" {
Properties {
_DayColor ("DayColor", Color) = (1,1,1,1)
[MHYToggle] _MainColorToggle ("MainColorToggle", Float) = 0
_MainColor ("MainColor", Color) = (0,0,0,0)
_ColorBrightness ("ColorBrightness", Float) = 1
_MovingLightTex ("MovingLightTex", 2D) = "white" { }
_MovingLightColor02 ("MovingLightColor02", Color) = (1,1,1,1)
_MovingLightColor01 ("MovingLightColor01", Color) = (1,1,1,1)
_MovingLight_V_Speed02 ("MovingLight_V_Speed02", Float) = 0
_MovingLight_V_Speed04 ("MovingLight_V_Speed04", Float) = 0
_MovingLight_V_Speed03 ("MovingLight_V_Speed03", Float) = 0
_MovingLight_V_Speed01 ("MovingLight_V_Speed01", Float) = 0
_AlphaOffset ("AlphaOffset", Float) = 0
[MHYToggle] _DissolveTexToggle ("DissolveTexToggle", Float) = 1
_DissolveTex ("DissolveTex", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _DissolveTexColorChannelToggle ("DissolveTexColorChannelToggle", Float) = 0
_RemapMin ("RemapMin", Float) = 0
_RemapMax ("RemapMax", Float) = 1
_DissolveTex_Uspeed ("DissolveTex_Uspeed", Float) = 0
_DissolveTex_Vspeed ("DissolveTex_Vspeed", Float) = 0
_NoiseTex ("NoiseTex", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _NoiseTexChannelToggle ("NoiseTexChannelToggle", Float) = 0
_NoiseTex_Uspeed ("NoiseTex_Uspeed", Float) = 0
_NoiseTex_Vspeed ("NoiseTex_Vspeed", Float) = 0
_Noise_Brightness ("Noise_Brightness", Float) = 0.2
_Noise_Offset ("Noise_Offset", Float) = 0.5
_AlphaBrightness ("AlphaBrightness", Float) = 1
[Enum(DissolveMask,0,DissolveMasKSoft,1)] _SoftHardEdgeToggle ("SoftHardEdgeToggle", Float) = 1
_OpacityIntensity ("OpacityIntensity", Float) = 4
[Header(MiHoYoDepthFade)] [Toggle(_SOFTPARTICLES_ON)] _SOFTPARTICLES ("SOFTPARTICLES", Float) = 0
_DepthThresh ("DepthThresh", Range(0.001, 20)) = 1
_DepthFade ("DepthFade", Range(0.001, 20)) = 1
_texcoord ("", 2D) = "white" { }
__dirty ("", Float) = 1
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 44041
Program "vp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
lowp float u_xlat10_3;
mediump float u_xlat16_4;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
bool u_xlatb6;
float u_xlat9;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
float u_xlat10;
mediump float u_xlat16_10;
bool u_xlatb10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat3.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xw;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zy;
    u_xlat10_9 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_10 = u_xlat10_6 + u_xlat10_9;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zw;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_4 = u_xlat10_1 + u_xlat16_10;
    u_xlat16_6 = u_xlat10_6 + u_xlat10_1;
    u_xlat16_6 = u_xlat10_9 + u_xlat16_6;
    u_xlat16_9 = u_xlat10_3 + u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat10_3) * _MovingLightColor01.xyz;
    u_xlat1.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_6) + u_xlat1.xyz;
    u_xlat3.x = u_xlat16_9 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat0.x * u_xlat3.x;
    u_xlat9 = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat10 = (-u_xlat2.w) + 1.0;
    u_xlat9 = u_xlat10 * u_xlat9 + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat9>=u_xlat6.x);
#else
    u_xlatb6 = u_xlat9>=u_xlat6.x;
#endif
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat9);
    u_xlat3.x = u_xlat3.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.x = (u_xlatb6) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat0.x = u_xlatb2.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb2.x) ? u_xlat6.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat3.x;
    u_xlat1.w = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    vs_TEXCOORD3.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
lowp float u_xlat10_3;
mediump float u_xlat16_4;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
bool u_xlatb6;
float u_xlat9;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
float u_xlat10;
mediump float u_xlat16_10;
bool u_xlatb10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat3.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xw;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zy;
    u_xlat10_9 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_10 = u_xlat10_6 + u_xlat10_9;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zw;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_4 = u_xlat10_1 + u_xlat16_10;
    u_xlat16_6 = u_xlat10_6 + u_xlat10_1;
    u_xlat16_6 = u_xlat10_9 + u_xlat16_6;
    u_xlat16_9 = u_xlat10_3 + u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat10_3) * _MovingLightColor01.xyz;
    u_xlat1.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_6) + u_xlat1.xyz;
    u_xlat3.x = u_xlat16_9 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat0.x * u_xlat3.x;
    u_xlat9 = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat10 = (-u_xlat2.w) + 1.0;
    u_xlat9 = u_xlat10 * u_xlat9 + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat9>=u_xlat6.x);
#else
    u_xlatb6 = u_xlat9>=u_xlat6.x;
#endif
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat9);
    u_xlat3.x = u_xlat3.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.x = (u_xlatb6) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat0.x = u_xlatb2.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb2.x) ? u_xlat6.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat3.x;
    u_xlat1.w = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
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
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
lowp float u_xlat10_3;
mediump float u_xlat16_4;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
bool u_xlatb6;
float u_xlat9;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
float u_xlat10;
mediump float u_xlat16_10;
bool u_xlatb10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat3.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xw;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zy;
    u_xlat10_9 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_10 = u_xlat10_6 + u_xlat10_9;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zw;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_4 = u_xlat10_1 + u_xlat16_10;
    u_xlat16_6 = u_xlat10_6 + u_xlat10_1;
    u_xlat16_6 = u_xlat10_9 + u_xlat16_6;
    u_xlat16_9 = u_xlat10_3 + u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat10_3) * _MovingLightColor01.xyz;
    u_xlat1.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_6) + u_xlat1.xyz;
    u_xlat3.x = u_xlat16_9 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat0.x * u_xlat3.x;
    u_xlat9 = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat10 = (-u_xlat2.w) + 1.0;
    u_xlat9 = u_xlat10 * u_xlat9 + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat9>=u_xlat6.x);
#else
    u_xlatb6 = u_xlat9>=u_xlat6.x;
#endif
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat9);
    u_xlat3.x = u_xlat3.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.x = (u_xlatb6) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat0.x = u_xlatb2.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb2.x) ? u_xlat6.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat3.x;
    u_xlat1.w = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
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
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
lowp float u_xlat10_3;
mediump float u_xlat16_4;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
bool u_xlatb6;
float u_xlat9;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
float u_xlat10;
mediump float u_xlat16_10;
bool u_xlatb10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat3.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xw;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zy;
    u_xlat10_9 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_10 = u_xlat10_6 + u_xlat10_9;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zw;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_4 = u_xlat10_1 + u_xlat16_10;
    u_xlat16_6 = u_xlat10_6 + u_xlat10_1;
    u_xlat16_6 = u_xlat10_9 + u_xlat16_6;
    u_xlat16_9 = u_xlat10_3 + u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat10_3) * _MovingLightColor01.xyz;
    u_xlat1.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_6) + u_xlat1.xyz;
    u_xlat3.x = u_xlat16_9 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat0.x * u_xlat3.x;
    u_xlat9 = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat10 = (-u_xlat2.w) + 1.0;
    u_xlat9 = u_xlat10 * u_xlat9 + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat9>=u_xlat6.x);
#else
    u_xlatb6 = u_xlat9>=u_xlat6.x;
#endif
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat9);
    u_xlat3.x = u_xlat3.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.x = (u_xlatb6) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat0.x = u_xlatb2.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb2.x) ? u_xlat6.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat3.x;
    u_xlat1.w = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
lowp float u_xlat10_3;
mediump float u_xlat16_4;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
bool u_xlatb6;
float u_xlat9;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
float u_xlat10;
mediump float u_xlat16_10;
bool u_xlatb10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat3.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xw;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zy;
    u_xlat10_9 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_10 = u_xlat10_6 + u_xlat10_9;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zw;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_4 = u_xlat10_1 + u_xlat16_10;
    u_xlat16_6 = u_xlat10_6 + u_xlat10_1;
    u_xlat16_6 = u_xlat10_9 + u_xlat16_6;
    u_xlat16_9 = u_xlat10_3 + u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat10_3) * _MovingLightColor01.xyz;
    u_xlat1.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_6) + u_xlat1.xyz;
    u_xlat3.x = u_xlat16_9 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat0.x * u_xlat3.x;
    u_xlat9 = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat10 = (-u_xlat2.w) + 1.0;
    u_xlat9 = u_xlat10 * u_xlat9 + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat9>=u_xlat6.x);
#else
    u_xlatb6 = u_xlat9>=u_xlat6.x;
#endif
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat9);
    u_xlat3.x = u_xlat3.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.x = (u_xlatb6) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat0.x = u_xlatb2.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb2.x) ? u_xlat6.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat3.x;
    u_xlat1.w = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat4 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat5 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat5 * u_xlat1.xxxx + u_xlat4;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat4;
    u_xlat2 = u_xlat5 * u_xlat5 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
lowp float u_xlat10_3;
mediump float u_xlat16_4;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
bool u_xlatb6;
float u_xlat9;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
float u_xlat10;
mediump float u_xlat16_10;
bool u_xlatb10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat3.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xw;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zy;
    u_xlat10_9 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_10 = u_xlat10_6 + u_xlat10_9;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zw;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_4 = u_xlat10_1 + u_xlat16_10;
    u_xlat16_6 = u_xlat10_6 + u_xlat10_1;
    u_xlat16_6 = u_xlat10_9 + u_xlat16_6;
    u_xlat16_9 = u_xlat10_3 + u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat10_3) * _MovingLightColor01.xyz;
    u_xlat1.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_6) + u_xlat1.xyz;
    u_xlat3.x = u_xlat16_9 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat0.x * u_xlat3.x;
    u_xlat9 = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat10 = (-u_xlat2.w) + 1.0;
    u_xlat9 = u_xlat10 * u_xlat9 + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat9>=u_xlat6.x);
#else
    u_xlatb6 = u_xlat9>=u_xlat6.x;
#endif
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat9);
    u_xlat3.x = u_xlat3.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.x = (u_xlatb6) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat0.x = u_xlatb2.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb2.x) ? u_xlat6.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat3.x;
    u_xlat1.w = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
lowp float u_xlat10_3;
mediump float u_xlat16_4;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
bool u_xlatb6;
float u_xlat9;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
float u_xlat10;
mediump float u_xlat16_10;
bool u_xlatb10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat3.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xw;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zy;
    u_xlat10_9 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_10 = u_xlat10_6 + u_xlat10_9;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zw;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_4 = u_xlat10_1 + u_xlat16_10;
    u_xlat16_6 = u_xlat10_6 + u_xlat10_1;
    u_xlat16_6 = u_xlat10_9 + u_xlat16_6;
    u_xlat16_9 = u_xlat10_3 + u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat10_3) * _MovingLightColor01.xyz;
    u_xlat1.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_6) + u_xlat1.xyz;
    u_xlat3.x = u_xlat16_9 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat0.x * u_xlat3.x;
    u_xlat9 = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat10 = (-u_xlat2.w) + 1.0;
    u_xlat9 = u_xlat10 * u_xlat9 + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat9>=u_xlat6.x);
#else
    u_xlatb6 = u_xlat9>=u_xlat6.x;
#endif
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat9);
    u_xlat3.x = u_xlat3.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.x = (u_xlatb6) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat0.x = u_xlatb2.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb2.x) ? u_xlat6.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat3.x;
    u_xlat1.w = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    vs_TEXCOORD3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
lowp float u_xlat10_3;
mediump float u_xlat16_4;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
bool u_xlatb6;
float u_xlat9;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
float u_xlat10;
mediump float u_xlat16_10;
bool u_xlatb10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat3.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xw;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zy;
    u_xlat10_9 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_10 = u_xlat10_6 + u_xlat10_9;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zw;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_4 = u_xlat10_1 + u_xlat16_10;
    u_xlat16_6 = u_xlat10_6 + u_xlat10_1;
    u_xlat16_6 = u_xlat10_9 + u_xlat16_6;
    u_xlat16_9 = u_xlat10_3 + u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat10_3) * _MovingLightColor01.xyz;
    u_xlat1.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_6) + u_xlat1.xyz;
    u_xlat3.x = u_xlat16_9 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat0.x * u_xlat3.x;
    u_xlat9 = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat10 = (-u_xlat2.w) + 1.0;
    u_xlat9 = u_xlat10 * u_xlat9 + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat9>=u_xlat6.x);
#else
    u_xlatb6 = u_xlat9>=u_xlat6.x;
#endif
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat9);
    u_xlat3.x = u_xlat3.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.x = (u_xlatb6) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat0.x = u_xlatb2.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb2.x) ? u_xlat6.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat3.x;
    u_xlat1.w = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct unity_Builtins2Array_Type {
	vec4 unity_StaicLightMapSTArray;
	vec4 unity_DynamicLightMapSTArray;
};
layout(std140) uniform UnityInstancing_PerDraw2 {
	unity_Builtins2Array_Type unity_Builtins2Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
ivec2 u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0.x = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0.xy = u_xlati0.xx << ivec2(3, 1);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_Builtins2Array[u_xlati0.y / 2].unity_StaicLightMapSTArray.xy + unity_Builtins2Array[u_xlati0.y / 2].unity_StaicLightMapSTArray.zw;
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
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
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
lowp float u_xlat10_3;
mediump float u_xlat16_4;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
bool u_xlatb6;
float u_xlat9;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
float u_xlat10;
mediump float u_xlat16_10;
bool u_xlatb10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat3.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xw;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zy;
    u_xlat10_9 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_10 = u_xlat10_6 + u_xlat10_9;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zw;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_4 = u_xlat10_1 + u_xlat16_10;
    u_xlat16_6 = u_xlat10_6 + u_xlat10_1;
    u_xlat16_6 = u_xlat10_9 + u_xlat16_6;
    u_xlat16_9 = u_xlat10_3 + u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat10_3) * _MovingLightColor01.xyz;
    u_xlat1.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_6) + u_xlat1.xyz;
    u_xlat3.x = u_xlat16_9 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat0.x * u_xlat3.x;
    u_xlat9 = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat10 = (-u_xlat2.w) + 1.0;
    u_xlat9 = u_xlat10 * u_xlat9 + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat9>=u_xlat6.x);
#else
    u_xlatb6 = u_xlat9>=u_xlat6.x;
#endif
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat9);
    u_xlat3.x = u_xlat3.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.x = (u_xlatb6) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat0.x = u_xlatb2.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb2.x) ? u_xlat6.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat3.x;
    u_xlat1.w = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct unity_Builtins2Array_Type {
	vec4 unity_StaicLightMapSTArray;
	vec4 unity_DynamicLightMapSTArray;
};
layout(std140) uniform UnityInstancing_PerDraw2 {
	unity_Builtins2Array_Type unity_Builtins2Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
ivec2 u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0.x = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0.xy = u_xlati0.xx << ivec2(3, 1);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_Builtins2Array[u_xlati0.y / 2].unity_StaicLightMapSTArray.xy + unity_Builtins2Array[u_xlati0.y / 2].unity_StaicLightMapSTArray.zw;
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
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
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
lowp float u_xlat10_3;
mediump float u_xlat16_4;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
bool u_xlatb6;
float u_xlat9;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
float u_xlat10;
mediump float u_xlat16_10;
bool u_xlatb10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat3.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xw;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zy;
    u_xlat10_9 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_10 = u_xlat10_6 + u_xlat10_9;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zw;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_4 = u_xlat10_1 + u_xlat16_10;
    u_xlat16_6 = u_xlat10_6 + u_xlat10_1;
    u_xlat16_6 = u_xlat10_9 + u_xlat16_6;
    u_xlat16_9 = u_xlat10_3 + u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat10_3) * _MovingLightColor01.xyz;
    u_xlat1.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_6) + u_xlat1.xyz;
    u_xlat3.x = u_xlat16_9 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat0.x * u_xlat3.x;
    u_xlat9 = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat10 = (-u_xlat2.w) + 1.0;
    u_xlat9 = u_xlat10 * u_xlat9 + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat9>=u_xlat6.x);
#else
    u_xlatb6 = u_xlat9>=u_xlat6.x;
#endif
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat9);
    u_xlat3.x = u_xlat3.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.x = (u_xlatb6) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat0.x = u_xlatb2.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb2.x) ? u_xlat6.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat3.x;
    u_xlat1.w = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat5.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat2 = (-u_xlat5.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat4 = (-u_xlat5.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat5.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat1.xxxx + u_xlat3;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat3;
    u_xlat2 = u_xlat4 * u_xlat4 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
lowp float u_xlat10_3;
mediump float u_xlat16_4;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
bool u_xlatb6;
float u_xlat9;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
float u_xlat10;
mediump float u_xlat16_10;
bool u_xlatb10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat3.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xw;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zy;
    u_xlat10_9 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_10 = u_xlat10_6 + u_xlat10_9;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zw;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_4 = u_xlat10_1 + u_xlat16_10;
    u_xlat16_6 = u_xlat10_6 + u_xlat10_1;
    u_xlat16_6 = u_xlat10_9 + u_xlat16_6;
    u_xlat16_9 = u_xlat10_3 + u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat10_3) * _MovingLightColor01.xyz;
    u_xlat1.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_6) + u_xlat1.xyz;
    u_xlat3.x = u_xlat16_9 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat0.x * u_xlat3.x;
    u_xlat9 = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat10 = (-u_xlat2.w) + 1.0;
    u_xlat9 = u_xlat10 * u_xlat9 + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat9>=u_xlat6.x);
#else
    u_xlatb6 = u_xlat9>=u_xlat6.x;
#endif
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat9);
    u_xlat3.x = u_xlat3.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.x = (u_xlatb6) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat0.x = u_xlatb2.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb2.x) ? u_xlat6.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat3.x;
    u_xlat1.w = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat6.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat2 = (-u_xlat6.yyyy) + unity_4LightPosY0;
    u_xlat4 = u_xlat1.yyyy * u_xlat2;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat5 = (-u_xlat6.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat6.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat5 * u_xlat1.xxxx + u_xlat4;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat4;
    u_xlat2 = u_xlat5 * u_xlat5 + u_xlat2;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat2 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
lowp float u_xlat10_3;
mediump float u_xlat16_4;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
bool u_xlatb6;
float u_xlat9;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
float u_xlat10;
mediump float u_xlat16_10;
bool u_xlatb10;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat3.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xw;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zy;
    u_xlat10_9 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_10 = u_xlat10_6 + u_xlat10_9;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat3.xx + u_xlat2.zw;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_4 = u_xlat10_1 + u_xlat16_10;
    u_xlat16_6 = u_xlat10_6 + u_xlat10_1;
    u_xlat16_6 = u_xlat10_9 + u_xlat16_6;
    u_xlat16_9 = u_xlat10_3 + u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat10_3) * _MovingLightColor01.xyz;
    u_xlat1.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_6) + u_xlat1.xyz;
    u_xlat3.x = u_xlat16_9 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat0.x * u_xlat3.x;
    u_xlat9 = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_MainColorToggle==1.0);
#else
    u_xlatb10 = _MainColorToggle==1.0;
#endif
    u_xlat2 = (bool(u_xlatb10)) ? _MainColor : vs_COLOR0;
    u_xlat10 = (-u_xlat2.w) + 1.0;
    u_xlat9 = u_xlat10 * u_xlat9 + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat9>=u_xlat6.x);
#else
    u_xlatb6 = u_xlat9>=u_xlat6.x;
#endif
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat9);
    u_xlat3.x = u_xlat3.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.x = (u_xlatb6) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat0.x = u_xlatb2.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb2.x) ? u_xlat6.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat3.x;
    u_xlat1.w = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec2 u_xlat6;
vec2 u_xlat8;
lowp float u_xlat10_8;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
bool u_xlatb12;
lowp float u_xlat10_13;
void main()
{
    u_xlat0 = vs_TEXCOORD3.w + 9.99999996e-12;
    u_xlat4.xy = vs_TEXCOORD3.xy / vec2(u_xlat0);
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0 = (-u_xlat0) + u_xlat4.x;
    u_xlat4.x = u_xlat0 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0) + 1.0;
    u_xlat0 = u_xlat4.x * u_xlat8.x + u_xlat0;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat4.y;
    u_xlat1 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xw;
    u_xlat10_12 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zy;
    u_xlat10_13 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_2 = u_xlat10_12 + u_xlat10_13;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zw;
    u_xlat10_8 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_5 = u_xlat10_1 + u_xlat16_2;
    u_xlat16_12 = u_xlat10_12 + u_xlat10_1;
    u_xlat16_12 = u_xlat10_13 + u_xlat16_12;
    u_xlat16_1 = u_xlat10_8 + u_xlat16_5;
    u_xlat5.xyz = vec3(u_xlat10_8) * _MovingLightColor01.xyz;
    u_xlat5.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_12) + u_xlat5.xyz;
    u_xlat8.x = u_xlat16_1 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat4.x * u_xlat8.x;
    u_xlat1.x = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_MainColorToggle==1.0);
#else
    u_xlatb2.x = _MainColorToggle==1.0;
#endif
    u_xlat2 = (u_xlatb2.x) ? _MainColor : vs_COLOR0;
    u_xlat3.x = (-u_xlat2.w) + 1.0;
    u_xlat1.x = u_xlat3.x * u_xlat1.x + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat1.x>=u_xlat12);
#else
    u_xlatb12 = u_xlat1.x>=u_xlat12;
#endif
    u_xlat4.x = u_xlat8.x * u_xlat4.x + (-u_xlat1.x);
    u_xlat8.x = u_xlat8.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat5.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat4.x = u_xlat4.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (u_xlatb12) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat4.x = u_xlatb2.y ? u_xlat4.x : float(0.0);
    u_xlat4.x = (u_xlatb2.x) ? u_xlat12 : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat4.x : u_xlat8.x;
    u_xlat0 = u_xlat0 * u_xlat4.x;
    u_xlat1.w = u_xlat0 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
    vs_TEXCOORD4.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec2 u_xlat6;
vec2 u_xlat8;
lowp float u_xlat10_8;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
bool u_xlatb12;
lowp float u_xlat10_13;
void main()
{
    u_xlat0 = vs_TEXCOORD3.w + 9.99999996e-12;
    u_xlat4.xy = vs_TEXCOORD3.xy / vec2(u_xlat0);
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0 = (-u_xlat0) + u_xlat4.x;
    u_xlat4.x = u_xlat0 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0) + 1.0;
    u_xlat0 = u_xlat4.x * u_xlat8.x + u_xlat0;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat4.y;
    u_xlat1 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xw;
    u_xlat10_12 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zy;
    u_xlat10_13 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_2 = u_xlat10_12 + u_xlat10_13;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zw;
    u_xlat10_8 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_5 = u_xlat10_1 + u_xlat16_2;
    u_xlat16_12 = u_xlat10_12 + u_xlat10_1;
    u_xlat16_12 = u_xlat10_13 + u_xlat16_12;
    u_xlat16_1 = u_xlat10_8 + u_xlat16_5;
    u_xlat5.xyz = vec3(u_xlat10_8) * _MovingLightColor01.xyz;
    u_xlat5.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_12) + u_xlat5.xyz;
    u_xlat8.x = u_xlat16_1 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat4.x * u_xlat8.x;
    u_xlat1.x = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_MainColorToggle==1.0);
#else
    u_xlatb2.x = _MainColorToggle==1.0;
#endif
    u_xlat2 = (u_xlatb2.x) ? _MainColor : vs_COLOR0;
    u_xlat3.x = (-u_xlat2.w) + 1.0;
    u_xlat1.x = u_xlat3.x * u_xlat1.x + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat1.x>=u_xlat12);
#else
    u_xlatb12 = u_xlat1.x>=u_xlat12;
#endif
    u_xlat4.x = u_xlat8.x * u_xlat4.x + (-u_xlat1.x);
    u_xlat8.x = u_xlat8.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat5.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat4.x = u_xlat4.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (u_xlatb12) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat4.x = u_xlatb2.y ? u_xlat4.x : float(0.0);
    u_xlat4.x = (u_xlatb2.x) ? u_xlat12 : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat4.x : u_xlat8.x;
    u_xlat0 = u_xlat0 * u_xlat4.x;
    u_xlat1.w = u_xlat0 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
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
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec2 u_xlat6;
vec2 u_xlat8;
lowp float u_xlat10_8;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
bool u_xlatb12;
lowp float u_xlat10_13;
void main()
{
    u_xlat0 = vs_TEXCOORD3.w + 9.99999996e-12;
    u_xlat4.xy = vs_TEXCOORD3.xy / vec2(u_xlat0);
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0 = (-u_xlat0) + u_xlat4.x;
    u_xlat4.x = u_xlat0 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0) + 1.0;
    u_xlat0 = u_xlat4.x * u_xlat8.x + u_xlat0;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat4.y;
    u_xlat1 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xw;
    u_xlat10_12 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zy;
    u_xlat10_13 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_2 = u_xlat10_12 + u_xlat10_13;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zw;
    u_xlat10_8 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_5 = u_xlat10_1 + u_xlat16_2;
    u_xlat16_12 = u_xlat10_12 + u_xlat10_1;
    u_xlat16_12 = u_xlat10_13 + u_xlat16_12;
    u_xlat16_1 = u_xlat10_8 + u_xlat16_5;
    u_xlat5.xyz = vec3(u_xlat10_8) * _MovingLightColor01.xyz;
    u_xlat5.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_12) + u_xlat5.xyz;
    u_xlat8.x = u_xlat16_1 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat4.x * u_xlat8.x;
    u_xlat1.x = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_MainColorToggle==1.0);
#else
    u_xlatb2.x = _MainColorToggle==1.0;
#endif
    u_xlat2 = (u_xlatb2.x) ? _MainColor : vs_COLOR0;
    u_xlat3.x = (-u_xlat2.w) + 1.0;
    u_xlat1.x = u_xlat3.x * u_xlat1.x + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat1.x>=u_xlat12);
#else
    u_xlatb12 = u_xlat1.x>=u_xlat12;
#endif
    u_xlat4.x = u_xlat8.x * u_xlat4.x + (-u_xlat1.x);
    u_xlat8.x = u_xlat8.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat5.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat4.x = u_xlat4.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (u_xlatb12) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat4.x = u_xlatb2.y ? u_xlat4.x : float(0.0);
    u_xlat4.x = (u_xlatb2.x) ? u_xlat12 : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat4.x : u_xlat8.x;
    u_xlat0 = u_xlat0 * u_xlat4.x;
    u_xlat1.w = u_xlat0 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
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
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec2 u_xlat6;
vec2 u_xlat8;
lowp float u_xlat10_8;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
bool u_xlatb12;
lowp float u_xlat10_13;
void main()
{
    u_xlat0 = vs_TEXCOORD3.w + 9.99999996e-12;
    u_xlat4.xy = vs_TEXCOORD3.xy / vec2(u_xlat0);
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0 = (-u_xlat0) + u_xlat4.x;
    u_xlat4.x = u_xlat0 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0) + 1.0;
    u_xlat0 = u_xlat4.x * u_xlat8.x + u_xlat0;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat4.y;
    u_xlat1 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xw;
    u_xlat10_12 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zy;
    u_xlat10_13 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_2 = u_xlat10_12 + u_xlat10_13;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zw;
    u_xlat10_8 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_5 = u_xlat10_1 + u_xlat16_2;
    u_xlat16_12 = u_xlat10_12 + u_xlat10_1;
    u_xlat16_12 = u_xlat10_13 + u_xlat16_12;
    u_xlat16_1 = u_xlat10_8 + u_xlat16_5;
    u_xlat5.xyz = vec3(u_xlat10_8) * _MovingLightColor01.xyz;
    u_xlat5.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_12) + u_xlat5.xyz;
    u_xlat8.x = u_xlat16_1 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat4.x * u_xlat8.x;
    u_xlat1.x = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_MainColorToggle==1.0);
#else
    u_xlatb2.x = _MainColorToggle==1.0;
#endif
    u_xlat2 = (u_xlatb2.x) ? _MainColor : vs_COLOR0;
    u_xlat3.x = (-u_xlat2.w) + 1.0;
    u_xlat1.x = u_xlat3.x * u_xlat1.x + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat1.x>=u_xlat12);
#else
    u_xlatb12 = u_xlat1.x>=u_xlat12;
#endif
    u_xlat4.x = u_xlat8.x * u_xlat4.x + (-u_xlat1.x);
    u_xlat8.x = u_xlat8.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat5.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat4.x = u_xlat4.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (u_xlatb12) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat4.x = u_xlatb2.y ? u_xlat4.x : float(0.0);
    u_xlat4.x = (u_xlatb2.x) ? u_xlat12 : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat4.x : u_xlat8.x;
    u_xlat0 = u_xlat0 * u_xlat4.x;
    u_xlat1.w = u_xlat0 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat15 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat2.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec2 u_xlat6;
vec2 u_xlat8;
lowp float u_xlat10_8;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
bool u_xlatb12;
lowp float u_xlat10_13;
void main()
{
    u_xlat0 = vs_TEXCOORD3.w + 9.99999996e-12;
    u_xlat4.xy = vs_TEXCOORD3.xy / vec2(u_xlat0);
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0 = (-u_xlat0) + u_xlat4.x;
    u_xlat4.x = u_xlat0 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0) + 1.0;
    u_xlat0 = u_xlat4.x * u_xlat8.x + u_xlat0;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat4.y;
    u_xlat1 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xw;
    u_xlat10_12 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zy;
    u_xlat10_13 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_2 = u_xlat10_12 + u_xlat10_13;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zw;
    u_xlat10_8 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_5 = u_xlat10_1 + u_xlat16_2;
    u_xlat16_12 = u_xlat10_12 + u_xlat10_1;
    u_xlat16_12 = u_xlat10_13 + u_xlat16_12;
    u_xlat16_1 = u_xlat10_8 + u_xlat16_5;
    u_xlat5.xyz = vec3(u_xlat10_8) * _MovingLightColor01.xyz;
    u_xlat5.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_12) + u_xlat5.xyz;
    u_xlat8.x = u_xlat16_1 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat4.x * u_xlat8.x;
    u_xlat1.x = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_MainColorToggle==1.0);
#else
    u_xlatb2.x = _MainColorToggle==1.0;
#endif
    u_xlat2 = (u_xlatb2.x) ? _MainColor : vs_COLOR0;
    u_xlat3.x = (-u_xlat2.w) + 1.0;
    u_xlat1.x = u_xlat3.x * u_xlat1.x + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat1.x>=u_xlat12);
#else
    u_xlatb12 = u_xlat1.x>=u_xlat12;
#endif
    u_xlat4.x = u_xlat8.x * u_xlat4.x + (-u_xlat1.x);
    u_xlat8.x = u_xlat8.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat5.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat4.x = u_xlat4.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (u_xlatb12) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat4.x = u_xlatb2.y ? u_xlat4.x : float(0.0);
    u_xlat4.x = (u_xlatb2.x) ? u_xlat12 : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat4.x : u_xlat8.x;
    u_xlat0 = u_xlat0 * u_xlat4.x;
    u_xlat1.w = u_xlat0 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat18 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
    u_xlat16_1 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat2.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat5 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat5 * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
    u_xlat1 = u_xlat5 * u_xlat5 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec2 u_xlat6;
vec2 u_xlat8;
lowp float u_xlat10_8;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
bool u_xlatb12;
lowp float u_xlat10_13;
void main()
{
    u_xlat0 = vs_TEXCOORD3.w + 9.99999996e-12;
    u_xlat4.xy = vs_TEXCOORD3.xy / vec2(u_xlat0);
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0 = (-u_xlat0) + u_xlat4.x;
    u_xlat4.x = u_xlat0 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0) + 1.0;
    u_xlat0 = u_xlat4.x * u_xlat8.x + u_xlat0;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat4.y;
    u_xlat1 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xw;
    u_xlat10_12 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zy;
    u_xlat10_13 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_2 = u_xlat10_12 + u_xlat10_13;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zw;
    u_xlat10_8 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_5 = u_xlat10_1 + u_xlat16_2;
    u_xlat16_12 = u_xlat10_12 + u_xlat10_1;
    u_xlat16_12 = u_xlat10_13 + u_xlat16_12;
    u_xlat16_1 = u_xlat10_8 + u_xlat16_5;
    u_xlat5.xyz = vec3(u_xlat10_8) * _MovingLightColor01.xyz;
    u_xlat5.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_12) + u_xlat5.xyz;
    u_xlat8.x = u_xlat16_1 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat4.x * u_xlat8.x;
    u_xlat1.x = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_MainColorToggle==1.0);
#else
    u_xlatb2.x = _MainColorToggle==1.0;
#endif
    u_xlat2 = (u_xlatb2.x) ? _MainColor : vs_COLOR0;
    u_xlat3.x = (-u_xlat2.w) + 1.0;
    u_xlat1.x = u_xlat3.x * u_xlat1.x + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat1.x>=u_xlat12);
#else
    u_xlatb12 = u_xlat1.x>=u_xlat12;
#endif
    u_xlat4.x = u_xlat8.x * u_xlat4.x + (-u_xlat1.x);
    u_xlat8.x = u_xlat8.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat5.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat4.x = u_xlat4.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (u_xlatb12) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat4.x = u_xlatb2.y ? u_xlat4.x : float(0.0);
    u_xlat4.x = (u_xlatb2.x) ? u_xlat12 : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat4.x : u_xlat8.x;
    u_xlat0 = u_xlat0 * u_xlat4.x;
    u_xlat1.w = u_xlat0 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec2 u_xlat6;
vec2 u_xlat8;
lowp float u_xlat10_8;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
bool u_xlatb12;
lowp float u_xlat10_13;
void main()
{
    u_xlat0 = vs_TEXCOORD3.w + 9.99999996e-12;
    u_xlat4.xy = vs_TEXCOORD3.xy / vec2(u_xlat0);
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0 = (-u_xlat0) + u_xlat4.x;
    u_xlat4.x = u_xlat0 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0) + 1.0;
    u_xlat0 = u_xlat4.x * u_xlat8.x + u_xlat0;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat4.y;
    u_xlat1 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xw;
    u_xlat10_12 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zy;
    u_xlat10_13 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_2 = u_xlat10_12 + u_xlat10_13;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zw;
    u_xlat10_8 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_5 = u_xlat10_1 + u_xlat16_2;
    u_xlat16_12 = u_xlat10_12 + u_xlat10_1;
    u_xlat16_12 = u_xlat10_13 + u_xlat16_12;
    u_xlat16_1 = u_xlat10_8 + u_xlat16_5;
    u_xlat5.xyz = vec3(u_xlat10_8) * _MovingLightColor01.xyz;
    u_xlat5.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_12) + u_xlat5.xyz;
    u_xlat8.x = u_xlat16_1 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat4.x * u_xlat8.x;
    u_xlat1.x = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_MainColorToggle==1.0);
#else
    u_xlatb2.x = _MainColorToggle==1.0;
#endif
    u_xlat2 = (u_xlatb2.x) ? _MainColor : vs_COLOR0;
    u_xlat3.x = (-u_xlat2.w) + 1.0;
    u_xlat1.x = u_xlat3.x * u_xlat1.x + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat1.x>=u_xlat12);
#else
    u_xlatb12 = u_xlat1.x>=u_xlat12;
#endif
    u_xlat4.x = u_xlat8.x * u_xlat4.x + (-u_xlat1.x);
    u_xlat8.x = u_xlat8.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat5.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat4.x = u_xlat4.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (u_xlatb12) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat4.x = u_xlatb2.y ? u_xlat4.x : float(0.0);
    u_xlat4.x = (u_xlatb2.x) ? u_xlat12 : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat4.x : u_xlat8.x;
    u_xlat0 = u_xlat0 * u_xlat4.x;
    u_xlat1.w = u_xlat0 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
    vs_TEXCOORD4.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec2 u_xlat6;
vec2 u_xlat8;
lowp float u_xlat10_8;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
bool u_xlatb12;
lowp float u_xlat10_13;
void main()
{
    u_xlat0 = vs_TEXCOORD3.w + 9.99999996e-12;
    u_xlat4.xy = vs_TEXCOORD3.xy / vec2(u_xlat0);
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0 = (-u_xlat0) + u_xlat4.x;
    u_xlat4.x = u_xlat0 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0) + 1.0;
    u_xlat0 = u_xlat4.x * u_xlat8.x + u_xlat0;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat4.y;
    u_xlat1 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xw;
    u_xlat10_12 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zy;
    u_xlat10_13 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_2 = u_xlat10_12 + u_xlat10_13;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zw;
    u_xlat10_8 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_5 = u_xlat10_1 + u_xlat16_2;
    u_xlat16_12 = u_xlat10_12 + u_xlat10_1;
    u_xlat16_12 = u_xlat10_13 + u_xlat16_12;
    u_xlat16_1 = u_xlat10_8 + u_xlat16_5;
    u_xlat5.xyz = vec3(u_xlat10_8) * _MovingLightColor01.xyz;
    u_xlat5.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_12) + u_xlat5.xyz;
    u_xlat8.x = u_xlat16_1 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat4.x * u_xlat8.x;
    u_xlat1.x = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_MainColorToggle==1.0);
#else
    u_xlatb2.x = _MainColorToggle==1.0;
#endif
    u_xlat2 = (u_xlatb2.x) ? _MainColor : vs_COLOR0;
    u_xlat3.x = (-u_xlat2.w) + 1.0;
    u_xlat1.x = u_xlat3.x * u_xlat1.x + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat1.x>=u_xlat12);
#else
    u_xlatb12 = u_xlat1.x>=u_xlat12;
#endif
    u_xlat4.x = u_xlat8.x * u_xlat4.x + (-u_xlat1.x);
    u_xlat8.x = u_xlat8.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat5.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat4.x = u_xlat4.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (u_xlatb12) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat4.x = u_xlatb2.y ? u_xlat4.x : float(0.0);
    u_xlat4.x = (u_xlatb2.x) ? u_xlat12 : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat4.x : u_xlat8.x;
    u_xlat0 = u_xlat0 * u_xlat4.x;
    u_xlat1.w = u_xlat0 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct unity_Builtins2Array_Type {
	vec4 unity_StaicLightMapSTArray;
	vec4 unity_DynamicLightMapSTArray;
};
layout(std140) uniform UnityInstancing_PerDraw2 {
	unity_Builtins2Array_Type unity_Builtins2Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
ivec2 u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0.x = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0.xy = u_xlati0.xx << ivec2(3, 1);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_Builtins2Array[u_xlati0.y / 2].unity_StaicLightMapSTArray.xy + unity_Builtins2Array[u_xlati0.y / 2].unity_StaicLightMapSTArray.zw;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec2 u_xlat6;
vec2 u_xlat8;
lowp float u_xlat10_8;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
bool u_xlatb12;
lowp float u_xlat10_13;
void main()
{
    u_xlat0 = vs_TEXCOORD3.w + 9.99999996e-12;
    u_xlat4.xy = vs_TEXCOORD3.xy / vec2(u_xlat0);
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0 = (-u_xlat0) + u_xlat4.x;
    u_xlat4.x = u_xlat0 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0) + 1.0;
    u_xlat0 = u_xlat4.x * u_xlat8.x + u_xlat0;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat4.y;
    u_xlat1 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xw;
    u_xlat10_12 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zy;
    u_xlat10_13 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_2 = u_xlat10_12 + u_xlat10_13;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zw;
    u_xlat10_8 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_5 = u_xlat10_1 + u_xlat16_2;
    u_xlat16_12 = u_xlat10_12 + u_xlat10_1;
    u_xlat16_12 = u_xlat10_13 + u_xlat16_12;
    u_xlat16_1 = u_xlat10_8 + u_xlat16_5;
    u_xlat5.xyz = vec3(u_xlat10_8) * _MovingLightColor01.xyz;
    u_xlat5.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_12) + u_xlat5.xyz;
    u_xlat8.x = u_xlat16_1 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat4.x * u_xlat8.x;
    u_xlat1.x = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_MainColorToggle==1.0);
#else
    u_xlatb2.x = _MainColorToggle==1.0;
#endif
    u_xlat2 = (u_xlatb2.x) ? _MainColor : vs_COLOR0;
    u_xlat3.x = (-u_xlat2.w) + 1.0;
    u_xlat1.x = u_xlat3.x * u_xlat1.x + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat1.x>=u_xlat12);
#else
    u_xlatb12 = u_xlat1.x>=u_xlat12;
#endif
    u_xlat4.x = u_xlat8.x * u_xlat4.x + (-u_xlat1.x);
    u_xlat8.x = u_xlat8.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat5.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat4.x = u_xlat4.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (u_xlatb12) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat4.x = u_xlatb2.y ? u_xlat4.x : float(0.0);
    u_xlat4.x = (u_xlatb2.x) ? u_xlat12 : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat4.x : u_xlat8.x;
    u_xlat0 = u_xlat0 * u_xlat4.x;
    u_xlat1.w = u_xlat0 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct unity_Builtins2Array_Type {
	vec4 unity_StaicLightMapSTArray;
	vec4 unity_DynamicLightMapSTArray;
};
layout(std140) uniform UnityInstancing_PerDraw2 {
	unity_Builtins2Array_Type unity_Builtins2Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
ivec2 u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlati0.x = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0.xy = u_xlati0.xx << ivec2(3, 1);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_Builtins2Array[u_xlati0.y / 2].unity_StaicLightMapSTArray.xy + unity_Builtins2Array[u_xlati0.y / 2].unity_StaicLightMapSTArray.zw;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec2 u_xlat6;
vec2 u_xlat8;
lowp float u_xlat10_8;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
bool u_xlatb12;
lowp float u_xlat10_13;
void main()
{
    u_xlat0 = vs_TEXCOORD3.w + 9.99999996e-12;
    u_xlat4.xy = vs_TEXCOORD3.xy / vec2(u_xlat0);
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0 = (-u_xlat0) + u_xlat4.x;
    u_xlat4.x = u_xlat0 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0) + 1.0;
    u_xlat0 = u_xlat4.x * u_xlat8.x + u_xlat0;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat4.y;
    u_xlat1 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xw;
    u_xlat10_12 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zy;
    u_xlat10_13 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_2 = u_xlat10_12 + u_xlat10_13;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zw;
    u_xlat10_8 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_5 = u_xlat10_1 + u_xlat16_2;
    u_xlat16_12 = u_xlat10_12 + u_xlat10_1;
    u_xlat16_12 = u_xlat10_13 + u_xlat16_12;
    u_xlat16_1 = u_xlat10_8 + u_xlat16_5;
    u_xlat5.xyz = vec3(u_xlat10_8) * _MovingLightColor01.xyz;
    u_xlat5.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_12) + u_xlat5.xyz;
    u_xlat8.x = u_xlat16_1 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat4.x * u_xlat8.x;
    u_xlat1.x = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_MainColorToggle==1.0);
#else
    u_xlatb2.x = _MainColorToggle==1.0;
#endif
    u_xlat2 = (u_xlatb2.x) ? _MainColor : vs_COLOR0;
    u_xlat3.x = (-u_xlat2.w) + 1.0;
    u_xlat1.x = u_xlat3.x * u_xlat1.x + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat1.x>=u_xlat12);
#else
    u_xlatb12 = u_xlat1.x>=u_xlat12;
#endif
    u_xlat4.x = u_xlat8.x * u_xlat4.x + (-u_xlat1.x);
    u_xlat8.x = u_xlat8.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat5.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat4.x = u_xlat4.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (u_xlatb12) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat4.x = u_xlatb2.y ? u_xlat4.x : float(0.0);
    u_xlat4.x = (u_xlatb2.x) ? u_xlat12 : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat4.x : u_xlat8.x;
    u_xlat0 = u_xlat0 * u_xlat4.x;
    u_xlat1.w = u_xlat0 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat5.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat0.x * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1 = (-u_xlat5.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat2.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat5.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat5.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat4 * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec2 u_xlat6;
vec2 u_xlat8;
lowp float u_xlat10_8;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
bool u_xlatb12;
lowp float u_xlat10_13;
void main()
{
    u_xlat0 = vs_TEXCOORD3.w + 9.99999996e-12;
    u_xlat4.xy = vs_TEXCOORD3.xy / vec2(u_xlat0);
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0 = (-u_xlat0) + u_xlat4.x;
    u_xlat4.x = u_xlat0 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0) + 1.0;
    u_xlat0 = u_xlat4.x * u_xlat8.x + u_xlat0;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat4.y;
    u_xlat1 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xw;
    u_xlat10_12 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zy;
    u_xlat10_13 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_2 = u_xlat10_12 + u_xlat10_13;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zw;
    u_xlat10_8 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_5 = u_xlat10_1 + u_xlat16_2;
    u_xlat16_12 = u_xlat10_12 + u_xlat10_1;
    u_xlat16_12 = u_xlat10_13 + u_xlat16_12;
    u_xlat16_1 = u_xlat10_8 + u_xlat16_5;
    u_xlat5.xyz = vec3(u_xlat10_8) * _MovingLightColor01.xyz;
    u_xlat5.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_12) + u_xlat5.xyz;
    u_xlat8.x = u_xlat16_1 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat4.x * u_xlat8.x;
    u_xlat1.x = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_MainColorToggle==1.0);
#else
    u_xlatb2.x = _MainColorToggle==1.0;
#endif
    u_xlat2 = (u_xlatb2.x) ? _MainColor : vs_COLOR0;
    u_xlat3.x = (-u_xlat2.w) + 1.0;
    u_xlat1.x = u_xlat3.x * u_xlat1.x + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat1.x>=u_xlat12);
#else
    u_xlatb12 = u_xlat1.x>=u_xlat12;
#endif
    u_xlat4.x = u_xlat8.x * u_xlat4.x + (-u_xlat1.x);
    u_xlat8.x = u_xlat8.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat5.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat4.x = u_xlat4.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (u_xlatb12) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat4.x = u_xlatb2.y ? u_xlat4.x : float(0.0);
    u_xlat4.x = (u_xlatb2.x) ? u_xlat12 : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat4.x : u_xlat8.x;
    u_xlat0 = u_xlat0 * u_xlat4.x;
    u_xlat1.w = u_xlat0 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _texcoord_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat6.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat0.x * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_4.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_4.x);
    u_xlat16_1 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_5.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    u_xlat1 = (-u_xlat6.yyyy) + unity_4LightPosY0;
    u_xlat3 = u_xlat2.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat5 = (-u_xlat6.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat6.zzzz) + unity_4LightPosZ0;
    u_xlat3 = u_xlat5 * u_xlat2.xxxx + u_xlat3;
    u_xlat2 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
    u_xlat1 = u_xlat5 * u_xlat5 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec2 u_xlat3;
vec2 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec2 u_xlat6;
vec2 u_xlat8;
lowp float u_xlat10_8;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
bool u_xlatb12;
lowp float u_xlat10_13;
void main()
{
    u_xlat0 = vs_TEXCOORD3.w + 9.99999996e-12;
    u_xlat4.xy = vs_TEXCOORD3.xy / vec2(u_xlat0);
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat0 = (-u_xlat0) + u_xlat4.x;
    u_xlat4.x = u_xlat0 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0) + 1.0;
    u_xlat0 = u_xlat4.x * u_xlat8.x + u_xlat0;
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat4.y;
    u_xlat1 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat8.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat8.y;
    u_xlat1 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xw;
    u_xlat10_12 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zy;
    u_xlat10_13 = texture(_MovingLightTex, u_xlat2.xy).x;
    u_xlat16_2 = u_xlat10_12 + u_xlat10_13;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat1.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat8.xx + u_xlat2.zw;
    u_xlat10_8 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat10_1 = texture(_MovingLightTex, u_xlat1.xz).x;
    u_xlat16_5 = u_xlat10_1 + u_xlat16_2;
    u_xlat16_12 = u_xlat10_12 + u_xlat10_1;
    u_xlat16_12 = u_xlat10_13 + u_xlat16_12;
    u_xlat16_1 = u_xlat10_8 + u_xlat16_5;
    u_xlat5.xyz = vec3(u_xlat10_8) * _MovingLightColor01.xyz;
    u_xlat5.xyz = _MovingLightColor02.xxx * vec3(u_xlat16_12) + u_xlat5.xyz;
    u_xlat8.x = u_xlat16_1 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat4.x * u_xlat8.x;
    u_xlat1.x = (-_RemapMin) + _RemapMax;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_MainColorToggle==1.0);
#else
    u_xlatb2.x = _MainColorToggle==1.0;
#endif
    u_xlat2 = (u_xlatb2.x) ? _MainColor : vs_COLOR0;
    u_xlat3.x = (-u_xlat2.w) + 1.0;
    u_xlat1.x = u_xlat3.x * u_xlat1.x + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat1.x>=u_xlat12);
#else
    u_xlatb12 = u_xlat1.x>=u_xlat12;
#endif
    u_xlat4.x = u_xlat8.x * u_xlat4.x + (-u_xlat1.x);
    u_xlat8.x = u_xlat8.x * u_xlat2.w;
    u_xlat1.xyz = u_xlat5.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat4.x = u_xlat4.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (u_xlatb12) ? 0.0 : 1.0;
    u_xlatb2.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat4.x = u_xlatb2.y ? u_xlat4.x : float(0.0);
    u_xlat4.x = (u_xlatb2.x) ? u_xlat12 : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat4.x : u_xlat8.x;
    u_xlat0 = u_xlat0 * u_xlat4.x;
    u_xlat1.w = u_xlat0 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDADD" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 92772
Program "vp" {
SubProgram "gles3 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
float u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
bool u_xlatb6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xw;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zy;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat16_3 = u_xlat10_3 + u_xlat10_6;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zw;
    u_xlat10_0 = texture(_MovingLightTex, u_xlat1.xy).x;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat16_3 = u_xlat10_6 + u_xlat16_3;
    u_xlat16_0 = u_xlat10_0 + u_xlat16_3;
    u_xlat0.x = u_xlat16_0 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat3.y;
    u_xlat1 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_MainColorToggle==1.0);
#else
    u_xlatb9 = _MainColorToggle==1.0;
#endif
    u_xlat3.z = (u_xlatb9) ? _MainColor.w : vs_COLOR0.w;
    u_xlat1.x = (-u_xlat3.z) + 1.0;
    u_xlat6.xy = u_xlat3.xz * u_xlat0.xx;
    u_xlat4 = (-_RemapMin) + _RemapMax;
    u_xlat1.x = u_xlat1.x * u_xlat4 + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat1.x>=u_xlat6.x);
#else
    u_xlatb6 = u_xlat1.x>=u_xlat6.x;
#endif
    u_xlat0.x = u_xlat0.x * u_xlat3.x + (-u_xlat1.x);
    u_xlat0.x = u_xlat0.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.x = (u_xlatb6) ? 0.0 : 1.0;
    u_xlatb1.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat0.x = u_xlatb1.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb1.x) ? u_xlat3.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat6.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
float u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
bool u_xlatb6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xw;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zy;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat16_3 = u_xlat10_3 + u_xlat10_6;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zw;
    u_xlat10_0 = texture(_MovingLightTex, u_xlat1.xy).x;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat16_3 = u_xlat10_6 + u_xlat16_3;
    u_xlat16_0 = u_xlat10_0 + u_xlat16_3;
    u_xlat0.x = u_xlat16_0 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat3.y;
    u_xlat1 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_MainColorToggle==1.0);
#else
    u_xlatb9 = _MainColorToggle==1.0;
#endif
    u_xlat3.z = (u_xlatb9) ? _MainColor.w : vs_COLOR0.w;
    u_xlat1.x = (-u_xlat3.z) + 1.0;
    u_xlat6.xy = u_xlat3.xz * u_xlat0.xx;
    u_xlat4 = (-_RemapMin) + _RemapMax;
    u_xlat1.x = u_xlat1.x * u_xlat4 + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat1.x>=u_xlat6.x);
#else
    u_xlatb6 = u_xlat1.x>=u_xlat6.x;
#endif
    u_xlat0.x = u_xlat0.x * u_xlat3.x + (-u_xlat1.x);
    u_xlat0.x = u_xlat0.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.x = (u_xlatb6) ? 0.0 : 1.0;
    u_xlatb1.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat0.x = u_xlatb1.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb1.x) ? u_xlat3.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat6.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
float u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
bool u_xlatb6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xw;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zy;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat16_3 = u_xlat10_3 + u_xlat10_6;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zw;
    u_xlat10_0 = texture(_MovingLightTex, u_xlat1.xy).x;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat16_3 = u_xlat10_6 + u_xlat16_3;
    u_xlat16_0 = u_xlat10_0 + u_xlat16_3;
    u_xlat0.x = u_xlat16_0 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat3.y;
    u_xlat1 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_MainColorToggle==1.0);
#else
    u_xlatb9 = _MainColorToggle==1.0;
#endif
    u_xlat3.z = (u_xlatb9) ? _MainColor.w : vs_COLOR0.w;
    u_xlat1.x = (-u_xlat3.z) + 1.0;
    u_xlat6.xy = u_xlat3.xz * u_xlat0.xx;
    u_xlat4 = (-_RemapMin) + _RemapMax;
    u_xlat1.x = u_xlat1.x * u_xlat4 + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat1.x>=u_xlat6.x);
#else
    u_xlatb6 = u_xlat1.x>=u_xlat6.x;
#endif
    u_xlat0.x = u_xlat0.x * u_xlat3.x + (-u_xlat1.x);
    u_xlat0.x = u_xlat0.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.x = (u_xlatb6) ? 0.0 : 1.0;
    u_xlatb1.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat0.x = u_xlatb1.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb1.x) ? u_xlat3.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat6.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
float u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
bool u_xlatb6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xw;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zy;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat16_3 = u_xlat10_3 + u_xlat10_6;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zw;
    u_xlat10_0 = texture(_MovingLightTex, u_xlat1.xy).x;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat16_3 = u_xlat10_6 + u_xlat16_3;
    u_xlat16_0 = u_xlat10_0 + u_xlat16_3;
    u_xlat0.x = u_xlat16_0 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat3.y;
    u_xlat1 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_MainColorToggle==1.0);
#else
    u_xlatb9 = _MainColorToggle==1.0;
#endif
    u_xlat3.z = (u_xlatb9) ? _MainColor.w : vs_COLOR0.w;
    u_xlat1.x = (-u_xlat3.z) + 1.0;
    u_xlat6.xy = u_xlat3.xz * u_xlat0.xx;
    u_xlat4 = (-_RemapMin) + _RemapMax;
    u_xlat1.x = u_xlat1.x * u_xlat4 + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat1.x>=u_xlat6.x);
#else
    u_xlatb6 = u_xlat1.x>=u_xlat6.x;
#endif
    u_xlat0.x = u_xlat0.x * u_xlat3.x + (-u_xlat1.x);
    u_xlat0.x = u_xlat0.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.x = (u_xlatb6) ? 0.0 : 1.0;
    u_xlatb1.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat0.x = u_xlatb1.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb1.x) ? u_xlat3.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat6.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
float u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
bool u_xlatb6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xw;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zy;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat16_3 = u_xlat10_3 + u_xlat10_6;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zw;
    u_xlat10_0 = texture(_MovingLightTex, u_xlat1.xy).x;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat16_3 = u_xlat10_6 + u_xlat16_3;
    u_xlat16_0 = u_xlat10_0 + u_xlat16_3;
    u_xlat0.x = u_xlat16_0 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat3.y;
    u_xlat1 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_MainColorToggle==1.0);
#else
    u_xlatb9 = _MainColorToggle==1.0;
#endif
    u_xlat3.z = (u_xlatb9) ? _MainColor.w : vs_COLOR0.w;
    u_xlat1.x = (-u_xlat3.z) + 1.0;
    u_xlat6.xy = u_xlat3.xz * u_xlat0.xx;
    u_xlat4 = (-_RemapMin) + _RemapMax;
    u_xlat1.x = u_xlat1.x * u_xlat4 + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat1.x>=u_xlat6.x);
#else
    u_xlatb6 = u_xlat1.x>=u_xlat6.x;
#endif
    u_xlat0.x = u_xlat0.x * u_xlat3.x + (-u_xlat1.x);
    u_xlat0.x = u_xlat0.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.x = (u_xlatb6) ? 0.0 : 1.0;
    u_xlatb1.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat0.x = u_xlatb1.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb1.x) ? u_xlat3.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat6.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "POINT" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
float u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
bool u_xlatb6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xw;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zy;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat16_3 = u_xlat10_3 + u_xlat10_6;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zw;
    u_xlat10_0 = texture(_MovingLightTex, u_xlat1.xy).x;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat16_3 = u_xlat10_6 + u_xlat16_3;
    u_xlat16_0 = u_xlat10_0 + u_xlat16_3;
    u_xlat0.x = u_xlat16_0 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat3.y;
    u_xlat1 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_MainColorToggle==1.0);
#else
    u_xlatb9 = _MainColorToggle==1.0;
#endif
    u_xlat3.z = (u_xlatb9) ? _MainColor.w : vs_COLOR0.w;
    u_xlat1.x = (-u_xlat3.z) + 1.0;
    u_xlat6.xy = u_xlat3.xz * u_xlat0.xx;
    u_xlat4 = (-_RemapMin) + _RemapMax;
    u_xlat1.x = u_xlat1.x * u_xlat4 + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat1.x>=u_xlat6.x);
#else
    u_xlatb6 = u_xlat1.x>=u_xlat6.x;
#endif
    u_xlat0.x = u_xlat0.x * u_xlat3.x + (-u_xlat1.x);
    u_xlat0.x = u_xlat0.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.x = (u_xlatb6) ? 0.0 : 1.0;
    u_xlatb1.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat0.x = u_xlatb1.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb1.x) ? u_xlat3.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat6.y;
    u_xlat3.x = texture(_CameraDepthTexture, vec2(9.9999998e+10, 0.0)).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + -9.99999996e-12;
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
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
float u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
bool u_xlatb6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xw;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zy;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat16_3 = u_xlat10_3 + u_xlat10_6;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zw;
    u_xlat10_0 = texture(_MovingLightTex, u_xlat1.xy).x;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat16_3 = u_xlat10_6 + u_xlat16_3;
    u_xlat16_0 = u_xlat10_0 + u_xlat16_3;
    u_xlat0.x = u_xlat16_0 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat3.y;
    u_xlat1 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_MainColorToggle==1.0);
#else
    u_xlatb9 = _MainColorToggle==1.0;
#endif
    u_xlat3.z = (u_xlatb9) ? _MainColor.w : vs_COLOR0.w;
    u_xlat1.x = (-u_xlat3.z) + 1.0;
    u_xlat6.xy = u_xlat3.xz * u_xlat0.xx;
    u_xlat4 = (-_RemapMin) + _RemapMax;
    u_xlat1.x = u_xlat1.x * u_xlat4 + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat1.x>=u_xlat6.x);
#else
    u_xlatb6 = u_xlat1.x>=u_xlat6.x;
#endif
    u_xlat0.x = u_xlat0.x * u_xlat3.x + (-u_xlat1.x);
    u_xlat0.x = u_xlat0.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.x = (u_xlatb6) ? 0.0 : 1.0;
    u_xlatb1.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat0.x = u_xlatb1.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb1.x) ? u_xlat3.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat6.y;
    u_xlat3.x = texture(_CameraDepthTexture, vec2(9.9999998e+10, 0.0)).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + -9.99999996e-12;
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
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SPOT" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
float u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
bool u_xlatb6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xw;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zy;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat16_3 = u_xlat10_3 + u_xlat10_6;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zw;
    u_xlat10_0 = texture(_MovingLightTex, u_xlat1.xy).x;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat16_3 = u_xlat10_6 + u_xlat16_3;
    u_xlat16_0 = u_xlat10_0 + u_xlat16_3;
    u_xlat0.x = u_xlat16_0 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat3.y;
    u_xlat1 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_MainColorToggle==1.0);
#else
    u_xlatb9 = _MainColorToggle==1.0;
#endif
    u_xlat3.z = (u_xlatb9) ? _MainColor.w : vs_COLOR0.w;
    u_xlat1.x = (-u_xlat3.z) + 1.0;
    u_xlat6.xy = u_xlat3.xz * u_xlat0.xx;
    u_xlat4 = (-_RemapMin) + _RemapMax;
    u_xlat1.x = u_xlat1.x * u_xlat4 + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat1.x>=u_xlat6.x);
#else
    u_xlatb6 = u_xlat1.x>=u_xlat6.x;
#endif
    u_xlat0.x = u_xlat0.x * u_xlat3.x + (-u_xlat1.x);
    u_xlat0.x = u_xlat0.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.x = (u_xlatb6) ? 0.0 : 1.0;
    u_xlatb1.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat0.x = u_xlatb1.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb1.x) ? u_xlat3.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat6.y;
    u_xlat3.x = texture(_CameraDepthTexture, vec2(9.9999998e+10, 0.0)).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + -9.99999996e-12;
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
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
float u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
bool u_xlatb6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xw;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zy;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat16_3 = u_xlat10_3 + u_xlat10_6;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zw;
    u_xlat10_0 = texture(_MovingLightTex, u_xlat1.xy).x;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat16_3 = u_xlat10_6 + u_xlat16_3;
    u_xlat16_0 = u_xlat10_0 + u_xlat16_3;
    u_xlat0.x = u_xlat16_0 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat3.y;
    u_xlat1 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_MainColorToggle==1.0);
#else
    u_xlatb9 = _MainColorToggle==1.0;
#endif
    u_xlat3.z = (u_xlatb9) ? _MainColor.w : vs_COLOR0.w;
    u_xlat1.x = (-u_xlat3.z) + 1.0;
    u_xlat6.xy = u_xlat3.xz * u_xlat0.xx;
    u_xlat4 = (-_RemapMin) + _RemapMax;
    u_xlat1.x = u_xlat1.x * u_xlat4 + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat1.x>=u_xlat6.x);
#else
    u_xlatb6 = u_xlat1.x>=u_xlat6.x;
#endif
    u_xlat0.x = u_xlat0.x * u_xlat3.x + (-u_xlat1.x);
    u_xlat0.x = u_xlat0.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.x = (u_xlatb6) ? 0.0 : 1.0;
    u_xlatb1.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat0.x = u_xlatb1.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb1.x) ? u_xlat3.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat6.y;
    u_xlat3.x = texture(_CameraDepthTexture, vec2(9.9999998e+10, 0.0)).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + -9.99999996e-12;
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
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _DissolveTexToggle;
uniform 	float _AlphaOffset;
uniform 	float _SoftHardEdgeToggle;
uniform 	float _DissolveTexColorChannelToggle;
uniform 	float _DissolveTex_Uspeed;
uniform 	vec4 _DissolveTex_ST;
uniform 	float _DissolveTex_Vspeed;
uniform 	float _RemapMin;
uniform 	float _RemapMax;
uniform 	float _OpacityIntensity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
uniform lowp sampler2D _DissolveTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
float u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
bool u_xlatb6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xw;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.z = u_xlat1.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zy;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat16_3 = u_xlat10_3 + u_xlat10_6;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xz;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zw;
    u_xlat10_0 = texture(_MovingLightTex, u_xlat1.xy).x;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat16_3 = u_xlat10_6 + u_xlat16_3;
    u_xlat16_0 = u_xlat10_0 + u_xlat16_3;
    u_xlat0.x = u_xlat16_0 + _AlphaOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveTex_Uspeed + u_xlat3.x;
    u_xlat1.y = _Time.y * _DissolveTex_Vspeed + u_xlat3.y;
    u_xlat1 = texture(_DissolveTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle, _DissolveTexColorChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_MainColorToggle==1.0);
#else
    u_xlatb9 = _MainColorToggle==1.0;
#endif
    u_xlat3.z = (u_xlatb9) ? _MainColor.w : vs_COLOR0.w;
    u_xlat1.x = (-u_xlat3.z) + 1.0;
    u_xlat6.xy = u_xlat3.xz * u_xlat0.xx;
    u_xlat4 = (-_RemapMin) + _RemapMax;
    u_xlat1.x = u_xlat1.x * u_xlat4 + _RemapMin;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat1.x>=u_xlat6.x);
#else
    u_xlatb6 = u_xlat1.x>=u_xlat6.x;
#endif
    u_xlat0.x = u_xlat0.x * u_xlat3.x + (-u_xlat1.x);
    u_xlat0.x = u_xlat0.x * _OpacityIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.x = (u_xlatb6) ? 0.0 : 1.0;
    u_xlatb1.xyz = equal(vec4(_SoftHardEdgeToggle, _SoftHardEdgeToggle, _DissolveTexToggle, _SoftHardEdgeToggle), vec4(0.0, 1.0, 1.0, 0.0)).xyz;
    u_xlat0.x = u_xlatb1.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb1.x) ? u_xlat3.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat6.y;
    u_xlat3.x = texture(_CameraDepthTexture, vec2(9.9999998e+10, 0.0)).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + -9.99999996e-12;
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
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
Keywords { "POINT" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 " {
Keywords { "SPOT" }
""
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles3 " {
Keywords { "POINT" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "SPOT" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "_SOFTPARTICLES_ON" }
""
}
}
}
 Pass {
  Name "META"
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "META" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 147517
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	bvec4 unity_MetaVertexControl;
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb6;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<in_POSITION0.z);
#else
    u_xlatb0 = 0.0<in_POSITION0.z;
#endif
    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.0<u_xlat0.z);
#else
    u_xlatb6 = 0.0<u_xlat0.z;
#endif
    u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
    u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	bvec4 unity_MetaFragmentControl;
uniform 	float unity_MaxOutputValue;
uniform 	float unity_UseLinearSpace;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat6;
lowp float u_xlat10_6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xz;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xw;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat16_3 = u_xlat10_6 + u_xlat10_3;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zw;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zy;
    u_xlat10_0 = texture(_MovingLightTex, u_xlat1.xy).x;
    u_xlat16_0.x = u_xlat10_0 + u_xlat16_3;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat3.xyz = vec3(u_xlat10_3) * _MovingLightColor01.xyz;
    u_xlat0.xyz = _MovingLightColor02.xxx * u_xlat16_0.xxx + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_MainColorToggle==1.0);
#else
    u_xlatb9 = _MainColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb9)) ? _MainColor.xyz : vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace));
#else
    u_xlatb9 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace);
#endif
    u_xlat16_0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1.x = min(unity_MaxOutputValue, 0.0);
    u_xlat16_1.xyz = (unity_MetaFragmentControl.x) ? u_xlat1.xxx : vec3(0.0, 0.0, 0.0);
    u_xlat16_1.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
    u_xlat16_0.w = 1.0;
    SV_Target0 = (unity_MetaFragmentControl.y) ? u_xlat16_0 : u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	bvec4 unity_MetaVertexControl;
uniform 	vec4 _texcoord_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb6;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<in_POSITION0.z);
#else
    u_xlatb0 = 0.0<in_POSITION0.z;
#endif
    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.0<u_xlat0.z);
#else
    u_xlatb6 = 0.0<u_xlat0.z;
#endif
    u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
    u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _MovingLightColor02;
uniform 	vec4 _MovingLightTex_ST;
uniform 	float _MovingLight_V_Speed04;
uniform 	float _Noise_Brightness;
uniform 	float _NoiseTexChannelToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _MovingLight_V_Speed03;
uniform 	float _MovingLight_V_Speed02;
uniform 	vec4 _MovingLightColor01;
uniform 	float _MovingLight_V_Speed01;
uniform 	float _MainColorToggle;
uniform 	vec4 _MainColor;
uniform 	float _ColorBrightness;
uniform 	vec4 _DayColor;
uniform 	bvec4 unity_MetaFragmentControl;
uniform 	float unity_MaxOutputValue;
uniform 	float unity_UseLinearSpace;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MovingLightTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
vec2 u_xlat6;
lowp float u_xlat10_6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlat0 = texture(_NoiseTex, u_xlat1.xy);
    u_xlatb1 = equal(vec4(vec4(_NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle, _NoiseTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat9 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat6.x = (u_xlatb1.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = u_xlat0.x + (-_Noise_Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MovingLightTex_ST.xy + _MovingLightTex_ST.zw;
    u_xlat1.z = _Time.y * _MovingLight_V_Speed04 + u_xlat1.y;
    u_xlat3.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xz;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat3.xy).x;
    u_xlat2.xy = _Time.yy * vec2(_MovingLight_V_Speed03, _MovingLight_V_Speed02) + u_xlat1.yy;
    u_xlat1.w = u_xlat2.x;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat1.xw;
    u_xlat10_6 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat16_3 = u_xlat10_6 + u_xlat10_3;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.w = _Time.y * _MovingLight_V_Speed01 + u_xlat1.y;
    u_xlat6.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zw;
    u_xlat1.xy = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.zy;
    u_xlat10_0 = texture(_MovingLightTex, u_xlat1.xy).x;
    u_xlat16_0.x = u_xlat10_0 + u_xlat16_3;
    u_xlat10_3 = texture(_MovingLightTex, u_xlat6.xy).x;
    u_xlat3.xyz = vec3(u_xlat10_3) * _MovingLightColor01.xyz;
    u_xlat0.xyz = _MovingLightColor02.xxx * u_xlat16_0.xxx + u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_MainColorToggle==1.0);
#else
    u_xlatb9 = _MainColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb9)) ? _MainColor.xyz : vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace));
#else
    u_xlatb9 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(unity_UseLinearSpace);
#endif
    u_xlat16_0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1.x = min(unity_MaxOutputValue, 0.0);
    u_xlat16_1.xyz = (unity_MetaFragmentControl.x) ? u_xlat1.xxx : vec3(0.0, 0.0, 0.0);
    u_xlat16_1.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
    u_xlat16_0.w = 1.0;
    SV_Target0 = (unity_MetaFragmentControl.y) ? u_xlat16_0 : u_xlat16_1;
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
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}