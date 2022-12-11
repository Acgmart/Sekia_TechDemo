//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Particles/Alpha Blended" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Toggle(ENABLE_SHADING_ON)] _ApplyShading ("Apply Shading", Float) = 0
[Toggle(TEXTURE_SCALE)] _TextureScale ("Texture Scale", Float) = 0
_TSAspectRatio ("Texture Aspect Ratio (width : height)", Float) = 1
[Toggle(DISTORTION)] _Distortion ("Distortion", Float) = 0
_DistortionTex ("Distortion Tex", 2D) = "gray" { }
_DistortionIntensity ("Distortion Intensity", Range(0, 10)) = 5
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
[Enum(OFF,0,ON,1)] _SOFTPARTICLES ("SOFTPARTICLES", Float) = 0
_DepthThresh ("DepthThresh", Range(0.001, 20)) = 1
_DepthFade ("DepthFade", Range(0.001, 20)) = 1
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
}
SubShader {
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "DebugView" = "On" "Distortion" = "None" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 43127
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _SOFTPARTICLES;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
bool u_xlatb2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES);
#endif
    vs_TEXCOORD2.z = (u_xlatb2) ? (-u_xlat0.x) : u_xlat1.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD4.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	float _SOFTPARTICLES;
uniform 	float _DepthThresh;
uniform 	float _DepthFade;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
float u_xlat6;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat10_1;
    u_xlat16_2.xyz = u_xlat0.xyz * vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb0 = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat0.xyxx, (-u_xlat0.xyxx)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb1.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlat0.xy = uintBitsToFloat(uvec2(u_xlat0.xy));
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[floatBitsToInt(u_xlat0).x]);
            u_xlat0.x = _DitherAlpha * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat0.x<0.0);
#else
            u_xlatb0 = u_xlat0.x<0.0;
#endif
            if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
        //ENDIF
        }
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_SOFTPARTICLES==1.0);
#else
    u_xlatb0 = _SOFTPARTICLES==1.0;
#endif
    if(u_xlatb0){
        u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
        u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
        u_xlat3.x = float(1.0) / u_xlat3.x;
        u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD2.z);
        u_xlat6 = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
        u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
        u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
        u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat6) + 1.0;
        u_xlat0.y = u_xlat3.x * u_xlat1.x + u_xlat6;
    //ENDIF
    }
    u_xlat0.x = (u_xlatb0) ? u_xlat0.y : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "ENABLE_SHADING_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MainTex_ST;
uniform 	float _SOFTPARTICLES;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES);
#endif
    vs_TEXCOORD2.z = (u_xlatb1) ? (-u_xlat15) : u_xlat2.z;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat2.w;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_18 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = vec3(u_xlat16_18) * _LightColor0.xyz + u_xlat16_3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	float _SOFTPARTICLES;
uniform 	float _DepthThresh;
uniform 	float _DepthFade;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
float u_xlat6;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat10_1;
    u_xlat16_2.xyz = u_xlat0.xyz * vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb0 = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat0.xyxx, (-u_xlat0.xyxx)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb1.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlat0.xy = uintBitsToFloat(uvec2(u_xlat0.xy));
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[floatBitsToInt(u_xlat0).x]);
            u_xlat0.x = _DitherAlpha * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat0.x<0.0);
#else
            u_xlatb0 = u_xlat0.x<0.0;
#endif
            if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
        //ENDIF
        }
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_SOFTPARTICLES==1.0);
#else
    u_xlatb0 = _SOFTPARTICLES==1.0;
#endif
    if(u_xlatb0){
        u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
        u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
        u_xlat3.x = float(1.0) / u_xlat3.x;
        u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD2.z);
        u_xlat6 = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
        u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
        u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
        u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat6) + 1.0;
        u_xlat0.y = u_xlat3.x * u_xlat1.x + u_xlat6;
    //ENDIF
    }
    u_xlat0.x = (u_xlatb0) ? u_xlat0.y : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _SOFTPARTICLES;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
bool u_xlatb2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES);
#endif
    vs_TEXCOORD2.z = (u_xlatb2) ? (-u_xlat0.x) : u_xlat1.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD4.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	float _SOFTPARTICLES;
uniform 	float _DepthThresh;
uniform 	float _DepthFade;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
float u_xlat6;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat10_1;
    u_xlat16_2.xyz = u_xlat0.xyz * vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb0 = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat0.xyxx, (-u_xlat0.xyxx)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb1.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlat0.xy = uintBitsToFloat(uvec2(u_xlat0.xy));
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[floatBitsToInt(u_xlat0).x]);
            u_xlat0.x = _DitherAlpha * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat0.x<0.0);
#else
            u_xlatb0 = u_xlat0.x<0.0;
#endif
            if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
        //ENDIF
        }
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_SOFTPARTICLES==1.0);
#else
    u_xlatb0 = _SOFTPARTICLES==1.0;
#endif
    if(u_xlatb0){
        u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
        u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
        u_xlat3.x = float(1.0) / u_xlat3.x;
        u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD2.z);
        u_xlat6 = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
        u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
        u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
        u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat6) + 1.0;
        u_xlat0.y = u_xlat3.x * u_xlat1.x + u_xlat6;
    //ENDIF
    }
    u_xlat0.x = (u_xlatb0) ? u_xlat0.y : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "ENABLE_SHADING_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MainTex_ST;
