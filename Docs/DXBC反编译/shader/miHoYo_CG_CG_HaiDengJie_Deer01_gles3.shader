//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/CG/CG_HaiDengJie_Deer01" {
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
_BaseTex ("BaseTex", 2D) = "white" { }
_MainColor ("MainColor", Color) = (1,1,1,0)
_Normal ("Normal", 2D) = "bump" { }
_SMBE ("SMBE", 2D) = "white" { }
_Cubemap ("Cubemap", Cube) = "white" { }
_Dissolve ("Dissolve", Range(0, 1)) = 0
_Noise ("Noise", 2D) = "white" { }
_NoiseIntensity ("NoiseIntensity", Range(0, 1)) = 0
_Noise_Vspeed ("Noise_Vspeed", Float) = 0
_Noise_Uspeed ("Noise_Uspeed", Float) = 0
_DissolveEdge ("DissolveEdge", Range(0, 0.1)) = 0.1
_DissolveColor ("DissolveColor", Color) = (1,1,1,0)
_DissolveColorScale ("DissolveColorScale", Float) = 1
_EmissionColor ("EmissionColor", Color) = (1,1,1,0)
_EmissionStrength ("Emission Strength", Range(0, 40)) = 1
_EmissionMulAlbedo ("Emission Mul Albedo", Range(0, 1)) = 0.8
_LampColor ("Lamp Color", Color) = (1,1,1,0)
_LampRadius ("Lamp Radius", Range(0, 20)) = 1
_LampLocalPos ("LampLocalPos", Vector) = (0,0,0,1)
_texcoord ("", 2D) = "white" { }
}
SubShader {
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "HYBRIDDEFERRED"
  Tags { "LIGHTMODE" = "HYBRIDDEFERRED" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 17781
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _EnableEmission;
uniform 	mediump float _Dissolve;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _SMBE_ST;
uniform 	vec4 _Normal_ST;
uniform 	vec4 _Cubemap_HDR;
uniform 	vec4 _Cubemap_TexelSize;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump vec4 _LampColor;
uniform 	mediump vec4 _LampLocalPos;
uniform 	mediump float _LampRadius;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionMulAlbedo;
uniform 	mediump vec4 _DissolveColor;
uniform 	mediump float _DissolveColorScale;
uniform 	mediump float _DissolveEdge;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _SMBE;
uniform lowp sampler2D _Normal;
uniform lowp samplerCube _Cubemap;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
lowp vec4 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
bool u_xlatb11;
mediump vec3 u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
bool u_xlatb13;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_16;
mediump float u_xlat16_27;
float u_xlat33;
mediump float u_xlat16_34;
mediump float u_xlat16_36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
    u_xlat10_0 = texture(_Noise, u_xlat16_1.xy).x;
    u_xlat0.x = u_xlat10_0 * _NoiseIntensity + vs_TEXCOORD3.x;
    u_xlat16_1.x = _Dissolve + _DissolveEdge;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb11 = u_xlat0.x>=u_xlat16_1.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=_Dissolve);
#else
    u_xlatb0 = u_xlat0.x>=_Dissolve;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_12.x = (u_xlatb11) ? -1.0 : -0.0;
    u_xlat16_1.x = u_xlat16_12.x + u_xlat16_1.x;
    u_xlat16_12.xyz = _DissolveColor.xyz * vec3(_DissolveColorScale);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_12.xyz;
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD3.zw * _Normal_ST.xy + _Normal_ST.zw;
    u_xlat10_2.xyz = texture(_Normal, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat33 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * vs_TEXCOORD4.zxy;
    u_xlat16_34 = dot(u_xlat2.yzx, u_xlat0.xyz);
    u_xlat16_3.x = u_xlat16_34 + u_xlat16_34;
    u_xlat16_34 = max(u_xlat16_34, 0.00100000005);
    u_xlat16_3.xyz = u_xlat0.xyz * (-u_xlat16_3.xxx) + u_xlat2.yzx;
    u_xlat16_3.xyz = (-u_xlat16_3.xyz);
    u_xlat16_36 = log2(_Cubemap_TexelSize.z);
    u_xlat4.xy = vs_TEXCOORD3.zw * _SMBE_ST.xy + _SMBE_ST.zw;
    u_xlat10_4.xyz = texture(_SMBE, u_xlat4.xy).xyw;
    u_xlat16_5.x = (-u_xlat10_4.x) + 1.0;
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = min(u_xlat16_5.x, 0.999000013);
    u_xlat16_36 = u_xlat16_36 * u_xlat16_5.x;
    u_xlat10_6 = textureLod(_Cubemap, u_xlat16_3.xyz, u_xlat16_36);
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat16_3.xyz);
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_14.x = u_xlat10_6.w + -1.0;
    u_xlat16_14.x = _Cubemap_HDR.w * u_xlat16_14.x + 1.0;
    u_xlat16_14.x = log2(u_xlat16_14.x);
    u_xlat16_14.x = u_xlat16_14.x * _Cubemap_HDR.y;
    u_xlat16_14.x = exp2(u_xlat16_14.x);
    u_xlat16_14.x = u_xlat16_14.x * _Cubemap_HDR.x;
    u_xlat16_14.xyz = u_xlat10_6.xyz * u_xlat16_14.xxx;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat16_14.xyz;
    u_xlat16_0.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_14.xyz = u_xlat16_0.xxx * u_xlat16_14.xyz;
    u_xlat16_16.x = u_xlat16_34 * -5.55472994 + -6.98316002;
    u_xlat16_16.x = u_xlat16_34 * u_xlat16_16.x;
    u_xlat16_16.x = exp2(u_xlat16_16.x);
    u_xlat16_27 = u_xlat10_4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_5.w = u_xlat16_5.x * u_xlat16_27;
    u_xlat16_5.xw = u_xlat16_5.xw * u_xlat16_5.xw;
    u_xlat16_5.x = u_xlat16_5.x * 0.5;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_38 = u_xlat16_5.w * -0.5 + 1.0;
    u_xlat4.xy = vs_TEXCOORD3.zw * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_4.xyw = texture(_BaseTex, u_xlat4.xy).xyz;
    u_xlat16_7.xyz = _MainColor.xyz * u_xlat10_4.xyw + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyw = u_xlat10_4.xyw * _MainColor.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_27) * u_xlat16_7.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_27 = (-u_xlat16_27) + 1.0;
    u_xlat16_8.xyz = u_xlat16_4.xyw * vec3(u_xlat16_27);
    u_xlat16_9.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_10.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_38) + vec3(1.0, 1.0, 1.0);
    u_xlat16_16.xyz = u_xlat16_10.xyz * u_xlat16_16.xxx + u_xlat16_9.xyz;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat16_16.xyz;
    u_xlat16_16.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_27 = u_xlat16_3.x * u_xlat16_16.x + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_34 * u_xlat16_16.x + u_xlat16_5.x;
    u_xlat16_5.x = float(1.0) / u_xlat16_5.x;
    u_xlat16_16.x = float(1.0) / u_xlat16_27;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_16.x;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat16_5.xxx;
    u_xlat16_14.xyz = vec3(u_xlat16_34) * u_xlat16_14.xyz;
    u_xlat16_3.xyz = u_xlat16_14.xyz * u_xlat16_3.xxx + u_xlat16_8.xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[1].yzx * _LampLocalPos.yyy;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * _LampLocalPos.xxx + u_xlat4.xyw;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * _LampLocalPos.zzz + u_xlat4.xyw;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].yzx * _LampLocalPos.www + u_xlat4.xyw;
    u_xlat4.xyw = (-u_xlat4.xyw) + _WorldSpaceCameraPos.yzx;
    u_xlat6.xyz = u_xlat2.xyz * u_xlat4.xyw;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat4.ywx + (-u_xlat6.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat16_13 = _LampRadius + 9.99999975e-05;
    u_xlat2.x = u_xlat2.x / u_xlat16_13;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat2.xxx * _LampColor.xyz;
    u_xlat2.xyz = _EmissionColor.xyz * u_xlat16_3.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = u_xlat2.xyz * vec3(vec3(_EmissionStrength, _EmissionStrength, _EmissionStrength));
    u_xlat16_5.xyz = u_xlat10_4.zzz * u_xlat16_5.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = vec3(vec3(_EmissionMulAlbedo, _EmissionMulAlbedo, _EmissionMulAlbedo)) * u_xlat16_8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
    u_xlat16_0.yzw = u_xlat16_1.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(9.99999975e-05<u_xlat16_34);
#else
    u_xlatb2 = 9.99999975e-05<u_xlat16_34;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.5<_EnableEmission);
