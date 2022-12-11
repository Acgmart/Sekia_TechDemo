//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/River AQUS" {
Properties {
[Header(Global)] _UV_Mix_Start_Distance ("UV_Mix_Start_Distance", Range(0, 3000)) = 400
_UV_Mix_Range ("UV_Mix_Range", Range(1, 500)) = 100
_FarTillingMul ("Far tilling mul", Range(1, 100)) = 1
[Header(MainColor)] _MainColor ("Main Color", Color) = (0,0.4627451,1,1)
_DeepWaterColor ("Deep Water Color", Color) = (0,0.3411765,0.6235294,1)
_Fade ("Fade", Float) = 1.45
_Density ("Density", Range(0, 10)) = 1.74
[Header(Transparency)] _ShoreTransparency ("Shore Transparency", Range(0.0001, 10)) = 0.04
_ShoreFade ("Shore Transparency Fade", Range(0.0001, 10)) = 0.3
[Header(Specular)] _FresnelBias ("Fresnel Bias", Range(0, 1)) = 0.1
_Specular ("Water Specular Color strength", Range(0, 3)) = 0.15
_Gloss ("Water Gloss", Float) = 0.7
[Header(Refraction)] [Toggle] _EnableRefractions ("Enable Refractions", Float) = 1
_Refraction ("Refraction Distort", Range(0, 1)) = 0.67
[Toggle] _EnableReflections ("Enable Reflections", Float) = 1
_ReflectionIntensity ("Reflection Intensity", Range(0, 1)) = 0.6
_Distortion ("Reflction Distortion", Range(0, 5)) = 0.3
_ReflectionTraceLen ("Reflection Trace Length", Range(0, 512)) = 128
[Header(Small Wave)] _SmallWavesTexture ("Small Waves Bump", 2D) = "bump" { }
_SmallWavesParams ("Small Waves Tilling(X, Y) Speed(Z, W)", Vector) = (1,1,1,1)
[Header(Large Wave)] _LargeWavesTexture ("Large Waves Bump", 2D) = "bump" { }
_LargeWavesParams ("Large Waves Tilling(X, Y) Speed(Z, W)", Vector) = (1,1,1,1)
[Header(Shore Foam)] _ShoreFoam ("Foam", 2D) = "black" { }
_ShoreFoamParams ("Shore Foam Tilling(X, Y) Speed(Z, W)", Vector) = (10,10,1,1)
_ShoreFoamColor ("ShoreFoam Color", Color) = (1,1,1,0)
_ShoreFoamColorStrength ("Shore Foam Color Strength", Range(0, 1000)) = 1
_ShoreFoamDepth ("Shore Foam Depth", Range(0, 5)) = 0.3
[Header(Foam)] _Foam ("Foam", 2D) = "black" { }
_FoamParams ("Foam Tilling(X, Y) Speed(Z, W)", Vector) = (10,10,1,1)
_FoamColor ("Foam Color", Color) = (1,1,1,0)
_FoamColorStrength ("Foam Color Strength", Range(0, 1000)) = 1
}
SubShader {
 Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 27143
Program "vp" {
SubProgram "gles3 " {
Keywords { "WATER_REFRACTIVE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	float _TimeEditor;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _MainColor;
uniform 	float _Density;
uniform 	float _ShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
uniform 	vec4 _FoamParams;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y + _TimeEditor;
    u_xlat2.x = u_xlat2.x * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat9.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _FoamParams.z, u_xlat2.x * _FoamParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD2 = u_xlat16_3;
    u_xlat9.xy = in_TEXCOORD0.xy * _FoamParams.xy;
    u_xlat6.xy = u_xlat1.xy * u_xlat9.xy;
    u_xlat16_1.xy = u_xlat9.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat6.xy + u_xlat6.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD3 = u_xlat16_1;
    vs_TEXCOORD4.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD5.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _Density;
    u_xlat0.xyz = u_xlat0.xxx * _MainColor.xyz;
    vs_TEXCOORD8.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD8.w = float(1.0) / _ShoreTransparency;
    vs_TEXCOORD9.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD9.w = float(1.0) / _ShoreFoamDepth;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _LightColor0;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _MainColor;
uniform 	vec4 _DeepWaterColor;
uniform 	float _Fade;
uniform 	float _FresnelBias;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	float _ShoreFade;
uniform 	float _EnableRefractions;
uniform 	float _Refraction;
uniform 	float _ReflectionIntensity;
uniform 	float _Distortion;
uniform 	vec4 _ReflectionSkyCubeMap_HDR;
uniform 	vec3 _ES_SunDirection;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _SSRTexture;
uniform lowp samplerCube _ReflectionSkyCubeMap;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_19;
vec2 u_xlat20;
mediump float u_xlat16_20;
mediump vec2 u_xlat16_21;
float u_xlat27;
mediump float u_xlat16_27;
bool u_xlatb27;
float u_xlat29;
mediump float u_xlat16_29;
float u_xlat31;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_1);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_10.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_10.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = u_xlat16_10.xz * vec2(0.150000006, 0.150000006);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.300000012, 1.0, 0.300000012);
    u_xlat16_21.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_21.x = inversesqrt(u_xlat16_21.x);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_21.xxx;
    u_xlat16_21.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat27 = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
    u_xlat27 = _ZBufferParams.z * u_xlat27 + _ZBufferParams.w;
    u_xlat27 = float(1.0) / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<_EnableRefractions);
#else
    u_xlatb2 = 0.00999999978<_EnableRefractions;
#endif
    if(u_xlatb2){
        u_xlat2.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat2.x = sqrt(u_xlat2.x);
        u_xlat2.x = u_xlat2.x + (-_UV_Mix_Start_Distance);
        u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.w;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat16_21.x = u_xlat2.x * u_xlat2.x;
        u_xlat16_21.x = u_xlat16_21.x * u_xlat16_21.x;
        u_xlat2.x = _Refraction * -0.75;
        u_xlat2.x = u_xlat16_21.x * u_xlat2.x + _Refraction;
        u_xlat11.x = float(1.0) / vs_TEXCOORD6.w;
        u_xlat20.x = u_xlat11.x * vs_TEXCOORD6.z;
        u_xlat20.x = u_xlat20.x * 0.5 + 0.5;
        u_xlat16_21.xy = u_xlat2.xx * u_xlat16_3.xy;
        u_xlat2.x = u_xlat11.x * 4.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat2.xy = u_xlat2.xx * u_xlat16_21.xy;
        u_xlat4.xy = u_xlat2.xy * vs_TEXCOORD6.ww;
        u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD6.ww + vs_TEXCOORD6.xy;
        u_xlat29 = vs_TEXCOORD6.w;
        u_xlat16_21.xy = u_xlat2.xy / vec2(u_xlat29);
        u_xlat2.x = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(u_xlat2.x>=u_xlat20.x);
#else
        u_xlatb2 = u_xlat2.x>=u_xlat20.x;
#endif
        u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
        u_xlat16_5.xy = u_xlat2.xx * u_xlat4.xy;
        u_xlat16_5.z = 0.0;
        u_xlat2.xyz = u_xlat16_5.xyz + vs_TEXCOORD6.xyw;
        u_xlat16_21.xy = u_xlat2.xy / u_xlat2.zz;
        u_xlat10_2.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_21.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_2.xyz;
    } else {
        u_xlat16_5.xyz = _MainColor.xyz;
    //ENDIF
    }
    u_xlat27 = u_xlat27 + (-vs_TEXCOORD6.w);
    u_xlat2.x = u_xlat27 * vs_TEXCOORD8.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _ShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat11.xy = vec2(u_xlat27) * vec2(0.0500000007, -0.5);
    u_xlat11.x = u_xlat11.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat11.yyy * vs_TEXCOORD8.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_Fade);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat16_5.xyz * u_xlat4.xyz + _DeepWaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat16_21.x = dot((-u_xlat0.xyz), vs_TEXCOORD5.xyz);
    u_xlat16_21.x = u_xlat16_21.x + u_xlat16_21.x;
    u_xlat16_5.xyz = vs_TEXCOORD5.xyz * (-u_xlat16_21.xxx) + (-u_xlat0.xyz);
    u_xlat20.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion));
    u_xlat20.xy = u_xlat20.xy * vs_TEXCOORD6.ww;
    u_xlat20.xy = u_xlat11.xx * u_xlat20.xy;
    u_xlat20.xy = u_xlat20.xy * vec2(0.5, 0.5);
    u_xlat31 = vs_TEXCOORD6.w * _ProjectionParams.w;
    u_xlat31 = u_xlat31 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat20.xy = vec2(u_xlat31) * (-u_xlat20.xy) + u_xlat20.xy;
    u_xlat20.xy = u_xlat20.xy + vs_TEXCOORD6.xy;
    u_xlat16_21.xy = u_xlat20.xy / vs_TEXCOORD6.ww;
    u_xlat10_6 = texture(_SSRTexture, u_xlat16_21.xy);
    u_xlat7.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion)) + u_xlat16_5.xy;
    u_xlat7.z = u_xlat16_5.z;
    u_xlat10_3 = texture(_ReflectionSkyCubeMap, u_xlat7.xyz);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = _ReflectionSkyCubeMap_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.x;
    u_xlat16_14.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat16_8 = u_xlat10_6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat2.z = u_xlat16_1 * 0.00499999989;
    u_xlat2.xz = min(u_xlat2.xz, vec2(1.0, 1.0));
    u_xlat20.x = (-u_xlat2.z) * 0.800000012 + 1.0;
    u_xlat20.x = u_xlat20.x * u_xlat16_8;
    u_xlat16_6.xyz = (-u_xlat16_5.xxx) * u_xlat10_3.xyz + u_xlat10_6.xyz;
    u_xlat6.xyz = u_xlat20.xxx * u_xlat16_6.xyz + u_xlat16_14.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_20 = (-u_xlat16_1) + 1.0;
    u_xlat16_29 = u_xlat16_20 * u_xlat16_20;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_20 = u_xlat16_20 * u_xlat16_29;
    u_xlat29 = (-_FresnelBias) + 1.0;
    u_xlat20.x = u_xlat29 * u_xlat16_20 + _FresnelBias;
    u_xlat20.x = u_xlat20.x * _ReflectionIntensity;
    u_xlat11.x = u_xlat11.x * u_xlat20.x;
    u_xlat6.xyz = (-u_xlat4.xyz) + u_xlat6.xyz;
    u_xlat11.xyz = u_xlat11.xxx * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat27 = u_xlat27 * vs_TEXCOORD9.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10_4 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = (-u_xlat27) + 1.0;
    u_xlat16_27 = u_xlat16_1 * u_xlat10_4;
    u_xlat27 = u_xlat2.x * u_xlat16_27;
    u_xlat4.xyz = (-u_xlat11.xyz) + vs_TEXCOORD9.xyz;
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat4.xyz + u_xlat11.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0<_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0<_ES_SunDirection.xxyz.z;
#endif
    u_xlat16_1 = _Gloss * 20.3718395 + 0.318309993;
    u_xlat0.xyz = vec3(u_xlat0.x + _ES_SunDirection.xxyz.y, u_xlat0.y + _ES_SunDirection.xxyz.z, u_xlat0.z + float(_ES_SunDirection.z));
    u_xlat4.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xxx;
    u_xlat16_10.x = dot(u_xlat16_10.xyz, u_xlat0.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 9.99999975e-05);
    u_xlat16_19 = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_0 = log2(u_xlat16_10.x);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_19;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat16_0 * u_xlat16_1;
    u_xlat0.x = u_xlatb27 ? u_xlat0.x : float(0.0);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat0.x = u_xlat0.x * 0.200000003;
    u_xlat16_1 = max(u_xlat0.x, 0.0);
    u_xlat16_1 = min(u_xlat16_1, 16.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * _LightColor0.xyz + u_xlat11.xyz;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "WATER_REFRACTIVE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	float _TimeEditor;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _MainColor;
uniform 	float _Density;
uniform 	float _ShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
uniform 	vec4 _FoamParams;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
vec2 u_xlat12;
vec2 u_xlat14;
float u_xlat18;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].x;
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat6.x);
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].z;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].z;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].z;
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.y = sqrt(u_xlat6.x);
    u_xlat6.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat2.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat18 = _Time.y + _TimeEditor;
    u_xlat18 = u_xlat18 * 0.100000001;
    u_xlat14.xy = vec2(float(u_xlat18) * _ShoreFoamParams.z, float(u_xlat18) * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat2.xy * u_xlat6.xy + u_xlat14.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat6.xy * _SmallWavesParams.xy;
    u_xlat16_3.xy = u_xlat2.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat14.xy = vec2(float(u_xlat18) * _SmallWavesParams.z, float(u_xlat18) * _SmallWavesParams.w);
    u_xlat16_3.zw = u_xlat14.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat2.xy + u_xlat14.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat2.xy = u_xlat6.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat2.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat14.xy = vec2(float(u_xlat18) * _LargeWavesParams.z, float(u_xlat18) * _LargeWavesParams.w);
    u_xlat4.xy = vec2(float(u_xlat18) * _FoamParams.z, float(u_xlat18) * _FoamParams.w);
    u_xlat16_3.zw = u_xlat14.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat2.xy + u_xlat14.xy;
    vs_TEXCOORD2 = u_xlat16_3;
    u_xlat2.xy = in_TEXCOORD0.xy * _FoamParams.xy;
    u_xlat14.xy = u_xlat6.xy * u_xlat2.xy;
    u_xlat16_3.xy = u_xlat2.xy * u_xlat6.xy + u_xlat4.xy;
    u_xlat16_5.xy = u_xlat14.xy + u_xlat14.xy;
    u_xlat16_3.zw = u_xlat4.xy * vec2(1.5, 1.5) + u_xlat16_5.xy;
    vs_TEXCOORD3 = u_xlat16_3;
    vs_TEXCOORD4.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0.x = 10.0 / _Density;
    u_xlat0.xyz = u_xlat0.xxx * _MainColor.xyz;
    vs_TEXCOORD8.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD8.w = float(1.0) / _ShoreTransparency;
    vs_TEXCOORD9.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD9.w = float(1.0) / _ShoreFoamDepth;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _LightColor0;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _MainColor;
uniform 	vec4 _DeepWaterColor;
uniform 	float _Fade;
uniform 	float _FresnelBias;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	float _ShoreFade;
uniform 	float _EnableRefractions;
uniform 	float _Refraction;
uniform 	float _ReflectionIntensity;
uniform 	float _Distortion;
uniform 	vec4 _ReflectionSkyCubeMap_HDR;
uniform 	vec3 _ES_SunDirection;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _SSRTexture;
uniform lowp samplerCube _ReflectionSkyCubeMap;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_19;
vec2 u_xlat20;
mediump float u_xlat16_20;
mediump vec2 u_xlat16_21;
float u_xlat27;
mediump float u_xlat16_27;
bool u_xlatb27;
float u_xlat29;
mediump float u_xlat16_29;
float u_xlat31;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_1);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_10.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_10.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = u_xlat16_10.xz * vec2(0.150000006, 0.150000006);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.300000012, 1.0, 0.300000012);
    u_xlat16_21.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_21.x = inversesqrt(u_xlat16_21.x);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_21.xxx;
    u_xlat16_21.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat27 = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
    u_xlat27 = _ZBufferParams.z * u_xlat27 + _ZBufferParams.w;
    u_xlat27 = float(1.0) / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<_EnableRefractions);
#else
    u_xlatb2 = 0.00999999978<_EnableRefractions;
#endif
    if(u_xlatb2){
        u_xlat2.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat2.x = sqrt(u_xlat2.x);
        u_xlat2.x = u_xlat2.x + (-_UV_Mix_Start_Distance);
        u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.w;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat16_21.x = u_xlat2.x * u_xlat2.x;
        u_xlat16_21.x = u_xlat16_21.x * u_xlat16_21.x;
        u_xlat2.x = _Refraction * -0.75;
        u_xlat2.x = u_xlat16_21.x * u_xlat2.x + _Refraction;
        u_xlat11.x = float(1.0) / vs_TEXCOORD6.w;
        u_xlat20.x = u_xlat11.x * vs_TEXCOORD6.z;
        u_xlat20.x = u_xlat20.x * 0.5 + 0.5;
        u_xlat16_21.xy = u_xlat2.xx * u_xlat16_3.xy;
        u_xlat2.x = u_xlat11.x * 4.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat2.xy = u_xlat2.xx * u_xlat16_21.xy;
        u_xlat4.xy = u_xlat2.xy * vs_TEXCOORD6.ww;
        u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD6.ww + vs_TEXCOORD6.xy;
        u_xlat29 = vs_TEXCOORD6.w;
        u_xlat16_21.xy = u_xlat2.xy / vec2(u_xlat29);
        u_xlat2.x = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(u_xlat2.x>=u_xlat20.x);
#else
        u_xlatb2 = u_xlat2.x>=u_xlat20.x;
#endif
        u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
        u_xlat16_5.xy = u_xlat2.xx * u_xlat4.xy;
        u_xlat16_5.z = 0.0;
        u_xlat2.xyz = u_xlat16_5.xyz + vs_TEXCOORD6.xyw;
        u_xlat16_21.xy = u_xlat2.xy / u_xlat2.zz;
        u_xlat10_2.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_21.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_2.xyz;
    } else {
        u_xlat16_5.xyz = _MainColor.xyz;
    //ENDIF
    }
    u_xlat27 = u_xlat27 + (-vs_TEXCOORD6.w);
    u_xlat2.x = u_xlat27 * vs_TEXCOORD8.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _ShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat11.xy = vec2(u_xlat27) * vec2(0.0500000007, -0.5);
    u_xlat11.x = u_xlat11.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat11.yyy * vs_TEXCOORD8.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_Fade);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat16_5.xyz * u_xlat4.xyz + _DeepWaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat16_21.x = dot((-u_xlat0.xyz), vs_TEXCOORD5.xyz);
    u_xlat16_21.x = u_xlat16_21.x + u_xlat16_21.x;
    u_xlat16_5.xyz = vs_TEXCOORD5.xyz * (-u_xlat16_21.xxx) + (-u_xlat0.xyz);
    u_xlat20.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion));
    u_xlat20.xy = u_xlat20.xy * vs_TEXCOORD6.ww;
    u_xlat20.xy = u_xlat11.xx * u_xlat20.xy;
    u_xlat20.xy = u_xlat20.xy * vec2(0.5, 0.5);
    u_xlat31 = vs_TEXCOORD6.w * _ProjectionParams.w;
    u_xlat31 = u_xlat31 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat20.xy = vec2(u_xlat31) * (-u_xlat20.xy) + u_xlat20.xy;
    u_xlat20.xy = u_xlat20.xy + vs_TEXCOORD6.xy;
    u_xlat16_21.xy = u_xlat20.xy / vs_TEXCOORD6.ww;
    u_xlat10_6 = texture(_SSRTexture, u_xlat16_21.xy);
    u_xlat7.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion)) + u_xlat16_5.xy;
    u_xlat7.z = u_xlat16_5.z;
    u_xlat10_3 = texture(_ReflectionSkyCubeMap, u_xlat7.xyz);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = _ReflectionSkyCubeMap_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.x;
    u_xlat16_14.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat16_8 = u_xlat10_6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat2.z = u_xlat16_1 * 0.00499999989;
    u_xlat2.xz = min(u_xlat2.xz, vec2(1.0, 1.0));
    u_xlat20.x = (-u_xlat2.z) * 0.800000012 + 1.0;
    u_xlat20.x = u_xlat20.x * u_xlat16_8;
    u_xlat16_6.xyz = (-u_xlat16_5.xxx) * u_xlat10_3.xyz + u_xlat10_6.xyz;
    u_xlat6.xyz = u_xlat20.xxx * u_xlat16_6.xyz + u_xlat16_14.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_20 = (-u_xlat16_1) + 1.0;
    u_xlat16_29 = u_xlat16_20 * u_xlat16_20;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_20 = u_xlat16_20 * u_xlat16_29;
    u_xlat29 = (-_FresnelBias) + 1.0;
    u_xlat20.x = u_xlat29 * u_xlat16_20 + _FresnelBias;
    u_xlat20.x = u_xlat20.x * _ReflectionIntensity;
    u_xlat11.x = u_xlat11.x * u_xlat20.x;
    u_xlat6.xyz = (-u_xlat4.xyz) + u_xlat6.xyz;
    u_xlat11.xyz = u_xlat11.xxx * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat27 = u_xlat27 * vs_TEXCOORD9.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10_4 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = (-u_xlat27) + 1.0;
    u_xlat16_27 = u_xlat16_1 * u_xlat10_4;
    u_xlat27 = u_xlat2.x * u_xlat16_27;
    u_xlat4.xyz = (-u_xlat11.xyz) + vs_TEXCOORD9.xyz;
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat4.xyz + u_xlat11.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0<_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0<_ES_SunDirection.xxyz.z;
#endif
    u_xlat16_1 = _Gloss * 20.3718395 + 0.318309993;
    u_xlat0.xyz = vec3(u_xlat0.x + _ES_SunDirection.xxyz.y, u_xlat0.y + _ES_SunDirection.xxyz.z, u_xlat0.z + float(_ES_SunDirection.z));
    u_xlat4.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xxx;
    u_xlat16_10.x = dot(u_xlat16_10.xyz, u_xlat0.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 9.99999975e-05);
    u_xlat16_19 = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_0 = log2(u_xlat16_10.x);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_19;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat16_0 * u_xlat16_1;
    u_xlat0.x = u_xlatb27 ? u_xlat0.x : float(0.0);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat0.x = u_xlat0.x * 0.200000003;
    u_xlat16_1 = max(u_xlat0.x, 0.0);
    u_xlat16_1 = min(u_xlat16_1, 16.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * _LightColor0.xyz + u_xlat11.xyz;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "WATER_REFLECTIVE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	float _TimeEditor;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _MainColor;
uniform 	float _Density;
uniform 	float _ShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
uniform 	vec4 _FoamParams;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y + _TimeEditor;
    u_xlat2.x = u_xlat2.x * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat9.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _FoamParams.z, u_xlat2.x * _FoamParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD2 = u_xlat16_3;
    u_xlat9.xy = in_TEXCOORD0.xy * _FoamParams.xy;
    u_xlat6.xy = u_xlat1.xy * u_xlat9.xy;
    u_xlat16_1.xy = u_xlat9.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat6.xy + u_xlat6.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD3 = u_xlat16_1;
    vs_TEXCOORD4.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD5.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _Density;
    u_xlat0.xyz = u_xlat0.xxx * _MainColor.xyz;
    vs_TEXCOORD8.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD8.w = float(1.0) / _ShoreTransparency;
    vs_TEXCOORD9.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD9.w = float(1.0) / _ShoreFoamDepth;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _LightColor0;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _MainColor;
uniform 	vec4 _DeepWaterColor;
uniform 	float _Fade;
uniform 	float _FresnelBias;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	float _ShoreFade;
uniform 	float _EnableRefractions;
uniform 	float _Refraction;
uniform 	float _ReflectionIntensity;
uniform 	float _Distortion;
uniform 	vec4 _ReflectionSkyCubeMap_HDR;
uniform 	vec3 _ES_SunDirection;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _SSRTexture;
uniform lowp samplerCube _ReflectionSkyCubeMap;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_19;
vec2 u_xlat20;
mediump float u_xlat16_20;
mediump vec2 u_xlat16_21;
float u_xlat27;
mediump float u_xlat16_27;
bool u_xlatb27;
float u_xlat29;
mediump float u_xlat16_29;
float u_xlat31;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_1);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_10.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_10.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = u_xlat16_10.xz * vec2(0.150000006, 0.150000006);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.300000012, 1.0, 0.300000012);
    u_xlat16_21.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_21.x = inversesqrt(u_xlat16_21.x);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_21.xxx;
    u_xlat16_21.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat27 = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
    u_xlat27 = _ZBufferParams.z * u_xlat27 + _ZBufferParams.w;
    u_xlat27 = float(1.0) / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<_EnableRefractions);