uniform 	float _SOFTPARTICLES;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES);
#endif
    vs_TEXCOORD2.z = (u_xlatb1) ? (-u_xlat15) : u_xlat2.z;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat2.w;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_18 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = vec3(u_xlat16_18) * _LightColor0.xyz + u_xlat16_3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	float _SOFTPARTICLES;
uniform 	float _DepthThresh;
uniform 	float _DepthFade;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
float u_xlat6;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat10_1;
    u_xlat16_2.xyz = u_xlat0.xyz * vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb0 = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat0.xyxx, (-u_xlat0.xyxx)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb1.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlat0.xy = uintBitsToFloat(uvec2(u_xlat0.xy));
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[floatBitsToInt(u_xlat0).x]);
            u_xlat0.x = _DitherAlpha * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat0.x<0.0);
#else
            u_xlatb0 = u_xlat0.x<0.0;
#endif
            if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
        //ENDIF
        }
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_SOFTPARTICLES==1.0);
#else
    u_xlatb0 = _SOFTPARTICLES==1.0;
#endif
    if(u_xlatb0){
        u_xlat3.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
        u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
        u_xlat3.x = float(1.0) / u_xlat3.x;
        u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD2.z);
        u_xlat6 = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
        u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
        u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
        u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat6) + 1.0;
        u_xlat0.y = u_xlat3.x * u_xlat1.x + u_xlat6;
    //ENDIF
    }
    u_xlat0.x = (u_xlatb0) ? u_xlat0.y : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _SOFTPARTICLES;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
bool u_xlatb2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES);
#endif
    vs_TEXCOORD2.z = (u_xlatb2) ? (-u_xlat0.x) : u_xlat1.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD4.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump float _EmissionScaler;
uniform 	float _SOFTPARTICLES;
uniform 	float _DepthThresh;
uniform 	float _DepthFade;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bvec2 u_xlatb8;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb1 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb1){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        return;
    } else {
        u_xlat16_1 = _TintColor + _TintColor;
        u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
        u_xlat0 = u_xlat10_0 * u_xlat16_1;
        u_xlat16_3.xyz = u_xlat0.xyz * vs_TEXCOORD4.xyz;
        u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(_EmissionScaler);
        u_xlat16_14 = u_xlat0.w;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb0.x){
        u_xlat0.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat0.x = max(u_xlat0.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(256.0<u_xlat0.x);
#else
        u_xlatb4 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb4)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb0.x){
        u_xlat0.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat8.xy = dFdx(u_xlat0.xy);
        u_xlat0.xy = dFdy(u_xlat0.xy);
        u_xlat8.x = dot(u_xlat8.xy, u_xlat8.xy);
        u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
        u_xlat0.x = max(u_xlat0.x, u_xlat8.x);
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.5;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + 1.0;
        u_xlat4.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat0.x = u_xlat4.x / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(256.0<u_xlat0.x);
#else
        u_xlatb4 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb4)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==100.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==100.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==101.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==101.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==102.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==102.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==103.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==103.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0.x = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb0.x = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb0.x){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlat0.xy = uintBitsToFloat(uvec2(u_xlat0.xy));
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[floatBitsToInt(u_xlat0).x]);
            u_xlat0.x = _DitherAlpha * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
            u_xlatb0.x = !!(u_xlat0.x<0.0);
#else
            u_xlatb0.x = u_xlat0.x<0.0;
#endif
            if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
        //ENDIF
        }
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_SOFTPARTICLES==1.0);
#else
    u_xlatb0.x = _SOFTPARTICLES==1.0;
#endif
    if(u_xlatb0.x){
        u_xlat4.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
        u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
        u_xlat4.x = float(1.0) / u_xlat4.x;
        u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD2.z);
        u_xlat8.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
        u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
        u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
        u_xlat4.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
        u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat8.x) + 1.0;
        u_xlat0.y = u_xlat4.x * u_xlat12 + u_xlat8.x;
    //ENDIF
    }
    u_xlat0.x = (u_xlatb0.x) ? u_xlat0.y : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_14;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_2.xyz;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "ENABLE_SHADING_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MainTex_ST;
uniform 	float _SOFTPARTICLES;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES);
#endif
    vs_TEXCOORD2.z = (u_xlatb1) ? (-u_xlat15) : u_xlat2.z;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat2.w;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_18 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = vec3(u_xlat16_18) * _LightColor0.xyz + u_xlat16_3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump float _EmissionScaler;