#else
    u_xlatb13 = 0.5<_EnableEmission;
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb13;
    SV_Target0.w = (u_xlatb2) ? 0.00392156886 : 0.0;
    u_xlat16_1.x = max(u_xlat16_0.w, u_xlat16_0.z);
    u_xlat16_1.w = max(u_xlat16_0.y, u_xlat16_1.x);
    u_xlat16_1.xyz = vec3(u_xlat16_0.y / u_xlat16_1.w, u_xlat16_0.z / u_xlat16_1.w, u_xlat16_0.w / u_xlat16_1.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb13 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_1 = (bool(u_xlatb13)) ? u_xlat16_1 : u_xlat16_0.yzwx;
    SV_Target1.xyz = (bool(u_xlatb2)) ? u_xlat16_1.xyz : u_xlat16_3.xyz;
    u_xlat16_1.x = 0.400000006;
    SV_Target1.w = (u_xlatb2) ? u_xlat16_1.w : u_xlat16_1.x;
    u_xlat16_13 = u_xlat16_1.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat13 = sqrt(u_xlat16_13);
    SV_Target2.w = (u_xlatb2) ? u_xlat13 : u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : u_xlat16_7.z;
    SV_Target2.xy = u_xlat16_7.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
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
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD4.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _EnableEmission;
uniform 	float _CutOff;
uniform 	mediump float _Dissolve;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _SMBE_ST;
uniform 	vec4 _Normal_ST;
uniform 	vec4 _Cubemap_HDR;
uniform 	vec4 _Cubemap_TexelSize;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump vec4 _LampColor;
uniform 	mediump vec4 _LampLocalPos;
uniform 	mediump float _LampRadius;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionMulAlbedo;
uniform 	mediump vec4 _DissolveColor;
uniform 	mediump float _DissolveColorScale;
uniform 	mediump float _DissolveEdge;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _SMBE;
uniform lowp sampler2D _Normal;
uniform lowp samplerCube _Cubemap;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
lowp vec4 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump vec3 u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
bool u_xlatb13;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_16;
mediump float u_xlat16_27;
float u_xlat33;
mediump float u_xlat16_34;
mediump float u_xlat16_36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
    u_xlat10_0 = texture(_Noise, u_xlat16_1.xy).x;
    u_xlat0.x = u_xlat10_0 * _NoiseIntensity + vs_TEXCOORD3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat0.x>=_Dissolve);