#else
    u_xlatb2 = 0.00999999978<_EnableRefractions;
#endif
    if(u_xlatb2){
        u_xlat2.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat2.x = sqrt(u_xlat2.x);
        u_xlat2.x = u_xlat2.x + (-_UV_Mix_Start_Distance);
        u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.w;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat16_21.x = u_xlat2.x * u_xlat2.x;
        u_xlat16_21.x = u_xlat16_21.x * u_xlat16_21.x;
        u_xlat2.x = _Refraction * -0.75;
        u_xlat2.x = u_xlat16_21.x * u_xlat2.x + _Refraction;
        u_xlat11.x = float(1.0) / vs_TEXCOORD6.w;
        u_xlat20.x = u_xlat11.x * vs_TEXCOORD6.z;
        u_xlat20.x = u_xlat20.x * 0.5 + 0.5;
        u_xlat16_21.xy = u_xlat2.xx * u_xlat16_3.xy;
        u_xlat2.x = u_xlat11.x * 4.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat2.xy = u_xlat2.xx * u_xlat16_21.xy;
        u_xlat4.xy = u_xlat2.xy * vs_TEXCOORD6.ww;
        u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD6.ww + vs_TEXCOORD6.xy;
        u_xlat29 = vs_TEXCOORD6.w;
        u_xlat16_21.xy = u_xlat2.xy / vec2(u_xlat29);
        u_xlat2.x = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(u_xlat2.x>=u_xlat20.x);
#else
        u_xlatb2 = u_xlat2.x>=u_xlat20.x;
#endif
        u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
        u_xlat16_5.xy = u_xlat2.xx * u_xlat4.xy;
        u_xlat16_5.z = 0.0;
        u_xlat2.xyz = u_xlat16_5.xyz + vs_TEXCOORD6.xyw;
        u_xlat16_21.xy = u_xlat2.xy / u_xlat2.zz;
        u_xlat10_2.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_21.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_2.xyz;
    } else {
        u_xlat16_5.xyz = _MainColor.xyz;
    //ENDIF
    }
    u_xlat27 = u_xlat27 + (-vs_TEXCOORD6.w);
    u_xlat2.x = u_xlat27 * vs_TEXCOORD8.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _ShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat11.xy = vec2(u_xlat27) * vec2(0.0500000007, -0.5);
    u_xlat11.x = u_xlat11.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat11.yyy * vs_TEXCOORD8.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_Fade);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat16_5.xyz * u_xlat4.xyz + _DeepWaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat16_21.x = dot((-u_xlat0.xyz), vs_TEXCOORD5.xyz);
    u_xlat16_21.x = u_xlat16_21.x + u_xlat16_21.x;
    u_xlat16_5.xyz = vs_TEXCOORD5.xyz * (-u_xlat16_21.xxx) + (-u_xlat0.xyz);
    u_xlat20.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion));
    u_xlat20.xy = u_xlat20.xy * vs_TEXCOORD6.ww;
    u_xlat20.xy = u_xlat11.xx * u_xlat20.xy;
    u_xlat20.xy = u_xlat20.xy * vec2(0.5, 0.5);
    u_xlat31 = vs_TEXCOORD6.w * _ProjectionParams.w;
    u_xlat31 = u_xlat31 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat20.xy = vec2(u_xlat31) * (-u_xlat20.xy) + u_xlat20.xy;
    u_xlat20.xy = u_xlat20.xy + vs_TEXCOORD6.xy;
    u_xlat16_21.xy = u_xlat20.xy / vs_TEXCOORD6.ww;
    u_xlat10_6 = texture(_SSRTexture, u_xlat16_21.xy);
    u_xlat7.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion)) + u_xlat16_5.xy;
    u_xlat7.z = u_xlat16_5.z;
    u_xlat10_3 = texture(_ReflectionSkyCubeMap, u_xlat7.xyz);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = _ReflectionSkyCubeMap_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.x;
    u_xlat16_14.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat16_8 = u_xlat10_6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat2.z = u_xlat16_1 * 0.00499999989;
    u_xlat2.xz = min(u_xlat2.xz, vec2(1.0, 1.0));
    u_xlat20.x = (-u_xlat2.z) * 0.800000012 + 1.0;
    u_xlat20.x = u_xlat20.x * u_xlat16_8;
    u_xlat16_6.xyz = (-u_xlat16_5.xxx) * u_xlat10_3.xyz + u_xlat10_6.xyz;
    u_xlat6.xyz = u_xlat20.xxx * u_xlat16_6.xyz + u_xlat16_14.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_20 = (-u_xlat16_1) + 1.0;
    u_xlat16_29 = u_xlat16_20 * u_xlat16_20;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_20 = u_xlat16_20 * u_xlat16_29;
    u_xlat29 = (-_FresnelBias) + 1.0;
    u_xlat20.x = u_xlat29 * u_xlat16_20 + _FresnelBias;
    u_xlat20.x = u_xlat20.x * _ReflectionIntensity;
    u_xlat11.x = u_xlat11.x * u_xlat20.x;
    u_xlat6.xyz = (-u_xlat4.xyz) + u_xlat6.xyz;
    u_xlat11.xyz = u_xlat11.xxx * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat27 = u_xlat27 * vs_TEXCOORD9.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10_4 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = (-u_xlat27) + 1.0;
    u_xlat16_27 = u_xlat16_1 * u_xlat10_4;
    u_xlat27 = u_xlat2.x * u_xlat16_27;
    u_xlat4.xyz = (-u_xlat11.xyz) + vs_TEXCOORD9.xyz;
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat4.xyz + u_xlat11.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0<_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0<_ES_SunDirection.xxyz.z;
#endif
    u_xlat16_1 = _Gloss * 20.3718395 + 0.318309993;
    u_xlat0.xyz = vec3(u_xlat0.x + _ES_SunDirection.xxyz.y, u_xlat0.y + _ES_SunDirection.xxyz.z, u_xlat0.z + float(_ES_SunDirection.z));
    u_xlat4.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xxx;
    u_xlat16_10.x = dot(u_xlat16_10.xyz, u_xlat0.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 9.99999975e-05);
    u_xlat16_19 = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_0 = log2(u_xlat16_10.x);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_19;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat16_0 * u_xlat16_1;
    u_xlat0.x = u_xlatb27 ? u_xlat0.x : float(0.0);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat0.x = u_xlat0.x * 0.200000003;
    u_xlat16_1 = max(u_xlat0.x, 0.0);
    u_xlat16_1 = min(u_xlat16_1, 16.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * _LightColor0.xyz + u_xlat11.xyz;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "WATER_REFLECTIVE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	float _TimeEditor;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _MainColor;
uniform 	float _Density;
uniform 	float _ShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
uniform 	vec4 _FoamParams;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
vec2 u_xlat12;
vec2 u_xlat14;
float u_xlat18;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].x;
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat6.x);
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].z;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].z;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].z;
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.y = sqrt(u_xlat6.x);
    u_xlat6.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat2.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat18 = _Time.y + _TimeEditor;
    u_xlat18 = u_xlat18 * 0.100000001;
    u_xlat14.xy = vec2(float(u_xlat18) * _ShoreFoamParams.z, float(u_xlat18) * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat2.xy * u_xlat6.xy + u_xlat14.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat6.xy * _SmallWavesParams.xy;
    u_xlat16_3.xy = u_xlat2.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat14.xy = vec2(float(u_xlat18) * _SmallWavesParams.z, float(u_xlat18) * _SmallWavesParams.w);
    u_xlat16_3.zw = u_xlat14.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat2.xy + u_xlat14.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat2.xy = u_xlat6.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat2.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat14.xy = vec2(float(u_xlat18) * _LargeWavesParams.z, float(u_xlat18) * _LargeWavesParams.w);
    u_xlat4.xy = vec2(float(u_xlat18) * _FoamParams.z, float(u_xlat18) * _FoamParams.w);
    u_xlat16_3.zw = u_xlat14.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat2.xy + u_xlat14.xy;
    vs_TEXCOORD2 = u_xlat16_3;
    u_xlat2.xy = in_TEXCOORD0.xy * _FoamParams.xy;
    u_xlat14.xy = u_xlat6.xy * u_xlat2.xy;
    u_xlat16_3.xy = u_xlat2.xy * u_xlat6.xy + u_xlat4.xy;
    u_xlat16_5.xy = u_xlat14.xy + u_xlat14.xy;
    u_xlat16_3.zw = u_xlat4.xy * vec2(1.5, 1.5) + u_xlat16_5.xy;
    vs_TEXCOORD3 = u_xlat16_3;
    vs_TEXCOORD4.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0.x = 10.0 / _Density;
    u_xlat0.xyz = u_xlat0.xxx * _MainColor.xyz;
    vs_TEXCOORD8.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD8.w = float(1.0) / _ShoreTransparency;
    vs_TEXCOORD9.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD9.w = float(1.0) / _ShoreFoamDepth;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _LightColor0;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _MainColor;
uniform 	vec4 _DeepWaterColor;
uniform 	float _Fade;
uniform 	float _FresnelBias;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	float _ShoreFade;
uniform 	float _EnableRefractions;
uniform 	float _Refraction;
uniform 	float _ReflectionIntensity;
uniform 	float _Distortion;
uniform 	vec4 _ReflectionSkyCubeMap_HDR;
uniform 	vec3 _ES_SunDirection;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _SSRTexture;
uniform lowp samplerCube _ReflectionSkyCubeMap;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_19;
vec2 u_xlat20;
mediump float u_xlat16_20;
mediump vec2 u_xlat16_21;
float u_xlat27;
mediump float u_xlat16_27;
bool u_xlatb27;
float u_xlat29;
mediump float u_xlat16_29;
float u_xlat31;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_1);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_10.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_10.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = u_xlat16_10.xz * vec2(0.150000006, 0.150000006);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.300000012, 1.0, 0.300000012);
    u_xlat16_21.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_21.x = inversesqrt(u_xlat16_21.x);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_21.xxx;
    u_xlat16_21.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat27 = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
    u_xlat27 = _ZBufferParams.z * u_xlat27 + _ZBufferParams.w;
    u_xlat27 = float(1.0) / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<_EnableRefractions);
#else
    u_xlatb2 = 0.00999999978<_EnableRefractions;
#endif
    if(u_xlatb2){
        u_xlat2.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat2.x = sqrt(u_xlat2.x);
        u_xlat2.x = u_xlat2.x + (-_UV_Mix_Start_Distance);
        u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.w;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat16_21.x = u_xlat2.x * u_xlat2.x;
        u_xlat16_21.x = u_xlat16_21.x * u_xlat16_21.x;
        u_xlat2.x = _Refraction * -0.75;
        u_xlat2.x = u_xlat16_21.x * u_xlat2.x + _Refraction;
        u_xlat11.x = float(1.0) / vs_TEXCOORD6.w;
        u_xlat20.x = u_xlat11.x * vs_TEXCOORD6.z;
        u_xlat20.x = u_xlat20.x * 0.5 + 0.5;
        u_xlat16_21.xy = u_xlat2.xx * u_xlat16_3.xy;
        u_xlat2.x = u_xlat11.x * 4.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat2.xy = u_xlat2.xx * u_xlat16_21.xy;
        u_xlat4.xy = u_xlat2.xy * vs_TEXCOORD6.ww;
        u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD6.ww + vs_TEXCOORD6.xy;
        u_xlat29 = vs_TEXCOORD6.w;
        u_xlat16_21.xy = u_xlat2.xy / vec2(u_xlat29);
        u_xlat2.x = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(u_xlat2.x>=u_xlat20.x);
#else
        u_xlatb2 = u_xlat2.x>=u_xlat20.x;
#endif
        u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
        u_xlat16_5.xy = u_xlat2.xx * u_xlat4.xy;
        u_xlat16_5.z = 0.0;
        u_xlat2.xyz = u_xlat16_5.xyz + vs_TEXCOORD6.xyw;
        u_xlat16_21.xy = u_xlat2.xy / u_xlat2.zz;
        u_xlat10_2.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_21.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_2.xyz;
    } else {
        u_xlat16_5.xyz = _MainColor.xyz;
    //ENDIF
    }
    u_xlat27 = u_xlat27 + (-vs_TEXCOORD6.w);
    u_xlat2.x = u_xlat27 * vs_TEXCOORD8.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _ShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat11.xy = vec2(u_xlat27) * vec2(0.0500000007, -0.5);
    u_xlat11.x = u_xlat11.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat11.yyy * vs_TEXCOORD8.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_Fade);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat16_5.xyz * u_xlat4.xyz + _DeepWaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat16_21.x = dot((-u_xlat0.xyz), vs_TEXCOORD5.xyz);
    u_xlat16_21.x = u_xlat16_21.x + u_xlat16_21.x;
    u_xlat16_5.xyz = vs_TEXCOORD5.xyz * (-u_xlat16_21.xxx) + (-u_xlat0.xyz);
    u_xlat20.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion));
    u_xlat20.xy = u_xlat20.xy * vs_TEXCOORD6.ww;
    u_xlat20.xy = u_xlat11.xx * u_xlat20.xy;
    u_xlat20.xy = u_xlat20.xy * vec2(0.5, 0.5);
    u_xlat31 = vs_TEXCOORD6.w * _ProjectionParams.w;
    u_xlat31 = u_xlat31 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat20.xy = vec2(u_xlat31) * (-u_xlat20.xy) + u_xlat20.xy;
    u_xlat20.xy = u_xlat20.xy + vs_TEXCOORD6.xy;
    u_xlat16_21.xy = u_xlat20.xy / vs_TEXCOORD6.ww;
    u_xlat10_6 = texture(_SSRTexture, u_xlat16_21.xy);
    u_xlat7.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion)) + u_xlat16_5.xy;
    u_xlat7.z = u_xlat16_5.z;
    u_xlat10_3 = texture(_ReflectionSkyCubeMap, u_xlat7.xyz);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = _ReflectionSkyCubeMap_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.x;
    u_xlat16_14.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat16_8 = u_xlat10_6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat2.z = u_xlat16_1 * 0.00499999989;
    u_xlat2.xz = min(u_xlat2.xz, vec2(1.0, 1.0));
    u_xlat20.x = (-u_xlat2.z) * 0.800000012 + 1.0;
    u_xlat20.x = u_xlat20.x * u_xlat16_8;
    u_xlat16_6.xyz = (-u_xlat16_5.xxx) * u_xlat10_3.xyz + u_xlat10_6.xyz;
    u_xlat6.xyz = u_xlat20.xxx * u_xlat16_6.xyz + u_xlat16_14.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_20 = (-u_xlat16_1) + 1.0;
    u_xlat16_29 = u_xlat16_20 * u_xlat16_20;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_20 = u_xlat16_20 * u_xlat16_29;
    u_xlat29 = (-_FresnelBias) + 1.0;
    u_xlat20.x = u_xlat29 * u_xlat16_20 + _FresnelBias;
    u_xlat20.x = u_xlat20.x * _ReflectionIntensity;
    u_xlat11.x = u_xlat11.x * u_xlat20.x;
    u_xlat6.xyz = (-u_xlat4.xyz) + u_xlat6.xyz;
    u_xlat11.xyz = u_xlat11.xxx * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat27 = u_xlat27 * vs_TEXCOORD9.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10_4 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = (-u_xlat27) + 1.0;
    u_xlat16_27 = u_xlat16_1 * u_xlat10_4;
    u_xlat27 = u_xlat2.x * u_xlat16_27;
    u_xlat4.xyz = (-u_xlat11.xyz) + vs_TEXCOORD9.xyz;
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat4.xyz + u_xlat11.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0<_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0<_ES_SunDirection.xxyz.z;
#endif
    u_xlat16_1 = _Gloss * 20.3718395 + 0.318309993;
    u_xlat0.xyz = vec3(u_xlat0.x + _ES_SunDirection.xxyz.y, u_xlat0.y + _ES_SunDirection.xxyz.z, u_xlat0.z + float(_ES_SunDirection.z));
    u_xlat4.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xxx;
    u_xlat16_10.x = dot(u_xlat16_10.xyz, u_xlat0.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 9.99999975e-05);
    u_xlat16_19 = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_0 = log2(u_xlat16_10.x);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_19;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat16_0 * u_xlat16_1;
    u_xlat0.x = u_xlatb27 ? u_xlat0.x : float(0.0);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat0.x = u_xlat0.x * 0.200000003;
    u_xlat16_1 = max(u_xlat0.x, 0.0);
    u_xlat16_1 = min(u_xlat16_1, 16.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * _LightColor0.xyz + u_xlat11.xyz;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "WATER_SHORE_FOAM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	float _TimeEditor;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _MainColor;
uniform 	float _Density;
uniform 	float _ShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
uniform 	vec4 _FoamParams;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y + _TimeEditor;
    u_xlat2.x = u_xlat2.x * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat9.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _FoamParams.z, u_xlat2.x * _FoamParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD2 = u_xlat16_3;
    u_xlat9.xy = in_TEXCOORD0.xy * _FoamParams.xy;
    u_xlat6.xy = u_xlat1.xy * u_xlat9.xy;
    u_xlat16_1.xy = u_xlat9.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat6.xy + u_xlat6.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD3 = u_xlat16_1;
    vs_TEXCOORD4.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD5.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _Density;
    u_xlat0.xyz = u_xlat0.xxx * _MainColor.xyz;
    vs_TEXCOORD8.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD8.w = float(1.0) / _ShoreTransparency;
    vs_TEXCOORD9.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD9.w = float(1.0) / _ShoreFoamDepth;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _LightColor0;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _MainColor;
uniform 	vec4 _DeepWaterColor;
uniform 	float _Fade;
uniform 	float _FresnelBias;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	float _ShoreFade;
uniform 	float _EnableRefractions;
uniform 	float _Refraction;
uniform 	float _ReflectionIntensity;
uniform 	float _Distortion;
uniform 	vec4 _ReflectionSkyCubeMap_HDR;
uniform 	vec3 _ES_SunDirection;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _SSRTexture;
uniform lowp samplerCube _ReflectionSkyCubeMap;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_19;
vec2 u_xlat20;
mediump float u_xlat16_20;
mediump vec2 u_xlat16_21;
float u_xlat27;
mediump float u_xlat16_27;
bool u_xlatb27;
float u_xlat29;
mediump float u_xlat16_29;
float u_xlat31;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_1);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_10.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_10.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = u_xlat16_10.xz * vec2(0.150000006, 0.150000006);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.300000012, 1.0, 0.300000012);
    u_xlat16_21.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_21.x = inversesqrt(u_xlat16_21.x);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_21.xxx;
    u_xlat16_21.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat27 = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
    u_xlat27 = _ZBufferParams.z * u_xlat27 + _ZBufferParams.w;
    u_xlat27 = float(1.0) / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<_EnableRefractions);
#else
    u_xlatb2 = 0.00999999978<_EnableRefractions;
