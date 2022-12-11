//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/Props_Dissolve_UV2" {
Properties {
_Scale ("Scale Compared to Maya", Float) = 0.01
[Header(Element View)] _ElementViewEleID ("Element ID", Float) = 0
[MHYToggle] _ReceiveShadow ("Receive Shadow", Float) = 0
_MaterialShadowBias ("Shadow Bias", Range(0, 0.1)) = 0
[MHYToggle] _EnableEmission ("Enable Emission", Float) = 0
[Toggle] _EnableAlphaTest ("Enable Alpha Test", Float) = 0
_CutOff ("Mask Clip Value", Range(0, 1)) = 0
[Header(Dithering)] [Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
_Color ("MainColor", Color) = (1,1,1,1)
_MainTex ("MainTex", 2D) = "white" { }
_MainNormalmap ("MainNormalmap", 2D) = "white" { }
_DissolveNoiseTex ("DissolveNoiseTex", 2D) = "white" { }
_DissolveNoise_Uspeed ("DissolveNoise_Uspeed", Float) = 0
_DissolveNoise_Vspeed ("DissolveNoise_Vspeed", Float) = 0
_DissolveNoiseScaler ("DissolveNoiseScaler", Float) = 0.2
_DissolveTex ("DissolveTex", 2D) = "white" { }
[Enum(R,0,G,1,B,2)] _DissolveTexChannelToggle ("DissolveTexChannelToggle", Float) = 0
_DissolveRemapMin ("DissolveRemapMin", Float) = -1.1
_DissolveRemapMax ("DissolveRemapMax", Float) = 0.1
_DissolveColor ("DissolveColor", Color) = (0.9561866,1,0.2058824,1)
[MHYToggle] _DissolveDirection_Toggle ("DissolveDirection_Toggle", Float) = 0
_DissolveValue ("DissolveValue", Range(0, 1)) = 0.548837
_SpecularColor ("SpecularColor", Color) = (1,1,1,1)
_Shiness ("Shiness", Range(0.03, 1)) = 0.03
_texcoord ("", 2D) = "white" { }
}
SubShader {
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "HYBRIDDEFERRED"
  Tags { "LIGHTMODE" = "HYBRIDDEFERRED" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 34961
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD0.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _EnableEmission;
uniform 	mediump float _DissolveTexChannelToggle;
uniform 	mediump float _DissolveNoiseScaler;
uniform 	mediump float _DissolveNoise_Uspeed;
uniform 	vec4 _DissolveNoiseTex_ST;
uniform 	mediump float _DissolveNoise_Vspeed;
uniform 	mediump float _DissolveDirection_Toggle;
uniform 	float _DissolveValue;
uniform 	mediump float _DissolveRemapMin;
uniform 	mediump float _DissolveRemapMax;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Color;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _MainNormalmap_ST;
uniform 	vec4 _DissolveColor;
uniform 	mediump float _Shiness;
uniform lowp sampler2D _DissolveNoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainNormalmap;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec3 u_xlatb1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
bool u_xlatb4;
float u_xlat5;
vec2 u_xlat10;
lowp float u_xlat10_10;
float u_xlat15;
bool u_xlatb15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = vs_TEXCOORD4.x;
    u_xlat0.y = vs_TEXCOORD6.x;
    u_xlat0.z = vs_TEXCOORD5.x;
    u_xlat1.xy = vs_TEXCOORD3.xy * _MainNormalmap_ST.xy + _MainNormalmap_ST.zw;
    u_xlat10_1 = texture(_MainNormalmap, u_xlat1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = u_xlat10_1.www * _SpecularColor.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD4.y;
    u_xlat1.y = vs_TEXCOORD6.y;
    u_xlat1.z = vs_TEXCOORD5.y;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD4.z;
    u_xlat1.y = vs_TEXCOORD6.z;
    u_xlat1.z = vs_TEXCOORD5.z;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveDirection_Toggle==1.0);
#else
    u_xlatb0 = _DissolveDirection_Toggle==1.0;
#endif
    u_xlat5 = (-vs_TEXCOORD3.w) + 1.0;
    u_xlat0.x = (u_xlatb0) ? u_xlat5 : vs_TEXCOORD3.w;
    u_xlat16_2.x = (-_DissolveRemapMin) + _DissolveRemapMax;
    u_xlat5 = _DissolveValue * u_xlat16_2.x + _DissolveRemapMin;
    u_xlat0.y = u_xlat5 + u_xlat0.x;
    u_xlat10.xy = vs_TEXCOORD3.xy * _DissolveNoiseTex_ST.xy + _DissolveNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveNoise_Uspeed + u_xlat10.x;
    u_xlat1.y = _Time.y * _DissolveNoise_Vspeed + u_xlat10.y;
    u_xlat10_10 = texture(_DissolveNoiseTex, u_xlat1.xy).x;
    u_xlat0.x = vs_TEXCOORD3.z;
    u_xlat0.xy = vec2(_DissolveNoiseScaler) * vec2(u_xlat10_10) + u_xlat0.xy;
    u_xlat0.xyz = texture(_DissolveTex, u_xlat0.xy).xyz;
    u_xlatb1.xyz = equal(vec4(vec4(_DissolveTexChannelToggle, _DissolveTexChannelToggle, _DissolveTexChannelToggle, _DissolveTexChannelToggle)), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat10.x = u_xlatb1.z ? u_xlat0.z : float(0.0);
    u_xlat5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat10.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat5;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * _DissolveColor.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(9.99999975e-05<u_xlat16_2.x);
#else
    u_xlatb15 = 9.99999975e-05<u_xlat16_2.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(0.5<_EnableEmission);
#else
    u_xlatb1.x = 0.5<_EnableEmission;
#endif
    u_xlatb15 = u_xlatb15 && u_xlatb1.x;
    SV_Target0.w = (u_xlatb15) ? 0.00392156886 : 0.0;
    u_xlat1.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = _Color.xyz * u_xlat10_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_18 = max(u_xlat16_2.z, u_xlat16_2.y);
    u_xlat16_1.w = max(u_xlat16_2.x, u_xlat16_18);
    u_xlat16_1.xyz = u_xlat16_2.xyz / u_xlat16_1.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb4 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_2.w = _Shiness;
    u_xlat16_1 = (bool(u_xlatb4)) ? u_xlat16_1 : u_xlat16_2;
    SV_Target1.xyz = (bool(u_xlatb15)) ? u_xlat16_1.xyz : u_xlat0.xyz;
    u_xlat16_2.x = 0.400000006;
    SV_Target1.w = (u_xlatb15) ? u_xlat16_1.w : u_xlat16_2.x;
    u_xlat16_0 = u_xlat16_1.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat0.x = sqrt(u_xlat16_0);
    u_xlat16_2.x = _Shiness;
    SV_Target2.w = (u_xlatb15) ? u_xlat0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_2.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_2.x : u_xlat16_3.z;
    SV_Target2.xy = u_xlat16_3.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD0.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = in_TEXCOORD1.xy;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _EnableEmission;
uniform 	float _CutOff;
uniform 	mediump float _DissolveTexChannelToggle;
uniform 	mediump float _DissolveNoiseScaler;
uniform 	mediump float _DissolveNoise_Uspeed;
uniform 	vec4 _DissolveNoiseTex_ST;
uniform 	mediump float _DissolveNoise_Vspeed;
uniform 	mediump float _DissolveDirection_Toggle;
uniform 	float _DissolveValue;
uniform 	mediump float _DissolveRemapMin;
uniform 	mediump float _DissolveRemapMax;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Color;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _MainNormalmap_ST;
uniform 	vec4 _DissolveColor;
uniform 	mediump float _Shiness;
uniform lowp sampler2D _DissolveNoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainNormalmap;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
bvec3 u_xlatb2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
bool u_xlatb6;
vec2 u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb20;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveDirection_Toggle==1.0);
#else
    u_xlatb0 = _DissolveDirection_Toggle==1.0;
#endif
    u_xlat6.x = (-vs_TEXCOORD3.w) + 1.0;
    u_xlat0.x = (u_xlatb0) ? u_xlat6.x : vs_TEXCOORD3.w;
    u_xlat16_1.x = (-_DissolveRemapMin) + _DissolveRemapMax;
    u_xlat6.x = _DissolveValue * u_xlat16_1.x + _DissolveRemapMin;
    u_xlat0.y = u_xlat6.x + u_xlat0.x;
    u_xlat12.xy = vs_TEXCOORD3.xy * _DissolveNoiseTex_ST.xy + _DissolveNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _DissolveNoise_Uspeed + u_xlat12.x;
    u_xlat2.y = _Time.y * _DissolveNoise_Vspeed + u_xlat12.y;
    u_xlat10_12 = texture(_DissolveNoiseTex, u_xlat2.xy).x;
    u_xlat0.x = vs_TEXCOORD3.z;
    u_xlat0.xy = vec2(_DissolveNoiseScaler) * vec2(u_xlat10_12) + u_xlat0.xy;
    u_xlat0.xyz = texture(_DissolveTex, u_xlat0.xy).xyz;
    u_xlatb2.xyz = equal(vec4(vec4(_DissolveTexChannelToggle, _DissolveTexChannelToggle, _DissolveTexChannelToggle, _DissolveTexChannelToggle)), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat12.x = u_xlatb2.z ? u_xlat0.z : float(0.0);
    u_xlat6.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat12.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat6.x;
    u_xlat6.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture(_MainTex, u_xlat6.xy);
    u_xlat6.x = u_xlat0.x * u_xlat10_1.w + (-_CutOff);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xzw = u_xlat0.xxx * _DissolveColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6.x<0.0);
#else
    u_xlatb6 = u_xlat6.x<0.0;
#endif
    if((int(u_xlatb6) * int(0xffffffffu))!=0){discard;}
    u_xlat2.x = vs_TEXCOORD4.x;
    u_xlat2.y = vs_TEXCOORD6.x;
    u_xlat2.z = vs_TEXCOORD5.x;
    u_xlat3.xy = vs_TEXCOORD3.xy * _MainNormalmap_ST.xy + _MainNormalmap_ST.zw;
    u_xlat10_3 = texture(_MainNormalmap, u_xlat3.xy);
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = u_xlat10_3.www * _SpecularColor.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat2.z = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat2.xyz = u_xlat6.xxx * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_4.x = dot(u_xlat0.xzw, vec3(0.0396819152, 0.45802179, 0.00609653955));
    u_xlat16_0.xyz = _Color.xyz * u_xlat10_1.xyz + u_xlat0.xzw;
    u_xlat2.xyz = u_xlat10_1.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(9.99999975e-05<u_xlat16_4.x);
#else
    u_xlatb20 = 9.99999975e-05<u_xlat16_4.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.5<_EnableEmission);
#else
    u_xlatb3 = 0.5<_EnableEmission;
#endif
    u_xlatb20 = u_xlatb20 && u_xlatb3;
    SV_Target0.w = (u_xlatb20) ? 0.00392156886 : 0.0;
    u_xlat16_4.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_4.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb3 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0.w = _Shiness;
    u_xlat16_0 = (bool(u_xlatb3)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = (bool(u_xlatb20)) ? u_xlat16_0.xyz : u_xlat2.xyz;
    u_xlat16_4.x = 0.400000006;
    SV_Target1.w = (u_xlatb20) ? u_xlat16_0.w : u_xlat16_4.x;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat2.x = sqrt(u_xlat16_2);
    u_xlat16_4.x = _Shiness;
    SV_Target2.w = (u_xlatb20) ? u_xlat2.x : u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_4.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2.x) ? u_xlat16_4.x : u_xlat16_5.z;
    SV_Target2.xy = u_xlat16_5.xy;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat3.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat3.xyz;
    vs_TEXCOORD0.w = 0.0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = in_TEXCOORD1.xy;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _EnableEmission;
uniform 	mediump float _DissolveTexChannelToggle;
uniform 	mediump float _DissolveNoiseScaler;
uniform 	mediump float _DissolveNoise_Uspeed;
uniform 	vec4 _DissolveNoiseTex_ST;
uniform 	mediump float _DissolveNoise_Vspeed;
uniform 	mediump float _DissolveDirection_Toggle;
uniform 	float _DissolveValue;
uniform 	mediump float _DissolveRemapMin;
uniform 	mediump float _DissolveRemapMax;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Color;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _MainNormalmap_ST;
uniform 	vec4 _DissolveColor;
uniform 	mediump float _Shiness;
uniform lowp sampler2D _DissolveNoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainNormalmap;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
bvec3 u_xlatb1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
bool u_xlatb4;
float u_xlat5;
vec2 u_xlat10;
lowp float u_xlat10_10;
float u_xlat15;
bool u_xlatb15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = vs_TEXCOORD4.x;
    u_xlat0.y = vs_TEXCOORD6.x;
    u_xlat0.z = vs_TEXCOORD5.x;
    u_xlat1.xy = vs_TEXCOORD3.xy * _MainNormalmap_ST.xy + _MainNormalmap_ST.zw;
    u_xlat10_1 = texture(_MainNormalmap, u_xlat1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = u_xlat10_1.www * _SpecularColor.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD4.y;
    u_xlat1.y = vs_TEXCOORD6.y;
    u_xlat1.z = vs_TEXCOORD5.y;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.x = vs_TEXCOORD4.z;
    u_xlat1.y = vs_TEXCOORD6.z;
    u_xlat1.z = vs_TEXCOORD5.z;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveDirection_Toggle==1.0);
#else
    u_xlatb0 = _DissolveDirection_Toggle==1.0;
#endif
    u_xlat5 = (-vs_TEXCOORD3.w) + 1.0;
    u_xlat0.x = (u_xlatb0) ? u_xlat5 : vs_TEXCOORD3.w;
    u_xlat16_2.x = (-_DissolveRemapMin) + _DissolveRemapMax;
    u_xlat5 = _DissolveValue * u_xlat16_2.x + _DissolveRemapMin;
    u_xlat0.y = u_xlat5 + u_xlat0.x;
    u_xlat10.xy = vs_TEXCOORD3.xy * _DissolveNoiseTex_ST.xy + _DissolveNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveNoise_Uspeed + u_xlat10.x;
    u_xlat1.y = _Time.y * _DissolveNoise_Vspeed + u_xlat10.y;
    u_xlat10_10 = texture(_DissolveNoiseTex, u_xlat1.xy).x;
    u_xlat0.x = vs_TEXCOORD3.z;
    u_xlat0.xy = vec2(_DissolveNoiseScaler) * vec2(u_xlat10_10) + u_xlat0.xy;
    u_xlat0.xyz = texture(_DissolveTex, u_xlat0.xy).xyz;
    u_xlatb1.xyz = equal(vec4(vec4(_DissolveTexChannelToggle, _DissolveTexChannelToggle, _DissolveTexChannelToggle, _DissolveTexChannelToggle)), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat10.x = u_xlatb1.z ? u_xlat0.z : float(0.0);
    u_xlat5 = (u_xlatb1.y) ? u_xlat0.y : u_xlat10.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat5;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * _DissolveColor.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(9.99999975e-05<u_xlat16_2.x);
#else
    u_xlatb15 = 9.99999975e-05<u_xlat16_2.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(0.5<_EnableEmission);
#else
    u_xlatb1.x = 0.5<_EnableEmission;
#endif
    u_xlatb15 = u_xlatb15 && u_xlatb1.x;
    SV_Target0.w = (u_xlatb15) ? 0.00392156886 : 0.0;
    u_xlat1.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = _Color.xyz * u_xlat10_1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat16_18 = max(u_xlat16_2.z, u_xlat16_2.y);
    u_xlat16_1.w = max(u_xlat16_2.x, u_xlat16_18);
    u_xlat16_1.xyz = u_xlat16_2.xyz / u_xlat16_1.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb4 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_2.w = _Shiness;
    u_xlat16_1 = (bool(u_xlatb4)) ? u_xlat16_1 : u_xlat16_2;
    SV_Target1.xyz = (bool(u_xlatb15)) ? u_xlat16_1.xyz : u_xlat0.xyz;
    u_xlat16_2.x = 0.400000006;
    SV_Target1.w = (u_xlatb15) ? u_xlat16_1.w : u_xlat16_2.x;
    u_xlat16_0 = u_xlat16_1.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat0.x = sqrt(u_xlat16_0);
    u_xlat16_2.x = _Shiness;
    SV_Target2.w = (u_xlatb15) ? u_xlat0.x : u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_2.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_2.x : u_xlat16_3.z;
    SV_Target2.xy = u_xlat16_3.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat3.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat3.xyz;
    vs_TEXCOORD0.w = 0.0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = in_TEXCOORD1.xy;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.xyz = u_xlat3.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _EnableEmission;
uniform 	float _CutOff;
uniform 	mediump float _DissolveTexChannelToggle;
uniform 	mediump float _DissolveNoiseScaler;
uniform 	mediump float _DissolveNoise_Uspeed;
uniform 	vec4 _DissolveNoiseTex_ST;
uniform 	mediump float _DissolveNoise_Vspeed;
uniform 	mediump float _DissolveDirection_Toggle;
uniform 	float _DissolveValue;
uniform 	mediump float _DissolveRemapMin;
uniform 	mediump float _DissolveRemapMax;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Color;
uniform 	mediump vec4 _SpecularColor;
uniform 	vec4 _MainNormalmap_ST;
uniform 	vec4 _DissolveColor;
uniform 	mediump float _Shiness;
uniform lowp sampler2D _DissolveNoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainNormalmap;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
bvec3 u_xlatb2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
bool u_xlatb6;
vec2 u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb20;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveDirection_Toggle==1.0);
#else
    u_xlatb0 = _DissolveDirection_Toggle==1.0;
#endif
    u_xlat6.x = (-vs_TEXCOORD3.w) + 1.0;
    u_xlat0.x = (u_xlatb0) ? u_xlat6.x : vs_TEXCOORD3.w;
    u_xlat16_1.x = (-_DissolveRemapMin) + _DissolveRemapMax;
    u_xlat6.x = _DissolveValue * u_xlat16_1.x + _DissolveRemapMin;
    u_xlat0.y = u_xlat6.x + u_xlat0.x;
    u_xlat12.xy = vs_TEXCOORD3.xy * _DissolveNoiseTex_ST.xy + _DissolveNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _DissolveNoise_Uspeed + u_xlat12.x;
    u_xlat2.y = _Time.y * _DissolveNoise_Vspeed + u_xlat12.y;
    u_xlat10_12 = texture(_DissolveNoiseTex, u_xlat2.xy).x;
    u_xlat0.x = vs_TEXCOORD3.z;
    u_xlat0.xy = vec2(_DissolveNoiseScaler) * vec2(u_xlat10_12) + u_xlat0.xy;
    u_xlat0.xyz = texture(_DissolveTex, u_xlat0.xy).xyz;
    u_xlatb2.xyz = equal(vec4(vec4(_DissolveTexChannelToggle, _DissolveTexChannelToggle, _DissolveTexChannelToggle, _DissolveTexChannelToggle)), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat12.x = u_xlatb2.z ? u_xlat0.z : float(0.0);
    u_xlat6.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat12.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat6.x;
    u_xlat6.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture(_MainTex, u_xlat6.xy);
    u_xlat6.x = u_xlat0.x * u_xlat10_1.w + (-_CutOff);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.xzw = u_xlat0.xxx * _DissolveColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6.x<0.0);
#else
    u_xlatb6 = u_xlat6.x<0.0;
#endif
    if((int(u_xlatb6) * int(0xffffffffu))!=0){discard;}
    u_xlat2.x = vs_TEXCOORD4.x;
    u_xlat2.y = vs_TEXCOORD6.x;
    u_xlat2.z = vs_TEXCOORD5.x;
    u_xlat3.xy = vs_TEXCOORD3.xy * _MainNormalmap_ST.xy + _MainNormalmap_ST.zw;
    u_xlat10_3 = texture(_MainNormalmap, u_xlat3.xy);
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_5.xyz = u_xlat10_3.www * _SpecularColor.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat2.z = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat2.xyz = u_xlat6.xxx * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_4.x = dot(u_xlat0.xzw, vec3(0.0396819152, 0.45802179, 0.00609653955));
    u_xlat16_0.xyz = _Color.xyz * u_xlat10_1.xyz + u_xlat0.xzw;
    u_xlat2.xyz = u_xlat10_1.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(9.99999975e-05<u_xlat16_4.x);
#else
    u_xlatb20 = 9.99999975e-05<u_xlat16_4.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.5<_EnableEmission);
#else
    u_xlatb3 = 0.5<_EnableEmission;
#endif
    u_xlatb20 = u_xlatb20 && u_xlatb3;
    SV_Target0.w = (u_xlatb20) ? 0.00392156886 : 0.0;
    u_xlat16_4.x = max(u_xlat16_0.z, u_xlat16_0.y);
    u_xlat16_1.w = max(u_xlat16_0.x, u_xlat16_4.x);
    u_xlat16_1.xyz = u_xlat16_0.xyz / u_xlat16_1.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb3 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_0.w = _Shiness;
    u_xlat16_0 = (bool(u_xlatb3)) ? u_xlat16_1 : u_xlat16_0;
    SV_Target1.xyz = (bool(u_xlatb20)) ? u_xlat16_0.xyz : u_xlat2.xyz;
    u_xlat16_4.x = 0.400000006;
    SV_Target1.w = (u_xlatb20) ? u_xlat16_0.w : u_xlat16_4.x;
    u_xlat16_2 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat2.x = sqrt(u_xlat16_2);
    u_xlat16_4.x = _Shiness;
    SV_Target2.w = (u_xlatb20) ? u_xlat2.x : u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_4.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2.x) ? u_xlat16_4.x : u_xlat16_5.z;
    SV_Target2.xy = u_xlat16_5.xy;
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
Keywords { "_ENABLEALPHATEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
""
}
}
}
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 116138
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _MaterialShadowBias;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD1;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = min(_MaterialShadowBias, 0.100000001);
    u_xlat0 = (-u_xlat0) * 2.0 + unity_LightShadowBias.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0 = u_xlat0 / u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 + u_xlat1.z;
    u_xlat3 = max((-u_xlat1.w), u_xlat0);
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat3 = (-u_xlat0) + u_xlat3;
    gl_Position.z = unity_LightShadowBias.y * u_xlat3 + u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _MaterialShadowBias;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD1;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = min(_MaterialShadowBias, 0.100000001);
    u_xlat0 = (-u_xlat0) * 2.0 + unity_LightShadowBias.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0 = u_xlat0 / u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 + u_xlat1.z;
    u_xlat3 = max((-u_xlat1.w), u_xlat0);
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat3 = (-u_xlat0) + u_xlat3;
    gl_Position.z = unity_LightShadowBias.y * u_xlat3 + u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy;
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
uniform 	float _CutOff;
uniform 	mediump float _DissolveTexChannelToggle;
uniform 	mediump float _DissolveNoiseScaler;
uniform 	mediump float _DissolveNoise_Uspeed;
uniform 	vec4 _DissolveNoiseTex_ST;
uniform 	mediump float _DissolveNoise_Vspeed;
uniform 	mediump float _DissolveDirection_Toggle;
uniform 	float _DissolveValue;
uniform 	mediump float _DissolveRemapMin;
uniform 	mediump float _DissolveRemapMax;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _DissolveNoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec2 u_xlat2;
bvec3 u_xlatb2;
vec2 u_xlat3;
lowp float u_xlat10_3;
vec2 u_xlat6;
lowp float u_xlat10_6;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveDirection_Toggle==1.0);
#else
    u_xlatb0 = _DissolveDirection_Toggle==1.0;