uniform 	float _SOFTPARTICLES;
uniform 	float _DepthThresh;
uniform 	float _DepthFade;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bvec2 u_xlatb8;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb1 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb1){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        return;
    } else {
        u_xlat16_1 = _TintColor + _TintColor;
        u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
        u_xlat0 = u_xlat10_0 * u_xlat16_1;
        u_xlat16_3.xyz = u_xlat0.xyz * vs_TEXCOORD4.xyz;
        u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(_EmissionScaler);
        u_xlat16_14 = u_xlat0.w;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb0.x){
        u_xlat0.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat0.x = max(u_xlat0.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(256.0<u_xlat0.x);
#else
        u_xlatb4 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb4)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb0.x){
        u_xlat0.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat8.xy = dFdx(u_xlat0.xy);
        u_xlat0.xy = dFdy(u_xlat0.xy);
        u_xlat8.x = dot(u_xlat8.xy, u_xlat8.xy);
        u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
        u_xlat0.x = max(u_xlat0.x, u_xlat8.x);
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.5;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + 1.0;
        u_xlat4.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat0.x = u_xlat4.x / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(256.0<u_xlat0.x);
#else
        u_xlatb4 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb4)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==100.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==100.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==101.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==101.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==102.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==102.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==103.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==103.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0.x = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb0.x = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb0.x){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlat0.xy = uintBitsToFloat(uvec2(u_xlat0.xy));
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[floatBitsToInt(u_xlat0).x]);
            u_xlat0.x = _DitherAlpha * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
            u_xlatb0.x = !!(u_xlat0.x<0.0);
#else
            u_xlatb0.x = u_xlat0.x<0.0;
#endif
            if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
        //ENDIF
        }
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_SOFTPARTICLES==1.0);
#else
    u_xlatb0.x = _SOFTPARTICLES==1.0;
#endif
    if(u_xlatb0.x){
        u_xlat4.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
        u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
        u_xlat4.x = float(1.0) / u_xlat4.x;
        u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD2.z);
        u_xlat8.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
        u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
        u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
        u_xlat4.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
        u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat8.x) + 1.0;
        u_xlat0.y = u_xlat4.x * u_xlat12 + u_xlat8.x;
    //ENDIF
    }
    u_xlat0.x = (u_xlatb0.x) ? u_xlat0.y : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_14;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_2.xyz;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _SOFTPARTICLES;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
bool u_xlatb2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES);
#endif
    vs_TEXCOORD2.z = (u_xlatb2) ? (-u_xlat0.x) : u_xlat1.z;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD4.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vs_TEXCOORD4.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "ENABLE_SHADING_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MainTex_ST;
uniform 	float _SOFTPARTICLES;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat15 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES);
#endif
    vs_TEXCOORD2.z = (u_xlatb1) ? (-u_xlat15) : u_xlat2.z;
    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat15 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat2.w;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_18 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = vec3(u_xlat16_18) * _LightColor0.xyz + u_xlat16_3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vs_TEXCOORD4.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _SOFTPARTICLES;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_9;
float u_xlat12;
float u_xlat13;
float u_xlat18;
float u_xlat19;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat18 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES);
#endif
    vs_TEXCOORD2.z = (u_xlatb1) ? (-u_xlat18) : u_xlat2.z;
    u_xlat18 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat18 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat2.w;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = u_xlat0.z * _HeigtFogParams.x;
    u_xlat7 = u_xlat1.x * -1.44269502;
    u_xlat7 = exp2(u_xlat7);
    u_xlat7 = (-u_xlat7) + 1.0;
    u_xlat7 = u_xlat7 / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.00999999978<abs(u_xlat1.x));
#else
    u_xlatb1 = 0.00999999978<abs(u_xlat1.x);
#endif
    u_xlat16_3.x = (u_xlatb1) ? u_xlat7 : 1.0;
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat7 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat7 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat7 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat13 = u_xlat7 * -1.44269502;
    u_xlat13 = exp2(u_xlat13);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat13 = u_xlat13 / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7);
#endif
    u_xlat16_9 = (u_xlatb7) ? u_xlat13 : 1.0;
    u_xlat7 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_9 = u_xlat7 * u_xlat16_9;
    u_xlat16_9 = exp2((-u_xlat16_9));
    u_xlat16_3.y = (-u_xlat16_9) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat7 = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat7) + 2.0;
    u_xlat16_9 = u_xlat7 * u_xlat16_9;
    u_xlat7 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat7 = u_xlat7 + 1.0;
    u_xlat16_3.x = u_xlat7 * u_xlat16_3.x;
    u_xlat7 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat13 = (-u_xlat7) + 1.0;
    u_xlat19 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat19) + 2.0;
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat4.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat6.x = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat1.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat6.xxx * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat5.xyz);
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat6.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat6.x;
#endif
    u_xlat6.x = (-u_xlat1.x) + 2.0;
    u_xlat6.x = u_xlat6.x * u_xlat1.x;
    u_xlat12 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat12 : u_xlat6.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat6.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat13 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat13) * u_xlat6.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz * vec3(u_xlat7) + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	float _SOFTPARTICLES;
uniform 	float _DepthThresh;
uniform 	float _DepthFade;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat3;
vec2 u_xlat4;
float u_xlat8;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat10_1;
    u_xlat16_2.xyz = u_xlat0.xyz * vs_TEXCOORD4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb0 = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat0.xyxx, (-u_xlat0.xyxx)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb1.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlat0.xy = uintBitsToFloat(uvec2(u_xlat0.xy));
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[floatBitsToInt(u_xlat0).x]);
            u_xlat0.x = _DitherAlpha * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat0.x<0.0);
#else
            u_xlatb0 = u_xlat0.x<0.0;
#endif
            if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat0.x = vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat16_2.xyz * u_xlat0.xxx + vs_TEXCOORD3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_SOFTPARTICLES==1.0);
#else
    u_xlatb0 = _SOFTPARTICLES==1.0;