#else
    u_xlatb11 = u_xlat0.x>=_Dissolve;
#endif
    u_xlat16_1.x = (u_xlatb11) ? 1.0 : 0.0;
    u_xlat11 = u_xlat16_1.x + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat11<0.0);
#else
    u_xlatb11 = u_xlat11<0.0;
#endif
    if((int(u_xlatb11) * int(0xffffffffu))!=0){discard;}
    u_xlat16_12.x = _Dissolve + _DissolveEdge;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_12.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_12.x;
#endif
    u_xlat16_12.x = (u_xlatb0) ? -1.0 : -0.0;
    u_xlat16_1.x = u_xlat16_12.x + u_xlat16_1.x;
    u_xlat16_12.xyz = _DissolveColor.xyz * vec3(_DissolveColorScale);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_12.xyz;
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD3.zw * _Normal_ST.xy + _Normal_ST.zw;
    u_xlat10_2.xyz = texture(_Normal, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat33 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * vs_TEXCOORD4.zxy;
    u_xlat16_34 = dot(u_xlat2.yzx, u_xlat0.xyz);
    u_xlat16_3.x = u_xlat16_34 + u_xlat16_34;
    u_xlat16_34 = max(u_xlat16_34, 0.00100000005);
    u_xlat16_3.xyz = u_xlat0.xyz * (-u_xlat16_3.xxx) + u_xlat2.yzx;
    u_xlat16_3.xyz = (-u_xlat16_3.xyz);
    u_xlat16_36 = log2(_Cubemap_TexelSize.z);
    u_xlat4.xy = vs_TEXCOORD3.zw * _SMBE_ST.xy + _SMBE_ST.zw;
    u_xlat10_4.xyz = texture(_SMBE, u_xlat4.xy).xyw;
    u_xlat16_5.x = (-u_xlat10_4.x) + 1.0;
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = min(u_xlat16_5.x, 0.999000013);
    u_xlat16_36 = u_xlat16_36 * u_xlat16_5.x;
    u_xlat10_6 = textureLod(_Cubemap, u_xlat16_3.xyz, u_xlat16_36);
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat16_3.xyz);
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_14.x = u_xlat10_6.w + -1.0;
    u_xlat16_14.x = _Cubemap_HDR.w * u_xlat16_14.x + 1.0;
    u_xlat16_14.x = log2(u_xlat16_14.x);
    u_xlat16_14.x = u_xlat16_14.x * _Cubemap_HDR.y;
    u_xlat16_14.x = exp2(u_xlat16_14.x);
    u_xlat16_14.x = u_xlat16_14.x * _Cubemap_HDR.x;
    u_xlat16_14.xyz = u_xlat10_6.xyz * u_xlat16_14.xxx;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat16_14.xyz;
    u_xlat16_0.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_14.xyz = u_xlat16_0.xxx * u_xlat16_14.xyz;
    u_xlat16_16.x = u_xlat16_34 * -5.55472994 + -6.98316002;
    u_xlat16_16.x = u_xlat16_34 * u_xlat16_16.x;
    u_xlat16_16.x = exp2(u_xlat16_16.x);
    u_xlat16_27 = u_xlat10_4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_5.w = u_xlat16_5.x * u_xlat16_27;
    u_xlat16_5.xw = u_xlat16_5.xw * u_xlat16_5.xw;
    u_xlat16_5.x = u_xlat16_5.x * 0.5;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_38 = u_xlat16_5.w * -0.5 + 1.0;
    u_xlat4.xy = vs_TEXCOORD3.zw * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_4.xyw = texture(_BaseTex, u_xlat4.xy).xyz;
    u_xlat16_7.xyz = _MainColor.xyz * u_xlat10_4.xyw + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyw = u_xlat10_4.xyw * _MainColor.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_27) * u_xlat16_7.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_27 = (-u_xlat16_27) + 1.0;
    u_xlat16_8.xyz = u_xlat16_4.xyw * vec3(u_xlat16_27);
    u_xlat16_9.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_10.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_38) + vec3(1.0, 1.0, 1.0);
    u_xlat16_16.xyz = u_xlat16_10.xyz * u_xlat16_16.xxx + u_xlat16_9.xyz;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat16_16.xyz;
    u_xlat16_16.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_27 = u_xlat16_3.x * u_xlat16_16.x + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_34 * u_xlat16_16.x + u_xlat16_5.x;
    u_xlat16_5.x = float(1.0) / u_xlat16_5.x;
    u_xlat16_16.x = float(1.0) / u_xlat16_27;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_16.x;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat16_5.xxx;
    u_xlat16_14.xyz = vec3(u_xlat16_34) * u_xlat16_14.xyz;
    u_xlat16_3.xyz = u_xlat16_14.xyz * u_xlat16_3.xxx + u_xlat16_8.xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[1].yzx * _LampLocalPos.yyy;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * _LampLocalPos.xxx + u_xlat4.xyw;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * _LampLocalPos.zzz + u_xlat4.xyw;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].yzx * _LampLocalPos.www + u_xlat4.xyw;
    u_xlat4.xyw = (-u_xlat4.xyw) + _WorldSpaceCameraPos.yzx;
    u_xlat6.xyz = u_xlat2.xyz * u_xlat4.xyw;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat4.ywx + (-u_xlat6.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat16_13 = _LampRadius + 9.99999975e-05;
    u_xlat2.x = u_xlat2.x / u_xlat16_13;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat2.xxx * _LampColor.xyz;
    u_xlat2.xyz = _EmissionColor.xyz * u_xlat16_3.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = u_xlat2.xyz * vec3(vec3(_EmissionStrength, _EmissionStrength, _EmissionStrength));
    u_xlat16_5.xyz = u_xlat10_4.zzz * u_xlat16_5.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = vec3(vec3(_EmissionMulAlbedo, _EmissionMulAlbedo, _EmissionMulAlbedo)) * u_xlat16_8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
    u_xlat16_0.yzw = u_xlat16_1.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(9.99999975e-05<u_xlat16_34);
#else
    u_xlatb2 = 9.99999975e-05<u_xlat16_34;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.5<_EnableEmission);
