//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Particles/Standard_Fresnel" {
Properties {
_Scale ("Scale Compared to Maya", Float) = 0.01
[Header(Element View)] _ElementViewEleID ("Element ID", Float) = 0
[MHYToggle] _ReceiveShadow ("Receive Shadow", Float) = 0
_MaterialShadowBias ("Shadow Bias", Range(0, 0.1)) = 0
[Toggle] _EnableAlphaTest ("Enable Alpha Test", Float) = 0
_CutOff ("Mask Clip Value", Range(0, 1)) = 0
[Header(Dithering)] [Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
_DayColor ("DayColor", Color) = (1,1,1,1)
_MainColor ("MainColor", Color) = (1,1,1,1)
_ColorBrightness ("ColorBrightness", Float) = 1
_BaseTex ("BaseTex", 2D) = "white" { }
_NormalMap ("NormalMap", 2D) = "bump" { }
_NormaTexlScale ("NormaTexlScale", Range(0, 20)) = 1
[MHYToggle] _FresnelNormalMapToggle ("FresnelNormalMapToggle", Float) = 0
_FresnelNormalMap ("FresnelNormalMap", 2D) = "bump" { }
_FresnelNormaTexlScale ("FresnelNormaTexlScale", Range(0, 20)) = 1
_Fresnal_Scale ("Fresnal_Scale", Float) = 0.5
_Fresnal_Power ("Fresnal_Power", Float) = 1
[Toggle(_PATTERNTEXTOGGLE_ON)] _PatternTexToggle ("PatternTexToggle", Float) = 0
_PatternTex ("PatternTex", 2D) = "white" { }
[Enum(RGB,0,R,1,G,2,B,3,A,4)] _PatternTexChannelToggle ("PatternTexChannelToggle", Float) = 1
_Pattern_Light ("Pattern_Light", Float) = 0.5
_MeshParticleColorArray ("MeshParticleColorArray", Vector) = (1,1,1,1)
[Enum(OnlyPattern1Tex,0,AddPattern2Tex,1,MaxPattern2Tex,2)] _PatternTexModeToggle ("PatternTexModeToggle", Float) = 0
_PatternTex2 ("PatternTex2", 2D) = "white" { }
[Enum(RGB,0,R,1,G,2,B,3,A,4)] _PatternTex2ChannelToggle ("PatternTex2ChannelToggle", Float) = 1
_Pattern2_Light ("Pattern2_Light", Float) = 0.5
[MHYToggle] _GlintToggle ("GlintToggle", Float) = 0
_GlintFrequency ("GlintFrequency", Float) = 0
_GlintBrightness ("GlintBrightness", Float) = 0
[Toggle(_GRAINTEXTOGGLE_ON)] _GrainTexToggle ("GrainTexToggle", Float) = 0
_GrainTex ("GrainTex", 2D) = "white" { }
[Enum(RGB,0,R,1,G,2,B,3,A,4)] _GrainTexChannelToggle ("GrainTexChannelToggle", Float) = 1
_GrainTex_Uspeed ("GrainTex_Uspeed", Float) = 0
_GrainTex_Vspeed ("GrainTex_Vspeed", Float) = 0
[Toggle(_MASKTEXTOGGLE_ON)] _MaskTexToggle ("MaskTexToggle", Float) = 0
_MaskTex ("MaskTex", 2D) = "white" { }
_MaskScaler ("MaskScaler", Float) = 1
_EmissionStrength ("EmissionStrength", Float) = 1
_texcoord ("", 2D) = "white" { }
}
SubShader {
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "HYBRIDDEFERRED"
  Tags { "LIGHTMODE" = "HYBRIDDEFERRED" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 29384
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
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD3.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _ReceiveShadow;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	mediump float _FresnelNormalMapToggle;
uniform 	float _FresnelNormaTexlScale;
uniform 	vec4 _FresnelNormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	float _ColorBrightness;
uniform 	mediump float _EmissionStrength;
uniform 	float _NormaTexlScale;
uniform 	vec4 _NormalMap_ST;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _FresnelNormalMap;
uniform lowp sampler2D _NormalMap;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat9;
float u_xlat25;
mediump float u_xlat16_25;
bool u_xlatb25;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xyz = texture(_BaseTex, u_xlat0.xy).xyz;
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(_FresnelNormalMapToggle==1.0);
#else
    u_xlatb25 = _FresnelNormalMapToggle==1.0;
#endif
    if(u_xlatb25){
        u_xlat2.xy = vs_TEXCOORD2.xy * _FresnelNormalMap_ST.xy + _FresnelNormalMap_ST.zw;
        u_xlat10_2.xyz = texture(_FresnelNormalMap, u_xlat2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(_FresnelNormaTexlScale);
        u_xlat2.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat2.x = float(0.0);
        u_xlat2.y = float(0.0);
        u_xlat2.z = float(1.0);
    //ENDIF
    }
    u_xlat4.x = vs_TEXCOORD4.x;
    u_xlat4.y = vs_TEXCOORD5.x;
    u_xlat4.z = vs_TEXCOORD0.x;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat6.x = vs_TEXCOORD4.y;
    u_xlat6.y = vs_TEXCOORD5.y;
    u_xlat6.z = vs_TEXCOORD0.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat7.x = vs_TEXCOORD4.z;
    u_xlat7.y = vs_TEXCOORD5.z;
    u_xlat7.z = vs_TEXCOORD0.z;
    u_xlat5.z = dot(u_xlat7.xyz, u_xlat2.xyz);
    u_xlat25 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Power;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Scale;
    u_xlat1.x = u_xlat1.x * _ColorBrightness;
    u_xlat9.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat9.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat2.xy = vs_TEXCOORD2.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormaTexlScale);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat16_3.xyz);
    u_xlat16_25 = _EmissionStrength * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat1.w = sqrt(u_xlat16_25);
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_3.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_3.x : u_xlat1.z;
    SV_Target0.w = 0.00392156886;
    u_xlat0.w = _ReceiveShadow;
    SV_Target1 = u_xlat0;
    SV_Target2.xyw = u_xlat1.xyw;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_GRAINTEXTOGGLE_ON" "_PATTERNTEXTOGGLE_ON" }
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
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD3.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	float _ReceiveShadow;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	mediump float _FresnelNormalMapToggle;
uniform 	float _FresnelNormaTexlScale;
uniform 	vec4 _FresnelNormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _GlintToggle;
uniform 	mediump float _PatternTexModeToggle;
uniform 	mediump float _PatternTexChannelToggle;
uniform 	vec4 _PatternTex_ST;
uniform 	float _Pattern_Light;
uniform 	mediump float _PatternTex2ChannelToggle;
uniform 	vec4 _PatternTex2_ST;
uniform 	float _Pattern2_Light;
uniform 	float _GlintBrightness;
uniform 	float _GlintFrequency;
uniform 	mediump float _GrainTexChannelToggle;
uniform 	float _GrainTex_Uspeed;
uniform 	vec4 _GrainTex_ST;
uniform 	float _GrainTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	mediump float _EmissionStrength;
uniform 	float _NormaTexlScale;
uniform 	vec4 _NormalMap_ST;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _FresnelNormalMap;
uniform lowp sampler2D _PatternTex;
uniform lowp sampler2D _PatternTex2;
uniform lowp sampler2D _GrainTex;
uniform lowp sampler2D _NormalMap;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
bvec4 u_xlatb5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
bvec4 u_xlatb8;
mediump vec3 u_xlat16_9;
vec3 u_xlat11;
bool u_xlatb12;
float u_xlat31;
mediump float u_xlat16_31;
bool u_xlatb31;
float u_xlat32;
bool u_xlatb32;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xyz = texture(_BaseTex, u_xlat0.xy).xyz;
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(_FresnelNormalMapToggle==1.0);
#else
    u_xlatb31 = _FresnelNormalMapToggle==1.0;
#endif
    if(u_xlatb31){
        u_xlat2.xy = vs_TEXCOORD2.xy * _FresnelNormalMap_ST.xy + _FresnelNormalMap_ST.zw;
        u_xlat10_2.xyz = texture(_FresnelNormalMap, u_xlat2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(_FresnelNormaTexlScale);
        u_xlat2.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat2.x = float(0.0);
        u_xlat2.y = float(0.0);
        u_xlat2.z = float(1.0);
    //ENDIF
    }
    u_xlat4.x = vs_TEXCOORD4.x;
    u_xlat4.y = vs_TEXCOORD5.x;
    u_xlat4.z = vs_TEXCOORD0.x;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat6.x = vs_TEXCOORD4.y;
    u_xlat6.y = vs_TEXCOORD5.y;
    u_xlat6.z = vs_TEXCOORD0.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat7.x = vs_TEXCOORD4.z;
    u_xlat7.y = vs_TEXCOORD5.z;
    u_xlat7.z = vs_TEXCOORD0.z;
    u_xlat5.z = dot(u_xlat7.xyz, u_xlat2.xyz);
    u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat2.xyz = vec3(u_xlat31) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Power;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Scale;
    u_xlat11.xy = vs_TEXCOORD2.xy * _PatternTex_ST.xy + _PatternTex_ST.zw;
    u_xlat2 = texture(_PatternTex, u_xlat11.xy);
    u_xlatb3 = equal(vec4(vec4(_PatternTexChannelToggle, _PatternTexChannelToggle, _PatternTexChannelToggle, _PatternTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb5 = equal(vec4(_PatternTexChannelToggle, _PatternTexModeToggle, _PatternTexModeToggle, _PatternTexModeToggle), vec4(4.0, 0.0, 1.0, 2.0));
    u_xlat11.x = u_xlatb5.x ? u_xlat2.w : float(0.0);
    u_xlat11.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat11.x;
    u_xlat11.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat11.x;
    u_xlat11.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat11.x;
    u_xlat11.xyz = (u_xlatb3.x) ? u_xlat2.xyz : u_xlat11.xxx;
    u_xlat2.xyz = u_xlat11.xyz * vec3(_Pattern_Light);
    u_xlat8.xy = vs_TEXCOORD2.xy * _PatternTex2_ST.xy + _PatternTex2_ST.zw;
    u_xlat3 = texture(_PatternTex2, u_xlat8.xy);
    u_xlatb8 = equal(vec4(_PatternTex2ChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(_PatternTex2ChannelToggle==4.0);
#else
    u_xlatb32 = _PatternTex2ChannelToggle==4.0;
#endif
    u_xlat32 = u_xlatb32 ? u_xlat3.w : float(0.0);
    u_xlat32 = (u_xlatb8.w) ? u_xlat3.z : u_xlat32;
    u_xlat32 = (u_xlatb8.z) ? u_xlat3.y : u_xlat32;
    u_xlat32 = (u_xlatb8.y) ? u_xlat3.x : u_xlat32;
    u_xlat8.xyz = (u_xlatb8.x) ? u_xlat3.xyz : vec3(u_xlat32);
    u_xlat8.xyz = u_xlat8.xyz * vec3(_Pattern2_Light);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_Pattern_Light) + u_xlat8.xyz;
    u_xlat8.xyz = max(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat8.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat8.xyz, vec3(u_xlatb5.www));
    u_xlat11.xyz = (u_xlatb5.z) ? u_xlat11.xyz : u_xlat8.xyz;
    u_xlat11.xyz = (u_xlatb5.y) ? u_xlat2.xyz : u_xlat11.xyz;
    u_xlat2.x = _Time.y * _GlintFrequency;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_GlintToggle==1.0);
#else
    u_xlatb12 = _GlintToggle==1.0;
#endif
    u_xlat2.x = cos(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * 0.5 + 0.5;
    u_xlat2.x = u_xlat2.x * _GlintBrightness;
    u_xlat2.xzw = u_xlat11.xyz * u_xlat2.xxx;
    u_xlat11.xyz = (bool(u_xlatb12)) ? u_xlat2.xzw : u_xlat11.xyz;
    u_xlat1.xyz = max(u_xlat11.xyz, u_xlat1.xxx);
    u_xlat2.xy = vs_TEXCOORD2.xy * _GrainTex_ST.xy + _GrainTex_ST.zw;
    u_xlat5.x = _Time.y * _GrainTex_Uspeed + u_xlat2.x;
    u_xlat5.y = _Time.y * _GrainTex_Vspeed + u_xlat2.y;
    u_xlat2 = texture(_GrainTex, u_xlat5.xy);
    u_xlatb3 = equal(vec4(_GrainTexChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(_GrainTexChannelToggle==4.0);
#else
    u_xlatb31 = _GrainTexChannelToggle==4.0;
#endif
    u_xlat31 = u_xlatb31 ? u_xlat2.w : float(0.0);
    u_xlat31 = (u_xlatb3.w) ? u_xlat2.z : u_xlat31;
    u_xlat31 = (u_xlatb3.z) ? u_xlat2.y : u_xlat31;
    u_xlat31 = (u_xlatb3.y) ? u_xlat2.x : u_xlat31;
    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat2.xyz : vec3(u_xlat31);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat2.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat2.xy = vs_TEXCOORD2.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_9.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_9.xy = u_xlat16_9.xy * vec2(_NormaTexlScale);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat16_9.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat16_9.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat16_9.xyz);
    u_xlat16_31 = _EmissionStrength * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat1.w = sqrt(u_xlat16_31);
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_9.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_9.x : u_xlat1.z;
    SV_Target0.w = 0.00392156886;
    u_xlat0.w = _ReceiveShadow;
    SV_Target1 = u_xlat0;
    SV_Target2.xyw = u_xlat1.xyw;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_PATTERNTEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
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
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD3.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	float _ReceiveShadow;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	mediump float _FresnelNormalMapToggle;
uniform 	float _FresnelNormaTexlScale;
uniform 	vec4 _FresnelNormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _GlintToggle;
uniform 	mediump float _PatternTexModeToggle;
uniform 	mediump float _PatternTexChannelToggle;
uniform 	vec4 _PatternTex_ST;
uniform 	float _Pattern_Light;
uniform 	mediump float _PatternTex2ChannelToggle;
uniform 	vec4 _PatternTex2_ST;
uniform 	float _Pattern2_Light;
uniform 	float _GlintBrightness;
uniform 	float _GlintFrequency;
uniform 	float _ColorBrightness;
uniform 	mediump float _MaskScaler;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _EmissionStrength;
uniform 	float _NormaTexlScale;
uniform 	vec4 _NormalMap_ST;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _FresnelNormalMap;
uniform lowp sampler2D _PatternTex;
uniform lowp sampler2D _PatternTex2;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NormalMap;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
bvec4 u_xlatb5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
bvec4 u_xlatb8;
mediump vec3 u_xlat16_9;
vec3 u_xlat11;
bool u_xlatb12;
float u_xlat31;
mediump float u_xlat16_31;
lowp float u_xlat10_31;
bool u_xlatb31;
float u_xlat32;
bool u_xlatb32;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xyz = texture(_BaseTex, u_xlat0.xy).xyz;
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(_FresnelNormalMapToggle==1.0);
#else
    u_xlatb31 = _FresnelNormalMapToggle==1.0;
#endif
    if(u_xlatb31){
        u_xlat2.xy = vs_TEXCOORD2.xy * _FresnelNormalMap_ST.xy + _FresnelNormalMap_ST.zw;
        u_xlat10_2.xyz = texture(_FresnelNormalMap, u_xlat2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(_FresnelNormaTexlScale);
        u_xlat2.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat2.x = float(0.0);
        u_xlat2.y = float(0.0);
        u_xlat2.z = float(1.0);
    //ENDIF
    }
    u_xlat4.x = vs_TEXCOORD4.x;
    u_xlat4.y = vs_TEXCOORD5.x;
    u_xlat4.z = vs_TEXCOORD0.x;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat6.x = vs_TEXCOORD4.y;
    u_xlat6.y = vs_TEXCOORD5.y;
    u_xlat6.z = vs_TEXCOORD0.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat7.x = vs_TEXCOORD4.z;
    u_xlat7.y = vs_TEXCOORD5.z;
    u_xlat7.z = vs_TEXCOORD0.z;
    u_xlat5.z = dot(u_xlat7.xyz, u_xlat2.xyz);
    u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat2.xyz = vec3(u_xlat31) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Power;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Scale;
    u_xlat11.xy = vs_TEXCOORD2.xy * _PatternTex_ST.xy + _PatternTex_ST.zw;
    u_xlat2 = texture(_PatternTex, u_xlat11.xy);
    u_xlatb3 = equal(vec4(vec4(_PatternTexChannelToggle, _PatternTexChannelToggle, _PatternTexChannelToggle, _PatternTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb5 = equal(vec4(_PatternTexChannelToggle, _PatternTexModeToggle, _PatternTexModeToggle, _PatternTexModeToggle), vec4(4.0, 0.0, 1.0, 2.0));
    u_xlat11.x = u_xlatb5.x ? u_xlat2.w : float(0.0);
    u_xlat11.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat11.x;
    u_xlat11.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat11.x;
    u_xlat11.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat11.x;
    u_xlat11.xyz = (u_xlatb3.x) ? u_xlat2.xyz : u_xlat11.xxx;
    u_xlat2.xyz = u_xlat11.xyz * vec3(_Pattern_Light);
    u_xlat8.xy = vs_TEXCOORD2.xy * _PatternTex2_ST.xy + _PatternTex2_ST.zw;
    u_xlat3 = texture(_PatternTex2, u_xlat8.xy);
    u_xlatb8 = equal(vec4(_PatternTex2ChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(_PatternTex2ChannelToggle==4.0);
#else
    u_xlatb32 = _PatternTex2ChannelToggle==4.0;
#endif
    u_xlat32 = u_xlatb32 ? u_xlat3.w : float(0.0);
    u_xlat32 = (u_xlatb8.w) ? u_xlat3.z : u_xlat32;
    u_xlat32 = (u_xlatb8.z) ? u_xlat3.y : u_xlat32;
    u_xlat32 = (u_xlatb8.y) ? u_xlat3.x : u_xlat32;
    u_xlat8.xyz = (u_xlatb8.x) ? u_xlat3.xyz : vec3(u_xlat32);
    u_xlat8.xyz = u_xlat8.xyz * vec3(_Pattern2_Light);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_Pattern_Light) + u_xlat8.xyz;
    u_xlat8.xyz = max(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat8.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat8.xyz, vec3(u_xlatb5.www));
    u_xlat11.xyz = (u_xlatb5.z) ? u_xlat11.xyz : u_xlat8.xyz;
    u_xlat11.xyz = (u_xlatb5.y) ? u_xlat2.xyz : u_xlat11.xyz;
    u_xlat2.x = _Time.y * _GlintFrequency;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_GlintToggle==1.0);
#else
    u_xlatb12 = _GlintToggle==1.0;
#endif
    u_xlat2.x = cos(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * 0.5 + 0.5;
    u_xlat2.x = u_xlat2.x * _GlintBrightness;
    u_xlat2.xzw = u_xlat11.xyz * u_xlat2.xxx;
    u_xlat11.xyz = (bool(u_xlatb12)) ? u_xlat2.xzw : u_xlat11.xyz;
    u_xlat1.xyz = max(u_xlat11.xyz, u_xlat1.xxx);
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat2.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat2.xy = vs_TEXCOORD2.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_31 = texture(_MaskTex, u_xlat2.xy).x;
    u_xlat16_31 = u_xlat10_31 * _MaskScaler;
    u_xlat1.xyz = vec3(u_xlat16_31) * u_xlat1.xyz;
    u_xlat2.xy = vs_TEXCOORD2.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_9.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_9.xy = u_xlat16_9.xy * vec2(_NormaTexlScale);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat16_9.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat16_9.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat16_9.xyz);
    u_xlat16_31 = _EmissionStrength * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat1.w = sqrt(u_xlat16_31);
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_9.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_9.x : u_xlat1.z;
    SV_Target0.w = 0.00392156886;
    u_xlat0.w = _ReceiveShadow;
    SV_Target1 = u_xlat0;
    SV_Target2.xyw = u_xlat1.xyw;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_GRAINTEXTOGGLE_ON" "_PATTERNTEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
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
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD3.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	float _ReceiveShadow;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	mediump float _FresnelNormalMapToggle;
uniform 	float _FresnelNormaTexlScale;
uniform 	vec4 _FresnelNormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _GlintToggle;
uniform 	mediump float _PatternTexModeToggle;
uniform 	mediump float _PatternTexChannelToggle;
uniform 	vec4 _PatternTex_ST;
uniform 	float _Pattern_Light;
uniform 	mediump float _PatternTex2ChannelToggle;
uniform 	vec4 _PatternTex2_ST;
uniform 	float _Pattern2_Light;
uniform 	float _GlintBrightness;
uniform 	float _GlintFrequency;
uniform 	mediump float _GrainTexChannelToggle;
uniform 	float _GrainTex_Uspeed;
uniform 	vec4 _GrainTex_ST;
uniform 	float _GrainTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	mediump float _MaskScaler;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _EmissionStrength;
uniform 	float _NormaTexlScale;
uniform 	vec4 _NormalMap_ST;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _FresnelNormalMap;
uniform lowp sampler2D _PatternTex;
uniform lowp sampler2D _PatternTex2;
uniform lowp sampler2D _GrainTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NormalMap;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
bvec4 u_xlatb5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
bvec4 u_xlatb8;
mediump vec3 u_xlat16_9;
vec3 u_xlat11;
bool u_xlatb12;
float u_xlat31;
mediump float u_xlat16_31;
lowp float u_xlat10_31;
bool u_xlatb31;
float u_xlat32;
bool u_xlatb32;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xyz = texture(_BaseTex, u_xlat0.xy).xyz;
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(_FresnelNormalMapToggle==1.0);
#else
    u_xlatb31 = _FresnelNormalMapToggle==1.0;
#endif
    if(u_xlatb31){
        u_xlat2.xy = vs_TEXCOORD2.xy * _FresnelNormalMap_ST.xy + _FresnelNormalMap_ST.zw;
        u_xlat10_2.xyz = texture(_FresnelNormalMap, u_xlat2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(_FresnelNormaTexlScale);
        u_xlat2.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat2.x = float(0.0);
        u_xlat2.y = float(0.0);
        u_xlat2.z = float(1.0);
    //ENDIF
    }
    u_xlat4.x = vs_TEXCOORD4.x;
    u_xlat4.y = vs_TEXCOORD5.x;
    u_xlat4.z = vs_TEXCOORD0.x;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat6.x = vs_TEXCOORD4.y;
    u_xlat6.y = vs_TEXCOORD5.y;
    u_xlat6.z = vs_TEXCOORD0.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat7.x = vs_TEXCOORD4.z;
    u_xlat7.y = vs_TEXCOORD5.z;
    u_xlat7.z = vs_TEXCOORD0.z;
    u_xlat5.z = dot(u_xlat7.xyz, u_xlat2.xyz);
    u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat2.xyz = vec3(u_xlat31) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Power;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Scale;
    u_xlat11.xy = vs_TEXCOORD2.xy * _PatternTex_ST.xy + _PatternTex_ST.zw;
    u_xlat2 = texture(_PatternTex, u_xlat11.xy);
    u_xlatb3 = equal(vec4(vec4(_PatternTexChannelToggle, _PatternTexChannelToggle, _PatternTexChannelToggle, _PatternTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb5 = equal(vec4(_PatternTexChannelToggle, _PatternTexModeToggle, _PatternTexModeToggle, _PatternTexModeToggle), vec4(4.0, 0.0, 1.0, 2.0));
    u_xlat11.x = u_xlatb5.x ? u_xlat2.w : float(0.0);
    u_xlat11.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat11.x;
    u_xlat11.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat11.x;
    u_xlat11.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat11.x;
    u_xlat11.xyz = (u_xlatb3.x) ? u_xlat2.xyz : u_xlat11.xxx;
    u_xlat2.xyz = u_xlat11.xyz * vec3(_Pattern_Light);
    u_xlat8.xy = vs_TEXCOORD2.xy * _PatternTex2_ST.xy + _PatternTex2_ST.zw;
    u_xlat3 = texture(_PatternTex2, u_xlat8.xy);
    u_xlatb8 = equal(vec4(_PatternTex2ChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(_PatternTex2ChannelToggle==4.0);
#else
    u_xlatb32 = _PatternTex2ChannelToggle==4.0;
#endif
    u_xlat32 = u_xlatb32 ? u_xlat3.w : float(0.0);
    u_xlat32 = (u_xlatb8.w) ? u_xlat3.z : u_xlat32;
    u_xlat32 = (u_xlatb8.z) ? u_xlat3.y : u_xlat32;
    u_xlat32 = (u_xlatb8.y) ? u_xlat3.x : u_xlat32;
    u_xlat8.xyz = (u_xlatb8.x) ? u_xlat3.xyz : vec3(u_xlat32);
    u_xlat8.xyz = u_xlat8.xyz * vec3(_Pattern2_Light);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_Pattern_Light) + u_xlat8.xyz;
    u_xlat8.xyz = max(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat8.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat8.xyz, vec3(u_xlatb5.www));
    u_xlat11.xyz = (u_xlatb5.z) ? u_xlat11.xyz : u_xlat8.xyz;
    u_xlat11.xyz = (u_xlatb5.y) ? u_xlat2.xyz : u_xlat11.xyz;
    u_xlat2.x = _Time.y * _GlintFrequency;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_GlintToggle==1.0);
#else
    u_xlatb12 = _GlintToggle==1.0;
#endif
    u_xlat2.x = cos(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * 0.5 + 0.5;
    u_xlat2.x = u_xlat2.x * _GlintBrightness;
    u_xlat2.xzw = u_xlat11.xyz * u_xlat2.xxx;
    u_xlat11.xyz = (bool(u_xlatb12)) ? u_xlat2.xzw : u_xlat11.xyz;
    u_xlat1.xyz = max(u_xlat11.xyz, u_xlat1.xxx);
    u_xlat2.xy = vs_TEXCOORD2.xy * _GrainTex_ST.xy + _GrainTex_ST.zw;
    u_xlat5.x = _Time.y * _GrainTex_Uspeed + u_xlat2.x;
    u_xlat5.y = _Time.y * _GrainTex_Vspeed + u_xlat2.y;
    u_xlat2 = texture(_GrainTex, u_xlat5.xy);
    u_xlatb3 = equal(vec4(_GrainTexChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(_GrainTexChannelToggle==4.0);
#else
    u_xlatb31 = _GrainTexChannelToggle==4.0;
#endif
    u_xlat31 = u_xlatb31 ? u_xlat2.w : float(0.0);
    u_xlat31 = (u_xlatb3.w) ? u_xlat2.z : u_xlat31;
    u_xlat31 = (u_xlatb3.z) ? u_xlat2.y : u_xlat31;
    u_xlat31 = (u_xlatb3.y) ? u_xlat2.x : u_xlat31;
    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat2.xyz : vec3(u_xlat31);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat2.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat2.xy = vs_TEXCOORD2.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_31 = texture(_MaskTex, u_xlat2.xy).x;
    u_xlat16_31 = u_xlat10_31 * _MaskScaler;
    u_xlat1.xyz = vec3(u_xlat16_31) * u_xlat1.xyz;
    u_xlat2.xy = vs_TEXCOORD2.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_9.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_9.xy = u_xlat16_9.xy * vec2(_NormaTexlScale);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat16_9.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat16_9.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat16_9.xyz);
    u_xlat16_31 = _EmissionStrength * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat1.w = sqrt(u_xlat16_31);
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_9.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_9.x : u_xlat1.z;
    SV_Target0.w = 0.00392156886;
    u_xlat0.w = _ReceiveShadow;
    SV_Target1 = u_xlat0;
    SV_Target2.xyw = u_xlat1.xyw;
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
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD3.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _ReceiveShadow;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	mediump float _FresnelNormalMapToggle;
uniform 	float _FresnelNormaTexlScale;
uniform 	vec4 _FresnelNormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	float _ColorBrightness;
uniform 	mediump float _EmissionStrength;
uniform 	float _NormaTexlScale;
uniform 	vec4 _NormalMap_ST;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _FresnelNormalMap;
uniform lowp sampler2D _NormalMap;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat9;
float u_xlat25;
mediump float u_xlat16_25;
bool u_xlatb25;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xyz = texture(_BaseTex, u_xlat0.xy).xyz;
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(_FresnelNormalMapToggle==1.0);
#else
    u_xlatb25 = _FresnelNormalMapToggle==1.0;
#endif
    if(u_xlatb25){
        u_xlat2.xy = vs_TEXCOORD2.xy * _FresnelNormalMap_ST.xy + _FresnelNormalMap_ST.zw;
        u_xlat10_2.xyz = texture(_FresnelNormalMap, u_xlat2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(_FresnelNormaTexlScale);
        u_xlat2.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat2.x = float(0.0);
        u_xlat2.y = float(0.0);
        u_xlat2.z = float(1.0);
    //ENDIF
    }
    u_xlat4.x = vs_TEXCOORD4.x;
    u_xlat4.y = vs_TEXCOORD5.x;
    u_xlat4.z = vs_TEXCOORD0.x;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat6.x = vs_TEXCOORD4.y;
    u_xlat6.y = vs_TEXCOORD5.y;
    u_xlat6.z = vs_TEXCOORD0.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat7.x = vs_TEXCOORD4.z;
    u_xlat7.y = vs_TEXCOORD5.z;
    u_xlat7.z = vs_TEXCOORD0.z;
    u_xlat5.z = dot(u_xlat7.xyz, u_xlat2.xyz);
    u_xlat25 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat2.xyz = vec3(u_xlat25) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Power;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Scale;
    u_xlat1.x = u_xlat1.x * _ColorBrightness;
    u_xlat9.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat9.xyz * u_xlat1.xxx;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat2.xy = vs_TEXCOORD2.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormaTexlScale);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat16_3.xyz);
    u_xlat16_25 = _EmissionStrength * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat1.w = sqrt(u_xlat16_25);
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_3.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_3.x : u_xlat1.z;
    SV_Target0.w = 0.00392156886;
    u_xlat0.w = _ReceiveShadow;
    SV_Target1 = u_xlat0;
    SV_Target2.xyw = u_xlat1.xyw;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_GRAINTEXTOGGLE_ON" "_PATTERNTEXTOGGLE_ON" }
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
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD3.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	float _ReceiveShadow;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	mediump float _FresnelNormalMapToggle;
uniform 	float _FresnelNormaTexlScale;
uniform 	vec4 _FresnelNormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _GlintToggle;
uniform 	mediump float _PatternTexModeToggle;
uniform 	mediump float _PatternTexChannelToggle;
uniform 	vec4 _PatternTex_ST;
uniform 	float _Pattern_Light;
uniform 	mediump float _PatternTex2ChannelToggle;
uniform 	vec4 _PatternTex2_ST;
uniform 	float _Pattern2_Light;
uniform 	float _GlintBrightness;
uniform 	float _GlintFrequency;
uniform 	mediump float _GrainTexChannelToggle;
uniform 	float _GrainTex_Uspeed;
uniform 	vec4 _GrainTex_ST;
uniform 	float _GrainTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	mediump float _EmissionStrength;
uniform 	float _NormaTexlScale;
uniform 	vec4 _NormalMap_ST;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _FresnelNormalMap;
uniform lowp sampler2D _PatternTex;
uniform lowp sampler2D _PatternTex2;
uniform lowp sampler2D _GrainTex;
uniform lowp sampler2D _NormalMap;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
bvec4 u_xlatb5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
bvec4 u_xlatb8;
mediump vec3 u_xlat16_9;
vec3 u_xlat11;
bool u_xlatb12;
float u_xlat31;
mediump float u_xlat16_31;
bool u_xlatb31;
float u_xlat32;
bool u_xlatb32;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xyz = texture(_BaseTex, u_xlat0.xy).xyz;
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(_FresnelNormalMapToggle==1.0);
#else
    u_xlatb31 = _FresnelNormalMapToggle==1.0;
#endif
    if(u_xlatb31){
        u_xlat2.xy = vs_TEXCOORD2.xy * _FresnelNormalMap_ST.xy + _FresnelNormalMap_ST.zw;
        u_xlat10_2.xyz = texture(_FresnelNormalMap, u_xlat2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(_FresnelNormaTexlScale);
        u_xlat2.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat2.x = float(0.0);
        u_xlat2.y = float(0.0);
        u_xlat2.z = float(1.0);
    //ENDIF
    }
    u_xlat4.x = vs_TEXCOORD4.x;
    u_xlat4.y = vs_TEXCOORD5.x;
    u_xlat4.z = vs_TEXCOORD0.x;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat6.x = vs_TEXCOORD4.y;
    u_xlat6.y = vs_TEXCOORD5.y;
    u_xlat6.z = vs_TEXCOORD0.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat7.x = vs_TEXCOORD4.z;
    u_xlat7.y = vs_TEXCOORD5.z;
    u_xlat7.z = vs_TEXCOORD0.z;
    u_xlat5.z = dot(u_xlat7.xyz, u_xlat2.xyz);
    u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat2.xyz = vec3(u_xlat31) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Power;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Scale;
    u_xlat11.xy = vs_TEXCOORD2.xy * _PatternTex_ST.xy + _PatternTex_ST.zw;
    u_xlat2 = texture(_PatternTex, u_xlat11.xy);
    u_xlatb3 = equal(vec4(vec4(_PatternTexChannelToggle, _PatternTexChannelToggle, _PatternTexChannelToggle, _PatternTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb5 = equal(vec4(_PatternTexChannelToggle, _PatternTexModeToggle, _PatternTexModeToggle, _PatternTexModeToggle), vec4(4.0, 0.0, 1.0, 2.0));
    u_xlat11.x = u_xlatb5.x ? u_xlat2.w : float(0.0);
    u_xlat11.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat11.x;
    u_xlat11.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat11.x;
    u_xlat11.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat11.x;
    u_xlat11.xyz = (u_xlatb3.x) ? u_xlat2.xyz : u_xlat11.xxx;
    u_xlat2.xyz = u_xlat11.xyz * vec3(_Pattern_Light);
    u_xlat8.xy = vs_TEXCOORD2.xy * _PatternTex2_ST.xy + _PatternTex2_ST.zw;
    u_xlat3 = texture(_PatternTex2, u_xlat8.xy);
    u_xlatb8 = equal(vec4(_PatternTex2ChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(_PatternTex2ChannelToggle==4.0);
#else
    u_xlatb32 = _PatternTex2ChannelToggle==4.0;
#endif
    u_xlat32 = u_xlatb32 ? u_xlat3.w : float(0.0);
    u_xlat32 = (u_xlatb8.w) ? u_xlat3.z : u_xlat32;
    u_xlat32 = (u_xlatb8.z) ? u_xlat3.y : u_xlat32;
    u_xlat32 = (u_xlatb8.y) ? u_xlat3.x : u_xlat32;
    u_xlat8.xyz = (u_xlatb8.x) ? u_xlat3.xyz : vec3(u_xlat32);
    u_xlat8.xyz = u_xlat8.xyz * vec3(_Pattern2_Light);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_Pattern_Light) + u_xlat8.xyz;
    u_xlat8.xyz = max(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat8.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat8.xyz, vec3(u_xlatb5.www));
    u_xlat11.xyz = (u_xlatb5.z) ? u_xlat11.xyz : u_xlat8.xyz;
    u_xlat11.xyz = (u_xlatb5.y) ? u_xlat2.xyz : u_xlat11.xyz;
    u_xlat2.x = _Time.y * _GlintFrequency;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_GlintToggle==1.0);
#else
    u_xlatb12 = _GlintToggle==1.0;
#endif
    u_xlat2.x = cos(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * 0.5 + 0.5;
    u_xlat2.x = u_xlat2.x * _GlintBrightness;
    u_xlat2.xzw = u_xlat11.xyz * u_xlat2.xxx;
    u_xlat11.xyz = (bool(u_xlatb12)) ? u_xlat2.xzw : u_xlat11.xyz;
    u_xlat1.xyz = max(u_xlat11.xyz, u_xlat1.xxx);
    u_xlat2.xy = vs_TEXCOORD2.xy * _GrainTex_ST.xy + _GrainTex_ST.zw;
    u_xlat5.x = _Time.y * _GrainTex_Uspeed + u_xlat2.x;
    u_xlat5.y = _Time.y * _GrainTex_Vspeed + u_xlat2.y;
    u_xlat2 = texture(_GrainTex, u_xlat5.xy);
    u_xlatb3 = equal(vec4(_GrainTexChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(_GrainTexChannelToggle==4.0);
#else
    u_xlatb31 = _GrainTexChannelToggle==4.0;
#endif
    u_xlat31 = u_xlatb31 ? u_xlat2.w : float(0.0);
    u_xlat31 = (u_xlatb3.w) ? u_xlat2.z : u_xlat31;
    u_xlat31 = (u_xlatb3.z) ? u_xlat2.y : u_xlat31;
    u_xlat31 = (u_xlatb3.y) ? u_xlat2.x : u_xlat31;
    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat2.xyz : vec3(u_xlat31);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat2.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat2.xy = vs_TEXCOORD2.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_9.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_9.xy = u_xlat16_9.xy * vec2(_NormaTexlScale);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat16_9.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat16_9.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat16_9.xyz);
    u_xlat16_31 = _EmissionStrength * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat1.w = sqrt(u_xlat16_31);
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_9.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_9.x : u_xlat1.z;
    SV_Target0.w = 0.00392156886;
    u_xlat0.w = _ReceiveShadow;
    SV_Target1 = u_xlat0;
    SV_Target2.xyw = u_xlat1.xyw;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_PATTERNTEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
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
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD3.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	float _ReceiveShadow;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	mediump float _FresnelNormalMapToggle;
uniform 	float _FresnelNormaTexlScale;
uniform 	vec4 _FresnelNormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _GlintToggle;
uniform 	mediump float _PatternTexModeToggle;
uniform 	mediump float _PatternTexChannelToggle;
uniform 	vec4 _PatternTex_ST;
uniform 	float _Pattern_Light;
uniform 	mediump float _PatternTex2ChannelToggle;
uniform 	vec4 _PatternTex2_ST;
uniform 	float _Pattern2_Light;
uniform 	float _GlintBrightness;
uniform 	float _GlintFrequency;
uniform 	float _ColorBrightness;
uniform 	mediump float _MaskScaler;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _EmissionStrength;
uniform 	float _NormaTexlScale;
uniform 	vec4 _NormalMap_ST;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _FresnelNormalMap;
uniform lowp sampler2D _PatternTex;
uniform lowp sampler2D _PatternTex2;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NormalMap;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
bvec4 u_xlatb5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
bvec4 u_xlatb8;
mediump vec3 u_xlat16_9;
vec3 u_xlat11;
bool u_xlatb12;
float u_xlat31;
mediump float u_xlat16_31;
lowp float u_xlat10_31;
bool u_xlatb31;
float u_xlat32;
bool u_xlatb32;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xyz = texture(_BaseTex, u_xlat0.xy).xyz;
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(_FresnelNormalMapToggle==1.0);
#else
    u_xlatb31 = _FresnelNormalMapToggle==1.0;
#endif
    if(u_xlatb31){
        u_xlat2.xy = vs_TEXCOORD2.xy * _FresnelNormalMap_ST.xy + _FresnelNormalMap_ST.zw;
        u_xlat10_2.xyz = texture(_FresnelNormalMap, u_xlat2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(_FresnelNormaTexlScale);
        u_xlat2.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat2.x = float(0.0);
        u_xlat2.y = float(0.0);
        u_xlat2.z = float(1.0);
    //ENDIF
    }
    u_xlat4.x = vs_TEXCOORD4.x;
    u_xlat4.y = vs_TEXCOORD5.x;
    u_xlat4.z = vs_TEXCOORD0.x;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat6.x = vs_TEXCOORD4.y;
    u_xlat6.y = vs_TEXCOORD5.y;
    u_xlat6.z = vs_TEXCOORD0.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat7.x = vs_TEXCOORD4.z;
    u_xlat7.y = vs_TEXCOORD5.z;
    u_xlat7.z = vs_TEXCOORD0.z;
    u_xlat5.z = dot(u_xlat7.xyz, u_xlat2.xyz);
    u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat2.xyz = vec3(u_xlat31) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Power;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Scale;
    u_xlat11.xy = vs_TEXCOORD2.xy * _PatternTex_ST.xy + _PatternTex_ST.zw;
    u_xlat2 = texture(_PatternTex, u_xlat11.xy);
    u_xlatb3 = equal(vec4(vec4(_PatternTexChannelToggle, _PatternTexChannelToggle, _PatternTexChannelToggle, _PatternTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb5 = equal(vec4(_PatternTexChannelToggle, _PatternTexModeToggle, _PatternTexModeToggle, _PatternTexModeToggle), vec4(4.0, 0.0, 1.0, 2.0));
    u_xlat11.x = u_xlatb5.x ? u_xlat2.w : float(0.0);
    u_xlat11.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat11.x;
    u_xlat11.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat11.x;
    u_xlat11.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat11.x;
    u_xlat11.xyz = (u_xlatb3.x) ? u_xlat2.xyz : u_xlat11.xxx;
    u_xlat2.xyz = u_xlat11.xyz * vec3(_Pattern_Light);
    u_xlat8.xy = vs_TEXCOORD2.xy * _PatternTex2_ST.xy + _PatternTex2_ST.zw;
    u_xlat3 = texture(_PatternTex2, u_xlat8.xy);
    u_xlatb8 = equal(vec4(_PatternTex2ChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(_PatternTex2ChannelToggle==4.0);
#else
    u_xlatb32 = _PatternTex2ChannelToggle==4.0;
#endif
    u_xlat32 = u_xlatb32 ? u_xlat3.w : float(0.0);
    u_xlat32 = (u_xlatb8.w) ? u_xlat3.z : u_xlat32;
    u_xlat32 = (u_xlatb8.z) ? u_xlat3.y : u_xlat32;
    u_xlat32 = (u_xlatb8.y) ? u_xlat3.x : u_xlat32;
    u_xlat8.xyz = (u_xlatb8.x) ? u_xlat3.xyz : vec3(u_xlat32);
    u_xlat8.xyz = u_xlat8.xyz * vec3(_Pattern2_Light);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_Pattern_Light) + u_xlat8.xyz;
    u_xlat8.xyz = max(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat8.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat8.xyz, vec3(u_xlatb5.www));
    u_xlat11.xyz = (u_xlatb5.z) ? u_xlat11.xyz : u_xlat8.xyz;
    u_xlat11.xyz = (u_xlatb5.y) ? u_xlat2.xyz : u_xlat11.xyz;
    u_xlat2.x = _Time.y * _GlintFrequency;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_GlintToggle==1.0);
#else
    u_xlatb12 = _GlintToggle==1.0;
#endif
    u_xlat2.x = cos(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * 0.5 + 0.5;
    u_xlat2.x = u_xlat2.x * _GlintBrightness;
    u_xlat2.xzw = u_xlat11.xyz * u_xlat2.xxx;
    u_xlat11.xyz = (bool(u_xlatb12)) ? u_xlat2.xzw : u_xlat11.xyz;
    u_xlat1.xyz = max(u_xlat11.xyz, u_xlat1.xxx);
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat2.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat2.xy = vs_TEXCOORD2.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_31 = texture(_MaskTex, u_xlat2.xy).x;
    u_xlat16_31 = u_xlat10_31 * _MaskScaler;
    u_xlat1.xyz = vec3(u_xlat16_31) * u_xlat1.xyz;
    u_xlat2.xy = vs_TEXCOORD2.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_9.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_9.xy = u_xlat16_9.xy * vec2(_NormaTexlScale);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat16_9.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat16_9.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat16_9.xyz);
    u_xlat16_31 = _EmissionStrength * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat1.w = sqrt(u_xlat16_31);
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_9.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_9.x : u_xlat1.z;
    SV_Target0.w = 0.00392156886;
    u_xlat0.w = _ReceiveShadow;
    SV_Target1 = u_xlat0;
    SV_Target2.xyw = u_xlat1.xyw;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_GRAINTEXTOGGLE_ON" "_PATTERNTEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
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
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD3.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	float _ReceiveShadow;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	mediump float _FresnelNormalMapToggle;
uniform 	float _FresnelNormaTexlScale;
uniform 	vec4 _FresnelNormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _GlintToggle;
uniform 	mediump float _PatternTexModeToggle;
uniform 	mediump float _PatternTexChannelToggle;
uniform 	vec4 _PatternTex_ST;
uniform 	float _Pattern_Light;
uniform 	mediump float _PatternTex2ChannelToggle;
uniform 	vec4 _PatternTex2_ST;
uniform 	float _Pattern2_Light;
uniform 	float _GlintBrightness;
uniform 	float _GlintFrequency;
uniform 	mediump float _GrainTexChannelToggle;
uniform 	float _GrainTex_Uspeed;
uniform 	vec4 _GrainTex_ST;
uniform 	float _GrainTex_Vspeed;
uniform 	float _ColorBrightness;
uniform 	mediump float _MaskScaler;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _EmissionStrength;
uniform 	float _NormaTexlScale;
uniform 	vec4 _NormalMap_ST;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _FresnelNormalMap;
uniform lowp sampler2D _PatternTex;
uniform lowp sampler2D _PatternTex2;
uniform lowp sampler2D _GrainTex;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _NormalMap;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
bvec4 u_xlatb5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
bvec4 u_xlatb8;
mediump vec3 u_xlat16_9;
vec3 u_xlat11;
bool u_xlatb12;
float u_xlat31;
mediump float u_xlat16_31;
lowp float u_xlat10_31;
bool u_xlatb31;
float u_xlat32;
bool u_xlatb32;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.xyz = texture(_BaseTex, u_xlat0.xy).xyz;
    u_xlat1.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(_FresnelNormalMapToggle==1.0);
#else
    u_xlatb31 = _FresnelNormalMapToggle==1.0;
#endif
    if(u_xlatb31){
        u_xlat2.xy = vs_TEXCOORD2.xy * _FresnelNormalMap_ST.xy + _FresnelNormalMap_ST.zw;
        u_xlat10_2.xyz = texture(_FresnelNormalMap, u_xlat2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(_FresnelNormaTexlScale);
        u_xlat2.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat2.x = float(0.0);
        u_xlat2.y = float(0.0);
        u_xlat2.z = float(1.0);
    //ENDIF
    }
    u_xlat4.x = vs_TEXCOORD4.x;
    u_xlat4.y = vs_TEXCOORD5.x;
    u_xlat4.z = vs_TEXCOORD0.x;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat6.x = vs_TEXCOORD4.y;
    u_xlat6.y = vs_TEXCOORD5.y;
    u_xlat6.z = vs_TEXCOORD0.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat7.x = vs_TEXCOORD4.z;
    u_xlat7.y = vs_TEXCOORD5.z;
    u_xlat7.z = vs_TEXCOORD0.z;
    u_xlat5.z = dot(u_xlat7.xyz, u_xlat2.xyz);
    u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat2.xyz = vec3(u_xlat31) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Power;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Scale;
    u_xlat11.xy = vs_TEXCOORD2.xy * _PatternTex_ST.xy + _PatternTex_ST.zw;
    u_xlat2 = texture(_PatternTex, u_xlat11.xy);
    u_xlatb3 = equal(vec4(vec4(_PatternTexChannelToggle, _PatternTexChannelToggle, _PatternTexChannelToggle, _PatternTexChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlatb5 = equal(vec4(_PatternTexChannelToggle, _PatternTexModeToggle, _PatternTexModeToggle, _PatternTexModeToggle), vec4(4.0, 0.0, 1.0, 2.0));
    u_xlat11.x = u_xlatb5.x ? u_xlat2.w : float(0.0);
    u_xlat11.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat11.x;
    u_xlat11.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat11.x;
    u_xlat11.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat11.x;
    u_xlat11.xyz = (u_xlatb3.x) ? u_xlat2.xyz : u_xlat11.xxx;
    u_xlat2.xyz = u_xlat11.xyz * vec3(_Pattern_Light);
    u_xlat8.xy = vs_TEXCOORD2.xy * _PatternTex2_ST.xy + _PatternTex2_ST.zw;
    u_xlat3 = texture(_PatternTex2, u_xlat8.xy);
    u_xlatb8 = equal(vec4(_PatternTex2ChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(_PatternTex2ChannelToggle==4.0);
#else
    u_xlatb32 = _PatternTex2ChannelToggle==4.0;
#endif
    u_xlat32 = u_xlatb32 ? u_xlat3.w : float(0.0);
    u_xlat32 = (u_xlatb8.w) ? u_xlat3.z : u_xlat32;
    u_xlat32 = (u_xlatb8.z) ? u_xlat3.y : u_xlat32;
    u_xlat32 = (u_xlatb8.y) ? u_xlat3.x : u_xlat32;
    u_xlat8.xyz = (u_xlatb8.x) ? u_xlat3.xyz : vec3(u_xlat32);
    u_xlat8.xyz = u_xlat8.xyz * vec3(_Pattern2_Light);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_Pattern_Light) + u_xlat8.xyz;
    u_xlat8.xyz = max(u_xlat2.xyz, u_xlat8.xyz);
    u_xlat8.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat8.xyz, vec3(u_xlatb5.www));
    u_xlat11.xyz = (u_xlatb5.z) ? u_xlat11.xyz : u_xlat8.xyz;
    u_xlat11.xyz = (u_xlatb5.y) ? u_xlat2.xyz : u_xlat11.xyz;
    u_xlat2.x = _Time.y * _GlintFrequency;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_GlintToggle==1.0);
#else
    u_xlatb12 = _GlintToggle==1.0;
#endif
    u_xlat2.x = cos(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * 0.5 + 0.5;
    u_xlat2.x = u_xlat2.x * _GlintBrightness;
    u_xlat2.xzw = u_xlat11.xyz * u_xlat2.xxx;
    u_xlat11.xyz = (bool(u_xlatb12)) ? u_xlat2.xzw : u_xlat11.xyz;
    u_xlat1.xyz = max(u_xlat11.xyz, u_xlat1.xxx);
    u_xlat2.xy = vs_TEXCOORD2.xy * _GrainTex_ST.xy + _GrainTex_ST.zw;
    u_xlat5.x = _Time.y * _GrainTex_Uspeed + u_xlat2.x;
    u_xlat5.y = _Time.y * _GrainTex_Vspeed + u_xlat2.y;
    u_xlat2 = texture(_GrainTex, u_xlat5.xy);
    u_xlatb3 = equal(vec4(_GrainTexChannelToggle), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(_GrainTexChannelToggle==4.0);
#else
    u_xlatb31 = _GrainTexChannelToggle==4.0;
#endif
    u_xlat31 = u_xlatb31 ? u_xlat2.w : float(0.0);
    u_xlat31 = (u_xlatb3.w) ? u_xlat2.z : u_xlat31;
    u_xlat31 = (u_xlatb3.z) ? u_xlat2.y : u_xlat31;
    u_xlat31 = (u_xlatb3.y) ? u_xlat2.x : u_xlat31;
    u_xlat2.xyz = (u_xlatb3.x) ? u_xlat2.xyz : vec3(u_xlat31);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat2.xyz = vs_COLOR0.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat2.xy = vs_TEXCOORD2.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_31 = texture(_MaskTex, u_xlat2.xy).x;
    u_xlat16_31 = u_xlat10_31 * _MaskScaler;
    u_xlat1.xyz = vec3(u_xlat16_31) * u_xlat1.xyz;
    u_xlat2.xy = vs_TEXCOORD2.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
    u_xlat16_9.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_9.xy = u_xlat16_9.xy * vec2(_NormaTexlScale);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat16_9.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat16_9.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat16_9.xyz);
    u_xlat16_31 = _EmissionStrength * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat1.w = sqrt(u_xlat16_31);
    SV_Target0.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_9.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_9.x : u_xlat1.z;
    SV_Target0.w = 0.00392156886;
    u_xlat0.w = _ReceiveShadow;
    SV_Target1 = u_xlat0;
    SV_Target2.xyw = u_xlat1.xyw;
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
Keywords { "_GRAINTEXTOGGLE_ON" "_PATTERNTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_PATTERNTEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_GRAINTEXTOGGLE_ON" "_PATTERNTEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_GRAINTEXTOGGLE_ON" "_PATTERNTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_PATTERNTEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_GRAINTEXTOGGLE_ON" "_PATTERNTEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
}
}
 Pass {
  Name "HYBRIDDEFERREDOUTLINE"
  Tags { "LIGHTMODE" = "HYBRIDDEFERREDOUTLINE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Front
  GpuProgramID 89187
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
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
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
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.5, 0.0, 0.5);
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
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
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
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.5, 0.0, 0.5);
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
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 156330
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
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
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.5, 0.0, 0.5);
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
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
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
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.5, 0.0, 0.5);
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
}
Fallback "Legacy Shaders/VertexLit"
CustomEditor "MiHoYoASEMaterialInspector"
}