#endif
    if(u_xlatb0){
        u_xlat4.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
        u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
        u_xlat4.x = float(1.0) / u_xlat4.x;
        u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD2.z);
        u_xlat8 = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
        u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
        u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
        u_xlat4.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
        u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
        u_xlat3 = (-u_xlat8) + 1.0;
        u_xlat0.y = u_xlat4.x * u_xlat3 + u_xlat8;
    //ENDIF
    }
    u_xlat0.x = (u_xlatb0) ? u_xlat0.y : 1.0;
    u_xlat1.w = u_xlat0.x * u_xlat0.w;
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
Keywords { "FOG_HEIGHT" "ENABLE_SHADING_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _SOFTPARTICLES;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat7;
vec3 u_xlat8;
mediump float u_xlat16_9;
float u_xlat13;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
mediump float u_xlat16_21;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat18 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES);
#endif
    vs_TEXCOORD2.z = (u_xlatb1) ? (-u_xlat18) : u_xlat2.z;
    u_xlat18 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat18 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat2.w;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat19 = u_xlat18 * -1.44269502;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_3.x = (u_xlatb18) ? u_xlat19 : 1.0;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = sqrt(u_xlat18);
    u_xlat19 = u_xlat18 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat19 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat2.x = u_xlat19 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_9 = (u_xlatb19) ? u_xlat2.x : 1.0;
    u_xlat19 = u_xlat18 * _HeigtFogParams2.y;
    u_xlat16_9 = u_xlat19 * u_xlat16_9;
    u_xlat16_9 = exp2((-u_xlat16_9));
    u_xlat16_3.y = (-u_xlat16_9) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat19 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat19) + 2.0;
    u_xlat16_9 = u_xlat19 * u_xlat16_9;
    u_xlat19 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat19 = u_xlat19 + 1.0;
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat19 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat2.x = (-u_xlat19) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat7 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat7);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat7;
#endif
    u_xlat7 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat7) + 2.0;
    u_xlat7 = u_xlat13 * u_xlat7;
    u_xlat13 = u_xlat7 * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat13 : u_xlat7;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat7 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat7) + 2.0;
    u_xlat16_3.x = u_xlat7 * u_xlat16_3.x;
    u_xlat8.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat8.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat18) * u_xlat4.xyz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat18 = (-u_xlat1.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat2.x * u_xlat18;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat8.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat2.xyz = vec3(u_xlat18) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_21 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = vec3(u_xlat16_21) * _LightColor0.xyz + u_xlat16_3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	float _SOFTPARTICLES;
uniform 	float _DepthThresh;
uniform 	float _DepthFade;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat3;
vec2 u_xlat4;
float u_xlat8;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat10_1;
    u_xlat16_2.xyz = u_xlat0.xyz * vs_TEXCOORD4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb0 = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat0.xyxx, (-u_xlat0.xyxx)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb1.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlat0.xy = uintBitsToFloat(uvec2(u_xlat0.xy));
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[floatBitsToInt(u_xlat0).x]);
            u_xlat0.x = _DitherAlpha * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat0.x<0.0);
#else
            u_xlatb0 = u_xlat0.x<0.0;
#endif
            if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat0.x = vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat16_2.xyz * u_xlat0.xxx + vs_TEXCOORD3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_SOFTPARTICLES==1.0);
#else
    u_xlatb0 = _SOFTPARTICLES==1.0;
#endif
    if(u_xlatb0){
        u_xlat4.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
        u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
        u_xlat4.x = float(1.0) / u_xlat4.x;
        u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD2.z);
        u_xlat8 = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
        u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
        u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
        u_xlat4.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
        u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
        u_xlat3 = (-u_xlat8) + 1.0;
        u_xlat0.y = u_xlat4.x * u_xlat3 + u_xlat8;
    //ENDIF
    }
    u_xlat0.x = (u_xlatb0) ? u_xlat0.y : 1.0;
    u_xlat1.w = u_xlat0.x * u_xlat0.w;
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _SOFTPARTICLES;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_9;
float u_xlat12;
float u_xlat13;
float u_xlat18;
float u_xlat19;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat18 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES);
#endif
    vs_TEXCOORD2.z = (u_xlatb1) ? (-u_xlat18) : u_xlat2.z;
    u_xlat18 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat18 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat2.w;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = u_xlat0.z * _HeigtFogParams.x;
    u_xlat7 = u_xlat1.x * -1.44269502;
    u_xlat7 = exp2(u_xlat7);
    u_xlat7 = (-u_xlat7) + 1.0;
    u_xlat7 = u_xlat7 / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.00999999978<abs(u_xlat1.x));
#else
    u_xlatb1 = 0.00999999978<abs(u_xlat1.x);
#endif
    u_xlat16_3.x = (u_xlatb1) ? u_xlat7 : 1.0;
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat7 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat7 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat7 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat13 = u_xlat7 * -1.44269502;
    u_xlat13 = exp2(u_xlat13);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat13 = u_xlat13 / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7);