#endif
    if(u_xlatb2){
        u_xlat2.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat2.x = sqrt(u_xlat2.x);
        u_xlat2.x = u_xlat2.x + (-_UV_Mix_Start_Distance);
        u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.w;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat16_21.x = u_xlat2.x * u_xlat2.x;
        u_xlat16_21.x = u_xlat16_21.x * u_xlat16_21.x;
        u_xlat2.x = _Refraction * -0.75;
        u_xlat2.x = u_xlat16_21.x * u_xlat2.x + _Refraction;
        u_xlat11.x = float(1.0) / vs_TEXCOORD6.w;
        u_xlat20.x = u_xlat11.x * vs_TEXCOORD6.z;
        u_xlat20.x = u_xlat20.x * 0.5 + 0.5;
        u_xlat16_21.xy = u_xlat2.xx * u_xlat16_3.xy;
        u_xlat2.x = u_xlat11.x * 4.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat2.xy = u_xlat2.xx * u_xlat16_21.xy;
        u_xlat4.xy = u_xlat2.xy * vs_TEXCOORD6.ww;
        u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD6.ww + vs_TEXCOORD6.xy;
        u_xlat29 = vs_TEXCOORD6.w;
        u_xlat16_21.xy = u_xlat2.xy / vec2(u_xlat29);
        u_xlat2.x = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(u_xlat2.x>=u_xlat20.x);
#else
        u_xlatb2 = u_xlat2.x>=u_xlat20.x;
#endif
        u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
        u_xlat16_5.xy = u_xlat2.xx * u_xlat4.xy;
        u_xlat16_5.z = 0.0;
        u_xlat2.xyz = u_xlat16_5.xyz + vs_TEXCOORD6.xyw;
        u_xlat16_21.xy = u_xlat2.xy / u_xlat2.zz;
        u_xlat10_2.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_21.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_2.xyz;
    } else {
        u_xlat16_5.xyz = _MainColor.xyz;
    //ENDIF
    }
    u_xlat27 = u_xlat27 + (-vs_TEXCOORD6.w);
    u_xlat2.x = u_xlat27 * vs_TEXCOORD8.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _ShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat11.xy = vec2(u_xlat27) * vec2(0.0500000007, -0.5);
    u_xlat11.x = u_xlat11.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat11.yyy * vs_TEXCOORD8.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_Fade);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat16_5.xyz * u_xlat4.xyz + _DeepWaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat16_21.x = dot((-u_xlat0.xyz), vs_TEXCOORD5.xyz);
    u_xlat16_21.x = u_xlat16_21.x + u_xlat16_21.x;
    u_xlat16_5.xyz = vs_TEXCOORD5.xyz * (-u_xlat16_21.xxx) + (-u_xlat0.xyz);
    u_xlat20.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion));
    u_xlat20.xy = u_xlat20.xy * vs_TEXCOORD6.ww;
    u_xlat20.xy = u_xlat11.xx * u_xlat20.xy;
    u_xlat20.xy = u_xlat20.xy * vec2(0.5, 0.5);
    u_xlat31 = vs_TEXCOORD6.w * _ProjectionParams.w;
    u_xlat31 = u_xlat31 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat20.xy = vec2(u_xlat31) * (-u_xlat20.xy) + u_xlat20.xy;
    u_xlat20.xy = u_xlat20.xy + vs_TEXCOORD6.xy;
    u_xlat16_21.xy = u_xlat20.xy / vs_TEXCOORD6.ww;
    u_xlat10_6 = texture(_SSRTexture, u_xlat16_21.xy);
    u_xlat7.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion)) + u_xlat16_5.xy;
    u_xlat7.z = u_xlat16_5.z;
    u_xlat10_3 = texture(_ReflectionSkyCubeMap, u_xlat7.xyz);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = _ReflectionSkyCubeMap_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.x;
    u_xlat16_14.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat16_8 = u_xlat10_6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat2.z = u_xlat16_1 * 0.00499999989;
    u_xlat2.xz = min(u_xlat2.xz, vec2(1.0, 1.0));
    u_xlat20.x = (-u_xlat2.z) * 0.800000012 + 1.0;
    u_xlat20.x = u_xlat20.x * u_xlat16_8;
    u_xlat16_6.xyz = (-u_xlat16_5.xxx) * u_xlat10_3.xyz + u_xlat10_6.xyz;
    u_xlat6.xyz = u_xlat20.xxx * u_xlat16_6.xyz + u_xlat16_14.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_20 = (-u_xlat16_1) + 1.0;
    u_xlat16_29 = u_xlat16_20 * u_xlat16_20;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_20 = u_xlat16_20 * u_xlat16_29;
    u_xlat29 = (-_FresnelBias) + 1.0;
    u_xlat20.x = u_xlat29 * u_xlat16_20 + _FresnelBias;
    u_xlat20.x = u_xlat20.x * _ReflectionIntensity;
    u_xlat11.x = u_xlat11.x * u_xlat20.x;
    u_xlat6.xyz = (-u_xlat4.xyz) + u_xlat6.xyz;
    u_xlat11.xyz = u_xlat11.xxx * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat27 = u_xlat27 * vs_TEXCOORD9.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10_4 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = (-u_xlat27) + 1.0;
    u_xlat16_27 = u_xlat16_1 * u_xlat10_4;
    u_xlat27 = u_xlat2.x * u_xlat16_27;
    u_xlat4.xyz = (-u_xlat11.xyz) + vs_TEXCOORD9.xyz;
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat4.xyz + u_xlat11.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0<_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0<_ES_SunDirection.xxyz.z;
#endif
    u_xlat16_1 = _Gloss * 20.3718395 + 0.318309993;
    u_xlat0.xyz = vec3(u_xlat0.x + _ES_SunDirection.xxyz.y, u_xlat0.y + _ES_SunDirection.xxyz.z, u_xlat0.z + float(_ES_SunDirection.z));
    u_xlat4.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xxx;
    u_xlat16_10.x = dot(u_xlat16_10.xyz, u_xlat0.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 9.99999975e-05);
    u_xlat16_19 = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_0 = log2(u_xlat16_10.x);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_19;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat16_0 * u_xlat16_1;
    u_xlat0.x = u_xlatb27 ? u_xlat0.x : float(0.0);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat0.x = u_xlat0.x * 0.200000003;
    u_xlat16_1 = max(u_xlat0.x, 0.0);
    u_xlat16_1 = min(u_xlat16_1, 16.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * _LightColor0.xyz + u_xlat11.xyz;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "WATER_SHORE_FOAM" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	float _TimeEditor;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _MainColor;
uniform 	float _Density;
uniform 	float _ShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
uniform 	vec4 _FoamParams;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
vec2 u_xlat12;
vec2 u_xlat14;
float u_xlat18;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].x;
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat6.x);
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].z;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].z;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].z;
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.y = sqrt(u_xlat6.x);
    u_xlat6.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat2.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat18 = _Time.y + _TimeEditor;
    u_xlat18 = u_xlat18 * 0.100000001;
    u_xlat14.xy = vec2(float(u_xlat18) * _ShoreFoamParams.z, float(u_xlat18) * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat2.xy * u_xlat6.xy + u_xlat14.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat6.xy * _SmallWavesParams.xy;
    u_xlat16_3.xy = u_xlat2.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat14.xy = vec2(float(u_xlat18) * _SmallWavesParams.z, float(u_xlat18) * _SmallWavesParams.w);
    u_xlat16_3.zw = u_xlat14.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat2.xy + u_xlat14.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat2.xy = u_xlat6.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat2.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat14.xy = vec2(float(u_xlat18) * _LargeWavesParams.z, float(u_xlat18) * _LargeWavesParams.w);
    u_xlat4.xy = vec2(float(u_xlat18) * _FoamParams.z, float(u_xlat18) * _FoamParams.w);
    u_xlat16_3.zw = u_xlat14.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat2.xy + u_xlat14.xy;
    vs_TEXCOORD2 = u_xlat16_3;
    u_xlat2.xy = in_TEXCOORD0.xy * _FoamParams.xy;
    u_xlat14.xy = u_xlat6.xy * u_xlat2.xy;
    u_xlat16_3.xy = u_xlat2.xy * u_xlat6.xy + u_xlat4.xy;
    u_xlat16_5.xy = u_xlat14.xy + u_xlat14.xy;
    u_xlat16_3.zw = u_xlat4.xy * vec2(1.5, 1.5) + u_xlat16_5.xy;
    vs_TEXCOORD3 = u_xlat16_3;
    vs_TEXCOORD4.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0.x = 10.0 / _Density;
    u_xlat0.xyz = u_xlat0.xxx * _MainColor.xyz;
    vs_TEXCOORD8.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD8.w = float(1.0) / _ShoreTransparency;
    vs_TEXCOORD9.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD9.w = float(1.0) / _ShoreFoamDepth;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _LightColor0;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _MainColor;
uniform 	vec4 _DeepWaterColor;
uniform 	float _Fade;
uniform 	float _FresnelBias;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	float _ShoreFade;
uniform 	float _EnableRefractions;
uniform 	float _Refraction;
uniform 	float _ReflectionIntensity;
uniform 	float _Distortion;
uniform 	vec4 _ReflectionSkyCubeMap_HDR;
uniform 	vec3 _ES_SunDirection;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _SSRTexture;
uniform lowp samplerCube _ReflectionSkyCubeMap;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_19;
vec2 u_xlat20;
mediump float u_xlat16_20;
mediump vec2 u_xlat16_21;
float u_xlat27;
mediump float u_xlat16_27;
bool u_xlatb27;
float u_xlat29;
mediump float u_xlat16_29;
float u_xlat31;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_1);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_10.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_10.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = u_xlat16_10.xz * vec2(0.150000006, 0.150000006);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.300000012, 1.0, 0.300000012);
    u_xlat16_21.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_21.x = inversesqrt(u_xlat16_21.x);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_21.xxx;
    u_xlat16_21.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat27 = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
    u_xlat27 = _ZBufferParams.z * u_xlat27 + _ZBufferParams.w;
    u_xlat27 = float(1.0) / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<_EnableRefractions);
#else
    u_xlatb2 = 0.00999999978<_EnableRefractions;
#endif
    if(u_xlatb2){
        u_xlat2.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat2.x = sqrt(u_xlat2.x);
        u_xlat2.x = u_xlat2.x + (-_UV_Mix_Start_Distance);
        u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.w;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat16_21.x = u_xlat2.x * u_xlat2.x;
        u_xlat16_21.x = u_xlat16_21.x * u_xlat16_21.x;
        u_xlat2.x = _Refraction * -0.75;
        u_xlat2.x = u_xlat16_21.x * u_xlat2.x + _Refraction;
        u_xlat11.x = float(1.0) / vs_TEXCOORD6.w;
        u_xlat20.x = u_xlat11.x * vs_TEXCOORD6.z;
        u_xlat20.x = u_xlat20.x * 0.5 + 0.5;
        u_xlat16_21.xy = u_xlat2.xx * u_xlat16_3.xy;
        u_xlat2.x = u_xlat11.x * 4.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat2.xy = u_xlat2.xx * u_xlat16_21.xy;
        u_xlat4.xy = u_xlat2.xy * vs_TEXCOORD6.ww;
        u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD6.ww + vs_TEXCOORD6.xy;
        u_xlat29 = vs_TEXCOORD6.w;
        u_xlat16_21.xy = u_xlat2.xy / vec2(u_xlat29);
        u_xlat2.x = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(u_xlat2.x>=u_xlat20.x);
#else
        u_xlatb2 = u_xlat2.x>=u_xlat20.x;
#endif
        u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
        u_xlat16_5.xy = u_xlat2.xx * u_xlat4.xy;
        u_xlat16_5.z = 0.0;
        u_xlat2.xyz = u_xlat16_5.xyz + vs_TEXCOORD6.xyw;
        u_xlat16_21.xy = u_xlat2.xy / u_xlat2.zz;
        u_xlat10_2.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_21.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_2.xyz;
    } else {
        u_xlat16_5.xyz = _MainColor.xyz;
    //ENDIF
    }
    u_xlat27 = u_xlat27 + (-vs_TEXCOORD6.w);
    u_xlat2.x = u_xlat27 * vs_TEXCOORD8.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _ShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat11.xy = vec2(u_xlat27) * vec2(0.0500000007, -0.5);
    u_xlat11.x = u_xlat11.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat11.yyy * vs_TEXCOORD8.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_Fade);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat16_5.xyz * u_xlat4.xyz + _DeepWaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat16_21.x = dot((-u_xlat0.xyz), vs_TEXCOORD5.xyz);
    u_xlat16_21.x = u_xlat16_21.x + u_xlat16_21.x;
    u_xlat16_5.xyz = vs_TEXCOORD5.xyz * (-u_xlat16_21.xxx) + (-u_xlat0.xyz);
    u_xlat20.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion));
    u_xlat20.xy = u_xlat20.xy * vs_TEXCOORD6.ww;
    u_xlat20.xy = u_xlat11.xx * u_xlat20.xy;
    u_xlat20.xy = u_xlat20.xy * vec2(0.5, 0.5);
    u_xlat31 = vs_TEXCOORD6.w * _ProjectionParams.w;
    u_xlat31 = u_xlat31 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat20.xy = vec2(u_xlat31) * (-u_xlat20.xy) + u_xlat20.xy;
    u_xlat20.xy = u_xlat20.xy + vs_TEXCOORD6.xy;
    u_xlat16_21.xy = u_xlat20.xy / vs_TEXCOORD6.ww;
    u_xlat10_6 = texture(_SSRTexture, u_xlat16_21.xy);
    u_xlat7.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion)) + u_xlat16_5.xy;
    u_xlat7.z = u_xlat16_5.z;
    u_xlat10_3 = texture(_ReflectionSkyCubeMap, u_xlat7.xyz);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = _ReflectionSkyCubeMap_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.x;
    u_xlat16_14.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat16_8 = u_xlat10_6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat2.z = u_xlat16_1 * 0.00499999989;
    u_xlat2.xz = min(u_xlat2.xz, vec2(1.0, 1.0));
    u_xlat20.x = (-u_xlat2.z) * 0.800000012 + 1.0;
    u_xlat20.x = u_xlat20.x * u_xlat16_8;
    u_xlat16_6.xyz = (-u_xlat16_5.xxx) * u_xlat10_3.xyz + u_xlat10_6.xyz;
    u_xlat6.xyz = u_xlat20.xxx * u_xlat16_6.xyz + u_xlat16_14.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_20 = (-u_xlat16_1) + 1.0;
    u_xlat16_29 = u_xlat16_20 * u_xlat16_20;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_20 = u_xlat16_20 * u_xlat16_29;
    u_xlat29 = (-_FresnelBias) + 1.0;
    u_xlat20.x = u_xlat29 * u_xlat16_20 + _FresnelBias;
    u_xlat20.x = u_xlat20.x * _ReflectionIntensity;
    u_xlat11.x = u_xlat11.x * u_xlat20.x;
    u_xlat6.xyz = (-u_xlat4.xyz) + u_xlat6.xyz;
    u_xlat11.xyz = u_xlat11.xxx * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat27 = u_xlat27 * vs_TEXCOORD9.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10_4 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = (-u_xlat27) + 1.0;
    u_xlat16_27 = u_xlat16_1 * u_xlat10_4;
    u_xlat27 = u_xlat2.x * u_xlat16_27;
    u_xlat4.xyz = (-u_xlat11.xyz) + vs_TEXCOORD9.xyz;
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat4.xyz + u_xlat11.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0<_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0<_ES_SunDirection.xxyz.z;
#endif
    u_xlat16_1 = _Gloss * 20.3718395 + 0.318309993;
    u_xlat0.xyz = vec3(u_xlat0.x + _ES_SunDirection.xxyz.y, u_xlat0.y + _ES_SunDirection.xxyz.z, u_xlat0.z + float(_ES_SunDirection.z));
    u_xlat4.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xxx;
    u_xlat16_10.x = dot(u_xlat16_10.xyz, u_xlat0.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 9.99999975e-05);
    u_xlat16_19 = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_0 = log2(u_xlat16_10.x);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_19;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat16_0 * u_xlat16_1;
    u_xlat0.x = u_xlatb27 ? u_xlat0.x : float(0.0);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat0.x = u_xlat0.x * 0.200000003;
    u_xlat16_1 = max(u_xlat0.x, 0.0);
    u_xlat16_1 = min(u_xlat16_1, 16.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * _LightColor0.xyz + u_xlat11.xyz;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "WATER_FOAM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	float _TimeEditor;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _MainColor;
uniform 	float _Density;
uniform 	float _ShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
uniform 	vec4 _FoamParams;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
vec2 u_xlat9;
float u_xlat14;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9.x = sqrt(u_xlat1.x);
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9.y = sqrt(u_xlat1.x);
    u_xlat1.xy = vec2(0.100000001, 0.100000001) / u_xlat9.xy;
    u_xlat9.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat2.x = _Time.y + _TimeEditor;
    u_xlat2.x = u_xlat2.x * 0.100000001;
    u_xlat6.xy = vec2(u_xlat2.x * _ShoreFoamParams.z, u_xlat2.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat9.xy * u_xlat1.xy + u_xlat6.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat9.xy = u_xlat1.xy * _SmallWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _SmallWavesParams.z, u_xlat2.x * _SmallWavesParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat9.xy = u_xlat1.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat9.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat6.xy = vec2(u_xlat2.x * _LargeWavesParams.z, u_xlat2.x * _LargeWavesParams.w);
    u_xlat2.xw = vec2(u_xlat2.x * _FoamParams.z, u_xlat2.x * _FoamParams.w);
    u_xlat16_3.zw = u_xlat6.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat9.xy + u_xlat6.xy;
    vs_TEXCOORD2 = u_xlat16_3;
    u_xlat9.xy = in_TEXCOORD0.xy * _FoamParams.xy;
    u_xlat6.xy = u_xlat1.xy * u_xlat9.xy;
    u_xlat16_1.xy = u_xlat9.xy * u_xlat1.xy + u_xlat2.xw;
    u_xlat16_3.xy = u_xlat6.xy + u_xlat6.xy;
    u_xlat16_1.zw = u_xlat2.xw * vec2(1.5, 1.5) + u_xlat16_3.xy;
    vs_TEXCOORD3 = u_xlat16_1;
    vs_TEXCOORD4.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    vs_TEXCOORD5.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat0.zw;
    vs_TEXCOORD6.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.x = 10.0 / _Density;
    u_xlat0.xyz = u_xlat0.xxx * _MainColor.xyz;
    vs_TEXCOORD8.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD8.w = float(1.0) / _ShoreTransparency;
    vs_TEXCOORD9.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD9.w = float(1.0) / _ShoreFoamDepth;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _LightColor0;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _MainColor;
uniform 	vec4 _DeepWaterColor;
uniform 	float _Fade;
uniform 	float _FresnelBias;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	float _ShoreFade;
uniform 	float _EnableRefractions;
uniform 	float _Refraction;
uniform 	float _ReflectionIntensity;
uniform 	float _Distortion;
uniform 	vec4 _ReflectionSkyCubeMap_HDR;
uniform 	vec3 _ES_SunDirection;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _SSRTexture;
uniform lowp samplerCube _ReflectionSkyCubeMap;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_19;
vec2 u_xlat20;
mediump float u_xlat16_20;
mediump vec2 u_xlat16_21;
float u_xlat27;
mediump float u_xlat16_27;
bool u_xlatb27;
float u_xlat29;
mediump float u_xlat16_29;
float u_xlat31;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_1);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_10.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_10.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = u_xlat16_10.xz * vec2(0.150000006, 0.150000006);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.300000012, 1.0, 0.300000012);
    u_xlat16_21.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_21.x = inversesqrt(u_xlat16_21.x);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_21.xxx;
    u_xlat16_21.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat27 = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
    u_xlat27 = _ZBufferParams.z * u_xlat27 + _ZBufferParams.w;
    u_xlat27 = float(1.0) / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<_EnableRefractions);
#else
    u_xlatb2 = 0.00999999978<_EnableRefractions;
#endif
    if(u_xlatb2){
        u_xlat2.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat2.x = sqrt(u_xlat2.x);
        u_xlat2.x = u_xlat2.x + (-_UV_Mix_Start_Distance);
        u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.w;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat16_21.x = u_xlat2.x * u_xlat2.x;
        u_xlat16_21.x = u_xlat16_21.x * u_xlat16_21.x;
        u_xlat2.x = _Refraction * -0.75;
        u_xlat2.x = u_xlat16_21.x * u_xlat2.x + _Refraction;
        u_xlat11.x = float(1.0) / vs_TEXCOORD6.w;
        u_xlat20.x = u_xlat11.x * vs_TEXCOORD6.z;
        u_xlat20.x = u_xlat20.x * 0.5 + 0.5;
        u_xlat16_21.xy = u_xlat2.xx * u_xlat16_3.xy;
        u_xlat2.x = u_xlat11.x * 4.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat2.xy = u_xlat2.xx * u_xlat16_21.xy;
        u_xlat4.xy = u_xlat2.xy * vs_TEXCOORD6.ww;
        u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD6.ww + vs_TEXCOORD6.xy;
        u_xlat29 = vs_TEXCOORD6.w;
        u_xlat16_21.xy = u_xlat2.xy / vec2(u_xlat29);
        u_xlat2.x = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(u_xlat2.x>=u_xlat20.x);
#else
        u_xlatb2 = u_xlat2.x>=u_xlat20.x;
#endif
        u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
        u_xlat16_5.xy = u_xlat2.xx * u_xlat4.xy;
        u_xlat16_5.z = 0.0;
        u_xlat2.xyz = u_xlat16_5.xyz + vs_TEXCOORD6.xyw;
        u_xlat16_21.xy = u_xlat2.xy / u_xlat2.zz;
        u_xlat10_2.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_21.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_2.xyz;
    } else {
        u_xlat16_5.xyz = _MainColor.xyz;
    //ENDIF
    }
    u_xlat27 = u_xlat27 + (-vs_TEXCOORD6.w);
    u_xlat2.x = u_xlat27 * vs_TEXCOORD8.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _ShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat11.xy = vec2(u_xlat27) * vec2(0.0500000007, -0.5);
    u_xlat11.x = u_xlat11.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat11.yyy * vs_TEXCOORD8.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_Fade);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat16_5.xyz * u_xlat4.xyz + _DeepWaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat16_21.x = dot((-u_xlat0.xyz), vs_TEXCOORD5.xyz);
    u_xlat16_21.x = u_xlat16_21.x + u_xlat16_21.x;
    u_xlat16_5.xyz = vs_TEXCOORD5.xyz * (-u_xlat16_21.xxx) + (-u_xlat0.xyz);
    u_xlat20.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion));
    u_xlat20.xy = u_xlat20.xy * vs_TEXCOORD6.ww;
    u_xlat20.xy = u_xlat11.xx * u_xlat20.xy;
    u_xlat20.xy = u_xlat20.xy * vec2(0.5, 0.5);
    u_xlat31 = vs_TEXCOORD6.w * _ProjectionParams.w;
    u_xlat31 = u_xlat31 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat20.xy = vec2(u_xlat31) * (-u_xlat20.xy) + u_xlat20.xy;
    u_xlat20.xy = u_xlat20.xy + vs_TEXCOORD6.xy;
    u_xlat16_21.xy = u_xlat20.xy / vs_TEXCOORD6.ww;
    u_xlat10_6 = texture(_SSRTexture, u_xlat16_21.xy);
    u_xlat7.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion)) + u_xlat16_5.xy;
    u_xlat7.z = u_xlat16_5.z;
    u_xlat10_3 = texture(_ReflectionSkyCubeMap, u_xlat7.xyz);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = _ReflectionSkyCubeMap_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.x;
    u_xlat16_14.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat16_8 = u_xlat10_6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat2.z = u_xlat16_1 * 0.00499999989;
    u_xlat2.xz = min(u_xlat2.xz, vec2(1.0, 1.0));
    u_xlat20.x = (-u_xlat2.z) * 0.800000012 + 1.0;
    u_xlat20.x = u_xlat20.x * u_xlat16_8;
    u_xlat16_6.xyz = (-u_xlat16_5.xxx) * u_xlat10_3.xyz + u_xlat10_6.xyz;
    u_xlat6.xyz = u_xlat20.xxx * u_xlat16_6.xyz + u_xlat16_14.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_20 = (-u_xlat16_1) + 1.0;
    u_xlat16_29 = u_xlat16_20 * u_xlat16_20;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_20 = u_xlat16_20 * u_xlat16_29;
    u_xlat29 = (-_FresnelBias) + 1.0;
    u_xlat20.x = u_xlat29 * u_xlat16_20 + _FresnelBias;
    u_xlat20.x = u_xlat20.x * _ReflectionIntensity;
    u_xlat11.x = u_xlat11.x * u_xlat20.x;
    u_xlat6.xyz = (-u_xlat4.xyz) + u_xlat6.xyz;
    u_xlat11.xyz = u_xlat11.xxx * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat27 = u_xlat27 * vs_TEXCOORD9.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10_4 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = (-u_xlat27) + 1.0;
    u_xlat16_27 = u_xlat16_1 * u_xlat10_4;
    u_xlat27 = u_xlat2.x * u_xlat16_27;
    u_xlat4.xyz = (-u_xlat11.xyz) + vs_TEXCOORD9.xyz;
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat4.xyz + u_xlat11.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0<_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0<_ES_SunDirection.xxyz.z;
#endif
    u_xlat16_1 = _Gloss * 20.3718395 + 0.318309993;
    u_xlat0.xyz = vec3(u_xlat0.x + _ES_SunDirection.xxyz.y, u_xlat0.y + _ES_SunDirection.xxyz.z, u_xlat0.z + float(_ES_SunDirection.z));
    u_xlat4.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xxx;
    u_xlat16_10.x = dot(u_xlat16_10.xyz, u_xlat0.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 9.99999975e-05);
    u_xlat16_19 = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_0 = log2(u_xlat16_10.x);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_19;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat16_0 * u_xlat16_1;
    u_xlat0.x = u_xlatb27 ? u_xlat0.x : float(0.0);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat0.x = u_xlat0.x * 0.200000003;
    u_xlat16_1 = max(u_xlat0.x, 0.0);
    u_xlat16_1 = min(u_xlat16_1, 16.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * _LightColor0.xyz + u_xlat11.xyz;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "WATER_FOAM" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	float _TimeEditor;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _MainColor;
uniform 	float _Density;
uniform 	float _ShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
uniform 	vec4 _FoamParams;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
vec2 u_xlat12;
vec2 u_xlat14;
float u_xlat18;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].x;
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.x = sqrt(u_xlat6.x);
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].z;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].z;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].z;
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12.y = sqrt(u_xlat6.x);
    u_xlat6.xy = vec2(0.100000001, 0.100000001) / u_xlat12.xy;
    u_xlat2.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat18 = _Time.y + _TimeEditor;
    u_xlat18 = u_xlat18 * 0.100000001;
    u_xlat14.xy = vec2(float(u_xlat18) * _ShoreFoamParams.z, float(u_xlat18) * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat2.xy * u_xlat6.xy + u_xlat14.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.xy = u_xlat6.xy * _SmallWavesParams.xy;
    u_xlat16_3.xy = u_xlat2.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat14.xy = vec2(float(u_xlat18) * _SmallWavesParams.z, float(u_xlat18) * _SmallWavesParams.w);
    u_xlat16_3.zw = u_xlat14.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat2.xy + u_xlat14.xy;
    vs_TEXCOORD1 = u_xlat16_3;
    u_xlat2.xy = u_xlat6.xy * _LargeWavesParams.xy;
    u_xlat16_3.xy = u_xlat2.xy * in_TEXCOORD0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat14.xy = vec2(float(u_xlat18) * _LargeWavesParams.z, float(u_xlat18) * _LargeWavesParams.w);
    u_xlat4.xy = vec2(float(u_xlat18) * _FoamParams.z, float(u_xlat18) * _FoamParams.w);
    u_xlat16_3.zw = u_xlat14.xy * vec2(1.5, 1.5) + u_xlat16_3.xy;
    u_xlat16_3.xy = in_TEXCOORD0.xy * u_xlat2.xy + u_xlat14.xy;
    vs_TEXCOORD2 = u_xlat16_3;
    u_xlat2.xy = in_TEXCOORD0.xy * _FoamParams.xy;
    u_xlat14.xy = u_xlat6.xy * u_xlat2.xy;
    u_xlat16_3.xy = u_xlat2.xy * u_xlat6.xy + u_xlat4.xy;
    u_xlat16_5.xy = u_xlat14.xy + u_xlat14.xy;
    u_xlat16_3.zw = u_xlat4.xy * vec2(1.5, 1.5) + u_xlat16_5.xy;
    vs_TEXCOORD3 = u_xlat16_3;
    vs_TEXCOORD4.w = float(1.0) / _UV_Mix_Range;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0.x = 10.0 / _Density;
    u_xlat0.xyz = u_xlat0.xxx * _MainColor.xyz;
    vs_TEXCOORD8.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD8.w = float(1.0) / _ShoreTransparency;
    vs_TEXCOORD9.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD9.w = float(1.0) / _ShoreFoamDepth;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _LightColor0;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _MainColor;
uniform 	vec4 _DeepWaterColor;
uniform 	float _Fade;
uniform 	float _FresnelBias;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	float _ShoreFade;
uniform 	float _EnableRefractions;
uniform 	float _Refraction;
uniform 	float _ReflectionIntensity;
uniform 	float _Distortion;
uniform 	vec4 _ReflectionSkyCubeMap_HDR;
uniform 	vec3 _ES_SunDirection;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _SSRTexture;
uniform lowp samplerCube _ReflectionSkyCubeMap;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_19;
vec2 u_xlat20;
mediump float u_xlat16_20;
mediump vec2 u_xlat16_21;
float u_xlat27;
mediump float u_xlat16_27;
bool u_xlatb27;
float u_xlat29;
mediump float u_xlat16_29;
float u_xlat31;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat0.xyz = u_xlat0.xyz / vec3(u_xlat16_1);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_10.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_10.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = u_xlat16_10.xz * vec2(0.150000006, 0.150000006);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.300000012, 1.0, 0.300000012);
    u_xlat16_21.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_21.x = inversesqrt(u_xlat16_21.x);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_21.xxx;
    u_xlat16_21.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat27 = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
    u_xlat27 = _ZBufferParams.z * u_xlat27 + _ZBufferParams.w;
    u_xlat27 = float(1.0) / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<_EnableRefractions);