#else
    u_xlatb13 = 0.5<_EnableEmission;
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb13;
    SV_Target0.w = (u_xlatb2) ? 0.00392156886 : 0.0;
    u_xlat16_1.x = max(u_xlat16_0.w, u_xlat16_0.z);
    u_xlat16_1.w = max(u_xlat16_0.y, u_xlat16_1.x);
    u_xlat16_1.xyz = vec3(u_xlat16_0.y / u_xlat16_1.w, u_xlat16_0.z / u_xlat16_1.w, u_xlat16_0.w / u_xlat16_1.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb13 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_1 = (bool(u_xlatb13)) ? u_xlat16_1 : u_xlat16_0.yzwx;
    SV_Target1.xyz = (bool(u_xlatb2)) ? u_xlat16_1.xyz : u_xlat16_3.xyz;
    u_xlat16_1.x = 0.400000006;
    SV_Target1.w = (u_xlatb2) ? u_xlat16_1.w : u_xlat16_1.x;
    u_xlat16_13 = u_xlat16_1.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat13 = sqrt(u_xlat16_13);
    SV_Target2.w = (u_xlatb2) ? u_xlat13 : u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : u_xlat16_7.z;
    SV_Target2.xy = u_xlat16_7.xy;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
in mediump vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
float u_xlat10;
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
    vs_TEXCOORD0.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat3.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat3.xyz;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _EnableEmission;
uniform 	mediump float _Dissolve;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _SMBE_ST;
uniform 	vec4 _Normal_ST;
uniform 	vec4 _Cubemap_HDR;
uniform 	vec4 _Cubemap_TexelSize;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump vec4 _LampColor;
uniform 	mediump vec4 _LampLocalPos;
uniform 	mediump float _LampRadius;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionMulAlbedo;
uniform 	mediump vec4 _DissolveColor;
uniform 	mediump float _DissolveColorScale;
uniform 	mediump float _DissolveEdge;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _SMBE;
uniform lowp sampler2D _Normal;
uniform lowp samplerCube _Cubemap;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
lowp vec4 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
bool u_xlatb11;
mediump vec3 u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
bool u_xlatb13;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_16;
mediump float u_xlat16_27;
float u_xlat33;
mediump float u_xlat16_34;
mediump float u_xlat16_36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
    u_xlat10_0 = texture(_Noise, u_xlat16_1.xy).x;
    u_xlat0.x = u_xlat10_0 * _NoiseIntensity + vs_TEXCOORD3.x;
    u_xlat16_1.x = _Dissolve + _DissolveEdge;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb11 = u_xlat0.x>=u_xlat16_1.x;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=_Dissolve);