#endif
    u_xlat16_9 = (u_xlatb7) ? u_xlat13 : 1.0;
    u_xlat7 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_9 = u_xlat7 * u_xlat16_9;
    u_xlat16_9 = exp2((-u_xlat16_9));
    u_xlat16_3.y = (-u_xlat16_9) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat7 = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat7) + 2.0;
    u_xlat16_9 = u_xlat7 * u_xlat16_9;
    u_xlat7 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat7 = u_xlat7 + 1.0;
    u_xlat16_3.x = u_xlat7 * u_xlat16_3.x;
    u_xlat7 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat13 = (-u_xlat7) + 1.0;
    u_xlat19 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat19) + 2.0;
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat4.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat6.x = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat1.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat6.xxx * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat5.xyz);
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat6.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat6.x;
#endif
    u_xlat6.x = (-u_xlat1.x) + 2.0;
    u_xlat6.x = u_xlat6.x * u_xlat1.x;
    u_xlat12 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat12 : u_xlat6.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat6.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat13 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat13) * u_xlat6.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz * vec3(u_xlat7) + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	float _SOFTPARTICLES;
uniform 	float _DepthThresh;
uniform 	float _DepthFade;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat3;
vec2 u_xlat4;
float u_xlat8;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat10_1;
    u_xlat16_2.xyz = u_xlat0.xyz * vs_TEXCOORD4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb0 = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat0.xyxx, (-u_xlat0.xyxx)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb1.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlat0.xy = uintBitsToFloat(uvec2(u_xlat0.xy));
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[floatBitsToInt(u_xlat0).x]);
            u_xlat0.x = _DitherAlpha * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat0.x<0.0);
#else
            u_xlatb0 = u_xlat0.x<0.0;
#endif
            if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat0.x = vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat16_2.xyz * u_xlat0.xxx + vs_TEXCOORD3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_SOFTPARTICLES==1.0);
#else
    u_xlatb0 = _SOFTPARTICLES==1.0;
#endif
    if(u_xlatb0){
        u_xlat4.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
        u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
        u_xlat4.x = float(1.0) / u_xlat4.x;
        u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD2.z);
        u_xlat8 = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
        u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
        u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
        u_xlat4.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
        u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
        u_xlat3 = (-u_xlat8) + 1.0;
        u_xlat0.y = u_xlat4.x * u_xlat3 + u_xlat8;
    //ENDIF
    }
    u_xlat0.x = (u_xlatb0) ? u_xlat0.y : 1.0;
    u_xlat1.w = u_xlat0.x * u_xlat0.w;
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "ENABLE_SHADING_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _SOFTPARTICLES;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat7;
vec3 u_xlat8;
mediump float u_xlat16_9;
float u_xlat13;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
mediump float u_xlat16_21;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat18 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES);
#endif
    vs_TEXCOORD2.z = (u_xlatb1) ? (-u_xlat18) : u_xlat2.z;
    u_xlat18 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat18 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat2.w;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat19 = u_xlat18 * -1.44269502;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_3.x = (u_xlatb18) ? u_xlat19 : 1.0;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = sqrt(u_xlat18);
    u_xlat19 = u_xlat18 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat19 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat2.x = u_xlat19 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_9 = (u_xlatb19) ? u_xlat2.x : 1.0;
    u_xlat19 = u_xlat18 * _HeigtFogParams2.y;
    u_xlat16_9 = u_xlat19 * u_xlat16_9;
    u_xlat16_9 = exp2((-u_xlat16_9));
    u_xlat16_3.y = (-u_xlat16_9) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat19 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat19) + 2.0;
    u_xlat16_9 = u_xlat19 * u_xlat16_9;
    u_xlat19 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat19 = u_xlat19 + 1.0;
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat19 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat2.x = (-u_xlat19) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat7 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat7);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat7;
#endif
    u_xlat7 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat7) + 2.0;
    u_xlat7 = u_xlat13 * u_xlat7;
    u_xlat13 = u_xlat7 * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat13 : u_xlat7;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat7 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat7) + 2.0;
    u_xlat16_3.x = u_xlat7 * u_xlat16_3.x;
    u_xlat8.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat8.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat18) * u_xlat4.xyz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat18 = (-u_xlat1.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat2.x * u_xlat18;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat8.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat2.xyz = vec3(u_xlat18) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_21 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = vec3(u_xlat16_21) * _LightColor0.xyz + u_xlat16_3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform 	float _SOFTPARTICLES;
uniform 	float _DepthThresh;
uniform 	float _DepthFade;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
mediump vec3 u_xlat16_2;
float u_xlat3;
vec2 u_xlat4;
float u_xlat8;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * u_xlat10_1;
    u_xlat16_2.xyz = u_xlat0.xyz * vs_TEXCOORD4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb0 = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb0){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb1.xy = greaterThanEqual(u_xlat0.xyxx, (-u_xlat0.xyxx)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb1.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb1.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlat0.xy = uintBitsToFloat(uvec2(u_xlat0.xy));
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[floatBitsToInt(u_xlat0).y]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[floatBitsToInt(u_xlat0).x]);
            u_xlat0.x = _DitherAlpha * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
            u_xlatb0 = !!(u_xlat0.x<0.0);
#else
            u_xlatb0 = u_xlat0.x<0.0;
#endif
            if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat0.x = vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat16_2.xyz * u_xlat0.xxx + vs_TEXCOORD3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_SOFTPARTICLES==1.0);
#else
    u_xlatb0 = _SOFTPARTICLES==1.0;