#else
    u_xlatb2 = 0.00999999978<_EnableRefractions;
#endif
    if(u_xlatb2){
        u_xlat2.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat2.x = sqrt(u_xlat2.x);
        u_xlat2.x = u_xlat2.x + (-_UV_Mix_Start_Distance);
        u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.w;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat16_21.x = u_xlat2.x * u_xlat2.x;
        u_xlat16_21.x = u_xlat16_21.x * u_xlat16_21.x;
        u_xlat2.x = _Refraction * -0.75;
        u_xlat2.x = u_xlat16_21.x * u_xlat2.x + _Refraction;
        u_xlat11.x = float(1.0) / vs_TEXCOORD6.w;
        u_xlat20.x = u_xlat11.x * vs_TEXCOORD6.z;
        u_xlat20.x = u_xlat20.x * 0.5 + 0.5;
        u_xlat16_21.xy = u_xlat2.xx * u_xlat16_3.xy;
        u_xlat2.x = u_xlat11.x * 4.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat2.xy = u_xlat2.xx * u_xlat16_21.xy;
        u_xlat4.xy = u_xlat2.xy * vs_TEXCOORD6.ww;
        u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD6.ww + vs_TEXCOORD6.xy;
        u_xlat29 = vs_TEXCOORD6.w;
        u_xlat16_21.xy = u_xlat2.xy / vec2(u_xlat29);
        u_xlat2.x = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(u_xlat2.x>=u_xlat20.x);
#else
        u_xlatb2 = u_xlat2.x>=u_xlat20.x;
#endif
        u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
        u_xlat16_5.xy = u_xlat2.xx * u_xlat4.xy;
        u_xlat16_5.z = 0.0;
        u_xlat2.xyz = u_xlat16_5.xyz + vs_TEXCOORD6.xyw;
        u_xlat16_21.xy = u_xlat2.xy / u_xlat2.zz;
        u_xlat10_2.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_21.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_2.xyz;
    } else {
        u_xlat16_5.xyz = _MainColor.xyz;
    //ENDIF
    }
    u_xlat27 = u_xlat27 + (-vs_TEXCOORD6.w);
    u_xlat2.x = u_xlat27 * vs_TEXCOORD8.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _ShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat11.xy = vec2(u_xlat27) * vec2(0.0500000007, -0.5);
    u_xlat11.x = u_xlat11.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat11.yyy * vs_TEXCOORD8.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_Fade);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat16_5.xyz * u_xlat4.xyz + _DeepWaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xyz = min(max(u_xlat4.xyz, 0.0), 1.0);
#else
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
#endif
    u_xlat16_21.x = dot((-u_xlat0.xyz), vs_TEXCOORD5.xyz);
    u_xlat16_21.x = u_xlat16_21.x + u_xlat16_21.x;
    u_xlat16_5.xyz = vs_TEXCOORD5.xyz * (-u_xlat16_21.xxx) + (-u_xlat0.xyz);
    u_xlat20.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion));
    u_xlat20.xy = u_xlat20.xy * vs_TEXCOORD6.ww;
    u_xlat20.xy = u_xlat11.xx * u_xlat20.xy;
    u_xlat20.xy = u_xlat20.xy * vec2(0.5, 0.5);
    u_xlat31 = vs_TEXCOORD6.w * _ProjectionParams.w;
    u_xlat31 = u_xlat31 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat20.xy = vec2(u_xlat31) * (-u_xlat20.xy) + u_xlat20.xy;
    u_xlat20.xy = u_xlat20.xy + vs_TEXCOORD6.xy;
    u_xlat16_21.xy = u_xlat20.xy / vs_TEXCOORD6.ww;
    u_xlat10_6 = texture(_SSRTexture, u_xlat16_21.xy);
    u_xlat7.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion)) + u_xlat16_5.xy;
    u_xlat7.z = u_xlat16_5.z;
    u_xlat10_3 = texture(_ReflectionSkyCubeMap, u_xlat7.xyz);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = _ReflectionSkyCubeMap_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.x;
    u_xlat16_14.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat16_8 = u_xlat10_6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat2.z = u_xlat16_1 * 0.00499999989;
    u_xlat2.xz = min(u_xlat2.xz, vec2(1.0, 1.0));
    u_xlat20.x = (-u_xlat2.z) * 0.800000012 + 1.0;
    u_xlat20.x = u_xlat20.x * u_xlat16_8;
    u_xlat16_6.xyz = (-u_xlat16_5.xxx) * u_xlat10_3.xyz + u_xlat10_6.xyz;
    u_xlat6.xyz = u_xlat20.xxx * u_xlat16_6.xyz + u_xlat16_14.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_20 = (-u_xlat16_1) + 1.0;
    u_xlat16_29 = u_xlat16_20 * u_xlat16_20;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_20 = u_xlat16_20 * u_xlat16_29;
    u_xlat29 = (-_FresnelBias) + 1.0;
    u_xlat20.x = u_xlat29 * u_xlat16_20 + _FresnelBias;
    u_xlat20.x = u_xlat20.x * _ReflectionIntensity;
    u_xlat11.x = u_xlat11.x * u_xlat20.x;
    u_xlat6.xyz = (-u_xlat4.xyz) + u_xlat6.xyz;
    u_xlat11.xyz = u_xlat11.xxx * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat27 = u_xlat27 * vs_TEXCOORD9.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10_4 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1 = (-u_xlat27) + 1.0;
    u_xlat16_27 = u_xlat16_1 * u_xlat10_4;
    u_xlat27 = u_xlat2.x * u_xlat16_27;
    u_xlat4.xyz = (-u_xlat11.xyz) + vs_TEXCOORD9.xyz;
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat4.xyz + u_xlat11.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0<_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0<_ES_SunDirection.xxyz.z;
#endif
    u_xlat16_1 = _Gloss * 20.3718395 + 0.318309993;
    u_xlat0.xyz = vec3(u_xlat0.x + _ES_SunDirection.xxyz.y, u_xlat0.y + _ES_SunDirection.xxyz.z, u_xlat0.z + float(_ES_SunDirection.z));
    u_xlat4.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xxx;
    u_xlat16_10.x = dot(u_xlat16_10.xyz, u_xlat0.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 9.99999975e-05);
    u_xlat16_19 = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_0 = log2(u_xlat16_10.x);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_19;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat16_0 * u_xlat16_1;
    u_xlat0.x = u_xlatb27 ? u_xlat0.x : float(0.0);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat0.x = u_xlat0.x * 0.200000003;
    u_xlat16_1 = max(u_xlat0.x, 0.0);
    u_xlat16_1 = min(u_xlat16_1, 16.0);
    SV_Target0.xyz = vec3(u_xlat16_1) * _LightColor0.xyz + u_xlat11.xyz;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "WATER_REFRACTIVE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	float _TimeEditor;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _MainColor;
uniform 	float _Density;
uniform 	float _ShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
uniform 	vec4 _FoamParams;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_11;
float u_xlat14;
float u_xlat15;
vec2 u_xlat16;
vec2 u_xlat17;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16.x = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16.y = sqrt(u_xlat21);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat16.xy;
    u_xlat16.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat21 = _Time.y + _TimeEditor;
    u_xlat21 = u_xlat21 * 0.100000001;
    u_xlat3.xy = vec2(float(u_xlat21) * _ShoreFoamParams.z, float(u_xlat21) * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat16.xy * u_xlat2.xy + u_xlat3.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat16_4.xy = u_xlat16.xy * in_TEXCOORD0.xy;
    u_xlat16_4.xy = u_xlat16_4.xy + u_xlat16_4.xy;
    u_xlat3.xy = vec2(float(u_xlat21) * _SmallWavesParams.z, float(u_xlat21) * _SmallWavesParams.w);
    u_xlat16_4.zw = u_xlat3.xy * vec2(1.5, 1.5) + u_xlat16_4.xy;
    u_xlat16_4.xy = in_TEXCOORD0.xy * u_xlat16.xy + u_xlat3.xy;
    vs_TEXCOORD1 = u_xlat16_4;
    u_xlat16.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat16_4.xy = u_xlat16.xy * in_TEXCOORD0.xy;
    u_xlat16_4.xy = u_xlat16_4.xy + u_xlat16_4.xy;
    u_xlat3.xy = vec2(float(u_xlat21) * _LargeWavesParams.z, float(u_xlat21) * _LargeWavesParams.w);
    u_xlat17.xy = vec2(float(u_xlat21) * _FoamParams.z, float(u_xlat21) * _FoamParams.w);
    u_xlat16_4.zw = u_xlat3.xy * vec2(1.5, 1.5) + u_xlat16_4.xy;
    u_xlat16_4.xy = in_TEXCOORD0.xy * u_xlat16.xy + u_xlat3.xy;
    vs_TEXCOORD2 = u_xlat16_4;
    u_xlat16.xy = in_TEXCOORD0.xy * _FoamParams.xy;
    u_xlat3.xy = u_xlat2.xy * u_xlat16.xy;
    u_xlat16_2.xy = u_xlat16.xy * u_xlat2.xy + u_xlat17.xy;
    u_xlat16_4.xy = u_xlat3.xy + u_xlat3.xy;
    u_xlat16_2.zw = u_xlat17.xy * vec2(1.5, 1.5) + u_xlat16_4.xy;
    vs_TEXCOORD3 = u_xlat16_2;
    vs_TEXCOORD4.w = float(1.0) / _UV_Mix_Range;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD5.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat21 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat21 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = u_xlat0.z * _HeigtFogParams.x;
    u_xlat8 = u_xlat1.x * -1.44269502;
    u_xlat8 = exp2(u_xlat8);
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat8 = u_xlat8 / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.00999999978<abs(u_xlat1.x));
#else
    u_xlatb1 = 0.00999999978<abs(u_xlat1.x);
#endif
    u_xlat16_4.x = (u_xlatb1) ? u_xlat8 : 1.0;
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat8 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat8 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat8 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat15 = u_xlat8 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_11 = (u_xlatb8) ? u_xlat15 : 1.0;
    u_xlat8 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_11 = u_xlat8 * u_xlat16_11;
    u_xlat16_11 = exp2((-u_xlat16_11));
    u_xlat16_4.y = (-u_xlat16_11) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat8 = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat8) + 2.0;
    u_xlat16_11 = u_xlat8 * u_xlat16_11;
    u_xlat8 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat8 = u_xlat8 + 1.0;
    u_xlat16_4.x = u_xlat8 * u_xlat16_4.x;
    u_xlat8 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat15 = (-u_xlat8) + 1.0;
    u_xlat22 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat7.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_4.x = (-u_xlat22) + 2.0;
    u_xlat16_4.x = u_xlat22 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7.x = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat1.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat7.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat6.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = (-u_xlat1.x) + 2.0;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat14 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat14 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD7.w = u_xlat15 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat7.xyz;
    vs_TEXCOORD7.xyz = u_xlat3.xyz * vec3(u_xlat8) + u_xlat0.xyz;
    u_xlat0.x = 10.0 / _Density;
    u_xlat0.xyz = u_xlat0.xxx * _MainColor.xyz;
    vs_TEXCOORD8.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD8.w = float(1.0) / _ShoreTransparency;
    vs_TEXCOORD9.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD9.w = float(1.0) / _ShoreFoamDepth;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _LightColor0;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _MainColor;
uniform 	vec4 _DeepWaterColor;
uniform 	float _Fade;
uniform 	float _FresnelBias;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	float _ShoreFade;
uniform 	float _EnableRefractions;
uniform 	float _Refraction;
uniform 	float _ReflectionIntensity;
uniform 	float _Distortion;
uniform 	vec4 _ReflectionSkyCubeMap_HDR;
uniform 	vec3 _ES_SunDirection;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _SSRTexture;
uniform lowp samplerCube _ReflectionSkyCubeMap;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump float u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_10;
float u_xlat11;
vec3 u_xlat13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_19;
float u_xlat20;
mediump vec2 u_xlat16_21;
float u_xlat24;
float u_xlat27;
mediump float u_xlat16_27;
bool u_xlatb27;
float u_xlat29;
float u_xlat31;
lowp float u_xlat10_31;
float u_xlat33;
mediump float u_xlat16_33;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_10.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_10.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = u_xlat16_10.xz * vec2(0.150000006, 0.150000006);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.300000012, 1.0, 0.300000012);
    u_xlat16_21.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_21.x = inversesqrt(u_xlat16_21.x);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_21.xxx;
    u_xlat16_21.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat27 = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
    u_xlat27 = _ZBufferParams.z * u_xlat27 + _ZBufferParams.w;
    u_xlat27 = float(1.0) / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<_EnableRefractions);
#else
    u_xlatb2 = 0.00999999978<_EnableRefractions;
#endif
    if(u_xlatb2){
        u_xlat2.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat2.x = sqrt(u_xlat2.x);
        u_xlat2.x = u_xlat2.x + (-_UV_Mix_Start_Distance);
        u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.w;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat16_21.x = u_xlat2.x * u_xlat2.x;
        u_xlat16_21.x = u_xlat16_21.x * u_xlat16_21.x;
        u_xlat2.x = _Refraction * -0.75;
        u_xlat2.x = u_xlat16_21.x * u_xlat2.x + _Refraction;
        u_xlat11 = float(1.0) / vs_TEXCOORD6.w;
        u_xlat20 = u_xlat11 * vs_TEXCOORD6.z;
        u_xlat20 = u_xlat20 * 0.5 + 0.5;
        u_xlat16_21.xy = u_xlat2.xx * u_xlat16_3.xy;
        u_xlat2.x = u_xlat11 * 4.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat2.xy = u_xlat2.xx * u_xlat16_21.xy;
        u_xlat4.xy = u_xlat2.xy * vs_TEXCOORD6.ww;
        u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD6.ww + vs_TEXCOORD6.xy;
        u_xlat29 = vs_TEXCOORD6.w;
        u_xlat16_21.xy = u_xlat2.xy / vec2(u_xlat29);
        u_xlat2.x = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(u_xlat2.x>=u_xlat20);
#else
        u_xlatb2 = u_xlat2.x>=u_xlat20;
#endif
        u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
        u_xlat16_5.xy = u_xlat2.xx * u_xlat4.xy;
        u_xlat16_5.z = 0.0;
        u_xlat2.xyz = u_xlat16_5.xyz + vs_TEXCOORD6.xyw;
        u_xlat16_21.xy = u_xlat2.xy / u_xlat2.zz;
        u_xlat10_2.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_21.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_2.xyz;
    } else {
        u_xlat16_5.xyz = _MainColor.xyz;
    //ENDIF
    }
    u_xlat27 = u_xlat27 + (-vs_TEXCOORD6.w);
    u_xlat2.x = u_xlat27 * vs_TEXCOORD8.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _ShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.w = min(u_xlat2.x, 1.0);
    u_xlat4.xy = vec2(u_xlat27) * vec2(0.0500000007, -0.5);
    u_xlat4.x = u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat13.xyz = u_xlat4.yyy * vs_TEXCOORD8.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat13.xyz = min(max(u_xlat13.xyz, 0.0), 1.0);
#else
    u_xlat13.xyz = clamp(u_xlat13.xyz, 0.0, 1.0);
#endif
    u_xlat13.xyz = u_xlat13.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat13.xyz = log2(u_xlat13.xyz);
    u_xlat13.xyz = u_xlat13.xyz * vec3(_Fade);
    u_xlat13.xyz = exp2(u_xlat13.xyz);
    u_xlat13.xyz = u_xlat16_5.xyz * u_xlat13.xyz + _DeepWaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.xyz = min(max(u_xlat13.xyz, 0.0), 1.0);
#else
    u_xlat13.xyz = clamp(u_xlat13.xyz, 0.0, 1.0);