#endif
    u_xlat3.x = (-vs_TEXCOORD1.w) + 1.0;
    u_xlat0.x = (u_xlatb0) ? u_xlat3.x : vs_TEXCOORD1.w;
    u_xlat16_1 = (-_DissolveRemapMin) + _DissolveRemapMax;
    u_xlat3.x = _DissolveValue * u_xlat16_1 + _DissolveRemapMin;
    u_xlat0.y = u_xlat3.x + u_xlat0.x;
    u_xlat6.xy = vs_TEXCOORD1.xy * _DissolveNoiseTex_ST.xy + _DissolveNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _DissolveNoise_Uspeed + u_xlat6.x;
    u_xlat2.y = _Time.y * _DissolveNoise_Vspeed + u_xlat6.y;
    u_xlat10_6 = texture(_DissolveNoiseTex, u_xlat2.xy).x;
    u_xlat0.x = vs_TEXCOORD1.z;
    u_xlat0.xy = vec2(vec2(_DissolveNoiseScaler, _DissolveNoiseScaler)) * vec2(u_xlat10_6) + u_xlat0.xy;
    u_xlat0.xyz = texture(_DissolveTex, u_xlat0.xy).xyz;
    u_xlatb2.xyz = equal(vec4(_DissolveTexChannelToggle), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat6.x = u_xlatb2.z ? u_xlat0.z : float(0.0);
    u_xlat3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_3 = texture(_MainTex, u_xlat3.xy).w;
    u_xlat0.x = u_xlat0.x * u_xlat10_3 + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
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

uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _MaterialShadowBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD1;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
void main()
{
    u_xlat0 = min(_MaterialShadowBias, 0.100000001);
    u_xlat0 = (-u_xlat0) * 2.0 + unity_LightShadowBias.x;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0 = u_xlat0 / u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 + u_xlat1.z;
    u_xlat3 = max((-u_xlat1.w), u_xlat0);
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat3 = (-u_xlat0) + u_xlat3;
    gl_Position.z = unity_LightShadowBias.y * u_xlat3 + u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _MaterialShadowBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD1;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
void main()
{
    u_xlat0 = min(_MaterialShadowBias, 0.100000001);
    u_xlat0 = (-u_xlat0) * 2.0 + unity_LightShadowBias.x;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0 = u_xlat0 / u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 + u_xlat1.z;
    u_xlat3 = max((-u_xlat1.w), u_xlat0);
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat3 = (-u_xlat0) + u_xlat3;
    gl_Position.z = unity_LightShadowBias.y * u_xlat3 + u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy;
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
uniform 	float _CutOff;
uniform 	mediump float _DissolveTexChannelToggle;
uniform 	mediump float _DissolveNoiseScaler;
uniform 	mediump float _DissolveNoise_Uspeed;
uniform 	vec4 _DissolveNoiseTex_ST;
uniform 	mediump float _DissolveNoise_Vspeed;
uniform 	mediump float _DissolveDirection_Toggle;
uniform 	float _DissolveValue;
uniform 	mediump float _DissolveRemapMin;
uniform 	mediump float _DissolveRemapMax;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _DissolveNoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec2 u_xlat2;
bvec3 u_xlatb2;
vec2 u_xlat3;
lowp float u_xlat10_3;
vec2 u_xlat6;
lowp float u_xlat10_6;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveDirection_Toggle==1.0);
#else
    u_xlatb0 = _DissolveDirection_Toggle==1.0;
#endif
    u_xlat3.x = (-vs_TEXCOORD1.w) + 1.0;
    u_xlat0.x = (u_xlatb0) ? u_xlat3.x : vs_TEXCOORD1.w;
    u_xlat16_1 = (-_DissolveRemapMin) + _DissolveRemapMax;
    u_xlat3.x = _DissolveValue * u_xlat16_1 + _DissolveRemapMin;
    u_xlat0.y = u_xlat3.x + u_xlat0.x;
    u_xlat6.xy = vs_TEXCOORD1.xy * _DissolveNoiseTex_ST.xy + _DissolveNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _DissolveNoise_Uspeed + u_xlat6.x;
    u_xlat2.y = _Time.y * _DissolveNoise_Vspeed + u_xlat6.y;
    u_xlat10_6 = texture(_DissolveNoiseTex, u_xlat2.xy).x;
    u_xlat0.x = vs_TEXCOORD1.z;
    u_xlat0.xy = vec2(vec2(_DissolveNoiseScaler, _DissolveNoiseScaler)) * vec2(u_xlat10_6) + u_xlat0.xy;
    u_xlat0.xyz = texture(_DissolveTex, u_xlat0.xy).xyz;
    u_xlatb2.xyz = equal(vec4(_DissolveTexChannelToggle), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat6.x = u_xlatb2.z ? u_xlat0.z : float(0.0);
    u_xlat3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_3 = texture(_MainTex, u_xlat3.xy).w;
    u_xlat0.x = u_xlat0.x * u_xlat10_3 + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
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
Keywords { "_ENABLEALPHATEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
""
}
}
}
 Pass {
  Name "DEPTHONLY"
  Tags { "LIGHTMODE" = "DepthOnly" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 155274
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy;
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
uniform 	float _CutOff;
uniform 	mediump float _DissolveTexChannelToggle;
uniform 	mediump float _DissolveNoiseScaler;
uniform 	mediump float _DissolveNoise_Uspeed;
uniform 	vec4 _DissolveNoiseTex_ST;
uniform 	mediump float _DissolveNoise_Vspeed;
uniform 	mediump float _DissolveDirection_Toggle;
uniform 	float _DissolveValue;
uniform 	mediump float _DissolveRemapMin;
uniform 	mediump float _DissolveRemapMax;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _DissolveNoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec2 u_xlat2;
bvec3 u_xlatb2;
vec2 u_xlat3;
lowp float u_xlat10_3;
vec2 u_xlat6;
lowp float u_xlat10_6;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveDirection_Toggle==1.0);
#else
    u_xlatb0 = _DissolveDirection_Toggle==1.0;
#endif
    u_xlat3.x = (-vs_TEXCOORD1.w) + 1.0;
    u_xlat0.x = (u_xlatb0) ? u_xlat3.x : vs_TEXCOORD1.w;
    u_xlat16_1 = (-_DissolveRemapMin) + _DissolveRemapMax;
    u_xlat3.x = _DissolveValue * u_xlat16_1 + _DissolveRemapMin;
    u_xlat0.y = u_xlat3.x + u_xlat0.x;
    u_xlat6.xy = vs_TEXCOORD1.xy * _DissolveNoiseTex_ST.xy + _DissolveNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _DissolveNoise_Uspeed + u_xlat6.x;
    u_xlat2.y = _Time.y * _DissolveNoise_Vspeed + u_xlat6.y;
    u_xlat10_6 = texture(_DissolveNoiseTex, u_xlat2.xy).x;
    u_xlat0.x = vs_TEXCOORD1.z;
    u_xlat0.xy = vec2(vec2(_DissolveNoiseScaler, _DissolveNoiseScaler)) * vec2(u_xlat10_6) + u_xlat0.xy;
    u_xlat0.xyz = texture(_DissolveTex, u_xlat0.xy).xyz;
    u_xlatb2.xyz = equal(vec4(_DissolveTexChannelToggle), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat6.x = u_xlatb2.z ? u_xlat0.z : float(0.0);
    u_xlat3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_3 = texture(_MainTex, u_xlat3.xy).w;
    u_xlat0.x = u_xlat0.x * u_xlat10_3 + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = in_TEXCOORD1.xy;
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
uniform 	float _CutOff;
uniform 	mediump float _DissolveTexChannelToggle;
uniform 	mediump float _DissolveNoiseScaler;
uniform 	mediump float _DissolveNoise_Uspeed;
uniform 	vec4 _DissolveNoiseTex_ST;
uniform 	mediump float _DissolveNoise_Vspeed;
uniform 	mediump float _DissolveDirection_Toggle;
uniform 	float _DissolveValue;
uniform 	mediump float _DissolveRemapMin;
uniform 	mediump float _DissolveRemapMax;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _DissolveNoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec2 u_xlat2;
bvec3 u_xlatb2;
vec2 u_xlat3;
lowp float u_xlat10_3;
vec2 u_xlat6;
lowp float u_xlat10_6;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveDirection_Toggle==1.0);
#else
    u_xlatb0 = _DissolveDirection_Toggle==1.0;
#endif
    u_xlat3.x = (-vs_TEXCOORD1.w) + 1.0;
    u_xlat0.x = (u_xlatb0) ? u_xlat3.x : vs_TEXCOORD1.w;
    u_xlat16_1 = (-_DissolveRemapMin) + _DissolveRemapMax;
    u_xlat3.x = _DissolveValue * u_xlat16_1 + _DissolveRemapMin;
    u_xlat0.y = u_xlat3.x + u_xlat0.x;
    u_xlat6.xy = vs_TEXCOORD1.xy * _DissolveNoiseTex_ST.xy + _DissolveNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _DissolveNoise_Uspeed + u_xlat6.x;
    u_xlat2.y = _Time.y * _DissolveNoise_Vspeed + u_xlat6.y;
    u_xlat10_6 = texture(_DissolveNoiseTex, u_xlat2.xy).x;
    u_xlat0.x = vs_TEXCOORD1.z;
    u_xlat0.xy = vec2(vec2(_DissolveNoiseScaler, _DissolveNoiseScaler)) * vec2(u_xlat10_6) + u_xlat0.xy;
    u_xlat0.xyz = texture(_DissolveTex, u_xlat0.xy).xyz;
    u_xlatb2.xyz = equal(vec4(_DissolveTexChannelToggle), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat6.x = u_xlatb2.z ? u_xlat0.z : float(0.0);
    u_xlat3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_3 = texture(_MainTex, u_xlat3.xy).w;
    u_xlat0.x = u_xlat0.x * u_xlat10_3 + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
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
Keywords { "_ENABLEALPHATEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
""
}
}
}
 Pass {
  Name "MOTIONVECTORS"
  Tags { "LIGHTMODE" = "MOTIONVECTORS" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 207253
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousM[4];
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MotionVectorDepthBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4_PreviousM[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousM[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousM[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousM[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_TARGET0;
vec2 u_xlat0;
ivec2 u_xlati1;
vec2 u_xlat4;
ivec2 u_xlati4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat4.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati4.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati1.xy;
    u_xlat4.xy = vec2(u_xlati4.xy);
    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
    SV_TARGET0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_TARGET0.zw = vec2(1.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousM[4];
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MotionVectorDepthBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4_PreviousM[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousM[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousM[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousM[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = in_TEXCOORD1.xy;
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
uniform 	float _CutOff;
uniform 	mediump float _DissolveTexChannelToggle;
uniform 	mediump float _DissolveNoiseScaler;
uniform 	mediump float _DissolveNoise_Uspeed;
uniform 	vec4 _DissolveNoiseTex_ST;
uniform 	mediump float _DissolveNoise_Vspeed;
uniform 	mediump float _DissolveDirection_Toggle;
uniform 	float _DissolveValue;
uniform 	mediump float _DissolveRemapMin;
uniform 	mediump float _DissolveRemapMax;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _DissolveNoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_TARGET0;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec2 u_xlat2;
ivec2 u_xlati2;
bvec3 u_xlatb2;
vec2 u_xlat3;
lowp float u_xlat10_3;
vec2 u_xlat6;
lowp float u_xlat10_6;
ivec2 u_xlati6;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveDirection_Toggle==1.0);
#else
    u_xlatb0 = _DissolveDirection_Toggle==1.0;
#endif
    u_xlat3.x = (-vs_TEXCOORD2.w) + 1.0;
    u_xlat0.x = (u_xlatb0) ? u_xlat3.x : vs_TEXCOORD2.w;
    u_xlat16_1 = (-_DissolveRemapMin) + _DissolveRemapMax;
    u_xlat3.x = _DissolveValue * u_xlat16_1 + _DissolveRemapMin;
    u_xlat0.y = u_xlat3.x + u_xlat0.x;
    u_xlat6.xy = vs_TEXCOORD2.xy * _DissolveNoiseTex_ST.xy + _DissolveNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _DissolveNoise_Uspeed + u_xlat6.x;
    u_xlat2.y = _Time.y * _DissolveNoise_Vspeed + u_xlat6.y;
    u_xlat10_6 = texture(_DissolveNoiseTex, u_xlat2.xy).x;
    u_xlat0.x = vs_TEXCOORD2.z;
    u_xlat0.xy = vec2(vec2(_DissolveNoiseScaler, _DissolveNoiseScaler)) * vec2(u_xlat10_6) + u_xlat0.xy;
    u_xlat0.xyz = texture(_DissolveTex, u_xlat0.xy).xyz;
    u_xlatb2.xyz = equal(vec4(_DissolveTexChannelToggle), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat6.x = u_xlatb2.z ? u_xlat0.z : float(0.0);
    u_xlat3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_3 = texture(_MainTex, u_xlat3.xy).w;
    u_xlat0.x = u_xlat0.x * u_xlat10_3 + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati2.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
    SV_TARGET0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_TARGET0.zw = vec2(1.0, 0.0);
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct MotionVectorParam0Array_Type {
	vec4 hlslcc_mtx4x4unity_MVPreviousMArray[4];
};
layout(std140) uniform UnityInstancing_MotionVectorParam0 {
	MotionVectorParam0Array_Type MotionVectorParam0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
ivec2 u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
void main()
{
    u_xlati0.x = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0.xy = u_xlati0.xx << ivec2(3, 2);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.z = _MotionVectorDepthBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD0 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = in_POSITION0.yyyy * MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[1];
    u_xlat1 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_TARGET0;
vec2 u_xlat0;
ivec2 u_xlati1;
vec2 u_xlat4;
ivec2 u_xlati4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat4.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati4.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati1.xy;
    u_xlat4.xy = vec2(u_xlati4.xy);
    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
    SV_TARGET0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_TARGET0.zw = vec2(1.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct MotionVectorParam0Array_Type {
	vec4 hlslcc_mtx4x4unity_MVPreviousMArray[4];
};
layout(std140) uniform UnityInstancing_MotionVectorParam0 {
	MotionVectorParam0Array_Type MotionVectorParam0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
ivec2 u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
void main()
{
    u_xlati0.x = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0.xy = u_xlati0.xx << ivec2(3, 2);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.z = _MotionVectorDepthBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD0 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = in_POSITION0.yyyy * MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[1];
    u_xlat1 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = in_TEXCOORD1.xy;
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
uniform 	float _CutOff;
uniform 	mediump float _DissolveTexChannelToggle;
uniform 	mediump float _DissolveNoiseScaler;
uniform 	mediump float _DissolveNoise_Uspeed;
uniform 	vec4 _DissolveNoiseTex_ST;
uniform 	mediump float _DissolveNoise_Vspeed;
uniform 	mediump float _DissolveDirection_Toggle;
uniform 	float _DissolveValue;
uniform 	mediump float _DissolveRemapMin;
uniform 	mediump float _DissolveRemapMax;
uniform 	vec4 _MainTex_ST;
uniform lowp sampler2D _DissolveNoiseTex;
uniform lowp sampler2D _DissolveTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_TARGET0;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec2 u_xlat2;
ivec2 u_xlati2;
bvec3 u_xlatb2;
vec2 u_xlat3;
lowp float u_xlat10_3;
vec2 u_xlat6;
lowp float u_xlat10_6;
ivec2 u_xlati6;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_DissolveDirection_Toggle==1.0);
#else
    u_xlatb0 = _DissolveDirection_Toggle==1.0;
#endif
    u_xlat3.x = (-vs_TEXCOORD2.w) + 1.0;
    u_xlat0.x = (u_xlatb0) ? u_xlat3.x : vs_TEXCOORD2.w;
    u_xlat16_1 = (-_DissolveRemapMin) + _DissolveRemapMax;
    u_xlat3.x = _DissolveValue * u_xlat16_1 + _DissolveRemapMin;
    u_xlat0.y = u_xlat3.x + u_xlat0.x;
    u_xlat6.xy = vs_TEXCOORD2.xy * _DissolveNoiseTex_ST.xy + _DissolveNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * _DissolveNoise_Uspeed + u_xlat6.x;
    u_xlat2.y = _Time.y * _DissolveNoise_Vspeed + u_xlat6.y;
    u_xlat10_6 = texture(_DissolveNoiseTex, u_xlat2.xy).x;
    u_xlat0.x = vs_TEXCOORD2.z;
    u_xlat0.xy = vec2(vec2(_DissolveNoiseScaler, _DissolveNoiseScaler)) * vec2(u_xlat10_6) + u_xlat0.xy;
    u_xlat0.xyz = texture(_DissolveTex, u_xlat0.xy).xyz;
    u_xlatb2.xyz = equal(vec4(_DissolveTexChannelToggle), vec4(0.0, 1.0, 2.0, 0.0)).xyz;
    u_xlat6.x = u_xlatb2.z ? u_xlat0.z : float(0.0);
    u_xlat3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat6.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_3 = texture(_MainTex, u_xlat3.xy).w;
    u_xlat0.x = u_xlat0.x * u_xlat10_3 + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati2.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
    SV_TARGET0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_TARGET0.zw = vec2(1.0, 0.0);
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
Keywords { "_ENABLEALPHATEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
""
}
}
}
}
Fallback "Legacy Shaders/VertexLit"
CustomEditor "MiHoYoASEMaterialInspector"
}