#endif
    if(u_xlatb0){
        u_xlat4.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
        u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
        u_xlat4.x = float(1.0) / u_xlat4.x;
        u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD2.z);
        u_xlat8 = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
        u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
        u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
        u_xlat4.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
        u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
        u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
        u_xlat3 = (-u_xlat8) + 1.0;
        u_xlat0.y = u_xlat4.x * u_xlat3 + u_xlat8;
    //ENDIF
    }
    u_xlat0.x = (u_xlatb0) ? u_xlat0.y : 1.0;
    u_xlat1.w = u_xlat0.x * u_xlat0.w;
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _SOFTPARTICLES;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_9;
float u_xlat12;
float u_xlat13;
float u_xlat18;
float u_xlat19;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat18 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES);
#endif
    vs_TEXCOORD2.z = (u_xlatb1) ? (-u_xlat18) : u_xlat2.z;
    u_xlat18 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat18 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat2.w;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = u_xlat0.z * _HeigtFogParams.x;
    u_xlat7 = u_xlat1.x * -1.44269502;
    u_xlat7 = exp2(u_xlat7);
    u_xlat7 = (-u_xlat7) + 1.0;
    u_xlat7 = u_xlat7 / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.00999999978<abs(u_xlat1.x));
#else
    u_xlatb1 = 0.00999999978<abs(u_xlat1.x);
#endif
    u_xlat16_3.x = (u_xlatb1) ? u_xlat7 : 1.0;
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat7 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat7 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat7 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat13 = u_xlat7 * -1.44269502;
    u_xlat13 = exp2(u_xlat13);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat13 = u_xlat13 / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7);
#endif
    u_xlat16_9 = (u_xlatb7) ? u_xlat13 : 1.0;
    u_xlat7 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_9 = u_xlat7 * u_xlat16_9;
    u_xlat16_9 = exp2((-u_xlat16_9));
    u_xlat16_3.y = (-u_xlat16_9) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat7 = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat7) + 2.0;
    u_xlat16_9 = u_xlat7 * u_xlat16_9;
    u_xlat7 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat7 = u_xlat7 + 1.0;
    u_xlat16_3.x = u_xlat7 * u_xlat16_3.x;
    u_xlat7 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat13 = (-u_xlat7) + 1.0;
    u_xlat19 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat19) + 2.0;
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat4.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat6.x = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat1.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat6.xxx * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat5.xyz);
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat6.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat6.x;
#endif
    u_xlat6.x = (-u_xlat1.x) + 2.0;
    u_xlat6.x = u_xlat6.x * u_xlat1.x;
    u_xlat12 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat12 : u_xlat6.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat6.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat13 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat13) * u_xlat6.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz * vec3(u_xlat7) + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump float _EmissionScaler;
uniform 	float _SOFTPARTICLES;
uniform 	float _DepthThresh;
uniform 	float _DepthFade;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
uvec2 u_xlatu0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
vec2 u_xlat5;
vec2 u_xlat8;
bvec2 u_xlatb8;
float u_xlat9;
float u_xlat13;
mediump float u_xlat16_14;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb1 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb1){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        return;
    } else {
        u_xlat16_1 = _TintColor + _TintColor;
        u_xlat1 = u_xlat16_1 * vs_COLOR0;
        u_xlat0 = u_xlat10_0 * u_xlat1;
        u_xlat16_3.xyz = u_xlat0.xyz * vs_TEXCOORD4.xyz;
        u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(_EmissionScaler);
        u_xlat16_14 = u_xlat0.w;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb0.x){
        u_xlat0.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat0.x = max(u_xlat0.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(256.0<u_xlat0.x);
#else
        u_xlatb4 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb4)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb0.x){
        u_xlat0.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat8.xy = dFdx(u_xlat0.xy);
        u_xlat0.xy = dFdy(u_xlat0.xy);
        u_xlat8.x = dot(u_xlat8.xy, u_xlat8.xy);
        u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
        u_xlat0.x = max(u_xlat0.x, u_xlat8.x);
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.5;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + 1.0;
        u_xlat4 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat0.x = u_xlat4 / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(256.0<u_xlat0.x);
#else
        u_xlatb4 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb4)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==100.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==100.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==101.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==101.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==102.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==102.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==103.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==103.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0.x = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb0.x = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb0.x){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = _DitherAlpha * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
            u_xlatb0.x = !!(u_xlat0.x<0.0);
#else
            u_xlatb0.x = u_xlat0.x<0.0;
#endif
            if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat0.x = vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xxx + vs_TEXCOORD3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_SOFTPARTICLES==1.0);
#else
    u_xlatb1 = _SOFTPARTICLES==1.0;
#endif
    if(u_xlatb1){
        u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
        u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
        u_xlat5.x = float(1.0) / u_xlat5.x;
        u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD2.z);
        u_xlat9 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
        u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
        u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
        u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat13 = (-u_xlat9) + 1.0;
        u_xlat1.y = u_xlat5.x * u_xlat13 + u_xlat9;
    //ENDIF
    }
    u_xlat1.x = (u_xlatb1) ? u_xlat1.y : 1.0;
    u_xlat0.w = u_xlat1.x * u_xlat16_14;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "ENABLE_SHADING_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _SOFTPARTICLES;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat7;