#endif
    u_xlat16_21.x = dot((-u_xlat0.xyz), vs_TEXCOORD5.xyz);
    u_xlat16_21.x = u_xlat16_21.x + u_xlat16_21.x;
    u_xlat16_5.xyz = vs_TEXCOORD5.xyz * (-u_xlat16_21.xxx) + (-u_xlat0.xyz);
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion));
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD6.ww;
    u_xlat6.xy = u_xlat4.xx * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vec2(0.5, 0.5);
    u_xlat24 = vs_TEXCOORD6.w * _ProjectionParams.w;
    u_xlat24 = u_xlat24 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat24) * (-u_xlat6.xy) + u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD6.xy;
    u_xlat16_21.xy = u_xlat6.xy / vs_TEXCOORD6.ww;
    u_xlat10_6 = texture(_SSRTexture, u_xlat16_21.xy);
    u_xlat7.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion)) + u_xlat16_5.xy;
    u_xlat7.z = u_xlat16_5.z;
    u_xlat10_3 = texture(_ReflectionSkyCubeMap, u_xlat7.xyz);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = _ReflectionSkyCubeMap_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.x;
    u_xlat16_14.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat16_8 = u_xlat10_6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat16_1.x * 0.00499999989;
    u_xlat16_33 = min(u_xlat16_33, 1.0);
    u_xlat16_33 = (-u_xlat16_33) * 0.800000012 + 1.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_8;
    u_xlat16_6.xyz = (-u_xlat16_5.xxx) * u_xlat10_3.xyz + u_xlat10_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_33) * u_xlat16_6.xyz + u_xlat16_14.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_33 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_7 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_7;
    u_xlat7.x = (-_FresnelBias) + 1.0;
    u_xlat33 = u_xlat7.x * u_xlat16_33 + _FresnelBias;
    u_xlat33 = u_xlat33 * _ReflectionIntensity;
    u_xlat4.x = u_xlat4.x * u_xlat33;
    u_xlat6.xyz = (-u_xlat13.xyz) + u_xlat16_6.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat27 = u_xlat27 * vs_TEXCOORD9.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10_31 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat27) + 1.0;
    u_xlat16_27 = u_xlat16_1.x * u_xlat10_31;
    u_xlat27 = u_xlat2.w * u_xlat16_27;
    u_xlat6.xyz = (-u_xlat4.xyz) + vs_TEXCOORD9.xyz;
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat6.xyz + u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0<_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0<_ES_SunDirection.xxyz.z;
#endif
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat0.xyz = vec3(u_xlat0.x + _ES_SunDirection.xxyz.y, u_xlat0.y + _ES_SunDirection.xxyz.z, u_xlat0.z + float(_ES_SunDirection.z));
    u_xlat31 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat31);
    u_xlat16_10.x = dot(u_xlat16_10.xyz, u_xlat0.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 9.99999975e-05);
    u_xlat16_19 = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_0 = log2(u_xlat16_10.x);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_19;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat16_0 * u_xlat16_1.x;
    u_xlat0.x = u_xlatb27 ? u_xlat0.x : float(0.0);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat0.x = u_xlat0.x * 0.200000003;
    u_xlat16_1.x = max(u_xlat0.x, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat4.xyz;
    u_xlat2.xyz = vs_TEXCOORD7.www * u_xlat16_1.xyz + vs_TEXCOORD7.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "WATER_REFRACTIVE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	float _TimeEditor;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _MainColor;
uniform 	float _Density;
uniform 	float _ShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
uniform 	vec4 _FoamParams;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
mediump float u_xlat16_11;
float u_xlat14;
float u_xlat15;
vec2 u_xlat16;
float u_xlat22;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16.x = sqrt(u_xlat2.x);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].z;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16.y = sqrt(u_xlat2.x);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat16.xy;
    u_xlat16.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.x = _Time.y + _TimeEditor;
    u_xlat3.x = u_xlat3.x * 0.100000001;
    u_xlat10.xy = vec2(u_xlat3.x * _ShoreFoamParams.z, u_xlat3.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat16.xy * u_xlat2.xy + u_xlat10.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat16_4.xy = u_xlat16.xy * in_TEXCOORD0.xy;
    u_xlat16_4.xy = u_xlat16_4.xy + u_xlat16_4.xy;
    u_xlat10.xy = vec2(u_xlat3.x * _SmallWavesParams.z, u_xlat3.x * _SmallWavesParams.w);
    u_xlat16_4.zw = u_xlat10.xy * vec2(1.5, 1.5) + u_xlat16_4.xy;
    u_xlat16_4.xy = in_TEXCOORD0.xy * u_xlat16.xy + u_xlat10.xy;
    vs_TEXCOORD1 = u_xlat16_4;
    u_xlat16.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat16_4.xy = u_xlat16.xy * in_TEXCOORD0.xy;
    u_xlat16_4.xy = u_xlat16_4.xy + u_xlat16_4.xy;
    u_xlat10.xy = vec2(u_xlat3.x * _LargeWavesParams.z, u_xlat3.x * _LargeWavesParams.w);
    u_xlat3.xw = vec2(u_xlat3.x * _FoamParams.z, u_xlat3.x * _FoamParams.w);
    u_xlat16_4.zw = u_xlat10.xy * vec2(1.5, 1.5) + u_xlat16_4.xy;
    u_xlat16_4.xy = in_TEXCOORD0.xy * u_xlat16.xy + u_xlat10.xy;
    vs_TEXCOORD2 = u_xlat16_4;
    u_xlat16.xy = in_TEXCOORD0.xy * _FoamParams.xy;
    u_xlat10.xy = u_xlat2.xy * u_xlat16.xy;
    u_xlat16_2.xy = u_xlat16.xy * u_xlat2.xy + u_xlat3.xw;
    u_xlat16_4.xy = u_xlat10.xy + u_xlat10.xy;
    u_xlat16_2.zw = u_xlat3.xw * vec2(1.5, 1.5) + u_xlat16_4.xy;
    vs_TEXCOORD3 = u_xlat16_2;
    vs_TEXCOORD4.w = float(1.0) / _UV_Mix_Range;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat0.x * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat0.xyw = u_xlat7.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = u_xlat0.y * _HeigtFogParams.x;
    u_xlat8 = u_xlat1.x * -1.44269502;
    u_xlat8 = exp2(u_xlat8);
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat8 = u_xlat8 / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.00999999978<abs(u_xlat1.x));
#else
    u_xlatb1 = 0.00999999978<abs(u_xlat1.x);
#endif
    u_xlat16_4.x = (u_xlatb1) ? u_xlat8 : 1.0;
    u_xlat1.x = dot(u_xlat0.xyw, u_xlat0.xyw);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat8 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat8 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat8 = u_xlat0.y * _HeigtFogParams2.x;
    u_xlat15 = u_xlat8 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_11 = (u_xlatb8) ? u_xlat15 : 1.0;
    u_xlat8 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_11 = u_xlat8 * u_xlat16_11;
    u_xlat16_11 = exp2((-u_xlat16_11));
    u_xlat16_4.y = (-u_xlat16_11) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat8 = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat8) + 2.0;
    u_xlat16_11 = u_xlat8 * u_xlat16_11;
    u_xlat8 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat8 = u_xlat8 + 1.0;
    u_xlat16_4.x = u_xlat8 * u_xlat16_4.x;
    u_xlat8 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat15 = (-u_xlat8) + 1.0;
    u_xlat22 = u_xlat7.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat7.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_4.x = (-u_xlat22) + 2.0;
    u_xlat16_4.x = u_xlat22 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat14 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat1.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat14 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat5.xyz = vec3(u_xlat14) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xyw, u_xlat6.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = (-u_xlat1.x) + 2.0;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat14 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat14 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD7.w = u_xlat15 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat7.xyz;
    vs_TEXCOORD7.xyz = u_xlat3.xyz * vec3(u_xlat8) + u_xlat0.xyz;
    u_xlat0.x = 10.0 / _Density;
    u_xlat0.xyz = u_xlat0.xxx * _MainColor.xyz;
    vs_TEXCOORD8.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD8.w = float(1.0) / _ShoreTransparency;
    vs_TEXCOORD9.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD9.w = float(1.0) / _ShoreFoamDepth;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _LightColor0;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _MainColor;
uniform 	vec4 _DeepWaterColor;
uniform 	float _Fade;
uniform 	float _FresnelBias;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	float _ShoreFade;
uniform 	float _EnableRefractions;
uniform 	float _Refraction;
uniform 	float _ReflectionIntensity;
uniform 	float _Distortion;
uniform 	vec4 _ReflectionSkyCubeMap_HDR;
uniform 	vec3 _ES_SunDirection;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _SSRTexture;
uniform lowp samplerCube _ReflectionSkyCubeMap;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump float u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_10;
float u_xlat11;
vec3 u_xlat13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_19;
float u_xlat20;
mediump vec2 u_xlat16_21;
float u_xlat24;
float u_xlat27;
mediump float u_xlat16_27;
bool u_xlatb27;
float u_xlat29;
float u_xlat31;
lowp float u_xlat10_31;
float u_xlat33;
mediump float u_xlat16_33;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_10.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_10.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = u_xlat16_10.xz * vec2(0.150000006, 0.150000006);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.300000012, 1.0, 0.300000012);
    u_xlat16_21.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_21.x = inversesqrt(u_xlat16_21.x);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_21.xxx;
    u_xlat16_21.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat27 = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
    u_xlat27 = _ZBufferParams.z * u_xlat27 + _ZBufferParams.w;
    u_xlat27 = float(1.0) / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<_EnableRefractions);
#else
    u_xlatb2 = 0.00999999978<_EnableRefractions;
#endif
    if(u_xlatb2){
        u_xlat2.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat2.x = sqrt(u_xlat2.x);
        u_xlat2.x = u_xlat2.x + (-_UV_Mix_Start_Distance);
        u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.w;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat16_21.x = u_xlat2.x * u_xlat2.x;
        u_xlat16_21.x = u_xlat16_21.x * u_xlat16_21.x;
        u_xlat2.x = _Refraction * -0.75;
        u_xlat2.x = u_xlat16_21.x * u_xlat2.x + _Refraction;
        u_xlat11 = float(1.0) / vs_TEXCOORD6.w;
        u_xlat20 = u_xlat11 * vs_TEXCOORD6.z;
        u_xlat20 = u_xlat20 * 0.5 + 0.5;
        u_xlat16_21.xy = u_xlat2.xx * u_xlat16_3.xy;
        u_xlat2.x = u_xlat11 * 4.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat2.xy = u_xlat2.xx * u_xlat16_21.xy;
        u_xlat4.xy = u_xlat2.xy * vs_TEXCOORD6.ww;
        u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD6.ww + vs_TEXCOORD6.xy;
        u_xlat29 = vs_TEXCOORD6.w;
        u_xlat16_21.xy = u_xlat2.xy / vec2(u_xlat29);
        u_xlat2.x = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(u_xlat2.x>=u_xlat20);
#else
        u_xlatb2 = u_xlat2.x>=u_xlat20;
#endif
        u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
        u_xlat16_5.xy = u_xlat2.xx * u_xlat4.xy;
        u_xlat16_5.z = 0.0;
        u_xlat2.xyz = u_xlat16_5.xyz + vs_TEXCOORD6.xyw;
        u_xlat16_21.xy = u_xlat2.xy / u_xlat2.zz;
        u_xlat10_2.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_21.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_2.xyz;
    } else {
        u_xlat16_5.xyz = _MainColor.xyz;
    //ENDIF
    }
    u_xlat27 = u_xlat27 + (-vs_TEXCOORD6.w);
    u_xlat2.x = u_xlat27 * vs_TEXCOORD8.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _ShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.w = min(u_xlat2.x, 1.0);
    u_xlat4.xy = vec2(u_xlat27) * vec2(0.0500000007, -0.5);
    u_xlat4.x = u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat13.xyz = u_xlat4.yyy * vs_TEXCOORD8.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat13.xyz = min(max(u_xlat13.xyz, 0.0), 1.0);
#else
    u_xlat13.xyz = clamp(u_xlat13.xyz, 0.0, 1.0);
#endif
    u_xlat13.xyz = u_xlat13.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat13.xyz = log2(u_xlat13.xyz);
    u_xlat13.xyz = u_xlat13.xyz * vec3(_Fade);
    u_xlat13.xyz = exp2(u_xlat13.xyz);
    u_xlat13.xyz = u_xlat16_5.xyz * u_xlat13.xyz + _DeepWaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.xyz = min(max(u_xlat13.xyz, 0.0), 1.0);
#else
    u_xlat13.xyz = clamp(u_xlat13.xyz, 0.0, 1.0);
#endif
    u_xlat16_21.x = dot((-u_xlat0.xyz), vs_TEXCOORD5.xyz);
    u_xlat16_21.x = u_xlat16_21.x + u_xlat16_21.x;
    u_xlat16_5.xyz = vs_TEXCOORD5.xyz * (-u_xlat16_21.xxx) + (-u_xlat0.xyz);
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion));
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD6.ww;
    u_xlat6.xy = u_xlat4.xx * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vec2(0.5, 0.5);
    u_xlat24 = vs_TEXCOORD6.w * _ProjectionParams.w;
    u_xlat24 = u_xlat24 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat24) * (-u_xlat6.xy) + u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD6.xy;
    u_xlat16_21.xy = u_xlat6.xy / vs_TEXCOORD6.ww;
    u_xlat10_6 = texture(_SSRTexture, u_xlat16_21.xy);
    u_xlat7.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion)) + u_xlat16_5.xy;
    u_xlat7.z = u_xlat16_5.z;
    u_xlat10_3 = texture(_ReflectionSkyCubeMap, u_xlat7.xyz);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = _ReflectionSkyCubeMap_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.x;
    u_xlat16_14.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat16_8 = u_xlat10_6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat16_1.x * 0.00499999989;
    u_xlat16_33 = min(u_xlat16_33, 1.0);
    u_xlat16_33 = (-u_xlat16_33) * 0.800000012 + 1.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_8;
    u_xlat16_6.xyz = (-u_xlat16_5.xxx) * u_xlat10_3.xyz + u_xlat10_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_33) * u_xlat16_6.xyz + u_xlat16_14.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_33 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_7 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_7;
    u_xlat7.x = (-_FresnelBias) + 1.0;
    u_xlat33 = u_xlat7.x * u_xlat16_33 + _FresnelBias;
    u_xlat33 = u_xlat33 * _ReflectionIntensity;
    u_xlat4.x = u_xlat4.x * u_xlat33;
    u_xlat6.xyz = (-u_xlat13.xyz) + u_xlat16_6.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat27 = u_xlat27 * vs_TEXCOORD9.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10_31 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat27) + 1.0;
    u_xlat16_27 = u_xlat16_1.x * u_xlat10_31;
    u_xlat27 = u_xlat2.w * u_xlat16_27;
    u_xlat6.xyz = (-u_xlat4.xyz) + vs_TEXCOORD9.xyz;
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat6.xyz + u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0<_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0<_ES_SunDirection.xxyz.z;
#endif
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat0.xyz = vec3(u_xlat0.x + _ES_SunDirection.xxyz.y, u_xlat0.y + _ES_SunDirection.xxyz.z, u_xlat0.z + float(_ES_SunDirection.z));
    u_xlat31 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat31);
    u_xlat16_10.x = dot(u_xlat16_10.xyz, u_xlat0.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 9.99999975e-05);
    u_xlat16_19 = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_0 = log2(u_xlat16_10.x);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_19;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat16_0 * u_xlat16_1.x;
    u_xlat0.x = u_xlatb27 ? u_xlat0.x : float(0.0);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat0.x = u_xlat0.x * 0.200000003;
    u_xlat16_1.x = max(u_xlat0.x, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat4.xyz;
    u_xlat2.xyz = vs_TEXCOORD7.www * u_xlat16_1.xyz + vs_TEXCOORD7.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "WATER_REFLECTIVE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	float _TimeEditor;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _MainColor;
uniform 	float _Density;
uniform 	float _ShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
uniform 	vec4 _FoamParams;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_11;
float u_xlat14;
float u_xlat15;
vec2 u_xlat16;
vec2 u_xlat17;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16.x = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16.y = sqrt(u_xlat21);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat16.xy;
    u_xlat16.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat21 = _Time.y + _TimeEditor;
    u_xlat21 = u_xlat21 * 0.100000001;
    u_xlat3.xy = vec2(float(u_xlat21) * _ShoreFoamParams.z, float(u_xlat21) * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat16.xy * u_xlat2.xy + u_xlat3.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat16_4.xy = u_xlat16.xy * in_TEXCOORD0.xy;
    u_xlat16_4.xy = u_xlat16_4.xy + u_xlat16_4.xy;
    u_xlat3.xy = vec2(float(u_xlat21) * _SmallWavesParams.z, float(u_xlat21) * _SmallWavesParams.w);
    u_xlat16_4.zw = u_xlat3.xy * vec2(1.5, 1.5) + u_xlat16_4.xy;
    u_xlat16_4.xy = in_TEXCOORD0.xy * u_xlat16.xy + u_xlat3.xy;
    vs_TEXCOORD1 = u_xlat16_4;
    u_xlat16.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat16_4.xy = u_xlat16.xy * in_TEXCOORD0.xy;
    u_xlat16_4.xy = u_xlat16_4.xy + u_xlat16_4.xy;
    u_xlat3.xy = vec2(float(u_xlat21) * _LargeWavesParams.z, float(u_xlat21) * _LargeWavesParams.w);
    u_xlat17.xy = vec2(float(u_xlat21) * _FoamParams.z, float(u_xlat21) * _FoamParams.w);
    u_xlat16_4.zw = u_xlat3.xy * vec2(1.5, 1.5) + u_xlat16_4.xy;
    u_xlat16_4.xy = in_TEXCOORD0.xy * u_xlat16.xy + u_xlat3.xy;
    vs_TEXCOORD2 = u_xlat16_4;
    u_xlat16.xy = in_TEXCOORD0.xy * _FoamParams.xy;
    u_xlat3.xy = u_xlat2.xy * u_xlat16.xy;
    u_xlat16_2.xy = u_xlat16.xy * u_xlat2.xy + u_xlat17.xy;
    u_xlat16_4.xy = u_xlat3.xy + u_xlat3.xy;
    u_xlat16_2.zw = u_xlat17.xy * vec2(1.5, 1.5) + u_xlat16_4.xy;
    vs_TEXCOORD3 = u_xlat16_2;
    vs_TEXCOORD4.w = float(1.0) / _UV_Mix_Range;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD5.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat21 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat21 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = u_xlat0.z * _HeigtFogParams.x;
    u_xlat8 = u_xlat1.x * -1.44269502;
    u_xlat8 = exp2(u_xlat8);
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat8 = u_xlat8 / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.00999999978<abs(u_xlat1.x));
#else
    u_xlatb1 = 0.00999999978<abs(u_xlat1.x);
#endif
    u_xlat16_4.x = (u_xlatb1) ? u_xlat8 : 1.0;
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat8 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat8 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat8 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat15 = u_xlat8 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_11 = (u_xlatb8) ? u_xlat15 : 1.0;
    u_xlat8 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_11 = u_xlat8 * u_xlat16_11;
    u_xlat16_11 = exp2((-u_xlat16_11));
    u_xlat16_4.y = (-u_xlat16_11) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat8 = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat8) + 2.0;
    u_xlat16_11 = u_xlat8 * u_xlat16_11;
    u_xlat8 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat8 = u_xlat8 + 1.0;
    u_xlat16_4.x = u_xlat8 * u_xlat16_4.x;
    u_xlat8 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat15 = (-u_xlat8) + 1.0;
    u_xlat22 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat7.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_4.x = (-u_xlat22) + 2.0;
    u_xlat16_4.x = u_xlat22 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7.x = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat1.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat7.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat6.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = (-u_xlat1.x) + 2.0;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat14 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat14 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD7.w = u_xlat15 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat7.xyz;
    vs_TEXCOORD7.xyz = u_xlat3.xyz * vec3(u_xlat8) + u_xlat0.xyz;
    u_xlat0.x = 10.0 / _Density;
    u_xlat0.xyz = u_xlat0.xxx * _MainColor.xyz;
    vs_TEXCOORD8.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD8.w = float(1.0) / _ShoreTransparency;
    vs_TEXCOORD9.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD9.w = float(1.0) / _ShoreFoamDepth;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _LightColor0;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _MainColor;
uniform 	vec4 _DeepWaterColor;
uniform 	float _Fade;
uniform 	float _FresnelBias;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	float _ShoreFade;
uniform 	float _EnableRefractions;
uniform 	float _Refraction;
uniform 	float _ReflectionIntensity;
uniform 	float _Distortion;
uniform 	vec4 _ReflectionSkyCubeMap_HDR;
uniform 	vec3 _ES_SunDirection;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _SSRTexture;
uniform lowp samplerCube _ReflectionSkyCubeMap;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump float u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_10;
float u_xlat11;
vec3 u_xlat13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_19;
float u_xlat20;
mediump vec2 u_xlat16_21;
float u_xlat24;
float u_xlat27;
mediump float u_xlat16_27;
bool u_xlatb27;
float u_xlat29;
float u_xlat31;
lowp float u_xlat10_31;
float u_xlat33;
mediump float u_xlat16_33;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_10.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_10.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = u_xlat16_10.xz * vec2(0.150000006, 0.150000006);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.300000012, 1.0, 0.300000012);
    u_xlat16_21.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_21.x = inversesqrt(u_xlat16_21.x);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_21.xxx;
    u_xlat16_21.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat27 = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
    u_xlat27 = _ZBufferParams.z * u_xlat27 + _ZBufferParams.w;
    u_xlat27 = float(1.0) / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<_EnableRefractions);
#else
    u_xlatb2 = 0.00999999978<_EnableRefractions;
#endif
    if(u_xlatb2){
        u_xlat2.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat2.x = sqrt(u_xlat2.x);
        u_xlat2.x = u_xlat2.x + (-_UV_Mix_Start_Distance);
        u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.w;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat16_21.x = u_xlat2.x * u_xlat2.x;
        u_xlat16_21.x = u_xlat16_21.x * u_xlat16_21.x;
        u_xlat2.x = _Refraction * -0.75;
        u_xlat2.x = u_xlat16_21.x * u_xlat2.x + _Refraction;
        u_xlat11 = float(1.0) / vs_TEXCOORD6.w;
        u_xlat20 = u_xlat11 * vs_TEXCOORD6.z;
        u_xlat20 = u_xlat20 * 0.5 + 0.5;
        u_xlat16_21.xy = u_xlat2.xx * u_xlat16_3.xy;
        u_xlat2.x = u_xlat11 * 4.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat2.xy = u_xlat2.xx * u_xlat16_21.xy;
        u_xlat4.xy = u_xlat2.xy * vs_TEXCOORD6.ww;
        u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD6.ww + vs_TEXCOORD6.xy;
        u_xlat29 = vs_TEXCOORD6.w;
        u_xlat16_21.xy = u_xlat2.xy / vec2(u_xlat29);
        u_xlat2.x = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(u_xlat2.x>=u_xlat20);
#else
        u_xlatb2 = u_xlat2.x>=u_xlat20;
#endif
        u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
        u_xlat16_5.xy = u_xlat2.xx * u_xlat4.xy;
        u_xlat16_5.z = 0.0;
        u_xlat2.xyz = u_xlat16_5.xyz + vs_TEXCOORD6.xyw;
        u_xlat16_21.xy = u_xlat2.xy / u_xlat2.zz;
        u_xlat10_2.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_21.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_2.xyz;
    } else {
        u_xlat16_5.xyz = _MainColor.xyz;
    //ENDIF
    }
    u_xlat27 = u_xlat27 + (-vs_TEXCOORD6.w);
    u_xlat2.x = u_xlat27 * vs_TEXCOORD8.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _ShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.w = min(u_xlat2.x, 1.0);
    u_xlat4.xy = vec2(u_xlat27) * vec2(0.0500000007, -0.5);
    u_xlat4.x = u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat13.xyz = u_xlat4.yyy * vs_TEXCOORD8.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat13.xyz = min(max(u_xlat13.xyz, 0.0), 1.0);
#else
    u_xlat13.xyz = clamp(u_xlat13.xyz, 0.0, 1.0);
#endif
    u_xlat13.xyz = u_xlat13.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat13.xyz = log2(u_xlat13.xyz);
    u_xlat13.xyz = u_xlat13.xyz * vec3(_Fade);
    u_xlat13.xyz = exp2(u_xlat13.xyz);
    u_xlat13.xyz = u_xlat16_5.xyz * u_xlat13.xyz + _DeepWaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.xyz = min(max(u_xlat13.xyz, 0.0), 1.0);
#else
    u_xlat13.xyz = clamp(u_xlat13.xyz, 0.0, 1.0);