#else
    u_xlatb0 = u_xlat0.x>=_Dissolve;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_12.x = (u_xlatb11) ? -1.0 : -0.0;
    u_xlat16_1.x = u_xlat16_12.x + u_xlat16_1.x;
    u_xlat16_12.xyz = _DissolveColor.xyz * vec3(_DissolveColorScale);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_12.xyz;
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD3.zw * _Normal_ST.xy + _Normal_ST.zw;
    u_xlat10_2.xyz = texture(_Normal, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat33 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * vs_TEXCOORD4.zxy;
    u_xlat16_34 = dot(u_xlat2.yzx, u_xlat0.xyz);
    u_xlat16_3.x = u_xlat16_34 + u_xlat16_34;
    u_xlat16_34 = max(u_xlat16_34, 0.00100000005);
    u_xlat16_3.xyz = u_xlat0.xyz * (-u_xlat16_3.xxx) + u_xlat2.yzx;
    u_xlat16_3.xyz = (-u_xlat16_3.xyz);
    u_xlat16_36 = log2(_Cubemap_TexelSize.z);
    u_xlat4.xy = vs_TEXCOORD3.zw * _SMBE_ST.xy + _SMBE_ST.zw;
    u_xlat10_4.xyz = texture(_SMBE, u_xlat4.xy).xyw;
    u_xlat16_5.x = (-u_xlat10_4.x) + 1.0;
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = min(u_xlat16_5.x, 0.999000013);
    u_xlat16_36 = u_xlat16_36 * u_xlat16_5.x;
    u_xlat10_6 = textureLod(_Cubemap, u_xlat16_3.xyz, u_xlat16_36);
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat16_3.xyz);
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_14.x = u_xlat10_6.w + -1.0;
    u_xlat16_14.x = _Cubemap_HDR.w * u_xlat16_14.x + 1.0;
    u_xlat16_14.x = log2(u_xlat16_14.x);
    u_xlat16_14.x = u_xlat16_14.x * _Cubemap_HDR.y;
    u_xlat16_14.x = exp2(u_xlat16_14.x);
    u_xlat16_14.x = u_xlat16_14.x * _Cubemap_HDR.x;
    u_xlat16_14.xyz = u_xlat10_6.xyz * u_xlat16_14.xxx;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat16_14.xyz;
    u_xlat16_0.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_14.xyz = u_xlat16_0.xxx * u_xlat16_14.xyz;
    u_xlat16_16.x = u_xlat16_34 * -5.55472994 + -6.98316002;
    u_xlat16_16.x = u_xlat16_34 * u_xlat16_16.x;
    u_xlat16_16.x = exp2(u_xlat16_16.x);
    u_xlat16_27 = u_xlat10_4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_5.w = u_xlat16_5.x * u_xlat16_27;
    u_xlat16_5.xw = u_xlat16_5.xw * u_xlat16_5.xw;
    u_xlat16_5.x = u_xlat16_5.x * 0.5;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_38 = u_xlat16_5.w * -0.5 + 1.0;
    u_xlat4.xy = vs_TEXCOORD3.zw * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_4.xyw = texture(_BaseTex, u_xlat4.xy).xyz;
    u_xlat16_7.xyz = _MainColor.xyz * u_xlat10_4.xyw + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyw = u_xlat10_4.xyw * _MainColor.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_27) * u_xlat16_7.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_27 = (-u_xlat16_27) + 1.0;
    u_xlat16_8.xyz = u_xlat16_4.xyw * vec3(u_xlat16_27);
    u_xlat16_9.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_10.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_38) + vec3(1.0, 1.0, 1.0);
    u_xlat16_16.xyz = u_xlat16_10.xyz * u_xlat16_16.xxx + u_xlat16_9.xyz;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat16_16.xyz;
    u_xlat16_16.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_27 = u_xlat16_3.x * u_xlat16_16.x + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_34 * u_xlat16_16.x + u_xlat16_5.x;
    u_xlat16_5.x = float(1.0) / u_xlat16_5.x;
    u_xlat16_16.x = float(1.0) / u_xlat16_27;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_16.x;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat16_5.xxx;
    u_xlat16_14.xyz = vec3(u_xlat16_34) * u_xlat16_14.xyz;
    u_xlat16_3.xyz = u_xlat16_14.xyz * u_xlat16_3.xxx + u_xlat16_8.xyz;
    u_xlat4.xyw = _LampLocalPos.yyy * unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat4.xyw = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * _LampLocalPos.xxx + u_xlat4.xyw;
    u_xlat4.xyw = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * _LampLocalPos.zzz + u_xlat4.xyw;
    u_xlat4.xyw = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yzx * _LampLocalPos.www + u_xlat4.xyw;
    u_xlat4.xyw = (-u_xlat4.xyw) + _WorldSpaceCameraPos.yzx;
    u_xlat6.xyz = u_xlat2.xyz * u_xlat4.xyw;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat4.ywx + (-u_xlat6.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat16_13 = _LampRadius + 9.99999975e-05;
    u_xlat2.x = u_xlat2.x / u_xlat16_13;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat2.xxx * _LampColor.xyz;
    u_xlat2.xyz = _EmissionColor.xyz * u_xlat16_3.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = u_xlat2.xyz * vec3(vec3(_EmissionStrength, _EmissionStrength, _EmissionStrength));
    u_xlat16_5.xyz = u_xlat10_4.zzz * u_xlat16_5.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = vec3(vec3(_EmissionMulAlbedo, _EmissionMulAlbedo, _EmissionMulAlbedo)) * u_xlat16_8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
    u_xlat16_0.yzw = u_xlat16_1.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(9.99999975e-05<u_xlat16_34);
#else
    u_xlatb2 = 9.99999975e-05<u_xlat16_34;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.5<_EnableEmission);