vec3 u_xlat8;
mediump float u_xlat16_9;
float u_xlat13;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
mediump float u_xlat16_21;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat18 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES);
#endif
    vs_TEXCOORD2.z = (u_xlatb1) ? (-u_xlat18) : u_xlat2.z;
    u_xlat18 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat18 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat2.w;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat19 = u_xlat18 * -1.44269502;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_3.x = (u_xlatb18) ? u_xlat19 : 1.0;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = sqrt(u_xlat18);
    u_xlat19 = u_xlat18 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat19 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat2.x = u_xlat19 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_9 = (u_xlatb19) ? u_xlat2.x : 1.0;
    u_xlat19 = u_xlat18 * _HeigtFogParams2.y;
    u_xlat16_9 = u_xlat19 * u_xlat16_9;
    u_xlat16_9 = exp2((-u_xlat16_9));
    u_xlat16_3.y = (-u_xlat16_9) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat19 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat19) + 2.0;
    u_xlat16_9 = u_xlat19 * u_xlat16_9;
    u_xlat19 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat19 = u_xlat19 + 1.0;
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat19 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat2.x = (-u_xlat19) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat7 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat7);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat7;
#endif
    u_xlat7 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat7) + 2.0;
    u_xlat7 = u_xlat13 * u_xlat7;
    u_xlat13 = u_xlat7 * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat13 : u_xlat7;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat7 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat7) + 2.0;
    u_xlat16_3.x = u_xlat7 * u_xlat16_3.x;
    u_xlat8.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat8.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat18) * u_xlat4.xyz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat18 = (-u_xlat1.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat2.x * u_xlat18;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat8.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat2.xyz = vec3(u_xlat18) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_21 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = vec3(u_xlat16_21) * _LightColor0.xyz + u_xlat16_3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _TintColor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump float _EmissionScaler;
uniform 	float _SOFTPARTICLES;
uniform 	float _DepthThresh;
uniform 	float _DepthFade;
uniform lowp sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
uvec2 u_xlatu0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
vec2 u_xlat5;
vec2 u_xlat8;
bvec2 u_xlatb8;
float u_xlat9;
float u_xlat13;
mediump float u_xlat16_14;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb1 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb1){
        SV_Target0.xyz = u_xlat10_0.xyz;
        SV_Target0.w = 1.0;
        return;
    } else {
        u_xlat16_1 = _TintColor + _TintColor;
        u_xlat1 = u_xlat16_1 * vs_COLOR0;
        u_xlat0 = u_xlat10_0 * u_xlat1;
        u_xlat16_3.xyz = u_xlat0.xyz * vs_TEXCOORD4.xyz;
        u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(_EmissionScaler);
        u_xlat16_14 = u_xlat0.w;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb0.x){
        u_xlat0.x = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat0.x = max(u_xlat0.x, 8.0);
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(256.0<u_xlat0.x);
#else
        u_xlatb4 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb4)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb0.x){
        u_xlat0.xy = vec2(vs_TEXCOORD0.x * _MainTex_TexelSize.z, vs_TEXCOORD0.y * _MainTex_TexelSize.w);
        u_xlat8.xy = dFdx(u_xlat0.xy);
        u_xlat0.xy = dFdy(u_xlat0.xy);
        u_xlat8.x = dot(u_xlat8.xy, u_xlat8.xy);
        u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
        u_xlat0.x = max(u_xlat0.x, u_xlat8.x);
        u_xlat0.x = log2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.5;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = u_xlat0.x + 1.0;
        u_xlat4 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
        u_xlat0.x = u_xlat4 / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(256.0<u_xlat0.x);
#else
        u_xlatb4 = 256.0<u_xlat0.x;
#endif
        u_xlatb0.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat0.xxxx).xz;
        u_xlat1 = (u_xlatb0.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
        u_xlat1 = (u_xlatb0.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
        u_xlat0 = (bool(u_xlatb4)) ? u_xlat1 : vec4(0.0, 1.0, 0.0, 1.0);
        SV_Target0 = u_xlat0;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==100.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==100.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==101.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==101.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==102.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==102.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==103.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==103.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha));
#else
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UsingDitherAlpha);
#endif
    if(u_xlatb0.x){
#ifdef UNITY_ADRENO_ES3
        u_xlatb0.x = !!(_DitherAlpha<0.949999988);
#else
        u_xlatb0.x = _DitherAlpha<0.949999988;
#endif
        if(u_xlatb0.x){
            u_xlat0.xy = vs_TEXCOORD2.yx / vs_TEXCOORD2.ww;
            u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
            u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
            u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
            u_xlat0.xy = fract(abs(u_xlat0.xy));
            u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
            u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
            u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
            u_xlatu0.xy = uvec2(u_xlat0.xy);
            u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
            u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
            u_xlat0.x = _DitherAlpha * 17.0 + (-u_xlat0.x);
            u_xlat0.x = u_xlat0.x + -0.00999999978;
#ifdef UNITY_ADRENO_ES3
            u_xlatb0.x = !!(u_xlat0.x<0.0);
#else
            u_xlatb0.x = u_xlat0.x<0.0;
#endif
            if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
        //ENDIF
        }
    //ENDIF
    }
    u_xlat0.x = vs_TEXCOORD3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xxx + vs_TEXCOORD3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_SOFTPARTICLES==1.0);