#endif
    u_xlat16_21.x = dot((-u_xlat0.xyz), vs_TEXCOORD5.xyz);
    u_xlat16_21.x = u_xlat16_21.x + u_xlat16_21.x;
    u_xlat16_5.xyz = vs_TEXCOORD5.xyz * (-u_xlat16_21.xxx) + (-u_xlat0.xyz);
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion));
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD6.ww;
    u_xlat6.xy = u_xlat4.xx * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vec2(0.5, 0.5);
    u_xlat24 = vs_TEXCOORD6.w * _ProjectionParams.w;
    u_xlat24 = u_xlat24 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat24) * (-u_xlat6.xy) + u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD6.xy;
    u_xlat16_21.xy = u_xlat6.xy / vs_TEXCOORD6.ww;
    u_xlat10_6 = texture(_SSRTexture, u_xlat16_21.xy);
    u_xlat7.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion)) + u_xlat16_5.xy;
    u_xlat7.z = u_xlat16_5.z;
    u_xlat10_3 = texture(_ReflectionSkyCubeMap, u_xlat7.xyz);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = _ReflectionSkyCubeMap_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.x;
    u_xlat16_14.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat16_8 = u_xlat10_6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat16_1.x * 0.00499999989;
    u_xlat16_33 = min(u_xlat16_33, 1.0);
    u_xlat16_33 = (-u_xlat16_33) * 0.800000012 + 1.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_8;
    u_xlat16_6.xyz = (-u_xlat16_5.xxx) * u_xlat10_3.xyz + u_xlat10_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_33) * u_xlat16_6.xyz + u_xlat16_14.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_33 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_7 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_7;
    u_xlat7.x = (-_FresnelBias) + 1.0;
    u_xlat33 = u_xlat7.x * u_xlat16_33 + _FresnelBias;
    u_xlat33 = u_xlat33 * _ReflectionIntensity;
    u_xlat4.x = u_xlat4.x * u_xlat33;
    u_xlat6.xyz = (-u_xlat13.xyz) + u_xlat16_6.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat27 = u_xlat27 * vs_TEXCOORD9.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10_31 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat27) + 1.0;
    u_xlat16_27 = u_xlat16_1.x * u_xlat10_31;
    u_xlat27 = u_xlat2.w * u_xlat16_27;
    u_xlat6.xyz = (-u_xlat4.xyz) + vs_TEXCOORD9.xyz;
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat6.xyz + u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0<_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0<_ES_SunDirection.xxyz.z;
#endif
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat0.xyz = vec3(u_xlat0.x + _ES_SunDirection.xxyz.y, u_xlat0.y + _ES_SunDirection.xxyz.z, u_xlat0.z + float(_ES_SunDirection.z));
    u_xlat31 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat31);
    u_xlat16_10.x = dot(u_xlat16_10.xyz, u_xlat0.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 9.99999975e-05);
    u_xlat16_19 = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_0 = log2(u_xlat16_10.x);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_19;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat16_0 * u_xlat16_1.x;
    u_xlat0.x = u_xlatb27 ? u_xlat0.x : float(0.0);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat0.x = u_xlat0.x * 0.200000003;
    u_xlat16_1.x = max(u_xlat0.x, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat4.xyz;
    u_xlat2.xyz = vs_TEXCOORD7.www * u_xlat16_1.xyz + vs_TEXCOORD7.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "WATER_REFLECTIVE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	float _TimeEditor;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _MainColor;
uniform 	float _Density;
uniform 	float _ShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
uniform 	vec4 _FoamParams;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
mediump float u_xlat16_11;
float u_xlat14;
float u_xlat15;
vec2 u_xlat16;
float u_xlat22;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16.x = sqrt(u_xlat2.x);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].z;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16.y = sqrt(u_xlat2.x);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat16.xy;
    u_xlat16.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.x = _Time.y + _TimeEditor;
    u_xlat3.x = u_xlat3.x * 0.100000001;
    u_xlat10.xy = vec2(u_xlat3.x * _ShoreFoamParams.z, u_xlat3.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat16.xy * u_xlat2.xy + u_xlat10.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat16_4.xy = u_xlat16.xy * in_TEXCOORD0.xy;
    u_xlat16_4.xy = u_xlat16_4.xy + u_xlat16_4.xy;
    u_xlat10.xy = vec2(u_xlat3.x * _SmallWavesParams.z, u_xlat3.x * _SmallWavesParams.w);
    u_xlat16_4.zw = u_xlat10.xy * vec2(1.5, 1.5) + u_xlat16_4.xy;
    u_xlat16_4.xy = in_TEXCOORD0.xy * u_xlat16.xy + u_xlat10.xy;
    vs_TEXCOORD1 = u_xlat16_4;
    u_xlat16.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat16_4.xy = u_xlat16.xy * in_TEXCOORD0.xy;
    u_xlat16_4.xy = u_xlat16_4.xy + u_xlat16_4.xy;
    u_xlat10.xy = vec2(u_xlat3.x * _LargeWavesParams.z, u_xlat3.x * _LargeWavesParams.w);
    u_xlat3.xw = vec2(u_xlat3.x * _FoamParams.z, u_xlat3.x * _FoamParams.w);
    u_xlat16_4.zw = u_xlat10.xy * vec2(1.5, 1.5) + u_xlat16_4.xy;
    u_xlat16_4.xy = in_TEXCOORD0.xy * u_xlat16.xy + u_xlat10.xy;
    vs_TEXCOORD2 = u_xlat16_4;
    u_xlat16.xy = in_TEXCOORD0.xy * _FoamParams.xy;
    u_xlat10.xy = u_xlat2.xy * u_xlat16.xy;
    u_xlat16_2.xy = u_xlat16.xy * u_xlat2.xy + u_xlat3.xw;
    u_xlat16_4.xy = u_xlat10.xy + u_xlat10.xy;
    u_xlat16_2.zw = u_xlat3.xw * vec2(1.5, 1.5) + u_xlat16_4.xy;
    vs_TEXCOORD3 = u_xlat16_2;
    vs_TEXCOORD4.w = float(1.0) / _UV_Mix_Range;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat0.x * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat0.xyw = u_xlat7.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = u_xlat0.y * _HeigtFogParams.x;
    u_xlat8 = u_xlat1.x * -1.44269502;
    u_xlat8 = exp2(u_xlat8);
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat8 = u_xlat8 / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.00999999978<abs(u_xlat1.x));
#else
    u_xlatb1 = 0.00999999978<abs(u_xlat1.x);
#endif
    u_xlat16_4.x = (u_xlatb1) ? u_xlat8 : 1.0;
    u_xlat1.x = dot(u_xlat0.xyw, u_xlat0.xyw);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat8 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat8 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat8 = u_xlat0.y * _HeigtFogParams2.x;
    u_xlat15 = u_xlat8 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_11 = (u_xlatb8) ? u_xlat15 : 1.0;
    u_xlat8 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_11 = u_xlat8 * u_xlat16_11;
    u_xlat16_11 = exp2((-u_xlat16_11));
    u_xlat16_4.y = (-u_xlat16_11) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat8 = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat8) + 2.0;
    u_xlat16_11 = u_xlat8 * u_xlat16_11;
    u_xlat8 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat8 = u_xlat8 + 1.0;
    u_xlat16_4.x = u_xlat8 * u_xlat16_4.x;
    u_xlat8 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat15 = (-u_xlat8) + 1.0;
    u_xlat22 = u_xlat7.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat7.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_4.x = (-u_xlat22) + 2.0;
    u_xlat16_4.x = u_xlat22 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat14 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat1.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat14 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat5.xyz = vec3(u_xlat14) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xyw, u_xlat6.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = (-u_xlat1.x) + 2.0;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat14 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat14 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD7.w = u_xlat15 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat7.xyz;
    vs_TEXCOORD7.xyz = u_xlat3.xyz * vec3(u_xlat8) + u_xlat0.xyz;
    u_xlat0.x = 10.0 / _Density;
    u_xlat0.xyz = u_xlat0.xxx * _MainColor.xyz;
    vs_TEXCOORD8.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD8.w = float(1.0) / _ShoreTransparency;
    vs_TEXCOORD9.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD9.w = float(1.0) / _ShoreFoamDepth;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _LightColor0;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _MainColor;
uniform 	vec4 _DeepWaterColor;
uniform 	float _Fade;
uniform 	float _FresnelBias;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	float _ShoreFade;
uniform 	float _EnableRefractions;
uniform 	float _Refraction;
uniform 	float _ReflectionIntensity;
uniform 	float _Distortion;
uniform 	vec4 _ReflectionSkyCubeMap_HDR;
uniform 	vec3 _ES_SunDirection;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _SSRTexture;
uniform lowp samplerCube _ReflectionSkyCubeMap;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump float u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_10;
float u_xlat11;
vec3 u_xlat13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_19;
float u_xlat20;
mediump vec2 u_xlat16_21;
float u_xlat24;
float u_xlat27;
mediump float u_xlat16_27;
bool u_xlatb27;
float u_xlat29;
float u_xlat31;
lowp float u_xlat10_31;
float u_xlat33;
mediump float u_xlat16_33;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_10.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_10.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = u_xlat16_10.xz * vec2(0.150000006, 0.150000006);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.300000012, 1.0, 0.300000012);
    u_xlat16_21.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_21.x = inversesqrt(u_xlat16_21.x);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_21.xxx;
    u_xlat16_21.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat27 = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
    u_xlat27 = _ZBufferParams.z * u_xlat27 + _ZBufferParams.w;
    u_xlat27 = float(1.0) / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<_EnableRefractions);
#else
    u_xlatb2 = 0.00999999978<_EnableRefractions;
#endif
    if(u_xlatb2){
        u_xlat2.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat2.x = sqrt(u_xlat2.x);
        u_xlat2.x = u_xlat2.x + (-_UV_Mix_Start_Distance);
        u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.w;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat16_21.x = u_xlat2.x * u_xlat2.x;
        u_xlat16_21.x = u_xlat16_21.x * u_xlat16_21.x;
        u_xlat2.x = _Refraction * -0.75;
        u_xlat2.x = u_xlat16_21.x * u_xlat2.x + _Refraction;
        u_xlat11 = float(1.0) / vs_TEXCOORD6.w;
        u_xlat20 = u_xlat11 * vs_TEXCOORD6.z;
        u_xlat20 = u_xlat20 * 0.5 + 0.5;
        u_xlat16_21.xy = u_xlat2.xx * u_xlat16_3.xy;
        u_xlat2.x = u_xlat11 * 4.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat2.xy = u_xlat2.xx * u_xlat16_21.xy;
        u_xlat4.xy = u_xlat2.xy * vs_TEXCOORD6.ww;
        u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD6.ww + vs_TEXCOORD6.xy;
        u_xlat29 = vs_TEXCOORD6.w;
        u_xlat16_21.xy = u_xlat2.xy / vec2(u_xlat29);
        u_xlat2.x = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(u_xlat2.x>=u_xlat20);
#else
        u_xlatb2 = u_xlat2.x>=u_xlat20;
#endif
        u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
        u_xlat16_5.xy = u_xlat2.xx * u_xlat4.xy;
        u_xlat16_5.z = 0.0;
        u_xlat2.xyz = u_xlat16_5.xyz + vs_TEXCOORD6.xyw;
        u_xlat16_21.xy = u_xlat2.xy / u_xlat2.zz;
        u_xlat10_2.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_21.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_2.xyz;
    } else {
        u_xlat16_5.xyz = _MainColor.xyz;
    //ENDIF
    }
    u_xlat27 = u_xlat27 + (-vs_TEXCOORD6.w);
    u_xlat2.x = u_xlat27 * vs_TEXCOORD8.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _ShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.w = min(u_xlat2.x, 1.0);
    u_xlat4.xy = vec2(u_xlat27) * vec2(0.0500000007, -0.5);
    u_xlat4.x = u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat13.xyz = u_xlat4.yyy * vs_TEXCOORD8.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat13.xyz = min(max(u_xlat13.xyz, 0.0), 1.0);
#else
    u_xlat13.xyz = clamp(u_xlat13.xyz, 0.0, 1.0);
#endif
    u_xlat13.xyz = u_xlat13.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat13.xyz = log2(u_xlat13.xyz);
    u_xlat13.xyz = u_xlat13.xyz * vec3(_Fade);
    u_xlat13.xyz = exp2(u_xlat13.xyz);
    u_xlat13.xyz = u_xlat16_5.xyz * u_xlat13.xyz + _DeepWaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.xyz = min(max(u_xlat13.xyz, 0.0), 1.0);
#else
    u_xlat13.xyz = clamp(u_xlat13.xyz, 0.0, 1.0);
#endif
    u_xlat16_21.x = dot((-u_xlat0.xyz), vs_TEXCOORD5.xyz);
    u_xlat16_21.x = u_xlat16_21.x + u_xlat16_21.x;
    u_xlat16_5.xyz = vs_TEXCOORD5.xyz * (-u_xlat16_21.xxx) + (-u_xlat0.xyz);
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion));
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD6.ww;
    u_xlat6.xy = u_xlat4.xx * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vec2(0.5, 0.5);
    u_xlat24 = vs_TEXCOORD6.w * _ProjectionParams.w;
    u_xlat24 = u_xlat24 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat24) * (-u_xlat6.xy) + u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD6.xy;
    u_xlat16_21.xy = u_xlat6.xy / vs_TEXCOORD6.ww;
    u_xlat10_6 = texture(_SSRTexture, u_xlat16_21.xy);
    u_xlat7.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion)) + u_xlat16_5.xy;
    u_xlat7.z = u_xlat16_5.z;
    u_xlat10_3 = texture(_ReflectionSkyCubeMap, u_xlat7.xyz);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = _ReflectionSkyCubeMap_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.x;
    u_xlat16_14.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat16_8 = u_xlat10_6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat16_1.x * 0.00499999989;
    u_xlat16_33 = min(u_xlat16_33, 1.0);
    u_xlat16_33 = (-u_xlat16_33) * 0.800000012 + 1.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_8;
    u_xlat16_6.xyz = (-u_xlat16_5.xxx) * u_xlat10_3.xyz + u_xlat10_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_33) * u_xlat16_6.xyz + u_xlat16_14.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_33 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_7 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_7;
    u_xlat7.x = (-_FresnelBias) + 1.0;
    u_xlat33 = u_xlat7.x * u_xlat16_33 + _FresnelBias;
    u_xlat33 = u_xlat33 * _ReflectionIntensity;
    u_xlat4.x = u_xlat4.x * u_xlat33;
    u_xlat6.xyz = (-u_xlat13.xyz) + u_xlat16_6.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat27 = u_xlat27 * vs_TEXCOORD9.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10_31 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat27) + 1.0;
    u_xlat16_27 = u_xlat16_1.x * u_xlat10_31;
    u_xlat27 = u_xlat2.w * u_xlat16_27;
    u_xlat6.xyz = (-u_xlat4.xyz) + vs_TEXCOORD9.xyz;
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat6.xyz + u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0<_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0<_ES_SunDirection.xxyz.z;
#endif
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat0.xyz = vec3(u_xlat0.x + _ES_SunDirection.xxyz.y, u_xlat0.y + _ES_SunDirection.xxyz.z, u_xlat0.z + float(_ES_SunDirection.z));
    u_xlat31 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat31);
    u_xlat16_10.x = dot(u_xlat16_10.xyz, u_xlat0.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 9.99999975e-05);
    u_xlat16_19 = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_0 = log2(u_xlat16_10.x);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_19;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat16_0 * u_xlat16_1.x;
    u_xlat0.x = u_xlatb27 ? u_xlat0.x : float(0.0);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat0.x = u_xlat0.x * 0.200000003;
    u_xlat16_1.x = max(u_xlat0.x, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat4.xyz;
    u_xlat2.xyz = vs_TEXCOORD7.www * u_xlat16_1.xyz + vs_TEXCOORD7.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "WATER_SHORE_FOAM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	float _TimeEditor;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _MainColor;
uniform 	float _Density;
uniform 	float _ShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
uniform 	vec4 _FoamParams;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_11;
float u_xlat14;
float u_xlat15;
vec2 u_xlat16;
vec2 u_xlat17;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16.x = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16.y = sqrt(u_xlat21);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat16.xy;
    u_xlat16.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat21 = _Time.y + _TimeEditor;
    u_xlat21 = u_xlat21 * 0.100000001;
    u_xlat3.xy = vec2(float(u_xlat21) * _ShoreFoamParams.z, float(u_xlat21) * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat16.xy * u_xlat2.xy + u_xlat3.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat16_4.xy = u_xlat16.xy * in_TEXCOORD0.xy;
    u_xlat16_4.xy = u_xlat16_4.xy + u_xlat16_4.xy;
    u_xlat3.xy = vec2(float(u_xlat21) * _SmallWavesParams.z, float(u_xlat21) * _SmallWavesParams.w);
    u_xlat16_4.zw = u_xlat3.xy * vec2(1.5, 1.5) + u_xlat16_4.xy;
    u_xlat16_4.xy = in_TEXCOORD0.xy * u_xlat16.xy + u_xlat3.xy;
    vs_TEXCOORD1 = u_xlat16_4;
    u_xlat16.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat16_4.xy = u_xlat16.xy * in_TEXCOORD0.xy;
    u_xlat16_4.xy = u_xlat16_4.xy + u_xlat16_4.xy;
    u_xlat3.xy = vec2(float(u_xlat21) * _LargeWavesParams.z, float(u_xlat21) * _LargeWavesParams.w);
    u_xlat17.xy = vec2(float(u_xlat21) * _FoamParams.z, float(u_xlat21) * _FoamParams.w);
    u_xlat16_4.zw = u_xlat3.xy * vec2(1.5, 1.5) + u_xlat16_4.xy;
    u_xlat16_4.xy = in_TEXCOORD0.xy * u_xlat16.xy + u_xlat3.xy;
    vs_TEXCOORD2 = u_xlat16_4;
    u_xlat16.xy = in_TEXCOORD0.xy * _FoamParams.xy;
    u_xlat3.xy = u_xlat2.xy * u_xlat16.xy;
    u_xlat16_2.xy = u_xlat16.xy * u_xlat2.xy + u_xlat17.xy;
    u_xlat16_4.xy = u_xlat3.xy + u_xlat3.xy;
    u_xlat16_2.zw = u_xlat17.xy * vec2(1.5, 1.5) + u_xlat16_4.xy;
    vs_TEXCOORD3 = u_xlat16_2;
    vs_TEXCOORD4.w = float(1.0) / _UV_Mix_Range;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD5.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat21 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat21 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = u_xlat0.z * _HeigtFogParams.x;
    u_xlat8 = u_xlat1.x * -1.44269502;
    u_xlat8 = exp2(u_xlat8);
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat8 = u_xlat8 / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.00999999978<abs(u_xlat1.x));
#else
    u_xlatb1 = 0.00999999978<abs(u_xlat1.x);
#endif
    u_xlat16_4.x = (u_xlatb1) ? u_xlat8 : 1.0;
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat8 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat8 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat8 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat15 = u_xlat8 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_11 = (u_xlatb8) ? u_xlat15 : 1.0;
    u_xlat8 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_11 = u_xlat8 * u_xlat16_11;
    u_xlat16_11 = exp2((-u_xlat16_11));
    u_xlat16_4.y = (-u_xlat16_11) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat8 = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat8) + 2.0;
    u_xlat16_11 = u_xlat8 * u_xlat16_11;
    u_xlat8 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat8 = u_xlat8 + 1.0;
    u_xlat16_4.x = u_xlat8 * u_xlat16_4.x;
    u_xlat8 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat15 = (-u_xlat8) + 1.0;
    u_xlat22 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat7.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_4.x = (-u_xlat22) + 2.0;
    u_xlat16_4.x = u_xlat22 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7.x = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat1.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat7.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat6.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = (-u_xlat1.x) + 2.0;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat14 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat14 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD7.w = u_xlat15 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat7.xyz;
    vs_TEXCOORD7.xyz = u_xlat3.xyz * vec3(u_xlat8) + u_xlat0.xyz;
    u_xlat0.x = 10.0 / _Density;
    u_xlat0.xyz = u_xlat0.xxx * _MainColor.xyz;
    vs_TEXCOORD8.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD8.w = float(1.0) / _ShoreTransparency;
    vs_TEXCOORD9.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD9.w = float(1.0) / _ShoreFoamDepth;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _LightColor0;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _MainColor;
uniform 	vec4 _DeepWaterColor;
uniform 	float _Fade;
uniform 	float _FresnelBias;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	float _ShoreFade;
uniform 	float _EnableRefractions;
uniform 	float _Refraction;
uniform 	float _ReflectionIntensity;
uniform 	float _Distortion;
uniform 	vec4 _ReflectionSkyCubeMap_HDR;
uniform 	vec3 _ES_SunDirection;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _SSRTexture;
uniform lowp samplerCube _ReflectionSkyCubeMap;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump float u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_10;
float u_xlat11;
vec3 u_xlat13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_19;
float u_xlat20;
mediump vec2 u_xlat16_21;
float u_xlat24;
float u_xlat27;
mediump float u_xlat16_27;
bool u_xlatb27;
float u_xlat29;
float u_xlat31;
lowp float u_xlat10_31;
float u_xlat33;
mediump float u_xlat16_33;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_10.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_10.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = u_xlat16_10.xz * vec2(0.150000006, 0.150000006);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.300000012, 1.0, 0.300000012);
    u_xlat16_21.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_21.x = inversesqrt(u_xlat16_21.x);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_21.xxx;
    u_xlat16_21.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat27 = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
    u_xlat27 = _ZBufferParams.z * u_xlat27 + _ZBufferParams.w;
    u_xlat27 = float(1.0) / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<_EnableRefractions);
#else
    u_xlatb2 = 0.00999999978<_EnableRefractions;
#endif
    if(u_xlatb2){
        u_xlat2.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat2.x = sqrt(u_xlat2.x);
        u_xlat2.x = u_xlat2.x + (-_UV_Mix_Start_Distance);
        u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.w;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat16_21.x = u_xlat2.x * u_xlat2.x;
        u_xlat16_21.x = u_xlat16_21.x * u_xlat16_21.x;
        u_xlat2.x = _Refraction * -0.75;
        u_xlat2.x = u_xlat16_21.x * u_xlat2.x + _Refraction;
        u_xlat11 = float(1.0) / vs_TEXCOORD6.w;
        u_xlat20 = u_xlat11 * vs_TEXCOORD6.z;
        u_xlat20 = u_xlat20 * 0.5 + 0.5;
        u_xlat16_21.xy = u_xlat2.xx * u_xlat16_3.xy;
        u_xlat2.x = u_xlat11 * 4.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat2.xy = u_xlat2.xx * u_xlat16_21.xy;
        u_xlat4.xy = u_xlat2.xy * vs_TEXCOORD6.ww;
        u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD6.ww + vs_TEXCOORD6.xy;
        u_xlat29 = vs_TEXCOORD6.w;
        u_xlat16_21.xy = u_xlat2.xy / vec2(u_xlat29);
        u_xlat2.x = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(u_xlat2.x>=u_xlat20);
#else
        u_xlatb2 = u_xlat2.x>=u_xlat20;
#endif
        u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
        u_xlat16_5.xy = u_xlat2.xx * u_xlat4.xy;
        u_xlat16_5.z = 0.0;
        u_xlat2.xyz = u_xlat16_5.xyz + vs_TEXCOORD6.xyw;
        u_xlat16_21.xy = u_xlat2.xy / u_xlat2.zz;
        u_xlat10_2.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_21.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_2.xyz;
    } else {
        u_xlat16_5.xyz = _MainColor.xyz;
    //ENDIF
    }
    u_xlat27 = u_xlat27 + (-vs_TEXCOORD6.w);
    u_xlat2.x = u_xlat27 * vs_TEXCOORD8.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _ShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.w = min(u_xlat2.x, 1.0);
    u_xlat4.xy = vec2(u_xlat27) * vec2(0.0500000007, -0.5);
    u_xlat4.x = u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat13.xyz = u_xlat4.yyy * vs_TEXCOORD8.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat13.xyz = min(max(u_xlat13.xyz, 0.0), 1.0);
#else
    u_xlat13.xyz = clamp(u_xlat13.xyz, 0.0, 1.0);