#else
    u_xlatb13 = 0.5<_EnableEmission;
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb13;
    SV_Target0.w = (u_xlatb2) ? 0.00392156886 : 0.0;
    u_xlat16_1.x = max(u_xlat16_0.w, u_xlat16_0.z);
    u_xlat16_1.w = max(u_xlat16_0.y, u_xlat16_1.x);
    u_xlat16_1.xyz = vec3(u_xlat16_0.y / u_xlat16_1.w, u_xlat16_0.z / u_xlat16_1.w, u_xlat16_0.w / u_xlat16_1.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb13 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_1 = (bool(u_xlatb13)) ? u_xlat16_1 : u_xlat16_0.yzwx;
    SV_Target1.xyz = (bool(u_xlatb2)) ? u_xlat16_1.xyz : u_xlat16_3.xyz;
    u_xlat16_1.x = 0.400000006;
    SV_Target1.w = (u_xlatb2) ? u_xlat16_1.w : u_xlat16_1.x;
    u_xlat16_13 = u_xlat16_1.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat13 = sqrt(u_xlat16_13);
    SV_Target2.w = (u_xlatb2) ? u_xlat13 : u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : u_xlat16_7.z;
    SV_Target2.xy = u_xlat16_7.xy;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
in mediump vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
float u_xlat10;
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
    vs_TEXCOORD0.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat3.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat3.xyz;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD3.zw = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _EnableEmission;
uniform 	float _CutOff;
uniform 	mediump float _Dissolve;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _SMBE_ST;
uniform 	vec4 _Normal_ST;
uniform 	vec4 _Cubemap_HDR;
uniform 	vec4 _Cubemap_TexelSize;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump vec4 _LampColor;
uniform 	mediump vec4 _LampLocalPos;
uniform 	mediump float _LampRadius;
uniform 	mediump float _EmissionStrength;
uniform 	mediump float _EmissionMulAlbedo;
uniform 	mediump vec4 _DissolveColor;
uniform 	mediump float _DissolveColorScale;
uniform 	mediump float _DissolveEdge;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _SMBE;
uniform lowp sampler2D _Normal;
uniform lowp samplerCube _Cubemap;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec4 u_xlat10_4;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
lowp vec4 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump vec3 u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
bool u_xlatb13;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_16;
mediump float u_xlat16_27;
float u_xlat33;
mediump float u_xlat16_34;
mediump float u_xlat16_36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
    u_xlat10_0 = texture(_Noise, u_xlat16_1.xy).x;
    u_xlat0.x = u_xlat10_0 * _NoiseIntensity + vs_TEXCOORD3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat0.x>=_Dissolve);
#else
    u_xlatb11 = u_xlat0.x>=_Dissolve;
#endif
    u_xlat16_1.x = (u_xlatb11) ? 1.0 : 0.0;
    u_xlat11 = u_xlat16_1.x + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat11<0.0);
#else
    u_xlatb11 = u_xlat11<0.0;
#endif
    if((int(u_xlatb11) * int(0xffffffffu))!=0){discard;}
    u_xlat16_12.x = _Dissolve + _DissolveEdge;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_12.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_12.x;