#else
    u_xlatb1 = _SOFTPARTICLES==1.0;
#endif
    if(u_xlatb1){
        u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
        u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
        u_xlat5.x = float(1.0) / u_xlat5.x;
        u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD2.z);
        u_xlat9 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
        u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
        u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
        u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat13 = (-u_xlat9) + 1.0;
        u_xlat1.y = u_xlat5.x * u_xlat13 + u_xlat9;
    //ENDIF
    }
    u_xlat1.x = (u_xlatb1) ? u_xlat1.y : 1.0;
    u_xlat0.w = u_xlat1.x * u_xlat16_14;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _SOFTPARTICLES;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_9;
float u_xlat12;
float u_xlat13;
float u_xlat18;
float u_xlat19;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat18 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES);
#endif
    vs_TEXCOORD2.z = (u_xlatb1) ? (-u_xlat18) : u_xlat2.z;
    u_xlat18 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat18 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat2.w;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = u_xlat0.z * _HeigtFogParams.x;
    u_xlat7 = u_xlat1.x * -1.44269502;
    u_xlat7 = exp2(u_xlat7);
    u_xlat7 = (-u_xlat7) + 1.0;
    u_xlat7 = u_xlat7 / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.00999999978<abs(u_xlat1.x));
#else
    u_xlatb1 = 0.00999999978<abs(u_xlat1.x);
#endif
    u_xlat16_3.x = (u_xlatb1) ? u_xlat7 : 1.0;
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat7 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat7 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat7 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat13 = u_xlat7 * -1.44269502;
    u_xlat13 = exp2(u_xlat13);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat13 = u_xlat13 / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7);
#endif
    u_xlat16_9 = (u_xlatb7) ? u_xlat13 : 1.0;
    u_xlat7 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_9 = u_xlat7 * u_xlat16_9;
    u_xlat16_9 = exp2((-u_xlat16_9));
    u_xlat16_3.y = (-u_xlat16_9) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat7 = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat7) + 2.0;
    u_xlat16_9 = u_xlat7 * u_xlat16_9;
    u_xlat7 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat7 = u_xlat7 + 1.0;
    u_xlat16_3.x = u_xlat7 * u_xlat16_3.x;
    u_xlat7 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat13 = (-u_xlat7) + 1.0;
    u_xlat19 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat19) + 2.0;
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat4.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat6.x = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat1.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat6.xxx * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat5.xyz);
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat6.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat6.x;
#endif
    u_xlat6.x = (-u_xlat1.x) + 2.0;
    u_xlat6.x = u_xlat6.x * u_xlat1.x;
    u_xlat12 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat12 : u_xlat6.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat6.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat13 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat13) * u_xlat6.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz * vec3(u_xlat7) + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = vec3(1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vs_TEXCOORD4.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "ENABLE_SHADING_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 _MainTex_ST;
uniform 	float _SOFTPARTICLES;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat7;
vec3 u_xlat8;
mediump float u_xlat16_9;
float u_xlat13;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
mediump float u_xlat16_21;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat18 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES));
#else
    u_xlatb1 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_SOFTPARTICLES);
#endif
    vs_TEXCOORD2.z = (u_xlatb1) ? (-u_xlat18) : u_xlat2.z;
    u_xlat18 = u_xlat2.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat18 * 0.5;
    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat2.w;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat19 = u_xlat18 * -1.44269502;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_3.x = (u_xlatb18) ? u_xlat19 : 1.0;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = sqrt(u_xlat18);
    u_xlat19 = u_xlat18 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat19 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat2.x = u_xlat19 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = u_xlat2.x / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_9 = (u_xlatb19) ? u_xlat2.x : 1.0;
    u_xlat19 = u_xlat18 * _HeigtFogParams2.y;
    u_xlat16_9 = u_xlat19 * u_xlat16_9;
    u_xlat16_9 = exp2((-u_xlat16_9));
    u_xlat16_3.y = (-u_xlat16_9) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat19 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat19) + 2.0;
    u_xlat16_9 = u_xlat19 * u_xlat16_9;
    u_xlat19 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat19 = u_xlat19 + 1.0;
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat19 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat2.x = (-u_xlat19) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat7 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat7);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat7;
#endif
    u_xlat7 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat7) + 2.0;
    u_xlat7 = u_xlat13 * u_xlat7;
    u_xlat13 = u_xlat7 * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat13 : u_xlat7;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat7 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat7) + 2.0;
    u_xlat16_3.x = u_xlat7 * u_xlat16_3.x;
    u_xlat8.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat8.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat18) * u_xlat4.xyz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat18 = (-u_xlat1.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat2.x * u_xlat18;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat8.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat2.xyz = vec3(u_xlat18) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD3.xyz = u_xlat2.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_21 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = vec3(u_xlat16_21) * _LightColor0.xyz + u_xlat16_3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = _TintColor + _TintColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vs_TEXCOORD4.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_EmissionScaler);
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
Keywords { "ENABLE_SHADING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "ENABLE_SHADING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "ENABLE_SHADING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "ENABLE_SHADING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "ENABLE_SHADING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "ENABLE_SHADING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "ENABLE_SHADING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "ENABLE_SHADING_ON" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}