#endif
    u_xlat13.xyz = u_xlat13.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat13.xyz = log2(u_xlat13.xyz);
    u_xlat13.xyz = u_xlat13.xyz * vec3(_Fade);
    u_xlat13.xyz = exp2(u_xlat13.xyz);
    u_xlat13.xyz = u_xlat16_5.xyz * u_xlat13.xyz + _DeepWaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.xyz = min(max(u_xlat13.xyz, 0.0), 1.0);
#else
    u_xlat13.xyz = clamp(u_xlat13.xyz, 0.0, 1.0);
#endif
    u_xlat16_21.x = dot((-u_xlat0.xyz), vs_TEXCOORD5.xyz);
    u_xlat16_21.x = u_xlat16_21.x + u_xlat16_21.x;
    u_xlat16_5.xyz = vs_TEXCOORD5.xyz * (-u_xlat16_21.xxx) + (-u_xlat0.xyz);
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion));
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD6.ww;
    u_xlat6.xy = u_xlat4.xx * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vec2(0.5, 0.5);
    u_xlat24 = vs_TEXCOORD6.w * _ProjectionParams.w;
    u_xlat24 = u_xlat24 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat24) * (-u_xlat6.xy) + u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD6.xy;
    u_xlat16_21.xy = u_xlat6.xy / vs_TEXCOORD6.ww;
    u_xlat10_6 = texture(_SSRTexture, u_xlat16_21.xy);
    u_xlat7.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion)) + u_xlat16_5.xy;
    u_xlat7.z = u_xlat16_5.z;
    u_xlat10_3 = texture(_ReflectionSkyCubeMap, u_xlat7.xyz);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = _ReflectionSkyCubeMap_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.x;
    u_xlat16_14.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat16_8 = u_xlat10_6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat16_1.x * 0.00499999989;
    u_xlat16_33 = min(u_xlat16_33, 1.0);
    u_xlat16_33 = (-u_xlat16_33) * 0.800000012 + 1.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_8;
    u_xlat16_6.xyz = (-u_xlat16_5.xxx) * u_xlat10_3.xyz + u_xlat10_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_33) * u_xlat16_6.xyz + u_xlat16_14.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_33 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_7 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_7;
    u_xlat7.x = (-_FresnelBias) + 1.0;
    u_xlat33 = u_xlat7.x * u_xlat16_33 + _FresnelBias;
    u_xlat33 = u_xlat33 * _ReflectionIntensity;
    u_xlat4.x = u_xlat4.x * u_xlat33;
    u_xlat6.xyz = (-u_xlat13.xyz) + u_xlat16_6.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat27 = u_xlat27 * vs_TEXCOORD9.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10_31 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat27) + 1.0;
    u_xlat16_27 = u_xlat16_1.x * u_xlat10_31;
    u_xlat27 = u_xlat2.w * u_xlat16_27;
    u_xlat6.xyz = (-u_xlat4.xyz) + vs_TEXCOORD9.xyz;
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat6.xyz + u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0<_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0<_ES_SunDirection.xxyz.z;
#endif
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat0.xyz = vec3(u_xlat0.x + _ES_SunDirection.xxyz.y, u_xlat0.y + _ES_SunDirection.xxyz.z, u_xlat0.z + float(_ES_SunDirection.z));
    u_xlat31 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat31);
    u_xlat16_10.x = dot(u_xlat16_10.xyz, u_xlat0.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 9.99999975e-05);
    u_xlat16_19 = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_0 = log2(u_xlat16_10.x);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_19;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat16_0 * u_xlat16_1.x;
    u_xlat0.x = u_xlatb27 ? u_xlat0.x : float(0.0);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat0.x = u_xlat0.x * 0.200000003;
    u_xlat16_1.x = max(u_xlat0.x, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat4.xyz;
    u_xlat2.xyz = vs_TEXCOORD7.www * u_xlat16_1.xyz + vs_TEXCOORD7.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "WATER_SHORE_FOAM" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	float _TimeEditor;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _MainColor;
uniform 	float _Density;
uniform 	float _ShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
uniform 	vec4 _FoamParams;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
mediump float u_xlat16_11;
float u_xlat14;
float u_xlat15;
vec2 u_xlat16;
float u_xlat22;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16.x = sqrt(u_xlat2.x);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].z;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16.y = sqrt(u_xlat2.x);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat16.xy;
    u_xlat16.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.x = _Time.y + _TimeEditor;
    u_xlat3.x = u_xlat3.x * 0.100000001;
    u_xlat10.xy = vec2(u_xlat3.x * _ShoreFoamParams.z, u_xlat3.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat16.xy * u_xlat2.xy + u_xlat10.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat16_4.xy = u_xlat16.xy * in_TEXCOORD0.xy;
    u_xlat16_4.xy = u_xlat16_4.xy + u_xlat16_4.xy;
    u_xlat10.xy = vec2(u_xlat3.x * _SmallWavesParams.z, u_xlat3.x * _SmallWavesParams.w);
    u_xlat16_4.zw = u_xlat10.xy * vec2(1.5, 1.5) + u_xlat16_4.xy;
    u_xlat16_4.xy = in_TEXCOORD0.xy * u_xlat16.xy + u_xlat10.xy;
    vs_TEXCOORD1 = u_xlat16_4;
    u_xlat16.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat16_4.xy = u_xlat16.xy * in_TEXCOORD0.xy;
    u_xlat16_4.xy = u_xlat16_4.xy + u_xlat16_4.xy;
    u_xlat10.xy = vec2(u_xlat3.x * _LargeWavesParams.z, u_xlat3.x * _LargeWavesParams.w);
    u_xlat3.xw = vec2(u_xlat3.x * _FoamParams.z, u_xlat3.x * _FoamParams.w);
    u_xlat16_4.zw = u_xlat10.xy * vec2(1.5, 1.5) + u_xlat16_4.xy;
    u_xlat16_4.xy = in_TEXCOORD0.xy * u_xlat16.xy + u_xlat10.xy;
    vs_TEXCOORD2 = u_xlat16_4;
    u_xlat16.xy = in_TEXCOORD0.xy * _FoamParams.xy;
    u_xlat10.xy = u_xlat2.xy * u_xlat16.xy;
    u_xlat16_2.xy = u_xlat16.xy * u_xlat2.xy + u_xlat3.xw;
    u_xlat16_4.xy = u_xlat10.xy + u_xlat10.xy;
    u_xlat16_2.zw = u_xlat3.xw * vec2(1.5, 1.5) + u_xlat16_4.xy;
    vs_TEXCOORD3 = u_xlat16_2;
    vs_TEXCOORD4.w = float(1.0) / _UV_Mix_Range;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat0.x * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat0.xyw = u_xlat7.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = u_xlat0.y * _HeigtFogParams.x;
    u_xlat8 = u_xlat1.x * -1.44269502;
    u_xlat8 = exp2(u_xlat8);
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat8 = u_xlat8 / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.00999999978<abs(u_xlat1.x));
#else
    u_xlatb1 = 0.00999999978<abs(u_xlat1.x);
#endif
    u_xlat16_4.x = (u_xlatb1) ? u_xlat8 : 1.0;
    u_xlat1.x = dot(u_xlat0.xyw, u_xlat0.xyw);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat8 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat8 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat8 = u_xlat0.y * _HeigtFogParams2.x;
    u_xlat15 = u_xlat8 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_11 = (u_xlatb8) ? u_xlat15 : 1.0;
    u_xlat8 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_11 = u_xlat8 * u_xlat16_11;
    u_xlat16_11 = exp2((-u_xlat16_11));
    u_xlat16_4.y = (-u_xlat16_11) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat8 = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat8) + 2.0;
    u_xlat16_11 = u_xlat8 * u_xlat16_11;
    u_xlat8 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat8 = u_xlat8 + 1.0;
    u_xlat16_4.x = u_xlat8 * u_xlat16_4.x;
    u_xlat8 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat15 = (-u_xlat8) + 1.0;
    u_xlat22 = u_xlat7.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat7.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_4.x = (-u_xlat22) + 2.0;
    u_xlat16_4.x = u_xlat22 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat14 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat1.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat14 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat5.xyz = vec3(u_xlat14) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xyw, u_xlat6.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = (-u_xlat1.x) + 2.0;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat14 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat14 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD7.w = u_xlat15 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat7.xyz;
    vs_TEXCOORD7.xyz = u_xlat3.xyz * vec3(u_xlat8) + u_xlat0.xyz;
    u_xlat0.x = 10.0 / _Density;
    u_xlat0.xyz = u_xlat0.xxx * _MainColor.xyz;
    vs_TEXCOORD8.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD8.w = float(1.0) / _ShoreTransparency;
    vs_TEXCOORD9.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD9.w = float(1.0) / _ShoreFoamDepth;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _LightColor0;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _MainColor;
uniform 	vec4 _DeepWaterColor;
uniform 	float _Fade;
uniform 	float _FresnelBias;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	float _ShoreFade;
uniform 	float _EnableRefractions;
uniform 	float _Refraction;
uniform 	float _ReflectionIntensity;
uniform 	float _Distortion;
uniform 	vec4 _ReflectionSkyCubeMap_HDR;
uniform 	vec3 _ES_SunDirection;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _SSRTexture;
uniform lowp samplerCube _ReflectionSkyCubeMap;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump float u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_10;
float u_xlat11;
vec3 u_xlat13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_19;
float u_xlat20;
mediump vec2 u_xlat16_21;
float u_xlat24;
float u_xlat27;
mediump float u_xlat16_27;
bool u_xlatb27;
float u_xlat29;
float u_xlat31;
lowp float u_xlat10_31;
float u_xlat33;
mediump float u_xlat16_33;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_10.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_10.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = u_xlat16_10.xz * vec2(0.150000006, 0.150000006);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.300000012, 1.0, 0.300000012);
    u_xlat16_21.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_21.x = inversesqrt(u_xlat16_21.x);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_21.xxx;
    u_xlat16_21.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat27 = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
    u_xlat27 = _ZBufferParams.z * u_xlat27 + _ZBufferParams.w;
    u_xlat27 = float(1.0) / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<_EnableRefractions);
#else
    u_xlatb2 = 0.00999999978<_EnableRefractions;
#endif
    if(u_xlatb2){
        u_xlat2.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat2.x = sqrt(u_xlat2.x);
        u_xlat2.x = u_xlat2.x + (-_UV_Mix_Start_Distance);
        u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.w;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat16_21.x = u_xlat2.x * u_xlat2.x;
        u_xlat16_21.x = u_xlat16_21.x * u_xlat16_21.x;
        u_xlat2.x = _Refraction * -0.75;
        u_xlat2.x = u_xlat16_21.x * u_xlat2.x + _Refraction;
        u_xlat11 = float(1.0) / vs_TEXCOORD6.w;
        u_xlat20 = u_xlat11 * vs_TEXCOORD6.z;
        u_xlat20 = u_xlat20 * 0.5 + 0.5;
        u_xlat16_21.xy = u_xlat2.xx * u_xlat16_3.xy;
        u_xlat2.x = u_xlat11 * 4.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat2.xy = u_xlat2.xx * u_xlat16_21.xy;
        u_xlat4.xy = u_xlat2.xy * vs_TEXCOORD6.ww;
        u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD6.ww + vs_TEXCOORD6.xy;
        u_xlat29 = vs_TEXCOORD6.w;
        u_xlat16_21.xy = u_xlat2.xy / vec2(u_xlat29);
        u_xlat2.x = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(u_xlat2.x>=u_xlat20);
#else
        u_xlatb2 = u_xlat2.x>=u_xlat20;
#endif
        u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
        u_xlat16_5.xy = u_xlat2.xx * u_xlat4.xy;
        u_xlat16_5.z = 0.0;
        u_xlat2.xyz = u_xlat16_5.xyz + vs_TEXCOORD6.xyw;
        u_xlat16_21.xy = u_xlat2.xy / u_xlat2.zz;
        u_xlat10_2.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_21.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_2.xyz;
    } else {
        u_xlat16_5.xyz = _MainColor.xyz;
    //ENDIF
    }
    u_xlat27 = u_xlat27 + (-vs_TEXCOORD6.w);
    u_xlat2.x = u_xlat27 * vs_TEXCOORD8.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _ShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.w = min(u_xlat2.x, 1.0);
    u_xlat4.xy = vec2(u_xlat27) * vec2(0.0500000007, -0.5);
    u_xlat4.x = u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat13.xyz = u_xlat4.yyy * vs_TEXCOORD8.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat13.xyz = min(max(u_xlat13.xyz, 0.0), 1.0);
#else
    u_xlat13.xyz = clamp(u_xlat13.xyz, 0.0, 1.0);
#endif
    u_xlat13.xyz = u_xlat13.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat13.xyz = log2(u_xlat13.xyz);
    u_xlat13.xyz = u_xlat13.xyz * vec3(_Fade);
    u_xlat13.xyz = exp2(u_xlat13.xyz);
    u_xlat13.xyz = u_xlat16_5.xyz * u_xlat13.xyz + _DeepWaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.xyz = min(max(u_xlat13.xyz, 0.0), 1.0);
#else
    u_xlat13.xyz = clamp(u_xlat13.xyz, 0.0, 1.0);
#endif
    u_xlat16_21.x = dot((-u_xlat0.xyz), vs_TEXCOORD5.xyz);
    u_xlat16_21.x = u_xlat16_21.x + u_xlat16_21.x;
    u_xlat16_5.xyz = vs_TEXCOORD5.xyz * (-u_xlat16_21.xxx) + (-u_xlat0.xyz);
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion));
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD6.ww;
    u_xlat6.xy = u_xlat4.xx * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vec2(0.5, 0.5);
    u_xlat24 = vs_TEXCOORD6.w * _ProjectionParams.w;
    u_xlat24 = u_xlat24 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat24) * (-u_xlat6.xy) + u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD6.xy;
    u_xlat16_21.xy = u_xlat6.xy / vs_TEXCOORD6.ww;
    u_xlat10_6 = texture(_SSRTexture, u_xlat16_21.xy);
    u_xlat7.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion)) + u_xlat16_5.xy;
    u_xlat7.z = u_xlat16_5.z;
    u_xlat10_3 = texture(_ReflectionSkyCubeMap, u_xlat7.xyz);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = _ReflectionSkyCubeMap_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.x;
    u_xlat16_14.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat16_8 = u_xlat10_6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat16_1.x * 0.00499999989;
    u_xlat16_33 = min(u_xlat16_33, 1.0);
    u_xlat16_33 = (-u_xlat16_33) * 0.800000012 + 1.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_8;
    u_xlat16_6.xyz = (-u_xlat16_5.xxx) * u_xlat10_3.xyz + u_xlat10_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_33) * u_xlat16_6.xyz + u_xlat16_14.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_33 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_7 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_7;
    u_xlat7.x = (-_FresnelBias) + 1.0;
    u_xlat33 = u_xlat7.x * u_xlat16_33 + _FresnelBias;
    u_xlat33 = u_xlat33 * _ReflectionIntensity;
    u_xlat4.x = u_xlat4.x * u_xlat33;
    u_xlat6.xyz = (-u_xlat13.xyz) + u_xlat16_6.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat27 = u_xlat27 * vs_TEXCOORD9.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10_31 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat27) + 1.0;
    u_xlat16_27 = u_xlat16_1.x * u_xlat10_31;
    u_xlat27 = u_xlat2.w * u_xlat16_27;
    u_xlat6.xyz = (-u_xlat4.xyz) + vs_TEXCOORD9.xyz;
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat6.xyz + u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0<_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0<_ES_SunDirection.xxyz.z;
#endif
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat0.xyz = vec3(u_xlat0.x + _ES_SunDirection.xxyz.y, u_xlat0.y + _ES_SunDirection.xxyz.z, u_xlat0.z + float(_ES_SunDirection.z));
    u_xlat31 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat31);
    u_xlat16_10.x = dot(u_xlat16_10.xyz, u_xlat0.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 9.99999975e-05);
    u_xlat16_19 = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_0 = log2(u_xlat16_10.x);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_19;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat16_0 * u_xlat16_1.x;
    u_xlat0.x = u_xlatb27 ? u_xlat0.x : float(0.0);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat0.x = u_xlat0.x * 0.200000003;
    u_xlat16_1.x = max(u_xlat0.x, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat4.xyz;
    u_xlat2.xyz = vs_TEXCOORD7.www * u_xlat16_1.xyz + vs_TEXCOORD7.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "WATER_FOAM" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	float _TimeEditor;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _MainColor;
uniform 	float _Density;
uniform 	float _ShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
uniform 	vec4 _FoamParams;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_11;
float u_xlat14;
float u_xlat15;
vec2 u_xlat16;
vec2 u_xlat17;
float u_xlat21;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = hlslcc_mtx4x4unity_WorldToObject[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_WorldToObject[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_WorldToObject[2].x;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16.x = sqrt(u_xlat21);
    u_xlat3.x = hlslcc_mtx4x4unity_WorldToObject[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_WorldToObject[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_WorldToObject[2].z;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16.y = sqrt(u_xlat21);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat16.xy;
    u_xlat16.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat21 = _Time.y + _TimeEditor;
    u_xlat21 = u_xlat21 * 0.100000001;
    u_xlat3.xy = vec2(float(u_xlat21) * _ShoreFoamParams.z, float(u_xlat21) * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat16.xy * u_xlat2.xy + u_xlat3.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat16_4.xy = u_xlat16.xy * in_TEXCOORD0.xy;
    u_xlat16_4.xy = u_xlat16_4.xy + u_xlat16_4.xy;
    u_xlat3.xy = vec2(float(u_xlat21) * _SmallWavesParams.z, float(u_xlat21) * _SmallWavesParams.w);
    u_xlat16_4.zw = u_xlat3.xy * vec2(1.5, 1.5) + u_xlat16_4.xy;
    u_xlat16_4.xy = in_TEXCOORD0.xy * u_xlat16.xy + u_xlat3.xy;
    vs_TEXCOORD1 = u_xlat16_4;
    u_xlat16.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat16_4.xy = u_xlat16.xy * in_TEXCOORD0.xy;
    u_xlat16_4.xy = u_xlat16_4.xy + u_xlat16_4.xy;
    u_xlat3.xy = vec2(float(u_xlat21) * _LargeWavesParams.z, float(u_xlat21) * _LargeWavesParams.w);
    u_xlat17.xy = vec2(float(u_xlat21) * _FoamParams.z, float(u_xlat21) * _FoamParams.w);
    u_xlat16_4.zw = u_xlat3.xy * vec2(1.5, 1.5) + u_xlat16_4.xy;
    u_xlat16_4.xy = in_TEXCOORD0.xy * u_xlat16.xy + u_xlat3.xy;
    vs_TEXCOORD2 = u_xlat16_4;
    u_xlat16.xy = in_TEXCOORD0.xy * _FoamParams.xy;
    u_xlat3.xy = u_xlat2.xy * u_xlat16.xy;
    u_xlat16_2.xy = u_xlat16.xy * u_xlat2.xy + u_xlat17.xy;
    u_xlat16_4.xy = u_xlat3.xy + u_xlat3.xy;
    u_xlat16_2.zw = u_xlat17.xy * vec2(1.5, 1.5) + u_xlat16_4.xy;
    vs_TEXCOORD3 = u_xlat16_2;
    vs_TEXCOORD4.w = float(1.0) / _UV_Mix_Range;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD5.xyz = vec3(u_xlat21) * u_xlat3.xyz;
    u_xlat21 = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat21 * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = u_xlat0.z * _HeigtFogParams.x;
    u_xlat8 = u_xlat1.x * -1.44269502;
    u_xlat8 = exp2(u_xlat8);
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat8 = u_xlat8 / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.00999999978<abs(u_xlat1.x));
#else
    u_xlatb1 = 0.00999999978<abs(u_xlat1.x);
#endif
    u_xlat16_4.x = (u_xlatb1) ? u_xlat8 : 1.0;
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat8 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat8 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat8 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat15 = u_xlat8 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_11 = (u_xlatb8) ? u_xlat15 : 1.0;
    u_xlat8 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_11 = u_xlat8 * u_xlat16_11;
    u_xlat16_11 = exp2((-u_xlat16_11));
    u_xlat16_4.y = (-u_xlat16_11) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat8 = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat8) + 2.0;
    u_xlat16_11 = u_xlat8 * u_xlat16_11;
    u_xlat8 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat8 = u_xlat8 + 1.0;
    u_xlat16_4.x = u_xlat8 * u_xlat16_4.x;
    u_xlat8 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat15 = (-u_xlat8) + 1.0;
    u_xlat22 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat7.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_4.x = (-u_xlat22) + 2.0;
    u_xlat16_4.x = u_xlat22 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7.x = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat1.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat7.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat6.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = (-u_xlat1.x) + 2.0;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat14 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat14 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD7.w = u_xlat15 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat7.xyz;
    vs_TEXCOORD7.xyz = u_xlat3.xyz * vec3(u_xlat8) + u_xlat0.xyz;
    u_xlat0.x = 10.0 / _Density;
    u_xlat0.xyz = u_xlat0.xxx * _MainColor.xyz;
    vs_TEXCOORD8.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD8.w = float(1.0) / _ShoreTransparency;
    vs_TEXCOORD9.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD9.w = float(1.0) / _ShoreFoamDepth;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _LightColor0;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _MainColor;
uniform 	vec4 _DeepWaterColor;
uniform 	float _Fade;
uniform 	float _FresnelBias;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	float _ShoreFade;
uniform 	float _EnableRefractions;
uniform 	float _Refraction;
uniform 	float _ReflectionIntensity;
uniform 	float _Distortion;
uniform 	vec4 _ReflectionSkyCubeMap_HDR;
uniform 	vec3 _ES_SunDirection;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _SSRTexture;
uniform lowp samplerCube _ReflectionSkyCubeMap;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump float u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_10;
float u_xlat11;
vec3 u_xlat13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_19;
float u_xlat20;
mediump vec2 u_xlat16_21;
float u_xlat24;
float u_xlat27;
mediump float u_xlat16_27;
bool u_xlatb27;
float u_xlat29;
float u_xlat31;
lowp float u_xlat10_31;
float u_xlat33;
mediump float u_xlat16_33;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_10.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_10.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = u_xlat16_10.xz * vec2(0.150000006, 0.150000006);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.300000012, 1.0, 0.300000012);
    u_xlat16_21.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_21.x = inversesqrt(u_xlat16_21.x);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_21.xxx;
    u_xlat16_21.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat27 = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
    u_xlat27 = _ZBufferParams.z * u_xlat27 + _ZBufferParams.w;
    u_xlat27 = float(1.0) / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<_EnableRefractions);
#else
    u_xlatb2 = 0.00999999978<_EnableRefractions;
#endif
    if(u_xlatb2){
        u_xlat2.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat2.x = sqrt(u_xlat2.x);
        u_xlat2.x = u_xlat2.x + (-_UV_Mix_Start_Distance);
        u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.w;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat16_21.x = u_xlat2.x * u_xlat2.x;
        u_xlat16_21.x = u_xlat16_21.x * u_xlat16_21.x;
        u_xlat2.x = _Refraction * -0.75;
        u_xlat2.x = u_xlat16_21.x * u_xlat2.x + _Refraction;
        u_xlat11 = float(1.0) / vs_TEXCOORD6.w;
        u_xlat20 = u_xlat11 * vs_TEXCOORD6.z;
        u_xlat20 = u_xlat20 * 0.5 + 0.5;
        u_xlat16_21.xy = u_xlat2.xx * u_xlat16_3.xy;
        u_xlat2.x = u_xlat11 * 4.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat2.xy = u_xlat2.xx * u_xlat16_21.xy;
        u_xlat4.xy = u_xlat2.xy * vs_TEXCOORD6.ww;
        u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD6.ww + vs_TEXCOORD6.xy;
        u_xlat29 = vs_TEXCOORD6.w;
        u_xlat16_21.xy = u_xlat2.xy / vec2(u_xlat29);
        u_xlat2.x = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(u_xlat2.x>=u_xlat20);
#else
        u_xlatb2 = u_xlat2.x>=u_xlat20;
#endif
        u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
        u_xlat16_5.xy = u_xlat2.xx * u_xlat4.xy;
        u_xlat16_5.z = 0.0;
        u_xlat2.xyz = u_xlat16_5.xyz + vs_TEXCOORD6.xyw;
        u_xlat16_21.xy = u_xlat2.xy / u_xlat2.zz;
        u_xlat10_2.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_21.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_2.xyz;
    } else {
        u_xlat16_5.xyz = _MainColor.xyz;
    //ENDIF
    }
    u_xlat27 = u_xlat27 + (-vs_TEXCOORD6.w);
    u_xlat2.x = u_xlat27 * vs_TEXCOORD8.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _ShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.w = min(u_xlat2.x, 1.0);
    u_xlat4.xy = vec2(u_xlat27) * vec2(0.0500000007, -0.5);
    u_xlat4.x = u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat13.xyz = u_xlat4.yyy * vs_TEXCOORD8.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat13.xyz = min(max(u_xlat13.xyz, 0.0), 1.0);
#else
    u_xlat13.xyz = clamp(u_xlat13.xyz, 0.0, 1.0);
#endif
    u_xlat13.xyz = u_xlat13.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat13.xyz = log2(u_xlat13.xyz);
    u_xlat13.xyz = u_xlat13.xyz * vec3(_Fade);
    u_xlat13.xyz = exp2(u_xlat13.xyz);
    u_xlat13.xyz = u_xlat16_5.xyz * u_xlat13.xyz + _DeepWaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.xyz = min(max(u_xlat13.xyz, 0.0), 1.0);
#else
    u_xlat13.xyz = clamp(u_xlat13.xyz, 0.0, 1.0);
#endif
    u_xlat16_21.x = dot((-u_xlat0.xyz), vs_TEXCOORD5.xyz);
    u_xlat16_21.x = u_xlat16_21.x + u_xlat16_21.x;
    u_xlat16_5.xyz = vs_TEXCOORD5.xyz * (-u_xlat16_21.xxx) + (-u_xlat0.xyz);
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion));
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD6.ww;
    u_xlat6.xy = u_xlat4.xx * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vec2(0.5, 0.5);
    u_xlat24 = vs_TEXCOORD6.w * _ProjectionParams.w;
    u_xlat24 = u_xlat24 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat24) * (-u_xlat6.xy) + u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD6.xy;
    u_xlat16_21.xy = u_xlat6.xy / vs_TEXCOORD6.ww;
    u_xlat10_6 = texture(_SSRTexture, u_xlat16_21.xy);
    u_xlat7.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion)) + u_xlat16_5.xy;
    u_xlat7.z = u_xlat16_5.z;
    u_xlat10_3 = texture(_ReflectionSkyCubeMap, u_xlat7.xyz);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = _ReflectionSkyCubeMap_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.x;
    u_xlat16_14.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat16_8 = u_xlat10_6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat16_1.x * 0.00499999989;
    u_xlat16_33 = min(u_xlat16_33, 1.0);
    u_xlat16_33 = (-u_xlat16_33) * 0.800000012 + 1.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_8;
    u_xlat16_6.xyz = (-u_xlat16_5.xxx) * u_xlat10_3.xyz + u_xlat10_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_33) * u_xlat16_6.xyz + u_xlat16_14.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_33 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_7 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_7;
    u_xlat7.x = (-_FresnelBias) + 1.0;
    u_xlat33 = u_xlat7.x * u_xlat16_33 + _FresnelBias;
    u_xlat33 = u_xlat33 * _ReflectionIntensity;
    u_xlat4.x = u_xlat4.x * u_xlat33;
    u_xlat6.xyz = (-u_xlat13.xyz) + u_xlat16_6.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat27 = u_xlat27 * vs_TEXCOORD9.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10_31 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat27) + 1.0;
    u_xlat16_27 = u_xlat16_1.x * u_xlat10_31;
    u_xlat27 = u_xlat2.w * u_xlat16_27;
    u_xlat6.xyz = (-u_xlat4.xyz) + vs_TEXCOORD9.xyz;
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat6.xyz + u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0<_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0<_ES_SunDirection.xxyz.z;
#endif
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat0.xyz = vec3(u_xlat0.x + _ES_SunDirection.xxyz.y, u_xlat0.y + _ES_SunDirection.xxyz.z, u_xlat0.z + float(_ES_SunDirection.z));
    u_xlat31 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat31);
    u_xlat16_10.x = dot(u_xlat16_10.xyz, u_xlat0.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 9.99999975e-05);
    u_xlat16_19 = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_0 = log2(u_xlat16_10.x);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_19;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat16_0 * u_xlat16_1.x;
    u_xlat0.x = u_xlatb27 ? u_xlat0.x : float(0.0);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat0.x = u_xlat0.x * 0.200000003;
    u_xlat16_1.x = max(u_xlat0.x, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat4.xyz;
    u_xlat2.xyz = vs_TEXCOORD7.www * u_xlat16_1.xyz + vs_TEXCOORD7.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "WATER_FOAM" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	float _TimeEditor;
uniform 	float _UV_Mix_Range;
uniform 	vec4 _SmallWavesParams;
uniform 	vec4 _LargeWavesParams;
uniform 	vec4 _MainColor;
uniform 	float _Density;
uniform 	float _ShoreTransparency;
uniform 	vec4 _ShoreFoamParams;
uniform 	vec4 _ShoreFoamColor;
uniform 	float _ShoreFoamColorStrength;
uniform 	float _ShoreFoamDepth;
uniform 	vec4 _FoamParams;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
vec2 u_xlat10;
mediump float u_xlat16_11;
float u_xlat14;
float u_xlat15;
vec2 u_xlat16;
float u_xlat22;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16.x = sqrt(u_xlat2.x);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].z;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16.y = sqrt(u_xlat2.x);
    u_xlat2.xy = vec2(0.100000001, 0.100000001) / u_xlat16.xy;
    u_xlat16.xy = in_TEXCOORD0.xy * _ShoreFoamParams.xy;
    u_xlat3.x = _Time.y + _TimeEditor;
    u_xlat3.x = u_xlat3.x * 0.100000001;
    u_xlat10.xy = vec2(u_xlat3.x * _ShoreFoamParams.z, u_xlat3.x * _ShoreFoamParams.w);
    vs_TEXCOORD0.zw = u_xlat16.xy * u_xlat2.xy + u_xlat10.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16.xy = u_xlat2.xy * _SmallWavesParams.xy;
    u_xlat16_4.xy = u_xlat16.xy * in_TEXCOORD0.xy;
    u_xlat16_4.xy = u_xlat16_4.xy + u_xlat16_4.xy;
    u_xlat10.xy = vec2(u_xlat3.x * _SmallWavesParams.z, u_xlat3.x * _SmallWavesParams.w);
    u_xlat16_4.zw = u_xlat10.xy * vec2(1.5, 1.5) + u_xlat16_4.xy;
    u_xlat16_4.xy = in_TEXCOORD0.xy * u_xlat16.xy + u_xlat10.xy;
    vs_TEXCOORD1 = u_xlat16_4;
    u_xlat16.xy = u_xlat2.xy * _LargeWavesParams.xy;
    u_xlat16_4.xy = u_xlat16.xy * in_TEXCOORD0.xy;
    u_xlat16_4.xy = u_xlat16_4.xy + u_xlat16_4.xy;
    u_xlat10.xy = vec2(u_xlat3.x * _LargeWavesParams.z, u_xlat3.x * _LargeWavesParams.w);
    u_xlat3.xw = vec2(u_xlat3.x * _FoamParams.z, u_xlat3.x * _FoamParams.w);
    u_xlat16_4.zw = u_xlat10.xy * vec2(1.5, 1.5) + u_xlat16_4.xy;
    u_xlat16_4.xy = in_TEXCOORD0.xy * u_xlat16.xy + u_xlat10.xy;
    vs_TEXCOORD2 = u_xlat16_4;
    u_xlat16.xy = in_TEXCOORD0.xy * _FoamParams.xy;
    u_xlat10.xy = u_xlat2.xy * u_xlat16.xy;
    u_xlat16_2.xy = u_xlat16.xy * u_xlat2.xy + u_xlat3.xw;
    u_xlat16_4.xy = u_xlat10.xy + u_xlat10.xy;
    u_xlat16_2.zw = u_xlat3.xw * vec2(1.5, 1.5) + u_xlat16_4.xy;
    vs_TEXCOORD3 = u_xlat16_2;
    vs_TEXCOORD4.w = float(1.0) / _UV_Mix_Range;
    vs_TEXCOORD4.xyz = u_xlat7.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat0.x * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat0.xyw = u_xlat7.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = u_xlat0.y * _HeigtFogParams.x;
    u_xlat8 = u_xlat1.x * -1.44269502;
    u_xlat8 = exp2(u_xlat8);
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat8 = u_xlat8 / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.00999999978<abs(u_xlat1.x));
#else
    u_xlatb1 = 0.00999999978<abs(u_xlat1.x);