#endif
    u_xlat16_12.x = (u_xlatb0) ? -1.0 : -0.0;
    u_xlat16_1.x = u_xlat16_12.x + u_xlat16_1.x;
    u_xlat16_12.xyz = _DissolveColor.xyz * vec3(_DissolveColorScale);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_12.xyz;
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat2.xy = vs_TEXCOORD3.zw * _Normal_ST.xy + _Normal_ST.zw;
    u_xlat10_2.xyz = texture(_Normal, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.y;
    u_xlat2.y = vs_TEXCOORD7.y;
    u_xlat2.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.x = vs_TEXCOORD5.z;
    u_xlat2.y = vs_TEXCOORD7.z;
    u_xlat2.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat33 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * vs_TEXCOORD4.zxy;
    u_xlat16_34 = dot(u_xlat2.yzx, u_xlat0.xyz);
    u_xlat16_3.x = u_xlat16_34 + u_xlat16_34;
    u_xlat16_34 = max(u_xlat16_34, 0.00100000005);
    u_xlat16_3.xyz = u_xlat0.xyz * (-u_xlat16_3.xxx) + u_xlat2.yzx;
    u_xlat16_3.xyz = (-u_xlat16_3.xyz);
    u_xlat16_36 = log2(_Cubemap_TexelSize.z);
    u_xlat4.xy = vs_TEXCOORD3.zw * _SMBE_ST.xy + _SMBE_ST.zw;
    u_xlat10_4.xyz = texture(_SMBE, u_xlat4.xy).xyw;
    u_xlat16_5.x = (-u_xlat10_4.x) + 1.0;
    u_xlat16_5.x = max(u_xlat16_5.x, 0.00100000005);
    u_xlat16_5.x = min(u_xlat16_5.x, 0.999000013);
    u_xlat16_36 = u_xlat16_36 * u_xlat16_5.x;
    u_xlat10_6 = textureLod(_Cubemap, u_xlat16_3.xyz, u_xlat16_36);
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat16_3.xyz);
    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.00100000005);
    u_xlat16_14.x = u_xlat10_6.w + -1.0;
    u_xlat16_14.x = _Cubemap_HDR.w * u_xlat16_14.x + 1.0;
    u_xlat16_14.x = log2(u_xlat16_14.x);
    u_xlat16_14.x = u_xlat16_14.x * _Cubemap_HDR.y;
    u_xlat16_14.x = exp2(u_xlat16_14.x);
    u_xlat16_14.x = u_xlat16_14.x * _Cubemap_HDR.x;
    u_xlat16_14.xyz = u_xlat10_6.xyz * u_xlat16_14.xxx;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat16_14.xyz;
    u_xlat16_0.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_14.xyz = u_xlat16_0.xxx * u_xlat16_14.xyz;
    u_xlat16_16.x = u_xlat16_34 * -5.55472994 + -6.98316002;
    u_xlat16_16.x = u_xlat16_34 * u_xlat16_16.x;
    u_xlat16_16.x = exp2(u_xlat16_16.x);
    u_xlat16_27 = u_xlat10_4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_5.w = u_xlat16_5.x * u_xlat16_27;
    u_xlat16_5.xw = u_xlat16_5.xw * u_xlat16_5.xw;
    u_xlat16_5.x = u_xlat16_5.x * 0.5;
    u_xlat16_5.x = max(u_xlat16_5.x, 9.99999975e-05);
    u_xlat16_38 = u_xlat16_5.w * -0.5 + 1.0;
    u_xlat4.xy = vs_TEXCOORD3.zw * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10_4.xyw = texture(_BaseTex, u_xlat4.xy).xyz;
    u_xlat16_7.xyz = _MainColor.xyz * u_xlat10_4.xyw + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_4.xyw = u_xlat10_4.xyw * _MainColor.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_27) * u_xlat16_7.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_27 = (-u_xlat16_27) + 1.0;
    u_xlat16_8.xyz = u_xlat16_4.xyw * vec3(u_xlat16_27);
    u_xlat16_9.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_10.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_38) + vec3(1.0, 1.0, 1.0);
    u_xlat16_16.xyz = u_xlat16_10.xyz * u_xlat16_16.xxx + u_xlat16_9.xyz;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat16_16.xyz;
    u_xlat16_16.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_27 = u_xlat16_3.x * u_xlat16_16.x + u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_34 * u_xlat16_16.x + u_xlat16_5.x;
    u_xlat16_5.x = float(1.0) / u_xlat16_5.x;
    u_xlat16_16.x = float(1.0) / u_xlat16_27;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_16.x;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat16_5.xxx;
    u_xlat16_14.xyz = vec3(u_xlat16_34) * u_xlat16_14.xyz;
    u_xlat16_3.xyz = u_xlat16_14.xyz * u_xlat16_3.xxx + u_xlat16_8.xyz;
    u_xlat4.xyw = _LampLocalPos.yyy * unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat4.xyw = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * _LampLocalPos.xxx + u_xlat4.xyw;
    u_xlat4.xyw = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * _LampLocalPos.zzz + u_xlat4.xyw;
    u_xlat4.xyw = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yzx * _LampLocalPos.www + u_xlat4.xyw;
    u_xlat4.xyw = (-u_xlat4.xyw) + _WorldSpaceCameraPos.yzx;
    u_xlat6.xyz = u_xlat2.xyz * u_xlat4.xyw;
    u_xlat2.xyz = u_xlat2.zxy * u_xlat4.ywx + (-u_xlat6.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat16_13 = _LampRadius + 9.99999975e-05;
    u_xlat2.x = u_xlat2.x / u_xlat16_13;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat2.xxx * _LampColor.xyz;
    u_xlat2.xyz = _EmissionColor.xyz * u_xlat16_3.xyz + u_xlat2.xyz;
    u_xlat16_5.xyz = u_xlat2.xyz * vec3(vec3(_EmissionStrength, _EmissionStrength, _EmissionStrength));
    u_xlat16_5.xyz = u_xlat10_4.zzz * u_xlat16_5.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = vec3(vec3(_EmissionMulAlbedo, _EmissionMulAlbedo, _EmissionMulAlbedo)) * u_xlat16_8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_34 = dot(u_xlat16_1.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
    u_xlat16_0.yzw = u_xlat16_1.xyz + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(9.99999975e-05<u_xlat16_34);
#else
    u_xlatb2 = 9.99999975e-05<u_xlat16_34;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.5<_EnableEmission);
#else
    u_xlatb13 = 0.5<_EnableEmission;
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb13;
    SV_Target0.w = (u_xlatb2) ? 0.00392156886 : 0.0;
    u_xlat16_1.x = max(u_xlat16_0.w, u_xlat16_0.z);
    u_xlat16_1.w = max(u_xlat16_0.y, u_xlat16_1.x);
    u_xlat16_1.xyz = vec3(u_xlat16_0.y / u_xlat16_1.w, u_xlat16_0.z / u_xlat16_1.w, u_xlat16_0.w / u_xlat16_1.w);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(1.0<u_xlat16_1.w);
#else
    u_xlatb13 = 1.0<u_xlat16_1.w;
#endif
    u_xlat16_1 = (bool(u_xlatb13)) ? u_xlat16_1 : u_xlat16_0.yzwx;
    SV_Target1.xyz = (bool(u_xlatb2)) ? u_xlat16_1.xyz : u_xlat16_3.xyz;
    u_xlat16_1.x = 0.400000006;
    SV_Target1.w = (u_xlatb2) ? u_xlat16_1.w : u_xlat16_1.x;
    u_xlat16_13 = u_xlat16_1.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat13 = sqrt(u_xlat16_13);
    SV_Target2.w = (u_xlatb2) ? u_xlat13 : u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1.x : u_xlat16_7.z;
    SV_Target2.xy = u_xlat16_7.xy;
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
  GpuProgramID 66660
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _MaterialShadowBias;
in highp vec4 in_POSITION0;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _Dissolve;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform lowp sampler2D _Noise;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
    u_xlat10_0 = texture(_Noise, u_xlat16_1.xy).x;
    u_xlat0.x = u_xlat10_0 * _NoiseIntensity + vs_TEXCOORD1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=_Dissolve);