#endif
    u_xlat16_4.x = (u_xlatb1) ? u_xlat8 : 1.0;
    u_xlat1.x = dot(u_xlat0.xyw, u_xlat0.xyw);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat8 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat8 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat8 = u_xlat0.y * _HeigtFogParams2.x;
    u_xlat15 = u_xlat8 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_11 = (u_xlatb8) ? u_xlat15 : 1.0;
    u_xlat8 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_11 = u_xlat8 * u_xlat16_11;
    u_xlat16_11 = exp2((-u_xlat16_11));
    u_xlat16_4.y = (-u_xlat16_11) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat8 = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat8) + 2.0;
    u_xlat16_11 = u_xlat8 * u_xlat16_11;
    u_xlat8 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat8 = u_xlat8 + 1.0;
    u_xlat16_4.x = u_xlat8 * u_xlat16_4.x;
    u_xlat8 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat15 = (-u_xlat8) + 1.0;
    u_xlat22 = u_xlat7.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat7.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_4.x = (-u_xlat22) + 2.0;
    u_xlat16_4.x = u_xlat22 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat14 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat1.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat14 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat5.xyz = vec3(u_xlat14) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xyw, u_xlat6.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = (-u_xlat1.x) + 2.0;
    u_xlat7.x = u_xlat7.x * u_xlat1.x;
    u_xlat14 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat14 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD7.w = u_xlat15 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat7.xyz;
    vs_TEXCOORD7.xyz = u_xlat3.xyz * vec3(u_xlat8) + u_xlat0.xyz;
    u_xlat0.x = 10.0 / _Density;
    u_xlat0.xyz = u_xlat0.xxx * _MainColor.xyz;
    vs_TEXCOORD8.xyz = vec3(1.0, 1.0, 1.0) / u_xlat0.xyz;
    vs_TEXCOORD8.w = float(1.0) / _ShoreTransparency;
    vs_TEXCOORD9.xyz = _ShoreFoamColor.xyz * vec3(_ShoreFoamColorStrength);
    vs_TEXCOORD9.w = float(1.0) / _ShoreFoamDepth;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _LightColor0;
uniform 	float _UV_Mix_Start_Distance;
uniform 	vec4 _MainColor;
uniform 	vec4 _DeepWaterColor;
uniform 	float _Fade;
uniform 	float _FresnelBias;
uniform 	float _Specular;
uniform 	float _Gloss;
uniform 	float _ShoreFade;
uniform 	float _EnableRefractions;
uniform 	float _Refraction;
uniform 	float _ReflectionIntensity;
uniform 	float _Distortion;
uniform 	vec4 _ReflectionSkyCubeMap_HDR;
uniform 	vec3 _ES_SunDirection;
uniform lowp sampler2D _SmallWavesTexture;
uniform lowp sampler2D _LargeWavesTexture;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _SceneScaledBufferBeforTransParent;
uniform lowp sampler2D _SSRTexture;
uniform lowp samplerCube _ReflectionSkyCubeMap;
uniform lowp sampler2D _ShoreFoam;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec4 u_xlat10_6;
vec3 u_xlat7;
mediump float u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_10;
float u_xlat11;
vec3 u_xlat13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_19;
float u_xlat20;
mediump vec2 u_xlat16_21;
float u_xlat24;
float u_xlat27;
mediump float u_xlat16_27;
bool u_xlatb27;
float u_xlat29;
float u_xlat31;
lowp float u_xlat10_31;
float u_xlat33;
mediump float u_xlat16_33;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat16_1.xxx;
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_SmallWavesTexture, vs_TEXCOORD1.zw).xy;
    u_xlat16_10.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_10.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.xy).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10_2.xy = texture(_LargeWavesTexture, vs_TEXCOORD2.zw).xy;
    u_xlat16_3.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + u_xlat16_3.xy;
    u_xlat16_10.xy = u_xlat16_10.xy + u_xlat16_3.xy;
    u_xlat16_3.xz = u_xlat16_10.xy + vec2(-1.0, -1.0);
    u_xlat16_3.y = 1.0;
    u_xlat16_10.x = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xy = u_xlat16_10.xz * vec2(0.150000006, 0.150000006);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.300000012, 1.0, 0.300000012);
    u_xlat16_21.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_21.x = inversesqrt(u_xlat16_21.x);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_21.xxx;
    u_xlat16_21.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat27 = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
    u_xlat27 = _ZBufferParams.z * u_xlat27 + _ZBufferParams.w;
    u_xlat27 = float(1.0) / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<_EnableRefractions);
#else
    u_xlatb2 = 0.00999999978<_EnableRefractions;
#endif
    if(u_xlatb2){
        u_xlat2.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat2.x = sqrt(u_xlat2.x);
        u_xlat2.x = u_xlat2.x + (-_UV_Mix_Start_Distance);
        u_xlat2.x = u_xlat2.x * vs_TEXCOORD4.w;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat16_21.x = u_xlat2.x * u_xlat2.x;
        u_xlat16_21.x = u_xlat16_21.x * u_xlat16_21.x;
        u_xlat2.x = _Refraction * -0.75;
        u_xlat2.x = u_xlat16_21.x * u_xlat2.x + _Refraction;
        u_xlat11 = float(1.0) / vs_TEXCOORD6.w;
        u_xlat20 = u_xlat11 * vs_TEXCOORD6.z;
        u_xlat20 = u_xlat20 * 0.5 + 0.5;
        u_xlat16_21.xy = u_xlat2.xx * u_xlat16_3.xy;
        u_xlat2.x = u_xlat11 * 4.0;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat2.xy = u_xlat2.xx * u_xlat16_21.xy;
        u_xlat4.xy = u_xlat2.xy * vs_TEXCOORD6.ww;
        u_xlat2.xy = u_xlat2.xy * vs_TEXCOORD6.ww + vs_TEXCOORD6.xy;
        u_xlat29 = vs_TEXCOORD6.w;
        u_xlat16_21.xy = u_xlat2.xy / vec2(u_xlat29);
        u_xlat2.x = texture(_CameraDepthTexture, u_xlat16_21.xy).x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(u_xlat2.x>=u_xlat20);
#else
        u_xlatb2 = u_xlat2.x>=u_xlat20;
#endif
        u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
        u_xlat16_5.xy = u_xlat2.xx * u_xlat4.xy;
        u_xlat16_5.z = 0.0;
        u_xlat2.xyz = u_xlat16_5.xyz + vs_TEXCOORD6.xyw;
        u_xlat16_21.xy = u_xlat2.xy / u_xlat2.zz;
        u_xlat10_2.xyz = texture(_SceneScaledBufferBeforTransParent, u_xlat16_21.xy).xyz;
        u_xlat16_5.xyz = u_xlat10_2.xyz;
    } else {
        u_xlat16_5.xyz = _MainColor.xyz;
    //ENDIF
    }
    u_xlat27 = u_xlat27 + (-vs_TEXCOORD6.w);
    u_xlat2.x = u_xlat27 * vs_TEXCOORD8.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x + 9.99999975e-05;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _ShoreFade;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.w = min(u_xlat2.x, 1.0);
    u_xlat4.xy = vec2(u_xlat27) * vec2(0.0500000007, -0.5);
    u_xlat4.x = u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat13.xyz = u_xlat4.yyy * vs_TEXCOORD8.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat13.xyz = min(max(u_xlat13.xyz, 0.0), 1.0);
#else
    u_xlat13.xyz = clamp(u_xlat13.xyz, 0.0, 1.0);
#endif
    u_xlat13.xyz = u_xlat13.xyz + vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05);
    u_xlat13.xyz = log2(u_xlat13.xyz);
    u_xlat13.xyz = u_xlat13.xyz * vec3(_Fade);
    u_xlat13.xyz = exp2(u_xlat13.xyz);
    u_xlat13.xyz = u_xlat16_5.xyz * u_xlat13.xyz + _DeepWaterColor.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.xyz = min(max(u_xlat13.xyz, 0.0), 1.0);
#else
    u_xlat13.xyz = clamp(u_xlat13.xyz, 0.0, 1.0);
#endif
    u_xlat16_21.x = dot((-u_xlat0.xyz), vs_TEXCOORD5.xyz);
    u_xlat16_21.x = u_xlat16_21.x + u_xlat16_21.x;
    u_xlat16_5.xyz = vs_TEXCOORD5.xyz * (-u_xlat16_21.xxx) + (-u_xlat0.xyz);
    u_xlat6.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion));
    u_xlat6.xy = u_xlat6.xy * vs_TEXCOORD6.ww;
    u_xlat6.xy = u_xlat4.xx * u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy * vec2(0.5, 0.5);
    u_xlat24 = vs_TEXCOORD6.w * _ProjectionParams.w;
    u_xlat24 = u_xlat24 * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat6.xy = vec2(u_xlat24) * (-u_xlat6.xy) + u_xlat6.xy;
    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD6.xy;
    u_xlat16_21.xy = u_xlat6.xy / vs_TEXCOORD6.ww;
    u_xlat10_6 = texture(_SSRTexture, u_xlat16_21.xy);
    u_xlat7.xy = u_xlat16_3.xy * vec2(vec2(_Distortion, _Distortion)) + u_xlat16_5.xy;
    u_xlat7.z = u_xlat16_5.z;
    u_xlat10_3 = texture(_ReflectionSkyCubeMap, u_xlat7.xyz);
    u_xlat16_5.x = u_xlat10_3.w + -1.0;
    u_xlat16_5.x = _ReflectionSkyCubeMap_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.y;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ReflectionSkyCubeMap_HDR.x;
    u_xlat16_14.xyz = u_xlat10_3.xyz * u_xlat16_5.xxx;
    u_xlat16_8 = u_xlat10_6.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8 = min(max(u_xlat16_8, 0.0), 1.0);
#else
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat16_1.x * 0.00499999989;
    u_xlat16_33 = min(u_xlat16_33, 1.0);
    u_xlat16_33 = (-u_xlat16_33) * 0.800000012 + 1.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_8;
    u_xlat16_6.xyz = (-u_xlat16_5.xxx) * u_xlat10_3.xyz + u_xlat10_6.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_33) * u_xlat16_6.xyz + u_xlat16_14.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_33 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_7 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_7;
    u_xlat7.x = (-_FresnelBias) + 1.0;
    u_xlat33 = u_xlat7.x * u_xlat16_33 + _FresnelBias;
    u_xlat33 = u_xlat33 * _ReflectionIntensity;
    u_xlat4.x = u_xlat4.x * u_xlat33;
    u_xlat6.xyz = (-u_xlat13.xyz) + u_xlat16_6.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat27 = u_xlat27 * vs_TEXCOORD9.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat10_31 = texture(_ShoreFoam, vs_TEXCOORD0.zw).x;
    u_xlat16_1.x = (-u_xlat27) + 1.0;
    u_xlat16_27 = u_xlat16_1.x * u_xlat10_31;
    u_xlat27 = u_xlat2.w * u_xlat16_27;
    u_xlat6.xyz = (-u_xlat4.xyz) + vs_TEXCOORD9.xyz;
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat6.xyz + u_xlat4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.0<_ES_SunDirection.xxyz.z);
#else
    u_xlatb27 = 0.0<_ES_SunDirection.xxyz.z;
#endif
    u_xlat16_1.x = _Gloss * 20.3718395 + 0.318309993;
    u_xlat0.xyz = vec3(u_xlat0.x + _ES_SunDirection.xxyz.y, u_xlat0.y + _ES_SunDirection.xxyz.z, u_xlat0.z + float(_ES_SunDirection.z));
    u_xlat31 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat31);
    u_xlat16_10.x = dot(u_xlat16_10.xyz, u_xlat0.xyz);
    u_xlat16_10.x = max(u_xlat16_10.x, 9.99999975e-05);
    u_xlat16_19 = _Gloss * 128.0 + 9.99999997e-07;
    u_xlat16_0 = log2(u_xlat16_10.x);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_19;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat16_0 * u_xlat16_1.x;
    u_xlat0.x = u_xlatb27 ? u_xlat0.x : float(0.0);
    u_xlat0.x = u_xlat0.x * _Specular;
    u_xlat0.x = u_xlat0.x * 0.200000003;
    u_xlat16_1.x = max(u_xlat0.x, 0.0);
    u_xlat16_1.x = min(u_xlat16_1.x, 16.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz + u_xlat4.xyz;
    u_xlat2.xyz = vs_TEXCOORD7.www * u_xlat16_1.xyz + vs_TEXCOORD7.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
Keywords { "WATER_REFRACTIVE" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "WATER_REFRACTIVE" }
""
}
SubProgram "gles3 " {
Keywords { "WATER_REFLECTIVE" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "WATER_REFLECTIVE" }
""
}
SubProgram "gles3 " {
Keywords { "WATER_SHORE_FOAM" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "WATER_SHORE_FOAM" }
""
}
SubProgram "gles3 " {
Keywords { "WATER_FOAM" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "WATER_FOAM" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "WATER_REFRACTIVE" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "WATER_REFRACTIVE" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "WATER_REFLECTIVE" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "WATER_REFLECTIVE" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "WATER_SHORE_FOAM" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "WATER_SHORE_FOAM" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "WATER_FOAM" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "WATER_FOAM" }
""
}
}
}
}
}