#else
    u_xlatb0 = u_xlat0.x>=_Dissolve;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.x = u_xlat16_1.x + (-_CutOff);
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _Dissolve;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform lowp sampler2D _Noise;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
    u_xlat10_0 = texture(_Noise, u_xlat16_1.xy).x;
    u_xlat0.x = u_xlat10_0 * _NoiseIntensity + vs_TEXCOORD1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=_Dissolve);
#else
    u_xlatb0 = u_xlat0.x>=_Dissolve;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.x = u_xlat16_1.x + (-_CutOff);
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
  GpuProgramID 170424
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _Dissolve;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform lowp sampler2D _Noise;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
    u_xlat10_0 = texture(_Noise, u_xlat16_1.xy).x;
    u_xlat0.x = u_xlat10_0 * _NoiseIntensity + vs_TEXCOORD1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=_Dissolve);
#else
    u_xlatb0 = u_xlat0.x>=_Dissolve;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.x = u_xlat16_1.x + (-_CutOff);
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _Dissolve;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform lowp sampler2D _Noise;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
    u_xlat10_0 = texture(_Noise, u_xlat16_1.xy).x;
    u_xlat0.x = u_xlat10_0 * _NoiseIntensity + vs_TEXCOORD1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=_Dissolve);
#else
    u_xlatb0 = u_xlat0.x>=_Dissolve;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.x = u_xlat16_1.x + (-_CutOff);
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
  GpuProgramID 228825
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
uniform 	float _CutOff;
uniform 	mediump float _Dissolve;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform lowp sampler2D _Noise;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_TARGET0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
ivec2 u_xlati2;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
    u_xlat10_0 = texture(_Noise, u_xlat16_1.xy).x;
    u_xlat0.x = u_xlat10_0 * _NoiseIntensity + vs_TEXCOORD2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=_Dissolve);
#else
    u_xlatb0 = u_xlat0.x>=_Dissolve;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.x = u_xlat16_1.x + (-_CutOff);
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
uniform 	float _CutOff;
uniform 	mediump float _Dissolve;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform lowp sampler2D _Noise;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_TARGET0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
ivec2 u_xlati2;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
    u_xlat10_0 = texture(_Noise, u_xlat16_1.xy).x;
    u_xlat0.x = u_xlat10_0 * _NoiseIntensity + vs_TEXCOORD2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=_Dissolve);
#else
    u_xlatb0 = u_xlat0.x>=_Dissolve;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.x = u_xlat16_1.x + (-_CutOff);
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