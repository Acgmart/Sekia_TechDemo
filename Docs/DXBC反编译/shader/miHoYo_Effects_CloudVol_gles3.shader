//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/CloudVol" {
Properties {
_SuitEnv ("SuitEnv", Range(0, 1)) = 0
_FadeOut ("FadeOut", Range(0, 1)) = 0
_RimColor ("RimColor", Color) = (1,1,1,1)
_RimScale ("RimScale", Float) = 0
_RimThreshold ("RimThreshold", Float) = 0
_CloudColorA ("CloudColorA", Color) = (1,1,1,1)
_ColorAThreshold ("ColorAThreshold", Float) = 1
_ColorAThresholdScale ("ColorAThresholdScale", Range(0, 1)) = 1
_CloudColorB ("CloudColorB", Color) = (0.5943396,0.5943396,0.5943396,1)
_AlphaScale ("AlphaScale", Float) = 1
_CloudTex ("CloudTex", 2D) = "white" { }
_CloudTexThreshold ("CloudTexThreshold", Range(0, 1)) = 0
_CloudScale ("CloudScale", Float) = 1
_CloudHardToSoft ("CloudHardToSoft", Range(0, 1)) = 0
_CloudThickness ("CloudThickness", Float) = 0.02
_TimeScale ("TimeScale", Float) = 1
_CloudClipOffset ("CloudClipOffset", Float) = 0
_NormalTex ("NormalTex", 2D) = "white" { }
_NormalScale ("NormalScale", Range(0, 5)) = 0
_FarFadeLength ("FarFadeLength", Float) = 40
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
  GpuProgramID 48239
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
lowp float u_xlat10_10;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_13;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
mediump float u_xlat16_31;
float u_xlat33;
lowp float u_xlat10_33;
int u_xlati33;
uint u_xlatu33;
bool u_xlatb33;
float u_xlat35;
void main()
{
    u_xlat0 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat0) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_11.xy);
    u_xlat16_31 = abs(u_xlat0) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_31) + 1.0;
    u_xlat16_11.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_11.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat16_11.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_31;
    u_xlat10_10 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_0 = u_xlat10_10 * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_0 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_11.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_11.xyz + _CloudColorA.xyz;
    u_xlat10.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD6.xyz;
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat3.x = vs_TEXCOORD7.x;
    u_xlat3.y = vs_TEXCOORD9.x;
    u_xlat3.z = vs_TEXCOORD8.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.y;
    u_xlat4.y = vs_TEXCOORD9.y;
    u_xlat4.z = vs_TEXCOORD8.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.z;
    u_xlat4.y = vs_TEXCOORD9.z;
    u_xlat4.z = vs_TEXCOORD8.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat33 = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_31 = (-u_xlat33) + 1.0;
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimThreshold;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.w = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_31 = u_xlat2.y + u_xlat2.x;
    u_xlat16_8.x = u_xlat2.z + u_xlat16_31;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.z = (-u_xlat16_31);
    u_xlat4.w = (-u_xlat16_8.x);
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_31 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat16_31>=0.5);
#else
    u_xlatb33 = u_xlat16_31>=0.5;
#endif
    if(u_xlatb33){
        u_xlat33 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat33 = min(u_xlat33, 3.0);
        u_xlatu33 = uint(u_xlat33);
        u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu33)].xyz);
        u_xlati33 = int(u_xlatu33) << 2;
        u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 1)].xyz;
        u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati33].xyz * u_xlat4.xxx + u_xlat5.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 2)].xyz * u_xlat4.zzz + u_xlat4.xyw;
        u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
        u_xlat10_33 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_4.x = (-_LightShadowData.x) + 1.0;
        u_xlat33 = u_xlat10_33 * u_xlat16_4.x + _LightShadowData.x;
    } else {
        u_xlat33 = 1.0;
    //ENDIF
    }
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_2.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_31 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_31 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_31);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_31) + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xxx;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat35 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat16_31 = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_31) * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_9.xyz = u_xlat5.xyz * vec3(u_xlat35) + u_xlat3.xyz;
    u_xlat16_31 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_9.xyz = vec3(u_xlat16_31) * u_xlat16_9.xyz;
    u_xlat16_5 = dot(u_xlat16_2.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_13 = u_xlat16_13 * -0.00399392843 + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = 0.996006072 / u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * 0.318309873;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat16_31 = u_xlat3.x * u_xlat3.x;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_3 = u_xlat16_31 * 0.00766834244 + 0.0399999991;
    u_xlat16_23 = u_xlat16_3 * u_xlat16_13;
    u_xlat16_3 = u_xlat16_13 * u_xlat16_3 + 2.0;
    u_xlat16_3 = u_xlat16_23 / u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _LightColor0.xyz;
    u_xlat16_9.xyz = vec3(u_xlat33) * u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + u_xlat16_8.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_11.x = (-u_xlat10.x) + 1.0;
    u_xlat16_11.x = max(u_xlat16_11.x, 9.99999975e-05);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * 0.200000003;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat10.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat10.x = u_xlat10.x / _FarFadeLength;
    u_xlat16_21 = (-u_xlat10.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_8.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_31 = u_xlat16_31 / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_1.x = u_xlat16_31 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0 = u_xlat16_1.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_11.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_21 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    SV_Target0.w = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
lowp float u_xlat10_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat13;
mediump float u_xlat16_13;
mediump float u_xlat16_21;
float u_xlat23;
mediump float u_xlat16_23;
mediump float u_xlat16_31;
float u_xlat33;
lowp float u_xlat10_33;
int u_xlati33;
uint u_xlatu33;
bool u_xlatb33;
float u_xlat35;
void main()
{
    u_xlat0 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat0) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_11.xy);
    u_xlat16_31 = abs(u_xlat0) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_31) + 1.0;
    u_xlat16_11.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_11.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat16_11.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_31;
    u_xlat10_10 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_0 = u_xlat10_10 * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_0 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_11.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_11.xyz + _CloudColorA.xyz;
    u_xlat10.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD6.xyz;
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat3.x = vs_TEXCOORD7.x;
    u_xlat3.y = vs_TEXCOORD9.x;
    u_xlat3.z = vs_TEXCOORD8.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.y;
    u_xlat4.y = vs_TEXCOORD9.y;
    u_xlat4.z = vs_TEXCOORD8.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.z;
    u_xlat4.y = vs_TEXCOORD9.z;
    u_xlat4.z = vs_TEXCOORD8.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat33 = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_31 = (-u_xlat33) + 1.0;
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimThreshold;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.w = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_31 = u_xlat2.y + u_xlat2.x;
    u_xlat16_8.x = u_xlat2.z + u_xlat16_31;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.z = (-u_xlat16_31);
    u_xlat4.w = (-u_xlat16_8.x);
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_31 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat16_31>=0.5);
#else
    u_xlatb33 = u_xlat16_31>=0.5;
#endif
    if(u_xlatb33){
        u_xlat33 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat33 = min(u_xlat33, 3.0);
        u_xlatu33 = uint(u_xlat33);
        u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu33)].xyz);
        u_xlati33 = int(u_xlatu33) << 2;
        u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 1)].xyz;
        u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati33].xyz * u_xlat4.xxx + u_xlat5.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 2)].xyz * u_xlat4.zzz + u_xlat4.xyw;
        u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
        u_xlat10_33 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_4.x = (-_LightShadowData.x) + 1.0;
        u_xlat33 = u_xlat10_33 * u_xlat16_4.x + _LightShadowData.x;
    } else {
        u_xlat33 = 1.0;
    //ENDIF
    }
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_2.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_31 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_31 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_31);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_31) + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xxx;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat35 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat16_31 = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_31) * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_9.xyz = u_xlat5.xyz * vec3(u_xlat35) + u_xlat3.xyz;
    u_xlat16_31 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_9.xyz = vec3(u_xlat16_31) * u_xlat16_9.xyz;
    u_xlat16_5 = dot(u_xlat16_2.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_13 = u_xlat16_13 * -0.00399392843 + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = 0.996006072 / u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * 0.318309873;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat16_31 = u_xlat3.x * u_xlat3.x;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_3 = u_xlat16_31 * 0.00766834244 + 0.0399999991;
    u_xlat16_23 = u_xlat16_3 * u_xlat16_13;
    u_xlat16_3 = u_xlat16_13 * u_xlat16_3 + 2.0;
    u_xlat16_3 = u_xlat16_23 / u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _LightColor0.xyz;
    u_xlat16_9.xyz = vec3(u_xlat33) * u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + u_xlat16_8.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat3.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD10.w);
    u_xlat13.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat23 = (-u_xlat13.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat23 + u_xlat13.x;
    u_xlat13.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat13.x = inversesqrt(u_xlat13.x);
    u_xlat13.xyz = u_xlat13.xxx * vs_TEXCOORD8.xyz;
    u_xlat10.x = dot(u_xlat13.xyz, u_xlat10.xyz);
    u_xlat16_11.x = (-u_xlat10.x) + 1.0;
    u_xlat16_11.x = max(u_xlat16_11.x, 9.99999975e-05);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * 0.200000003;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat10.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat10.x = u_xlat10.x / _FarFadeLength;
    u_xlat16_21 = (-u_xlat10.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_8.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_31 = u_xlat16_31 / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_1.x = u_xlat16_31 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0 = u_xlat3.x * u_xlat16_1.x;
    u_xlat0 = u_xlat0 * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_11.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_21 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    SV_Target0.w = u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * u_xlat3.xxx;
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    vs_TEXCOORD7.xyz = u_xlat4.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat2.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
lowp float u_xlat10_10;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_13;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
mediump float u_xlat16_31;
float u_xlat33;
lowp float u_xlat10_33;
int u_xlati33;
uint u_xlatu33;
bool u_xlatb33;
float u_xlat35;
void main()
{
    u_xlat0 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat0) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_11.xy);
    u_xlat16_31 = abs(u_xlat0) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_31) + 1.0;
    u_xlat16_11.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_11.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat16_11.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_31;
    u_xlat10_10 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_0 = u_xlat10_10 * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_0 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_11.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_11.xyz + _CloudColorA.xyz;
    u_xlat10.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD6.xyz;
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat3.x = vs_TEXCOORD7.x;
    u_xlat3.y = vs_TEXCOORD9.x;
    u_xlat3.z = vs_TEXCOORD8.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.y;
    u_xlat4.y = vs_TEXCOORD9.y;
    u_xlat4.z = vs_TEXCOORD8.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.z;
    u_xlat4.y = vs_TEXCOORD9.z;
    u_xlat4.z = vs_TEXCOORD8.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat33 = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_31 = (-u_xlat33) + 1.0;
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimThreshold;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.w = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_31 = u_xlat2.y + u_xlat2.x;
    u_xlat16_8.x = u_xlat2.z + u_xlat16_31;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.z = (-u_xlat16_31);
    u_xlat4.w = (-u_xlat16_8.x);
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_31 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat16_31>=0.5);
#else
    u_xlatb33 = u_xlat16_31>=0.5;
#endif
    if(u_xlatb33){
        u_xlat33 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat33 = min(u_xlat33, 3.0);
        u_xlatu33 = uint(u_xlat33);
        u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu33)].xyz);
        u_xlati33 = int(u_xlatu33) << 2;
        u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 1)].xyz;
        u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati33].xyz * u_xlat4.xxx + u_xlat5.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 2)].xyz * u_xlat4.zzz + u_xlat4.xyw;
        u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
        u_xlat10_33 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_4.x = (-_LightShadowData.x) + 1.0;
        u_xlat33 = u_xlat10_33 * u_xlat16_4.x + _LightShadowData.x;
    } else {
        u_xlat33 = 1.0;
    //ENDIF
    }
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_2.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_31 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_31 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_31);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_31) + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xxx;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat35 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat16_31 = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_31) * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_9.xyz = u_xlat5.xyz * vec3(u_xlat35) + u_xlat3.xyz;
    u_xlat16_31 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_9.xyz = vec3(u_xlat16_31) * u_xlat16_9.xyz;
    u_xlat16_5 = dot(u_xlat16_2.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_13 = u_xlat16_13 * -0.00399392843 + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = 0.996006072 / u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * 0.318309873;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat16_31 = u_xlat3.x * u_xlat3.x;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_3 = u_xlat16_31 * 0.00766834244 + 0.0399999991;
    u_xlat16_23 = u_xlat16_3 * u_xlat16_13;
    u_xlat16_3 = u_xlat16_13 * u_xlat16_3 + 2.0;
    u_xlat16_3 = u_xlat16_23 / u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _LightColor0.xyz;
    u_xlat16_9.xyz = vec3(u_xlat33) * u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + u_xlat16_8.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_11.x = (-u_xlat10.x) + 1.0;
    u_xlat16_11.x = max(u_xlat16_11.x, 9.99999975e-05);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * 0.200000003;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat10.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat10.x = u_xlat10.x / _FarFadeLength;
    u_xlat16_21 = (-u_xlat10.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_8.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_31 = u_xlat16_31 / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_1.x = u_xlat16_31 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0 = u_xlat16_1.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_11.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_21 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    SV_Target0.w = u_xlat0;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * u_xlat3.xxx;
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    vs_TEXCOORD7.xyz = u_xlat4.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat2.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
lowp float u_xlat10_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat13;
mediump float u_xlat16_13;
mediump float u_xlat16_21;
float u_xlat23;
mediump float u_xlat16_23;
mediump float u_xlat16_31;
float u_xlat33;
lowp float u_xlat10_33;
int u_xlati33;
uint u_xlatu33;
bool u_xlatb33;
float u_xlat35;
void main()
{
    u_xlat0 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat0) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_11.xy);
    u_xlat16_31 = abs(u_xlat0) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_31) + 1.0;
    u_xlat16_11.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_11.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat16_11.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_31;
    u_xlat10_10 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_0 = u_xlat10_10 * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_0 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_11.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_11.xyz + _CloudColorA.xyz;
    u_xlat10.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD6.xyz;
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat3.x = vs_TEXCOORD7.x;
    u_xlat3.y = vs_TEXCOORD9.x;
    u_xlat3.z = vs_TEXCOORD8.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.y;
    u_xlat4.y = vs_TEXCOORD9.y;
    u_xlat4.z = vs_TEXCOORD8.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.z;
    u_xlat4.y = vs_TEXCOORD9.z;
    u_xlat4.z = vs_TEXCOORD8.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat33 = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_31 = (-u_xlat33) + 1.0;
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimThreshold;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.w = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_31 = u_xlat2.y + u_xlat2.x;
    u_xlat16_8.x = u_xlat2.z + u_xlat16_31;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.z = (-u_xlat16_31);
    u_xlat4.w = (-u_xlat16_8.x);
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_31 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat16_31>=0.5);
#else
    u_xlatb33 = u_xlat16_31>=0.5;
#endif
    if(u_xlatb33){
        u_xlat33 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat33 = min(u_xlat33, 3.0);
        u_xlatu33 = uint(u_xlat33);
        u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu33)].xyz);
        u_xlati33 = int(u_xlatu33) << 2;
        u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 1)].xyz;
        u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati33].xyz * u_xlat4.xxx + u_xlat5.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 2)].xyz * u_xlat4.zzz + u_xlat4.xyw;
        u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
        u_xlat10_33 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_4.x = (-_LightShadowData.x) + 1.0;
        u_xlat33 = u_xlat10_33 * u_xlat16_4.x + _LightShadowData.x;
    } else {
        u_xlat33 = 1.0;
    //ENDIF
    }
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_2.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_31 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_31 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_31);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_31) + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xxx;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat35 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat16_31 = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_31) * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_9.xyz = u_xlat5.xyz * vec3(u_xlat35) + u_xlat3.xyz;
    u_xlat16_31 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_9.xyz = vec3(u_xlat16_31) * u_xlat16_9.xyz;
    u_xlat16_5 = dot(u_xlat16_2.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_13 = u_xlat16_13 * -0.00399392843 + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = 0.996006072 / u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * 0.318309873;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat16_31 = u_xlat3.x * u_xlat3.x;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_3 = u_xlat16_31 * 0.00766834244 + 0.0399999991;
    u_xlat16_23 = u_xlat16_3 * u_xlat16_13;
    u_xlat16_3 = u_xlat16_13 * u_xlat16_3 + 2.0;
    u_xlat16_3 = u_xlat16_23 / u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _LightColor0.xyz;
    u_xlat16_9.xyz = vec3(u_xlat33) * u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + u_xlat16_8.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat3.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD10.w);
    u_xlat13.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat23 = (-u_xlat13.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat23 + u_xlat13.x;
    u_xlat13.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat13.x = inversesqrt(u_xlat13.x);
    u_xlat13.xyz = u_xlat13.xxx * vs_TEXCOORD8.xyz;
    u_xlat10.x = dot(u_xlat13.xyz, u_xlat10.xyz);
    u_xlat16_11.x = (-u_xlat10.x) + 1.0;
    u_xlat16_11.x = max(u_xlat16_11.x, 9.99999975e-05);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * 0.200000003;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat10.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat10.x = u_xlat10.x / _FarFadeLength;
    u_xlat16_21 = (-u_xlat10.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_8.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_31 = u_xlat16_31 / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_1.x = u_xlat16_31 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0 = u_xlat3.x * u_xlat16_1.x;
    u_xlat0 = u_xlat0 * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_11.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_21 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    SV_Target0.w = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
lowp float u_xlat10_10;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_13;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
mediump float u_xlat16_31;
float u_xlat33;
lowp float u_xlat10_33;
int u_xlati33;
uint u_xlatu33;
bool u_xlatb33;
float u_xlat35;
void main()
{
    u_xlat0 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat0) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_11.xy);
    u_xlat16_31 = abs(u_xlat0) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_31) + 1.0;
    u_xlat16_11.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_11.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat16_11.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_31;
    u_xlat10_10 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_0 = u_xlat10_10 * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_0 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_11.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_11.xyz + _CloudColorA.xyz;
    u_xlat10.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD6.xyz;
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat3.x = vs_TEXCOORD7.x;
    u_xlat3.y = vs_TEXCOORD9.x;
    u_xlat3.z = vs_TEXCOORD8.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.y;
    u_xlat4.y = vs_TEXCOORD9.y;
    u_xlat4.z = vs_TEXCOORD8.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.z;
    u_xlat4.y = vs_TEXCOORD9.z;
    u_xlat4.z = vs_TEXCOORD8.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat33 = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_31 = (-u_xlat33) + 1.0;
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimThreshold;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.w = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_31 = u_xlat2.y + u_xlat2.x;
    u_xlat16_8.x = u_xlat2.z + u_xlat16_31;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.z = (-u_xlat16_31);
    u_xlat4.w = (-u_xlat16_8.x);
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_31 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat16_31>=0.5);
#else
    u_xlatb33 = u_xlat16_31>=0.5;
#endif
    if(u_xlatb33){
        u_xlat33 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat33 = min(u_xlat33, 3.0);
        u_xlatu33 = uint(u_xlat33);
        u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu33)].xyz);
        u_xlati33 = int(u_xlatu33) << 2;
        u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 1)].xyz;
        u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati33].xyz * u_xlat4.xxx + u_xlat5.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 2)].xyz * u_xlat4.zzz + u_xlat4.xyw;
        u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
        u_xlat10_33 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_4.x = (-_LightShadowData.x) + 1.0;
        u_xlat33 = u_xlat10_33 * u_xlat16_4.x + _LightShadowData.x;
    } else {
        u_xlat33 = 1.0;
    //ENDIF
    }
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_2.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_31 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_31 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_31);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_31) + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xxx;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat35 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat16_31 = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_31) * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_9.xyz = u_xlat5.xyz * vec3(u_xlat35) + u_xlat3.xyz;
    u_xlat16_31 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_9.xyz = vec3(u_xlat16_31) * u_xlat16_9.xyz;
    u_xlat16_5 = dot(u_xlat16_2.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_13 = u_xlat16_13 * -0.00399392843 + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = 0.996006072 / u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * 0.318309873;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat16_31 = u_xlat3.x * u_xlat3.x;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_3 = u_xlat16_31 * 0.00766834244 + 0.0399999991;
    u_xlat16_23 = u_xlat16_3 * u_xlat16_13;
    u_xlat16_3 = u_xlat16_13 * u_xlat16_3 + 2.0;
    u_xlat16_3 = u_xlat16_23 / u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _LightColor0.xyz;
    u_xlat16_9.xyz = vec3(u_xlat33) * u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + u_xlat16_8.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_11.x = (-u_xlat10.x) + 1.0;
    u_xlat16_11.x = max(u_xlat16_11.x, 9.99999975e-05);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * 0.200000003;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat10.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat10.x = u_xlat10.x / _FarFadeLength;
    u_xlat16_21 = (-u_xlat10.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_8.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_31 = u_xlat16_31 / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_1.x = u_xlat16_31 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0 = u_xlat16_1.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_11.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_21 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    SV_Target0.w = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
lowp float u_xlat10_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat13;
mediump float u_xlat16_13;
mediump float u_xlat16_21;
float u_xlat23;
mediump float u_xlat16_23;
mediump float u_xlat16_31;
float u_xlat33;
lowp float u_xlat10_33;
int u_xlati33;
uint u_xlatu33;
bool u_xlatb33;
float u_xlat35;
void main()
{
    u_xlat0 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat0) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_11.xy);
    u_xlat16_31 = abs(u_xlat0) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_31) + 1.0;
    u_xlat16_11.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_11.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat16_11.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_31;
    u_xlat10_10 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_0 = u_xlat10_10 * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_0 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_11.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_11.xyz + _CloudColorA.xyz;
    u_xlat10.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD6.xyz;
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat3.x = vs_TEXCOORD7.x;
    u_xlat3.y = vs_TEXCOORD9.x;
    u_xlat3.z = vs_TEXCOORD8.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.y;
    u_xlat4.y = vs_TEXCOORD9.y;
    u_xlat4.z = vs_TEXCOORD8.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.z;
    u_xlat4.y = vs_TEXCOORD9.z;
    u_xlat4.z = vs_TEXCOORD8.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat33 = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_31 = (-u_xlat33) + 1.0;
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimThreshold;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.w = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_31 = u_xlat2.y + u_xlat2.x;
    u_xlat16_8.x = u_xlat2.z + u_xlat16_31;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.z = (-u_xlat16_31);
    u_xlat4.w = (-u_xlat16_8.x);
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_31 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat16_31>=0.5);
#else
    u_xlatb33 = u_xlat16_31>=0.5;
#endif
    if(u_xlatb33){
        u_xlat33 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat33 = min(u_xlat33, 3.0);
        u_xlatu33 = uint(u_xlat33);
        u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu33)].xyz);
        u_xlati33 = int(u_xlatu33) << 2;
        u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 1)].xyz;
        u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati33].xyz * u_xlat4.xxx + u_xlat5.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 2)].xyz * u_xlat4.zzz + u_xlat4.xyw;
        u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
        u_xlat10_33 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_4.x = (-_LightShadowData.x) + 1.0;
        u_xlat33 = u_xlat10_33 * u_xlat16_4.x + _LightShadowData.x;
    } else {
        u_xlat33 = 1.0;
    //ENDIF
    }
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_2.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_31 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_31 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_31);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_31) + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xxx;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat35 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat16_31 = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_31) * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_9.xyz = u_xlat5.xyz * vec3(u_xlat35) + u_xlat3.xyz;
    u_xlat16_31 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_9.xyz = vec3(u_xlat16_31) * u_xlat16_9.xyz;
    u_xlat16_5 = dot(u_xlat16_2.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_13 = u_xlat16_13 * -0.00399392843 + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = 0.996006072 / u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * 0.318309873;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat16_31 = u_xlat3.x * u_xlat3.x;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_3 = u_xlat16_31 * 0.00766834244 + 0.0399999991;
    u_xlat16_23 = u_xlat16_3 * u_xlat16_13;
    u_xlat16_3 = u_xlat16_13 * u_xlat16_3 + 2.0;
    u_xlat16_3 = u_xlat16_23 / u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _LightColor0.xyz;
    u_xlat16_9.xyz = vec3(u_xlat33) * u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + u_xlat16_8.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat3.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD10.w);
    u_xlat13.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat23 = (-u_xlat13.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat23 + u_xlat13.x;
    u_xlat13.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat13.x = inversesqrt(u_xlat13.x);
    u_xlat13.xyz = u_xlat13.xxx * vs_TEXCOORD8.xyz;
    u_xlat10.x = dot(u_xlat13.xyz, u_xlat10.xyz);
    u_xlat16_11.x = (-u_xlat10.x) + 1.0;
    u_xlat16_11.x = max(u_xlat16_11.x, 9.99999975e-05);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * 0.200000003;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat10.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat10.x = u_xlat10.x / _FarFadeLength;
    u_xlat16_21 = (-u_xlat10.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_8.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_31 = u_xlat16_31 / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_1.x = u_xlat16_31 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0 = u_xlat3.x * u_xlat16_1.x;
    u_xlat0 = u_xlat0 * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_11.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_21 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    SV_Target0.w = u_xlat0;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * u_xlat3.xxx;
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    vs_TEXCOORD7.xyz = u_xlat4.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat2.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
lowp float u_xlat10_10;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_13;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
mediump float u_xlat16_31;
float u_xlat33;
lowp float u_xlat10_33;
int u_xlati33;
uint u_xlatu33;
bool u_xlatb33;
float u_xlat35;
void main()
{
    u_xlat0 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat0) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_11.xy);
    u_xlat16_31 = abs(u_xlat0) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_31) + 1.0;
    u_xlat16_11.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_11.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat16_11.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_31;
    u_xlat10_10 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_0 = u_xlat10_10 * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_0 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_11.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_11.xyz + _CloudColorA.xyz;
    u_xlat10.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD6.xyz;
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat3.x = vs_TEXCOORD7.x;
    u_xlat3.y = vs_TEXCOORD9.x;
    u_xlat3.z = vs_TEXCOORD8.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.y;
    u_xlat4.y = vs_TEXCOORD9.y;
    u_xlat4.z = vs_TEXCOORD8.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.z;
    u_xlat4.y = vs_TEXCOORD9.z;
    u_xlat4.z = vs_TEXCOORD8.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat33 = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_31 = (-u_xlat33) + 1.0;
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimThreshold;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.w = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_31 = u_xlat2.y + u_xlat2.x;
    u_xlat16_8.x = u_xlat2.z + u_xlat16_31;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.z = (-u_xlat16_31);
    u_xlat4.w = (-u_xlat16_8.x);
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_31 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat16_31>=0.5);
#else
    u_xlatb33 = u_xlat16_31>=0.5;
#endif
    if(u_xlatb33){
        u_xlat33 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat33 = min(u_xlat33, 3.0);
        u_xlatu33 = uint(u_xlat33);
        u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu33)].xyz);
        u_xlati33 = int(u_xlatu33) << 2;
        u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 1)].xyz;
        u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati33].xyz * u_xlat4.xxx + u_xlat5.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 2)].xyz * u_xlat4.zzz + u_xlat4.xyw;
        u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
        u_xlat10_33 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_4.x = (-_LightShadowData.x) + 1.0;
        u_xlat33 = u_xlat10_33 * u_xlat16_4.x + _LightShadowData.x;
    } else {
        u_xlat33 = 1.0;
    //ENDIF
    }
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_2.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_31 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_31 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_31);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_31) + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xxx;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat35 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat16_31 = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_31) * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_9.xyz = u_xlat5.xyz * vec3(u_xlat35) + u_xlat3.xyz;
    u_xlat16_31 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_9.xyz = vec3(u_xlat16_31) * u_xlat16_9.xyz;
    u_xlat16_5 = dot(u_xlat16_2.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_13 = u_xlat16_13 * -0.00399392843 + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = 0.996006072 / u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * 0.318309873;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat16_31 = u_xlat3.x * u_xlat3.x;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_3 = u_xlat16_31 * 0.00766834244 + 0.0399999991;
    u_xlat16_23 = u_xlat16_3 * u_xlat16_13;
    u_xlat16_3 = u_xlat16_13 * u_xlat16_3 + 2.0;
    u_xlat16_3 = u_xlat16_23 / u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _LightColor0.xyz;
    u_xlat16_9.xyz = vec3(u_xlat33) * u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + u_xlat16_8.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_11.x = (-u_xlat10.x) + 1.0;
    u_xlat16_11.x = max(u_xlat16_11.x, 9.99999975e-05);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * 0.200000003;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat10.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat10.x = u_xlat10.x / _FarFadeLength;
    u_xlat16_21 = (-u_xlat10.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_8.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_31 = u_xlat16_31 / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_1.x = u_xlat16_31 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0 = u_xlat16_1.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_11.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_21 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    SV_Target0.w = u_xlat0;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * u_xlat3.xxx;
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    vs_TEXCOORD7.xyz = u_xlat4.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat2.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
lowp float u_xlat10_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat13;
mediump float u_xlat16_13;
mediump float u_xlat16_21;
float u_xlat23;
mediump float u_xlat16_23;
mediump float u_xlat16_31;
float u_xlat33;
lowp float u_xlat10_33;
int u_xlati33;
uint u_xlatu33;
bool u_xlatb33;
float u_xlat35;
void main()
{
    u_xlat0 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat0) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_11.xy);
    u_xlat16_31 = abs(u_xlat0) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_31) + 1.0;
    u_xlat16_11.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_11.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat16_11.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_31;
    u_xlat10_10 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_0 = u_xlat10_10 * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_0 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_11.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_11.xyz + _CloudColorA.xyz;
    u_xlat10.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD6.xyz;
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat3.x = vs_TEXCOORD7.x;
    u_xlat3.y = vs_TEXCOORD9.x;
    u_xlat3.z = vs_TEXCOORD8.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.y;
    u_xlat4.y = vs_TEXCOORD9.y;
    u_xlat4.z = vs_TEXCOORD8.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.z;
    u_xlat4.y = vs_TEXCOORD9.z;
    u_xlat4.z = vs_TEXCOORD8.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat33 = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_31 = (-u_xlat33) + 1.0;
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimThreshold;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.w = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_31 = u_xlat2.y + u_xlat2.x;
    u_xlat16_8.x = u_xlat2.z + u_xlat16_31;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.z = (-u_xlat16_31);
    u_xlat4.w = (-u_xlat16_8.x);
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_31 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat16_31>=0.5);
#else
    u_xlatb33 = u_xlat16_31>=0.5;
#endif
    if(u_xlatb33){
        u_xlat33 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat33 = min(u_xlat33, 3.0);
        u_xlatu33 = uint(u_xlat33);
        u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu33)].xyz);
        u_xlati33 = int(u_xlatu33) << 2;
        u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 1)].xyz;
        u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati33].xyz * u_xlat4.xxx + u_xlat5.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 2)].xyz * u_xlat4.zzz + u_xlat4.xyw;
        u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
        u_xlat10_33 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_4.x = (-_LightShadowData.x) + 1.0;
        u_xlat33 = u_xlat10_33 * u_xlat16_4.x + _LightShadowData.x;
    } else {
        u_xlat33 = 1.0;
    //ENDIF
    }
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_2.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_31 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_31 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_31);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_31) + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xxx;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat35 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat16_31 = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_31) * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_9.xyz = u_xlat5.xyz * vec3(u_xlat35) + u_xlat3.xyz;
    u_xlat16_31 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_9.xyz = vec3(u_xlat16_31) * u_xlat16_9.xyz;
    u_xlat16_5 = dot(u_xlat16_2.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_13 = u_xlat16_13 * -0.00399392843 + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = 0.996006072 / u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * 0.318309873;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat16_31 = u_xlat3.x * u_xlat3.x;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_3 = u_xlat16_31 * 0.00766834244 + 0.0399999991;
    u_xlat16_23 = u_xlat16_3 * u_xlat16_13;
    u_xlat16_3 = u_xlat16_13 * u_xlat16_3 + 2.0;
    u_xlat16_3 = u_xlat16_23 / u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _LightColor0.xyz;
    u_xlat16_9.xyz = vec3(u_xlat33) * u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + u_xlat16_8.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat3.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD10.w);
    u_xlat13.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat23 = (-u_xlat13.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat23 + u_xlat13.x;
    u_xlat13.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat13.x = inversesqrt(u_xlat13.x);
    u_xlat13.xyz = u_xlat13.xxx * vs_TEXCOORD8.xyz;
    u_xlat10.x = dot(u_xlat13.xyz, u_xlat10.xyz);
    u_xlat16_11.x = (-u_xlat10.x) + 1.0;
    u_xlat16_11.x = max(u_xlat16_11.x, 9.99999975e-05);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * 0.200000003;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat10.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat10.x = u_xlat10.x / _FarFadeLength;
    u_xlat16_21 = (-u_xlat10.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_8.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_31 = u_xlat16_31 / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_1.x = u_xlat16_31 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0 = u_xlat3.x * u_xlat16_1.x;
    u_xlat0 = u_xlat0 * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_11.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_21 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    SV_Target0.w = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec4 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
bool u_xlatb11;
bool u_xlatb12;
bvec3 u_xlatb13;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_15;
mediump float u_xlat16_16;
int u_xlati16;
bool u_xlatb16;
mediump vec3 u_xlat16_17;
vec3 u_xlat23;
bool u_xlatb24;
bool u_xlatb27;
bool u_xlatb28;
float u_xlat32;
mediump float u_xlat16_32;
lowp float u_xlat10_32;
bool u_xlatb32;
mediump float u_xlat16_33;
bool u_xlatb40;
bool u_xlatb43;
bool u_xlatb44;
float u_xlat48;
lowp float u_xlat10_48;
int u_xlati48;
uint u_xlatu48;
bool u_xlatb48;
mediump float u_xlat16_49;
float u_xlat51;
mediump float u_xlat16_51;
bool u_xlatb53;
bool u_xlatb54;
bool u_xlatb56;
bool u_xlatb59;
bool u_xlatb60;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb32 = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb32){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat32 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat32) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_17.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_17.xy);
    u_xlat16_49 = abs(u_xlat32) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = (-u_xlat16_49) + 1.0;
    u_xlat16_17.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_17.xy;
    u_xlat10_32 = texture(_CloudTex, u_xlat16_17.xy).x;
    u_xlat16_32 = u_xlat10_32 * u_xlat16_49;
    u_xlat10_48 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_32 = u_xlat10_48 * u_xlat16_32;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_32 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_17.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_17.xyz + _CloudColorA.xyz;
    u_xlat48 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat48 = inversesqrt(u_xlat48);
    u_xlat3.xyz = vec3(u_xlat48) * vs_TEXCOORD6.xyz;
    u_xlat10_4.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat4.x = vs_TEXCOORD7.x;
    u_xlat4.y = vs_TEXCOORD9.x;
    u_xlat4.z = vs_TEXCOORD8.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.y;
    u_xlat5.y = vs_TEXCOORD9.y;
    u_xlat5.z = vs_TEXCOORD8.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.z;
    u_xlat5.y = vs_TEXCOORD9.z;
    u_xlat5.z = vs_TEXCOORD8.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat48 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_49 = (-u_xlat48) + 1.0;
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimThreshold;
    u_xlat16_49 = exp2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_49) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat8.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.w = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_49 = u_xlat2.y + u_xlat2.x;
    u_xlat16_9.x = u_xlat2.z + u_xlat16_49;
    u_xlat5.x = -0.0;
    u_xlat5.y = (-u_xlat2.x);
    u_xlat5.z = (-u_xlat16_49);
    u_xlat5.w = (-u_xlat16_9.x);
    u_xlat2 = u_xlat2 + u_xlat5;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_49 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat16_49>=0.5);
#else
    u_xlatb48 = u_xlat16_49>=0.5;
#endif
    if(u_xlatb48){
        u_xlat48 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat48 = min(u_xlat48, 3.0);
        u_xlatu48 = uint(u_xlat48);
        u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu48)].xyz);
        u_xlati48 = int(u_xlatu48) << 2;
        u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 1)].xyz;
        u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati48].xyz * u_xlat5.xxx + u_xlat6.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
        u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
        u_xlat10_48 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_51 = (-_LightShadowData.x) + 1.0;
        u_xlat48 = u_xlat10_48 * u_xlat16_51 + _LightShadowData.x;
    } else {
        u_xlat48 = 1.0;
    //ENDIF
    }
    u_xlat16_49 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_2.xyz = vec3(u_xlat16_49) * u_xlat4.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_49 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_49 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_49);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_49) + u_xlat16_10.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat51 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
    u_xlat5.xyz = vec3(u_xlat51) * u_xlat5.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat51 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
#ifdef UNITY_ADRENO_ES3
    u_xlatb53 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb53 = unity_DebugViewInfo.x==1.0;
#endif
    if(!u_xlatb53){
#ifdef UNITY_ADRENO_ES3
        u_xlatb54 = !!(unity_DebugViewInfo.x==2.0);
#else
        u_xlatb54 = unity_DebugViewInfo.x==2.0;
#endif
        u_xlat16_10.xyz = (bool(u_xlatb54)) ? vec3(0.0399999991, 0.0399999991, 0.0399999991) : u_xlat16_1.xyz;
        if(!u_xlatb54){
#ifdef UNITY_ADRENO_ES3
            u_xlatb7 = !!(unity_DebugViewInfo.x==3.0);
#else
            u_xlatb7 = unity_DebugViewInfo.x==3.0;
#endif
            u_xlat16_10.xyz = (bool(u_xlatb7)) ? vec3(0.000999987125, 0.000999987125, 0.000999987125) : u_xlat16_10.xyz;
            if(!u_xlatb7){
                u_xlat23.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                u_xlatb8 = !!(unity_DebugViewInfo.x==4.0);
#else
                u_xlatb8 = unity_DebugViewInfo.x==4.0;
#endif
                if(!u_xlatb8){
#ifdef UNITY_ADRENO_ES3
                    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
                    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
                    if(!u_xlatb24){
#ifdef UNITY_ADRENO_ES3
                        u_xlatb40 = !!(unity_DebugViewInfo.x==6.0);
#else
                        u_xlatb40 = unity_DebugViewInfo.x==6.0;
#endif
                        if(!u_xlatb40){
#ifdef UNITY_ADRENO_ES3
                            u_xlatb56 = !!(unity_DebugViewInfo.x==7.0);
#else
                            u_xlatb56 = unity_DebugViewInfo.x==7.0;
#endif
                            if(!u_xlatb56){
#ifdef UNITY_ADRENO_ES3
                                u_xlatb11 = !!(unity_DebugViewInfo.x==8.0);
#else
                                u_xlatb11 = unity_DebugViewInfo.x==8.0;
#endif
                                u_xlat16_10.xyz = (bool(u_xlatb11)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                if(!u_xlatb11){
#ifdef UNITY_ADRENO_ES3
                                    u_xlatb27 = !!(unity_DebugViewInfo.x==9.0);
#else
                                    u_xlatb27 = unity_DebugViewInfo.x==9.0;
#endif
                                    u_xlat16_10.xyz = (bool(u_xlatb27)) ? vec3(u_xlat48) : u_xlat16_10.xyz;
                                    if(!u_xlatb27){
#ifdef UNITY_ADRENO_ES3
                                        u_xlatb43 = !!(unity_DebugViewInfo.x==10.0);
#else
                                        u_xlatb43 = unity_DebugViewInfo.x==10.0;
#endif
                                        if(!u_xlatb43){
#ifdef UNITY_ADRENO_ES3
                                            u_xlatb59 = !!(unity_DebugViewInfo.x==11.0);
#else
                                            u_xlatb59 = unity_DebugViewInfo.x==11.0;
#endif
                                            u_xlat16_10.xyz = (bool(u_xlatb59)) ? vec3(1.0, 1.0, 1.0) : u_xlat16_10.xyz;
                                            if(!u_xlatb59){
#ifdef UNITY_ADRENO_ES3
                                                u_xlatb12 = !!(unity_DebugViewInfo.x==12.0);
#else
                                                u_xlatb12 = unity_DebugViewInfo.x==12.0;
#endif
                                                u_xlat16_10.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                if(!u_xlatb12){
#ifdef UNITY_ADRENO_ES3
                                                    u_xlatb28 = !!(unity_DebugViewInfo.x==13.0);
#else
                                                    u_xlatb28 = unity_DebugViewInfo.x==13.0;
#endif
                                                    u_xlat16_10.xyz = (bool(u_xlatb28)) ? vec3(0.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                    if(!u_xlatb28){
#ifdef UNITY_ADRENO_ES3
                                                        u_xlatb44 = !!(unity_DebugViewInfo.x==51.0);
#else
                                                        u_xlatb44 = unity_DebugViewInfo.x==51.0;
#endif
                                                        u_xlat16_10.xyz = (bool(u_xlatb44)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                                        if(!u_xlatb44){
                                                            if(!u_xlatb0.x){
                                                                u_xlatb13.xyz = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 151.0, 0.0)).xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_10.xyz;
                                                                u_xlatb60 = u_xlatb0.y || u_xlatb13.y;
                                                                u_xlat16_15.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.z || u_xlatb60;
                                                                u_xlat16_14.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.y) ? u_xlat16_15.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.y || u_xlatb13.z;
                                                                u_xlat16_14.xyz = (u_xlatb0.y) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb16 = u_xlatb0.y || u_xlatb60;
                                                                u_xlat16_10.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_14.xyz;
                                                                u_xlati16 = int(uint(u_xlatb13.x) * 0xffffffffu | uint(u_xlatb16) * 0xffffffffu);
                                                            } else {
                                                                u_xlat16_10.x = float(0.200000003);
                                                                u_xlat16_10.y = float(0.200000003);
                                                                u_xlat16_10.z = float(0.200000003);
                                                                u_xlati16 = -1;
                                                            //ENDIF
                                                            }
                                                            u_xlati0 = int(uint(u_xlatb0.x) * 0xffffffffu | uint(u_xlati16));
                                                        } else {
                                                            u_xlati0 = -1;
                                                        //ENDIF
                                                        }
                                                        u_xlati0 = int(uint(u_xlatb44) * 0xffffffffu | uint(u_xlati0));
                                                    } else {
                                                        u_xlati0 = -1;
                                                    //ENDIF
                                                    }
                                                    u_xlati0 = int(uint(u_xlatb28) * 0xffffffffu | uint(u_xlati0));
                                                } else {
                                                    u_xlati0 = -1;
                                                //ENDIF
                                                }
                                                u_xlati0 = int(uint(u_xlatb12) * 0xffffffffu | uint(u_xlati0));
                                            } else {
                                                u_xlati0 = -1;
                                            //ENDIF
                                            }
                                            u_xlati0 = int(uint(u_xlatb59) * 0xffffffffu | uint(u_xlati0));
                                        } else {
                                            u_xlat16_10.x = float(1.0);
                                            u_xlat16_10.y = float(1.0);
                                            u_xlat16_10.z = float(1.0);
                                            u_xlati0 = -1;
                                        //ENDIF
                                        }
                                        u_xlati0 = int(uint(u_xlatb43) * 0xffffffffu | uint(u_xlati0));
                                    } else {
                                        u_xlati0 = -1;
                                    //ENDIF
                                    }
                                    u_xlati0 = int(uint(u_xlatb27) * 0xffffffffu | uint(u_xlati0));
                                } else {
                                    u_xlati0 = -1;
                                //ENDIF
                                }
                                u_xlati0 = int(uint(u_xlatb11) * 0xffffffffu | uint(u_xlati0));
                            } else {
                                u_xlat16_10.xyz = u_xlat23.xyz;
                                u_xlati0 = -1;
                            //ENDIF
                            }
                            u_xlati0 = int(uint(u_xlatb56) * 0xffffffffu | uint(u_xlati0));
                        } else {
                            u_xlat16_10.xyz = u_xlat23.xyz;
                            u_xlati0 = -1;
                        //ENDIF
                        }
                        u_xlati0 = int(uint(u_xlatb40) * 0xffffffffu | uint(u_xlati0));
                    } else {
                        u_xlat16_10.xyz = u_xlat23.xyz;
                        u_xlati0 = -1;
                    //ENDIF
                    }
                    u_xlati0 = int(uint(u_xlatb24) * 0xffffffffu | uint(u_xlati0));
                } else {
                    u_xlat16_10.xyz = u_xlat23.xyz;
                    u_xlati0 = -1;
                //ENDIF
                }
                u_xlati0 = int(uint(u_xlatb8) * 0xffffffffu | uint(u_xlati0));
            } else {
                u_xlati0 = -1;
            //ENDIF
            }
            u_xlati0 = int(uint(u_xlatb7) * 0xffffffffu | uint(u_xlati0));
        } else {
            u_xlati0 = -1;
        //ENDIF
        }
        u_xlati0 = int(uint(u_xlatb54) * 0xffffffffu | uint(u_xlati0));
    } else {
        u_xlat16_10.xyz = u_xlat16_1.xyz;
        u_xlati0 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb53) * 0xffffffffu | uint(u_xlati0));
    u_xlat16_49 = dot(u_xlat16_2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_14.xyz = vec3(u_xlat16_49) * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_14.xyz * vec3(u_xlat48) + u_xlat16_9.xyz;
    u_xlat16_14.xyz = u_xlat6.xyz * vec3(u_xlat51) + u_xlat5.xyz;
    u_xlat16_49 = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_14.xyz = vec3(u_xlat16_49) * u_xlat16_14.xyz;
    u_xlat16_16 = dot(u_xlat16_2.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat51 = dot(u_xlat5.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat51 = min(max(u_xlat51, 0.0), 1.0);
#else
    u_xlat51 = clamp(u_xlat51, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * -0.00399392843 + 1.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = 0.996006072 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * 0.318309873;
    u_xlat51 = (-u_xlat51) + 1.0;
    u_xlat16_49 = u_xlat51 * u_xlat51;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_51 = u_xlat16_49 * 0.00766834244 + 0.0399999991;
    u_xlat16_5 = u_xlat16_16 * u_xlat16_51;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_51 + 2.0;
    u_xlat16_16 = u_xlat16_5 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_14.xyz = vec3(u_xlat16_16) * _LightColor0.xyz;
    u_xlat16_14.xyz = vec3(u_xlat48) * u_xlat16_14.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_1.xyz + u_xlat16_14.xyz;
    u_xlat16_9.xyz = (int(u_xlati0) != 0) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat16_9.xyz = (-u_xlat16_1.xyz) + u_xlat16_9.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat0.x = dot(u_xlat0.xyw, u_xlat3.xyz);
    u_xlat16_17.x = (-u_xlat0.x) + 1.0;
    u_xlat16_17.x = max(u_xlat16_17.x, 9.99999975e-05);
    u_xlat16_17.x = log2(u_xlat16_17.x);
    u_xlat16_17.x = u_xlat16_17.x * 0.200000003;
    u_xlat16_17.x = exp2(u_xlat16_17.x);
    u_xlat0.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x / _FarFadeLength;
    u_xlat16_33 = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_49 = u_xlat16_32 + (-_CloudTexThreshold);
    u_xlat16_9.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_49 = u_xlat16_49 / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_1.x = u_xlat16_49 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_17.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_33 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec4 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
bool u_xlatb11;
bool u_xlatb12;
bvec3 u_xlatb13;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
bool u_xlatb16;
mediump vec3 u_xlat16_17;
vec3 u_xlat23;
bool u_xlatb24;
bool u_xlatb27;
bool u_xlatb28;
float u_xlat32;
mediump float u_xlat16_32;
lowp float u_xlat10_32;
bool u_xlatb32;
mediump float u_xlat16_33;
bool u_xlatb40;
bool u_xlatb43;
bool u_xlatb44;
float u_xlat48;
lowp float u_xlat10_48;
int u_xlati48;
uint u_xlatu48;
bool u_xlatb48;
mediump float u_xlat16_49;
float u_xlat51;
mediump float u_xlat16_51;
bool u_xlatb53;
bool u_xlatb54;
bool u_xlatb56;
bool u_xlatb59;
bool u_xlatb60;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb32 = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb32){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat32 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat32) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_17.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_17.xy);
    u_xlat16_49 = abs(u_xlat32) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = (-u_xlat16_49) + 1.0;
    u_xlat16_17.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_17.xy;
    u_xlat10_32 = texture(_CloudTex, u_xlat16_17.xy).x;
    u_xlat16_32 = u_xlat10_32 * u_xlat16_49;
    u_xlat10_48 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_32 = u_xlat10_48 * u_xlat16_32;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_32 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_17.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_17.xyz + _CloudColorA.xyz;
    u_xlat48 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat48 = inversesqrt(u_xlat48);
    u_xlat3.xyz = vec3(u_xlat48) * vs_TEXCOORD6.xyz;
    u_xlat10_4.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat4.x = vs_TEXCOORD7.x;
    u_xlat4.y = vs_TEXCOORD9.x;
    u_xlat4.z = vs_TEXCOORD8.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.y;
    u_xlat5.y = vs_TEXCOORD9.y;
    u_xlat5.z = vs_TEXCOORD8.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.z;
    u_xlat5.y = vs_TEXCOORD9.z;
    u_xlat5.z = vs_TEXCOORD8.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat48 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_49 = (-u_xlat48) + 1.0;
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimThreshold;
    u_xlat16_49 = exp2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_49) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat8.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.w = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_49 = u_xlat2.y + u_xlat2.x;
    u_xlat16_9.x = u_xlat2.z + u_xlat16_49;
    u_xlat5.x = -0.0;
    u_xlat5.y = (-u_xlat2.x);
    u_xlat5.z = (-u_xlat16_49);
    u_xlat5.w = (-u_xlat16_9.x);
    u_xlat2 = u_xlat2 + u_xlat5;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_49 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat16_49>=0.5);
#else
    u_xlatb48 = u_xlat16_49>=0.5;
#endif
    if(u_xlatb48){
        u_xlat48 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat48 = min(u_xlat48, 3.0);
        u_xlatu48 = uint(u_xlat48);
        u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu48)].xyz);
        u_xlati48 = int(u_xlatu48) << 2;
        u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 1)].xyz;
        u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati48].xyz * u_xlat5.xxx + u_xlat6.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
        u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
        u_xlat10_48 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_51 = (-_LightShadowData.x) + 1.0;
        u_xlat48 = u_xlat10_48 * u_xlat16_51 + _LightShadowData.x;
    } else {
        u_xlat48 = 1.0;
    //ENDIF
    }
    u_xlat16_49 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_2.xyz = vec3(u_xlat16_49) * u_xlat4.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_49 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_49 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_49);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_49) + u_xlat16_10.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat51 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
    u_xlat5.xyz = vec3(u_xlat51) * u_xlat5.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat51 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
#ifdef UNITY_ADRENO_ES3
    u_xlatb53 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb53 = unity_DebugViewInfo.x==1.0;
#endif
    if(!u_xlatb53){
#ifdef UNITY_ADRENO_ES3
        u_xlatb54 = !!(unity_DebugViewInfo.x==2.0);
#else
        u_xlatb54 = unity_DebugViewInfo.x==2.0;
#endif
        u_xlat16_10.xyz = (bool(u_xlatb54)) ? vec3(0.0399999991, 0.0399999991, 0.0399999991) : u_xlat16_1.xyz;
        if(!u_xlatb54){
#ifdef UNITY_ADRENO_ES3
            u_xlatb7 = !!(unity_DebugViewInfo.x==3.0);
#else
            u_xlatb7 = unity_DebugViewInfo.x==3.0;
#endif
            u_xlat16_10.xyz = (bool(u_xlatb7)) ? vec3(0.000999987125, 0.000999987125, 0.000999987125) : u_xlat16_10.xyz;
            if(!u_xlatb7){
                u_xlat23.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                u_xlatb8 = !!(unity_DebugViewInfo.x==4.0);
#else
                u_xlatb8 = unity_DebugViewInfo.x==4.0;
#endif
                if(!u_xlatb8){
#ifdef UNITY_ADRENO_ES3
                    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
                    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
                    if(!u_xlatb24){
#ifdef UNITY_ADRENO_ES3
                        u_xlatb40 = !!(unity_DebugViewInfo.x==6.0);
#else
                        u_xlatb40 = unity_DebugViewInfo.x==6.0;
#endif
                        if(!u_xlatb40){
#ifdef UNITY_ADRENO_ES3
                            u_xlatb56 = !!(unity_DebugViewInfo.x==7.0);
#else
                            u_xlatb56 = unity_DebugViewInfo.x==7.0;
#endif
                            if(!u_xlatb56){
#ifdef UNITY_ADRENO_ES3
                                u_xlatb11 = !!(unity_DebugViewInfo.x==8.0);
#else
                                u_xlatb11 = unity_DebugViewInfo.x==8.0;
#endif
                                u_xlat16_10.xyz = (bool(u_xlatb11)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                if(!u_xlatb11){
#ifdef UNITY_ADRENO_ES3
                                    u_xlatb27 = !!(unity_DebugViewInfo.x==9.0);
#else
                                    u_xlatb27 = unity_DebugViewInfo.x==9.0;
#endif
                                    u_xlat16_10.xyz = (bool(u_xlatb27)) ? vec3(u_xlat48) : u_xlat16_10.xyz;
                                    if(!u_xlatb27){
#ifdef UNITY_ADRENO_ES3
                                        u_xlatb43 = !!(unity_DebugViewInfo.x==10.0);
#else
                                        u_xlatb43 = unity_DebugViewInfo.x==10.0;
#endif
                                        if(!u_xlatb43){
#ifdef UNITY_ADRENO_ES3
                                            u_xlatb59 = !!(unity_DebugViewInfo.x==11.0);
#else
                                            u_xlatb59 = unity_DebugViewInfo.x==11.0;
#endif
                                            u_xlat16_10.xyz = (bool(u_xlatb59)) ? vec3(1.0, 1.0, 1.0) : u_xlat16_10.xyz;
                                            if(!u_xlatb59){
#ifdef UNITY_ADRENO_ES3
                                                u_xlatb12 = !!(unity_DebugViewInfo.x==12.0);
#else
                                                u_xlatb12 = unity_DebugViewInfo.x==12.0;
#endif
                                                u_xlat16_10.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                if(!u_xlatb12){
#ifdef UNITY_ADRENO_ES3
                                                    u_xlatb28 = !!(unity_DebugViewInfo.x==13.0);
#else
                                                    u_xlatb28 = unity_DebugViewInfo.x==13.0;
#endif
                                                    u_xlat16_10.xyz = (bool(u_xlatb28)) ? vec3(0.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                    if(!u_xlatb28){
#ifdef UNITY_ADRENO_ES3
                                                        u_xlatb44 = !!(unity_DebugViewInfo.x==51.0);
#else
                                                        u_xlatb44 = unity_DebugViewInfo.x==51.0;
#endif
                                                        u_xlat16_10.xyz = (bool(u_xlatb44)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                                        if(!u_xlatb44){
                                                            if(!u_xlatb0.x){
                                                                u_xlatb13.xyz = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 151.0, 0.0)).xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_10.xyz;
                                                                u_xlatb60 = u_xlatb0.y || u_xlatb13.y;
                                                                u_xlat16_15.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.z || u_xlatb60;
                                                                u_xlat16_14.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.y) ? u_xlat16_15.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.y || u_xlatb13.z;
                                                                u_xlat16_14.xyz = (u_xlatb0.y) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb16 = u_xlatb0.y || u_xlatb60;
                                                                u_xlat16_10.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_14.xyz;
                                                                u_xlati16 = int(uint(u_xlatb13.x) * 0xffffffffu | uint(u_xlatb16) * 0xffffffffu);
                                                            } else {
                                                                u_xlat16_10.x = float(0.200000003);
                                                                u_xlat16_10.y = float(0.200000003);
                                                                u_xlat16_10.z = float(0.200000003);
                                                                u_xlati16 = -1;
                                                            //ENDIF
                                                            }
                                                            u_xlati0 = int(uint(u_xlatb0.x) * 0xffffffffu | uint(u_xlati16));
                                                        } else {
                                                            u_xlati0 = -1;
                                                        //ENDIF
                                                        }
                                                        u_xlati0 = int(uint(u_xlatb44) * 0xffffffffu | uint(u_xlati0));
                                                    } else {
                                                        u_xlati0 = -1;
                                                    //ENDIF
                                                    }
                                                    u_xlati0 = int(uint(u_xlatb28) * 0xffffffffu | uint(u_xlati0));
                                                } else {
                                                    u_xlati0 = -1;
                                                //ENDIF
                                                }
                                                u_xlati0 = int(uint(u_xlatb12) * 0xffffffffu | uint(u_xlati0));
                                            } else {
                                                u_xlati0 = -1;
                                            //ENDIF
                                            }
                                            u_xlati0 = int(uint(u_xlatb59) * 0xffffffffu | uint(u_xlati0));
                                        } else {
                                            u_xlat16_10.x = float(1.0);
                                            u_xlat16_10.y = float(1.0);
                                            u_xlat16_10.z = float(1.0);
                                            u_xlati0 = -1;
                                        //ENDIF
                                        }
                                        u_xlati0 = int(uint(u_xlatb43) * 0xffffffffu | uint(u_xlati0));
                                    } else {
                                        u_xlati0 = -1;
                                    //ENDIF
                                    }
                                    u_xlati0 = int(uint(u_xlatb27) * 0xffffffffu | uint(u_xlati0));
                                } else {
                                    u_xlati0 = -1;
                                //ENDIF
                                }
                                u_xlati0 = int(uint(u_xlatb11) * 0xffffffffu | uint(u_xlati0));
                            } else {
                                u_xlat16_10.xyz = u_xlat23.xyz;
                                u_xlati0 = -1;
                            //ENDIF
                            }
                            u_xlati0 = int(uint(u_xlatb56) * 0xffffffffu | uint(u_xlati0));
                        } else {
                            u_xlat16_10.xyz = u_xlat23.xyz;
                            u_xlati0 = -1;
                        //ENDIF
                        }
                        u_xlati0 = int(uint(u_xlatb40) * 0xffffffffu | uint(u_xlati0));
                    } else {
                        u_xlat16_10.xyz = u_xlat23.xyz;
                        u_xlati0 = -1;
                    //ENDIF
                    }
                    u_xlati0 = int(uint(u_xlatb24) * 0xffffffffu | uint(u_xlati0));
                } else {
                    u_xlat16_10.xyz = u_xlat23.xyz;
                    u_xlati0 = -1;
                //ENDIF
                }
                u_xlati0 = int(uint(u_xlatb8) * 0xffffffffu | uint(u_xlati0));
            } else {
                u_xlati0 = -1;
            //ENDIF
            }
            u_xlati0 = int(uint(u_xlatb7) * 0xffffffffu | uint(u_xlati0));
        } else {
            u_xlati0 = -1;
        //ENDIF
        }
        u_xlati0 = int(uint(u_xlatb54) * 0xffffffffu | uint(u_xlati0));
    } else {
        u_xlat16_10.xyz = u_xlat16_1.xyz;
        u_xlati0 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb53) * 0xffffffffu | uint(u_xlati0));
    u_xlat16_49 = dot(u_xlat16_2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_14.xyz = vec3(u_xlat16_49) * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_14.xyz * vec3(u_xlat48) + u_xlat16_9.xyz;
    u_xlat16_14.xyz = u_xlat6.xyz * vec3(u_xlat51) + u_xlat5.xyz;
    u_xlat16_49 = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_14.xyz = vec3(u_xlat16_49) * u_xlat16_14.xyz;
    u_xlat16_16 = dot(u_xlat16_2.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat51 = dot(u_xlat5.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat51 = min(max(u_xlat51, 0.0), 1.0);
#else
    u_xlat51 = clamp(u_xlat51, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * -0.00399392843 + 1.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = 0.996006072 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * 0.318309873;
    u_xlat51 = (-u_xlat51) + 1.0;
    u_xlat16_49 = u_xlat51 * u_xlat51;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_51 = u_xlat16_49 * 0.00766834244 + 0.0399999991;
    u_xlat16_5 = u_xlat16_16 * u_xlat16_51;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_51 + 2.0;
    u_xlat16_16 = u_xlat16_5 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_14.xyz = vec3(u_xlat16_16) * _LightColor0.xyz;
    u_xlat16_14.xyz = vec3(u_xlat48) * u_xlat16_14.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_1.xyz + u_xlat16_14.xyz;
    u_xlat16_9.xyz = (int(u_xlati0) != 0) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat16_9.xyz = (-u_xlat16_1.xyz) + u_xlat16_9.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat0.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD10.w);
    u_xlat16 = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat48 = (-u_xlat16) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat48 + u_xlat16;
    u_xlat16 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat5.xyz = vec3(u_xlat16) * vs_TEXCOORD8.xyz;
    u_xlat16 = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat16_17.x = (-u_xlat16) + 1.0;
    u_xlat16_17.x = max(u_xlat16_17.x, 9.99999975e-05);
    u_xlat16_17.x = log2(u_xlat16_17.x);
    u_xlat16_17.x = u_xlat16_17.x * 0.200000003;
    u_xlat16_17.x = exp2(u_xlat16_17.x);
    u_xlat16 = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat16 = u_xlat16 / _FarFadeLength;
    u_xlat16_33 = (-u_xlat16) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_49 = u_xlat16_32 + (-_CloudTexThreshold);
    u_xlat16_9.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_49 = u_xlat16_49 / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_1.x = u_xlat16_49 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_17.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_33 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * u_xlat3.xxx;
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    vs_TEXCOORD7.xyz = u_xlat4.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat2.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec4 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
bool u_xlatb11;
bool u_xlatb12;
bvec3 u_xlatb13;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_15;
mediump float u_xlat16_16;
int u_xlati16;
bool u_xlatb16;
mediump vec3 u_xlat16_17;
vec3 u_xlat23;
bool u_xlatb24;
bool u_xlatb27;
bool u_xlatb28;
float u_xlat32;
mediump float u_xlat16_32;
lowp float u_xlat10_32;
bool u_xlatb32;
mediump float u_xlat16_33;
bool u_xlatb40;
bool u_xlatb43;
bool u_xlatb44;
float u_xlat48;
lowp float u_xlat10_48;
int u_xlati48;
uint u_xlatu48;
bool u_xlatb48;
mediump float u_xlat16_49;
float u_xlat51;
mediump float u_xlat16_51;
bool u_xlatb53;
bool u_xlatb54;
bool u_xlatb56;
bool u_xlatb59;
bool u_xlatb60;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb32 = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb32){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat32 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat32) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_17.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_17.xy);
    u_xlat16_49 = abs(u_xlat32) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = (-u_xlat16_49) + 1.0;
    u_xlat16_17.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_17.xy;
    u_xlat10_32 = texture(_CloudTex, u_xlat16_17.xy).x;
    u_xlat16_32 = u_xlat10_32 * u_xlat16_49;
    u_xlat10_48 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_32 = u_xlat10_48 * u_xlat16_32;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_32 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_17.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_17.xyz + _CloudColorA.xyz;
    u_xlat48 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat48 = inversesqrt(u_xlat48);
    u_xlat3.xyz = vec3(u_xlat48) * vs_TEXCOORD6.xyz;
    u_xlat10_4.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat4.x = vs_TEXCOORD7.x;
    u_xlat4.y = vs_TEXCOORD9.x;
    u_xlat4.z = vs_TEXCOORD8.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.y;
    u_xlat5.y = vs_TEXCOORD9.y;
    u_xlat5.z = vs_TEXCOORD8.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.z;
    u_xlat5.y = vs_TEXCOORD9.z;
    u_xlat5.z = vs_TEXCOORD8.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat48 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_49 = (-u_xlat48) + 1.0;
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimThreshold;
    u_xlat16_49 = exp2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_49) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat8.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.w = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_49 = u_xlat2.y + u_xlat2.x;
    u_xlat16_9.x = u_xlat2.z + u_xlat16_49;
    u_xlat5.x = -0.0;
    u_xlat5.y = (-u_xlat2.x);
    u_xlat5.z = (-u_xlat16_49);
    u_xlat5.w = (-u_xlat16_9.x);
    u_xlat2 = u_xlat2 + u_xlat5;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_49 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat16_49>=0.5);
#else
    u_xlatb48 = u_xlat16_49>=0.5;
#endif
    if(u_xlatb48){
        u_xlat48 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat48 = min(u_xlat48, 3.0);
        u_xlatu48 = uint(u_xlat48);
        u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu48)].xyz);
        u_xlati48 = int(u_xlatu48) << 2;
        u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 1)].xyz;
        u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati48].xyz * u_xlat5.xxx + u_xlat6.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
        u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
        u_xlat10_48 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_51 = (-_LightShadowData.x) + 1.0;
        u_xlat48 = u_xlat10_48 * u_xlat16_51 + _LightShadowData.x;
    } else {
        u_xlat48 = 1.0;
    //ENDIF
    }
    u_xlat16_49 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_2.xyz = vec3(u_xlat16_49) * u_xlat4.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_49 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_49 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_49);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_49) + u_xlat16_10.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat51 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
    u_xlat5.xyz = vec3(u_xlat51) * u_xlat5.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat51 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
#ifdef UNITY_ADRENO_ES3
    u_xlatb53 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb53 = unity_DebugViewInfo.x==1.0;
#endif
    if(!u_xlatb53){
#ifdef UNITY_ADRENO_ES3
        u_xlatb54 = !!(unity_DebugViewInfo.x==2.0);
#else
        u_xlatb54 = unity_DebugViewInfo.x==2.0;
#endif
        u_xlat16_10.xyz = (bool(u_xlatb54)) ? vec3(0.0399999991, 0.0399999991, 0.0399999991) : u_xlat16_1.xyz;
        if(!u_xlatb54){
#ifdef UNITY_ADRENO_ES3
            u_xlatb7 = !!(unity_DebugViewInfo.x==3.0);
#else
            u_xlatb7 = unity_DebugViewInfo.x==3.0;
#endif
            u_xlat16_10.xyz = (bool(u_xlatb7)) ? vec3(0.000999987125, 0.000999987125, 0.000999987125) : u_xlat16_10.xyz;
            if(!u_xlatb7){
                u_xlat23.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                u_xlatb8 = !!(unity_DebugViewInfo.x==4.0);
#else
                u_xlatb8 = unity_DebugViewInfo.x==4.0;
#endif
                if(!u_xlatb8){
#ifdef UNITY_ADRENO_ES3
                    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
                    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
                    if(!u_xlatb24){
#ifdef UNITY_ADRENO_ES3
                        u_xlatb40 = !!(unity_DebugViewInfo.x==6.0);
#else
                        u_xlatb40 = unity_DebugViewInfo.x==6.0;
#endif
                        if(!u_xlatb40){
#ifdef UNITY_ADRENO_ES3
                            u_xlatb56 = !!(unity_DebugViewInfo.x==7.0);
#else
                            u_xlatb56 = unity_DebugViewInfo.x==7.0;
#endif
                            if(!u_xlatb56){
#ifdef UNITY_ADRENO_ES3
                                u_xlatb11 = !!(unity_DebugViewInfo.x==8.0);
#else
                                u_xlatb11 = unity_DebugViewInfo.x==8.0;
#endif
                                u_xlat16_10.xyz = (bool(u_xlatb11)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                if(!u_xlatb11){
#ifdef UNITY_ADRENO_ES3
                                    u_xlatb27 = !!(unity_DebugViewInfo.x==9.0);
#else
                                    u_xlatb27 = unity_DebugViewInfo.x==9.0;
#endif
                                    u_xlat16_10.xyz = (bool(u_xlatb27)) ? vec3(u_xlat48) : u_xlat16_10.xyz;
                                    if(!u_xlatb27){
#ifdef UNITY_ADRENO_ES3
                                        u_xlatb43 = !!(unity_DebugViewInfo.x==10.0);
#else
                                        u_xlatb43 = unity_DebugViewInfo.x==10.0;
#endif
                                        if(!u_xlatb43){
#ifdef UNITY_ADRENO_ES3
                                            u_xlatb59 = !!(unity_DebugViewInfo.x==11.0);
#else
                                            u_xlatb59 = unity_DebugViewInfo.x==11.0;
#endif
                                            u_xlat16_10.xyz = (bool(u_xlatb59)) ? vec3(1.0, 1.0, 1.0) : u_xlat16_10.xyz;
                                            if(!u_xlatb59){
#ifdef UNITY_ADRENO_ES3
                                                u_xlatb12 = !!(unity_DebugViewInfo.x==12.0);
#else
                                                u_xlatb12 = unity_DebugViewInfo.x==12.0;
#endif
                                                u_xlat16_10.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                if(!u_xlatb12){
#ifdef UNITY_ADRENO_ES3
                                                    u_xlatb28 = !!(unity_DebugViewInfo.x==13.0);
#else
                                                    u_xlatb28 = unity_DebugViewInfo.x==13.0;
#endif
                                                    u_xlat16_10.xyz = (bool(u_xlatb28)) ? vec3(0.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                    if(!u_xlatb28){
#ifdef UNITY_ADRENO_ES3
                                                        u_xlatb44 = !!(unity_DebugViewInfo.x==51.0);
#else
                                                        u_xlatb44 = unity_DebugViewInfo.x==51.0;
#endif
                                                        u_xlat16_10.xyz = (bool(u_xlatb44)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                                        if(!u_xlatb44){
                                                            if(!u_xlatb0.x){
                                                                u_xlatb13.xyz = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 151.0, 0.0)).xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_10.xyz;
                                                                u_xlatb60 = u_xlatb0.y || u_xlatb13.y;
                                                                u_xlat16_15.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.z || u_xlatb60;
                                                                u_xlat16_14.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.y) ? u_xlat16_15.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.y || u_xlatb13.z;
                                                                u_xlat16_14.xyz = (u_xlatb0.y) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb16 = u_xlatb0.y || u_xlatb60;
                                                                u_xlat16_10.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_14.xyz;
                                                                u_xlati16 = int(uint(u_xlatb13.x) * 0xffffffffu | uint(u_xlatb16) * 0xffffffffu);
                                                            } else {
                                                                u_xlat16_10.x = float(0.200000003);
                                                                u_xlat16_10.y = float(0.200000003);
                                                                u_xlat16_10.z = float(0.200000003);
                                                                u_xlati16 = -1;
                                                            //ENDIF
                                                            }
                                                            u_xlati0 = int(uint(u_xlatb0.x) * 0xffffffffu | uint(u_xlati16));
                                                        } else {
                                                            u_xlati0 = -1;
                                                        //ENDIF
                                                        }
                                                        u_xlati0 = int(uint(u_xlatb44) * 0xffffffffu | uint(u_xlati0));
                                                    } else {
                                                        u_xlati0 = -1;
                                                    //ENDIF
                                                    }
                                                    u_xlati0 = int(uint(u_xlatb28) * 0xffffffffu | uint(u_xlati0));
                                                } else {
                                                    u_xlati0 = -1;
                                                //ENDIF
                                                }
                                                u_xlati0 = int(uint(u_xlatb12) * 0xffffffffu | uint(u_xlati0));
                                            } else {
                                                u_xlati0 = -1;
                                            //ENDIF
                                            }
                                            u_xlati0 = int(uint(u_xlatb59) * 0xffffffffu | uint(u_xlati0));
                                        } else {
                                            u_xlat16_10.x = float(1.0);
                                            u_xlat16_10.y = float(1.0);
                                            u_xlat16_10.z = float(1.0);
                                            u_xlati0 = -1;
                                        //ENDIF
                                        }
                                        u_xlati0 = int(uint(u_xlatb43) * 0xffffffffu | uint(u_xlati0));
                                    } else {
                                        u_xlati0 = -1;
                                    //ENDIF
                                    }
                                    u_xlati0 = int(uint(u_xlatb27) * 0xffffffffu | uint(u_xlati0));
                                } else {
                                    u_xlati0 = -1;
                                //ENDIF
                                }
                                u_xlati0 = int(uint(u_xlatb11) * 0xffffffffu | uint(u_xlati0));
                            } else {
                                u_xlat16_10.xyz = u_xlat23.xyz;
                                u_xlati0 = -1;
                            //ENDIF
                            }
                            u_xlati0 = int(uint(u_xlatb56) * 0xffffffffu | uint(u_xlati0));
                        } else {
                            u_xlat16_10.xyz = u_xlat23.xyz;
                            u_xlati0 = -1;
                        //ENDIF
                        }
                        u_xlati0 = int(uint(u_xlatb40) * 0xffffffffu | uint(u_xlati0));
                    } else {
                        u_xlat16_10.xyz = u_xlat23.xyz;
                        u_xlati0 = -1;
                    //ENDIF
                    }
                    u_xlati0 = int(uint(u_xlatb24) * 0xffffffffu | uint(u_xlati0));
                } else {
                    u_xlat16_10.xyz = u_xlat23.xyz;
                    u_xlati0 = -1;
                //ENDIF
                }
                u_xlati0 = int(uint(u_xlatb8) * 0xffffffffu | uint(u_xlati0));
            } else {
                u_xlati0 = -1;
            //ENDIF
            }
            u_xlati0 = int(uint(u_xlatb7) * 0xffffffffu | uint(u_xlati0));
        } else {
            u_xlati0 = -1;
        //ENDIF
        }
        u_xlati0 = int(uint(u_xlatb54) * 0xffffffffu | uint(u_xlati0));
    } else {
        u_xlat16_10.xyz = u_xlat16_1.xyz;
        u_xlati0 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb53) * 0xffffffffu | uint(u_xlati0));
    u_xlat16_49 = dot(u_xlat16_2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_14.xyz = vec3(u_xlat16_49) * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_14.xyz * vec3(u_xlat48) + u_xlat16_9.xyz;
    u_xlat16_14.xyz = u_xlat6.xyz * vec3(u_xlat51) + u_xlat5.xyz;
    u_xlat16_49 = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_14.xyz = vec3(u_xlat16_49) * u_xlat16_14.xyz;
    u_xlat16_16 = dot(u_xlat16_2.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat51 = dot(u_xlat5.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat51 = min(max(u_xlat51, 0.0), 1.0);
#else
    u_xlat51 = clamp(u_xlat51, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * -0.00399392843 + 1.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = 0.996006072 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * 0.318309873;
    u_xlat51 = (-u_xlat51) + 1.0;
    u_xlat16_49 = u_xlat51 * u_xlat51;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_51 = u_xlat16_49 * 0.00766834244 + 0.0399999991;
    u_xlat16_5 = u_xlat16_16 * u_xlat16_51;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_51 + 2.0;
    u_xlat16_16 = u_xlat16_5 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_14.xyz = vec3(u_xlat16_16) * _LightColor0.xyz;
    u_xlat16_14.xyz = vec3(u_xlat48) * u_xlat16_14.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_1.xyz + u_xlat16_14.xyz;
    u_xlat16_9.xyz = (int(u_xlati0) != 0) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat16_9.xyz = (-u_xlat16_1.xyz) + u_xlat16_9.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat0.x = dot(u_xlat0.xyw, u_xlat3.xyz);
    u_xlat16_17.x = (-u_xlat0.x) + 1.0;
    u_xlat16_17.x = max(u_xlat16_17.x, 9.99999975e-05);
    u_xlat16_17.x = log2(u_xlat16_17.x);
    u_xlat16_17.x = u_xlat16_17.x * 0.200000003;
    u_xlat16_17.x = exp2(u_xlat16_17.x);
    u_xlat0.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x / _FarFadeLength;
    u_xlat16_33 = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_49 = u_xlat16_32 + (-_CloudTexThreshold);
    u_xlat16_9.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_49 = u_xlat16_49 / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_1.x = u_xlat16_49 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_17.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_33 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * u_xlat3.xxx;
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    vs_TEXCOORD7.xyz = u_xlat4.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat2.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec4 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
bool u_xlatb11;
bool u_xlatb12;
bvec3 u_xlatb13;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
bool u_xlatb16;
mediump vec3 u_xlat16_17;
vec3 u_xlat23;
bool u_xlatb24;
bool u_xlatb27;
bool u_xlatb28;
float u_xlat32;
mediump float u_xlat16_32;
lowp float u_xlat10_32;
bool u_xlatb32;
mediump float u_xlat16_33;
bool u_xlatb40;
bool u_xlatb43;
bool u_xlatb44;
float u_xlat48;
lowp float u_xlat10_48;
int u_xlati48;
uint u_xlatu48;
bool u_xlatb48;
mediump float u_xlat16_49;
float u_xlat51;
mediump float u_xlat16_51;
bool u_xlatb53;
bool u_xlatb54;
bool u_xlatb56;
bool u_xlatb59;
bool u_xlatb60;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb32 = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb32){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat32 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat32) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_17.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_17.xy);
    u_xlat16_49 = abs(u_xlat32) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = (-u_xlat16_49) + 1.0;
    u_xlat16_17.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_17.xy;
    u_xlat10_32 = texture(_CloudTex, u_xlat16_17.xy).x;
    u_xlat16_32 = u_xlat10_32 * u_xlat16_49;
    u_xlat10_48 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_32 = u_xlat10_48 * u_xlat16_32;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_32 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_17.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_17.xyz + _CloudColorA.xyz;
    u_xlat48 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat48 = inversesqrt(u_xlat48);
    u_xlat3.xyz = vec3(u_xlat48) * vs_TEXCOORD6.xyz;
    u_xlat10_4.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat4.x = vs_TEXCOORD7.x;
    u_xlat4.y = vs_TEXCOORD9.x;
    u_xlat4.z = vs_TEXCOORD8.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.y;
    u_xlat5.y = vs_TEXCOORD9.y;
    u_xlat5.z = vs_TEXCOORD8.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.z;
    u_xlat5.y = vs_TEXCOORD9.z;
    u_xlat5.z = vs_TEXCOORD8.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat48 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_49 = (-u_xlat48) + 1.0;
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimThreshold;
    u_xlat16_49 = exp2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_49) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat8.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.w = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_49 = u_xlat2.y + u_xlat2.x;
    u_xlat16_9.x = u_xlat2.z + u_xlat16_49;
    u_xlat5.x = -0.0;
    u_xlat5.y = (-u_xlat2.x);
    u_xlat5.z = (-u_xlat16_49);
    u_xlat5.w = (-u_xlat16_9.x);
    u_xlat2 = u_xlat2 + u_xlat5;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_49 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat16_49>=0.5);
#else
    u_xlatb48 = u_xlat16_49>=0.5;
#endif
    if(u_xlatb48){
        u_xlat48 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat48 = min(u_xlat48, 3.0);
        u_xlatu48 = uint(u_xlat48);
        u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu48)].xyz);
        u_xlati48 = int(u_xlatu48) << 2;
        u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 1)].xyz;
        u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati48].xyz * u_xlat5.xxx + u_xlat6.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
        u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
        u_xlat10_48 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_51 = (-_LightShadowData.x) + 1.0;
        u_xlat48 = u_xlat10_48 * u_xlat16_51 + _LightShadowData.x;
    } else {
        u_xlat48 = 1.0;
    //ENDIF
    }
    u_xlat16_49 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_2.xyz = vec3(u_xlat16_49) * u_xlat4.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_49 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_49 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_49);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_49) + u_xlat16_10.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat51 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
    u_xlat5.xyz = vec3(u_xlat51) * u_xlat5.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat51 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
#ifdef UNITY_ADRENO_ES3
    u_xlatb53 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb53 = unity_DebugViewInfo.x==1.0;
#endif
    if(!u_xlatb53){
#ifdef UNITY_ADRENO_ES3
        u_xlatb54 = !!(unity_DebugViewInfo.x==2.0);
#else
        u_xlatb54 = unity_DebugViewInfo.x==2.0;
#endif
        u_xlat16_10.xyz = (bool(u_xlatb54)) ? vec3(0.0399999991, 0.0399999991, 0.0399999991) : u_xlat16_1.xyz;
        if(!u_xlatb54){
#ifdef UNITY_ADRENO_ES3
            u_xlatb7 = !!(unity_DebugViewInfo.x==3.0);
#else
            u_xlatb7 = unity_DebugViewInfo.x==3.0;
#endif
            u_xlat16_10.xyz = (bool(u_xlatb7)) ? vec3(0.000999987125, 0.000999987125, 0.000999987125) : u_xlat16_10.xyz;
            if(!u_xlatb7){
                u_xlat23.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                u_xlatb8 = !!(unity_DebugViewInfo.x==4.0);
#else
                u_xlatb8 = unity_DebugViewInfo.x==4.0;
#endif
                if(!u_xlatb8){
#ifdef UNITY_ADRENO_ES3
                    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
                    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
                    if(!u_xlatb24){
#ifdef UNITY_ADRENO_ES3
                        u_xlatb40 = !!(unity_DebugViewInfo.x==6.0);
#else
                        u_xlatb40 = unity_DebugViewInfo.x==6.0;
#endif
                        if(!u_xlatb40){
#ifdef UNITY_ADRENO_ES3
                            u_xlatb56 = !!(unity_DebugViewInfo.x==7.0);
#else
                            u_xlatb56 = unity_DebugViewInfo.x==7.0;
#endif
                            if(!u_xlatb56){
#ifdef UNITY_ADRENO_ES3
                                u_xlatb11 = !!(unity_DebugViewInfo.x==8.0);
#else
                                u_xlatb11 = unity_DebugViewInfo.x==8.0;
#endif
                                u_xlat16_10.xyz = (bool(u_xlatb11)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                if(!u_xlatb11){
#ifdef UNITY_ADRENO_ES3
                                    u_xlatb27 = !!(unity_DebugViewInfo.x==9.0);
#else
                                    u_xlatb27 = unity_DebugViewInfo.x==9.0;
#endif
                                    u_xlat16_10.xyz = (bool(u_xlatb27)) ? vec3(u_xlat48) : u_xlat16_10.xyz;
                                    if(!u_xlatb27){
#ifdef UNITY_ADRENO_ES3
                                        u_xlatb43 = !!(unity_DebugViewInfo.x==10.0);
#else
                                        u_xlatb43 = unity_DebugViewInfo.x==10.0;
#endif
                                        if(!u_xlatb43){
#ifdef UNITY_ADRENO_ES3
                                            u_xlatb59 = !!(unity_DebugViewInfo.x==11.0);
#else
                                            u_xlatb59 = unity_DebugViewInfo.x==11.0;
#endif
                                            u_xlat16_10.xyz = (bool(u_xlatb59)) ? vec3(1.0, 1.0, 1.0) : u_xlat16_10.xyz;
                                            if(!u_xlatb59){
#ifdef UNITY_ADRENO_ES3
                                                u_xlatb12 = !!(unity_DebugViewInfo.x==12.0);
#else
                                                u_xlatb12 = unity_DebugViewInfo.x==12.0;
#endif
                                                u_xlat16_10.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                if(!u_xlatb12){
#ifdef UNITY_ADRENO_ES3
                                                    u_xlatb28 = !!(unity_DebugViewInfo.x==13.0);
#else
                                                    u_xlatb28 = unity_DebugViewInfo.x==13.0;
#endif
                                                    u_xlat16_10.xyz = (bool(u_xlatb28)) ? vec3(0.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                    if(!u_xlatb28){
#ifdef UNITY_ADRENO_ES3
                                                        u_xlatb44 = !!(unity_DebugViewInfo.x==51.0);
#else
                                                        u_xlatb44 = unity_DebugViewInfo.x==51.0;
#endif
                                                        u_xlat16_10.xyz = (bool(u_xlatb44)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                                        if(!u_xlatb44){
                                                            if(!u_xlatb0.x){
                                                                u_xlatb13.xyz = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 151.0, 0.0)).xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_10.xyz;
                                                                u_xlatb60 = u_xlatb0.y || u_xlatb13.y;
                                                                u_xlat16_15.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.z || u_xlatb60;
                                                                u_xlat16_14.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.y) ? u_xlat16_15.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.y || u_xlatb13.z;
                                                                u_xlat16_14.xyz = (u_xlatb0.y) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb16 = u_xlatb0.y || u_xlatb60;
                                                                u_xlat16_10.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_14.xyz;
                                                                u_xlati16 = int(uint(u_xlatb13.x) * 0xffffffffu | uint(u_xlatb16) * 0xffffffffu);
                                                            } else {
                                                                u_xlat16_10.x = float(0.200000003);
                                                                u_xlat16_10.y = float(0.200000003);
                                                                u_xlat16_10.z = float(0.200000003);
                                                                u_xlati16 = -1;
                                                            //ENDIF
                                                            }
                                                            u_xlati0 = int(uint(u_xlatb0.x) * 0xffffffffu | uint(u_xlati16));
                                                        } else {
                                                            u_xlati0 = -1;
                                                        //ENDIF
                                                        }
                                                        u_xlati0 = int(uint(u_xlatb44) * 0xffffffffu | uint(u_xlati0));
                                                    } else {
                                                        u_xlati0 = -1;
                                                    //ENDIF
                                                    }
                                                    u_xlati0 = int(uint(u_xlatb28) * 0xffffffffu | uint(u_xlati0));
                                                } else {
                                                    u_xlati0 = -1;
                                                //ENDIF
                                                }
                                                u_xlati0 = int(uint(u_xlatb12) * 0xffffffffu | uint(u_xlati0));
                                            } else {
                                                u_xlati0 = -1;
                                            //ENDIF
                                            }
                                            u_xlati0 = int(uint(u_xlatb59) * 0xffffffffu | uint(u_xlati0));
                                        } else {
                                            u_xlat16_10.x = float(1.0);
                                            u_xlat16_10.y = float(1.0);
                                            u_xlat16_10.z = float(1.0);
                                            u_xlati0 = -1;
                                        //ENDIF
                                        }
                                        u_xlati0 = int(uint(u_xlatb43) * 0xffffffffu | uint(u_xlati0));
                                    } else {
                                        u_xlati0 = -1;
                                    //ENDIF
                                    }
                                    u_xlati0 = int(uint(u_xlatb27) * 0xffffffffu | uint(u_xlati0));
                                } else {
                                    u_xlati0 = -1;
                                //ENDIF
                                }
                                u_xlati0 = int(uint(u_xlatb11) * 0xffffffffu | uint(u_xlati0));
                            } else {
                                u_xlat16_10.xyz = u_xlat23.xyz;
                                u_xlati0 = -1;
                            //ENDIF
                            }
                            u_xlati0 = int(uint(u_xlatb56) * 0xffffffffu | uint(u_xlati0));
                        } else {
                            u_xlat16_10.xyz = u_xlat23.xyz;
                            u_xlati0 = -1;
                        //ENDIF
                        }
                        u_xlati0 = int(uint(u_xlatb40) * 0xffffffffu | uint(u_xlati0));
                    } else {
                        u_xlat16_10.xyz = u_xlat23.xyz;
                        u_xlati0 = -1;
                    //ENDIF
                    }
                    u_xlati0 = int(uint(u_xlatb24) * 0xffffffffu | uint(u_xlati0));
                } else {
                    u_xlat16_10.xyz = u_xlat23.xyz;
                    u_xlati0 = -1;
                //ENDIF
                }
                u_xlati0 = int(uint(u_xlatb8) * 0xffffffffu | uint(u_xlati0));
            } else {
                u_xlati0 = -1;
            //ENDIF
            }
            u_xlati0 = int(uint(u_xlatb7) * 0xffffffffu | uint(u_xlati0));
        } else {
            u_xlati0 = -1;
        //ENDIF
        }
        u_xlati0 = int(uint(u_xlatb54) * 0xffffffffu | uint(u_xlati0));
    } else {
        u_xlat16_10.xyz = u_xlat16_1.xyz;
        u_xlati0 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb53) * 0xffffffffu | uint(u_xlati0));
    u_xlat16_49 = dot(u_xlat16_2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_14.xyz = vec3(u_xlat16_49) * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_14.xyz * vec3(u_xlat48) + u_xlat16_9.xyz;
    u_xlat16_14.xyz = u_xlat6.xyz * vec3(u_xlat51) + u_xlat5.xyz;
    u_xlat16_49 = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_14.xyz = vec3(u_xlat16_49) * u_xlat16_14.xyz;
    u_xlat16_16 = dot(u_xlat16_2.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat51 = dot(u_xlat5.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat51 = min(max(u_xlat51, 0.0), 1.0);
#else
    u_xlat51 = clamp(u_xlat51, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * -0.00399392843 + 1.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = 0.996006072 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * 0.318309873;
    u_xlat51 = (-u_xlat51) + 1.0;
    u_xlat16_49 = u_xlat51 * u_xlat51;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_51 = u_xlat16_49 * 0.00766834244 + 0.0399999991;
    u_xlat16_5 = u_xlat16_16 * u_xlat16_51;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_51 + 2.0;
    u_xlat16_16 = u_xlat16_5 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_14.xyz = vec3(u_xlat16_16) * _LightColor0.xyz;
    u_xlat16_14.xyz = vec3(u_xlat48) * u_xlat16_14.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_1.xyz + u_xlat16_14.xyz;
    u_xlat16_9.xyz = (int(u_xlati0) != 0) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat16_9.xyz = (-u_xlat16_1.xyz) + u_xlat16_9.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat0.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD10.w);
    u_xlat16 = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat48 = (-u_xlat16) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat48 + u_xlat16;
    u_xlat16 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat5.xyz = vec3(u_xlat16) * vs_TEXCOORD8.xyz;
    u_xlat16 = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat16_17.x = (-u_xlat16) + 1.0;
    u_xlat16_17.x = max(u_xlat16_17.x, 9.99999975e-05);
    u_xlat16_17.x = log2(u_xlat16_17.x);
    u_xlat16_17.x = u_xlat16_17.x * 0.200000003;
    u_xlat16_17.x = exp2(u_xlat16_17.x);
    u_xlat16 = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat16 = u_xlat16 / _FarFadeLength;
    u_xlat16_33 = (-u_xlat16) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_49 = u_xlat16_32 + (-_CloudTexThreshold);
    u_xlat16_9.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_49 = u_xlat16_49 / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_1.x = u_xlat16_49 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_17.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_33 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec4 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
bool u_xlatb11;
bool u_xlatb12;
bvec3 u_xlatb13;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_15;
mediump float u_xlat16_16;
int u_xlati16;
bool u_xlatb16;
mediump vec3 u_xlat16_17;
vec3 u_xlat23;
bool u_xlatb24;
bool u_xlatb27;
bool u_xlatb28;
float u_xlat32;
mediump float u_xlat16_32;
lowp float u_xlat10_32;
bool u_xlatb32;
mediump float u_xlat16_33;
bool u_xlatb40;
bool u_xlatb43;
bool u_xlatb44;
float u_xlat48;
lowp float u_xlat10_48;
int u_xlati48;
uint u_xlatu48;
bool u_xlatb48;
mediump float u_xlat16_49;
float u_xlat51;
mediump float u_xlat16_51;
bool u_xlatb53;
bool u_xlatb54;
bool u_xlatb56;
bool u_xlatb59;
bool u_xlatb60;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb32 = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb32){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat32 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat32) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_17.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_17.xy);
    u_xlat16_49 = abs(u_xlat32) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = (-u_xlat16_49) + 1.0;
    u_xlat16_17.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_17.xy;
    u_xlat10_32 = texture(_CloudTex, u_xlat16_17.xy).x;
    u_xlat16_32 = u_xlat10_32 * u_xlat16_49;
    u_xlat10_48 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_32 = u_xlat10_48 * u_xlat16_32;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_32 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_17.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_17.xyz + _CloudColorA.xyz;
    u_xlat48 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat48 = inversesqrt(u_xlat48);
    u_xlat3.xyz = vec3(u_xlat48) * vs_TEXCOORD6.xyz;
    u_xlat10_4.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat4.x = vs_TEXCOORD7.x;
    u_xlat4.y = vs_TEXCOORD9.x;
    u_xlat4.z = vs_TEXCOORD8.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.y;
    u_xlat5.y = vs_TEXCOORD9.y;
    u_xlat5.z = vs_TEXCOORD8.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.z;
    u_xlat5.y = vs_TEXCOORD9.z;
    u_xlat5.z = vs_TEXCOORD8.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat48 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_49 = (-u_xlat48) + 1.0;
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimThreshold;
    u_xlat16_49 = exp2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_49) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat8.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.w = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_49 = u_xlat2.y + u_xlat2.x;
    u_xlat16_9.x = u_xlat2.z + u_xlat16_49;
    u_xlat5.x = -0.0;
    u_xlat5.y = (-u_xlat2.x);
    u_xlat5.z = (-u_xlat16_49);
    u_xlat5.w = (-u_xlat16_9.x);
    u_xlat2 = u_xlat2 + u_xlat5;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_49 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat16_49>=0.5);
#else
    u_xlatb48 = u_xlat16_49>=0.5;
#endif
    if(u_xlatb48){
        u_xlat48 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat48 = min(u_xlat48, 3.0);
        u_xlatu48 = uint(u_xlat48);
        u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu48)].xyz);
        u_xlati48 = int(u_xlatu48) << 2;
        u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 1)].xyz;
        u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati48].xyz * u_xlat5.xxx + u_xlat6.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
        u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
        u_xlat10_48 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_51 = (-_LightShadowData.x) + 1.0;
        u_xlat48 = u_xlat10_48 * u_xlat16_51 + _LightShadowData.x;
    } else {
        u_xlat48 = 1.0;
    //ENDIF
    }
    u_xlat16_49 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_2.xyz = vec3(u_xlat16_49) * u_xlat4.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_49 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_49 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_49);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_49) + u_xlat16_10.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat51 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
    u_xlat5.xyz = vec3(u_xlat51) * u_xlat5.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat51 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
#ifdef UNITY_ADRENO_ES3
    u_xlatb53 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb53 = unity_DebugViewInfo.x==1.0;
#endif
    if(!u_xlatb53){
#ifdef UNITY_ADRENO_ES3
        u_xlatb54 = !!(unity_DebugViewInfo.x==2.0);
#else
        u_xlatb54 = unity_DebugViewInfo.x==2.0;
#endif
        u_xlat16_10.xyz = (bool(u_xlatb54)) ? vec3(0.0399999991, 0.0399999991, 0.0399999991) : u_xlat16_1.xyz;
        if(!u_xlatb54){
#ifdef UNITY_ADRENO_ES3
            u_xlatb7 = !!(unity_DebugViewInfo.x==3.0);
#else
            u_xlatb7 = unity_DebugViewInfo.x==3.0;
#endif
            u_xlat16_10.xyz = (bool(u_xlatb7)) ? vec3(0.000999987125, 0.000999987125, 0.000999987125) : u_xlat16_10.xyz;
            if(!u_xlatb7){
                u_xlat23.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                u_xlatb8 = !!(unity_DebugViewInfo.x==4.0);
#else
                u_xlatb8 = unity_DebugViewInfo.x==4.0;
#endif
                if(!u_xlatb8){
#ifdef UNITY_ADRENO_ES3
                    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
                    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
                    if(!u_xlatb24){
#ifdef UNITY_ADRENO_ES3
                        u_xlatb40 = !!(unity_DebugViewInfo.x==6.0);
#else
                        u_xlatb40 = unity_DebugViewInfo.x==6.0;
#endif
                        if(!u_xlatb40){
#ifdef UNITY_ADRENO_ES3
                            u_xlatb56 = !!(unity_DebugViewInfo.x==7.0);
#else
                            u_xlatb56 = unity_DebugViewInfo.x==7.0;
#endif
                            if(!u_xlatb56){
#ifdef UNITY_ADRENO_ES3
                                u_xlatb11 = !!(unity_DebugViewInfo.x==8.0);
#else
                                u_xlatb11 = unity_DebugViewInfo.x==8.0;
#endif
                                u_xlat16_10.xyz = (bool(u_xlatb11)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                if(!u_xlatb11){
#ifdef UNITY_ADRENO_ES3
                                    u_xlatb27 = !!(unity_DebugViewInfo.x==9.0);
#else
                                    u_xlatb27 = unity_DebugViewInfo.x==9.0;
#endif
                                    u_xlat16_10.xyz = (bool(u_xlatb27)) ? vec3(u_xlat48) : u_xlat16_10.xyz;
                                    if(!u_xlatb27){
#ifdef UNITY_ADRENO_ES3
                                        u_xlatb43 = !!(unity_DebugViewInfo.x==10.0);
#else
                                        u_xlatb43 = unity_DebugViewInfo.x==10.0;
#endif
                                        if(!u_xlatb43){
#ifdef UNITY_ADRENO_ES3
                                            u_xlatb59 = !!(unity_DebugViewInfo.x==11.0);
#else
                                            u_xlatb59 = unity_DebugViewInfo.x==11.0;
#endif
                                            u_xlat16_10.xyz = (bool(u_xlatb59)) ? vec3(1.0, 1.0, 1.0) : u_xlat16_10.xyz;
                                            if(!u_xlatb59){
#ifdef UNITY_ADRENO_ES3
                                                u_xlatb12 = !!(unity_DebugViewInfo.x==12.0);
#else
                                                u_xlatb12 = unity_DebugViewInfo.x==12.0;
#endif
                                                u_xlat16_10.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                if(!u_xlatb12){
#ifdef UNITY_ADRENO_ES3
                                                    u_xlatb28 = !!(unity_DebugViewInfo.x==13.0);
#else
                                                    u_xlatb28 = unity_DebugViewInfo.x==13.0;
#endif
                                                    u_xlat16_10.xyz = (bool(u_xlatb28)) ? vec3(0.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                    if(!u_xlatb28){
#ifdef UNITY_ADRENO_ES3
                                                        u_xlatb44 = !!(unity_DebugViewInfo.x==51.0);
#else
                                                        u_xlatb44 = unity_DebugViewInfo.x==51.0;
#endif
                                                        u_xlat16_10.xyz = (bool(u_xlatb44)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                                        if(!u_xlatb44){
                                                            if(!u_xlatb0.x){
                                                                u_xlatb13.xyz = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 151.0, 0.0)).xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_10.xyz;
                                                                u_xlatb60 = u_xlatb0.y || u_xlatb13.y;
                                                                u_xlat16_15.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.z || u_xlatb60;
                                                                u_xlat16_14.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.y) ? u_xlat16_15.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.y || u_xlatb13.z;
                                                                u_xlat16_14.xyz = (u_xlatb0.y) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb16 = u_xlatb0.y || u_xlatb60;
                                                                u_xlat16_10.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_14.xyz;
                                                                u_xlati16 = int(uint(u_xlatb13.x) * 0xffffffffu | uint(u_xlatb16) * 0xffffffffu);
                                                            } else {
                                                                u_xlat16_10.x = float(0.200000003);
                                                                u_xlat16_10.y = float(0.200000003);
                                                                u_xlat16_10.z = float(0.200000003);
                                                                u_xlati16 = -1;
                                                            //ENDIF
                                                            }
                                                            u_xlati0 = int(uint(u_xlatb0.x) * 0xffffffffu | uint(u_xlati16));
                                                        } else {
                                                            u_xlati0 = -1;
                                                        //ENDIF
                                                        }
                                                        u_xlati0 = int(uint(u_xlatb44) * 0xffffffffu | uint(u_xlati0));
                                                    } else {
                                                        u_xlati0 = -1;
                                                    //ENDIF
                                                    }
                                                    u_xlati0 = int(uint(u_xlatb28) * 0xffffffffu | uint(u_xlati0));
                                                } else {
                                                    u_xlati0 = -1;
                                                //ENDIF
                                                }
                                                u_xlati0 = int(uint(u_xlatb12) * 0xffffffffu | uint(u_xlati0));
                                            } else {
                                                u_xlati0 = -1;
                                            //ENDIF
                                            }
                                            u_xlati0 = int(uint(u_xlatb59) * 0xffffffffu | uint(u_xlati0));
                                        } else {
                                            u_xlat16_10.x = float(1.0);
                                            u_xlat16_10.y = float(1.0);
                                            u_xlat16_10.z = float(1.0);
                                            u_xlati0 = -1;
                                        //ENDIF
                                        }
                                        u_xlati0 = int(uint(u_xlatb43) * 0xffffffffu | uint(u_xlati0));
                                    } else {
                                        u_xlati0 = -1;
                                    //ENDIF
                                    }
                                    u_xlati0 = int(uint(u_xlatb27) * 0xffffffffu | uint(u_xlati0));
                                } else {
                                    u_xlati0 = -1;
                                //ENDIF
                                }
                                u_xlati0 = int(uint(u_xlatb11) * 0xffffffffu | uint(u_xlati0));
                            } else {
                                u_xlat16_10.xyz = u_xlat23.xyz;
                                u_xlati0 = -1;
                            //ENDIF
                            }
                            u_xlati0 = int(uint(u_xlatb56) * 0xffffffffu | uint(u_xlati0));
                        } else {
                            u_xlat16_10.xyz = u_xlat23.xyz;
                            u_xlati0 = -1;
                        //ENDIF
                        }
                        u_xlati0 = int(uint(u_xlatb40) * 0xffffffffu | uint(u_xlati0));
                    } else {
                        u_xlat16_10.xyz = u_xlat23.xyz;
                        u_xlati0 = -1;
                    //ENDIF
                    }
                    u_xlati0 = int(uint(u_xlatb24) * 0xffffffffu | uint(u_xlati0));
                } else {
                    u_xlat16_10.xyz = u_xlat23.xyz;
                    u_xlati0 = -1;
                //ENDIF
                }
                u_xlati0 = int(uint(u_xlatb8) * 0xffffffffu | uint(u_xlati0));
            } else {
                u_xlati0 = -1;
            //ENDIF
            }
            u_xlati0 = int(uint(u_xlatb7) * 0xffffffffu | uint(u_xlati0));
        } else {
            u_xlati0 = -1;
        //ENDIF
        }
        u_xlati0 = int(uint(u_xlatb54) * 0xffffffffu | uint(u_xlati0));
    } else {
        u_xlat16_10.xyz = u_xlat16_1.xyz;
        u_xlati0 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb53) * 0xffffffffu | uint(u_xlati0));
    u_xlat16_49 = dot(u_xlat16_2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_14.xyz = vec3(u_xlat16_49) * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_14.xyz * vec3(u_xlat48) + u_xlat16_9.xyz;
    u_xlat16_14.xyz = u_xlat6.xyz * vec3(u_xlat51) + u_xlat5.xyz;
    u_xlat16_49 = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_14.xyz = vec3(u_xlat16_49) * u_xlat16_14.xyz;
    u_xlat16_16 = dot(u_xlat16_2.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat51 = dot(u_xlat5.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat51 = min(max(u_xlat51, 0.0), 1.0);
#else
    u_xlat51 = clamp(u_xlat51, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * -0.00399392843 + 1.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = 0.996006072 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * 0.318309873;
    u_xlat51 = (-u_xlat51) + 1.0;
    u_xlat16_49 = u_xlat51 * u_xlat51;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_51 = u_xlat16_49 * 0.00766834244 + 0.0399999991;
    u_xlat16_5 = u_xlat16_16 * u_xlat16_51;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_51 + 2.0;
    u_xlat16_16 = u_xlat16_5 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_14.xyz = vec3(u_xlat16_16) * _LightColor0.xyz;
    u_xlat16_14.xyz = vec3(u_xlat48) * u_xlat16_14.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_1.xyz + u_xlat16_14.xyz;
    u_xlat16_9.xyz = (int(u_xlati0) != 0) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat16_9.xyz = (-u_xlat16_1.xyz) + u_xlat16_9.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat0.x = dot(u_xlat0.xyw, u_xlat3.xyz);
    u_xlat16_17.x = (-u_xlat0.x) + 1.0;
    u_xlat16_17.x = max(u_xlat16_17.x, 9.99999975e-05);
    u_xlat16_17.x = log2(u_xlat16_17.x);
    u_xlat16_17.x = u_xlat16_17.x * 0.200000003;
    u_xlat16_17.x = exp2(u_xlat16_17.x);
    u_xlat0.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x / _FarFadeLength;
    u_xlat16_33 = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_49 = u_xlat16_32 + (-_CloudTexThreshold);
    u_xlat16_9.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_49 = u_xlat16_49 / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_1.x = u_xlat16_49 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_17.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_33 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec4 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
bool u_xlatb11;
bool u_xlatb12;
bvec3 u_xlatb13;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
bool u_xlatb16;
mediump vec3 u_xlat16_17;
vec3 u_xlat23;
bool u_xlatb24;
bool u_xlatb27;
bool u_xlatb28;
float u_xlat32;
mediump float u_xlat16_32;
lowp float u_xlat10_32;
bool u_xlatb32;
mediump float u_xlat16_33;
bool u_xlatb40;
bool u_xlatb43;
bool u_xlatb44;
float u_xlat48;
lowp float u_xlat10_48;
int u_xlati48;
uint u_xlatu48;
bool u_xlatb48;
mediump float u_xlat16_49;
float u_xlat51;
mediump float u_xlat16_51;
bool u_xlatb53;
bool u_xlatb54;
bool u_xlatb56;
bool u_xlatb59;
bool u_xlatb60;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb32 = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb32){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat32 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat32) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_17.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_17.xy);
    u_xlat16_49 = abs(u_xlat32) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = (-u_xlat16_49) + 1.0;
    u_xlat16_17.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_17.xy;
    u_xlat10_32 = texture(_CloudTex, u_xlat16_17.xy).x;
    u_xlat16_32 = u_xlat10_32 * u_xlat16_49;
    u_xlat10_48 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_32 = u_xlat10_48 * u_xlat16_32;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_32 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_17.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_17.xyz + _CloudColorA.xyz;
    u_xlat48 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat48 = inversesqrt(u_xlat48);
    u_xlat3.xyz = vec3(u_xlat48) * vs_TEXCOORD6.xyz;
    u_xlat10_4.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat4.x = vs_TEXCOORD7.x;
    u_xlat4.y = vs_TEXCOORD9.x;
    u_xlat4.z = vs_TEXCOORD8.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.y;
    u_xlat5.y = vs_TEXCOORD9.y;
    u_xlat5.z = vs_TEXCOORD8.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.z;
    u_xlat5.y = vs_TEXCOORD9.z;
    u_xlat5.z = vs_TEXCOORD8.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat48 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_49 = (-u_xlat48) + 1.0;
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimThreshold;
    u_xlat16_49 = exp2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_49) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat8.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.w = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_49 = u_xlat2.y + u_xlat2.x;
    u_xlat16_9.x = u_xlat2.z + u_xlat16_49;
    u_xlat5.x = -0.0;
    u_xlat5.y = (-u_xlat2.x);
    u_xlat5.z = (-u_xlat16_49);
    u_xlat5.w = (-u_xlat16_9.x);
    u_xlat2 = u_xlat2 + u_xlat5;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_49 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat16_49>=0.5);
#else
    u_xlatb48 = u_xlat16_49>=0.5;
#endif
    if(u_xlatb48){
        u_xlat48 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat48 = min(u_xlat48, 3.0);
        u_xlatu48 = uint(u_xlat48);
        u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu48)].xyz);
        u_xlati48 = int(u_xlatu48) << 2;
        u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 1)].xyz;
        u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati48].xyz * u_xlat5.xxx + u_xlat6.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
        u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
        u_xlat10_48 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_51 = (-_LightShadowData.x) + 1.0;
        u_xlat48 = u_xlat10_48 * u_xlat16_51 + _LightShadowData.x;
    } else {
        u_xlat48 = 1.0;
    //ENDIF
    }
    u_xlat16_49 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_2.xyz = vec3(u_xlat16_49) * u_xlat4.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_49 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_49 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_49);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_49) + u_xlat16_10.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat51 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
    u_xlat5.xyz = vec3(u_xlat51) * u_xlat5.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat51 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
#ifdef UNITY_ADRENO_ES3
    u_xlatb53 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb53 = unity_DebugViewInfo.x==1.0;
#endif
    if(!u_xlatb53){
#ifdef UNITY_ADRENO_ES3
        u_xlatb54 = !!(unity_DebugViewInfo.x==2.0);
#else
        u_xlatb54 = unity_DebugViewInfo.x==2.0;
#endif
        u_xlat16_10.xyz = (bool(u_xlatb54)) ? vec3(0.0399999991, 0.0399999991, 0.0399999991) : u_xlat16_1.xyz;
        if(!u_xlatb54){
#ifdef UNITY_ADRENO_ES3
            u_xlatb7 = !!(unity_DebugViewInfo.x==3.0);
#else
            u_xlatb7 = unity_DebugViewInfo.x==3.0;
#endif
            u_xlat16_10.xyz = (bool(u_xlatb7)) ? vec3(0.000999987125, 0.000999987125, 0.000999987125) : u_xlat16_10.xyz;
            if(!u_xlatb7){
                u_xlat23.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                u_xlatb8 = !!(unity_DebugViewInfo.x==4.0);
#else
                u_xlatb8 = unity_DebugViewInfo.x==4.0;
#endif
                if(!u_xlatb8){
#ifdef UNITY_ADRENO_ES3
                    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
                    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
                    if(!u_xlatb24){
#ifdef UNITY_ADRENO_ES3
                        u_xlatb40 = !!(unity_DebugViewInfo.x==6.0);
#else
                        u_xlatb40 = unity_DebugViewInfo.x==6.0;
#endif
                        if(!u_xlatb40){
#ifdef UNITY_ADRENO_ES3
                            u_xlatb56 = !!(unity_DebugViewInfo.x==7.0);
#else
                            u_xlatb56 = unity_DebugViewInfo.x==7.0;
#endif
                            if(!u_xlatb56){
#ifdef UNITY_ADRENO_ES3
                                u_xlatb11 = !!(unity_DebugViewInfo.x==8.0);
#else
                                u_xlatb11 = unity_DebugViewInfo.x==8.0;
#endif
                                u_xlat16_10.xyz = (bool(u_xlatb11)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                if(!u_xlatb11){
#ifdef UNITY_ADRENO_ES3
                                    u_xlatb27 = !!(unity_DebugViewInfo.x==9.0);
#else
                                    u_xlatb27 = unity_DebugViewInfo.x==9.0;
#endif
                                    u_xlat16_10.xyz = (bool(u_xlatb27)) ? vec3(u_xlat48) : u_xlat16_10.xyz;
                                    if(!u_xlatb27){
#ifdef UNITY_ADRENO_ES3
                                        u_xlatb43 = !!(unity_DebugViewInfo.x==10.0);
#else
                                        u_xlatb43 = unity_DebugViewInfo.x==10.0;
#endif
                                        if(!u_xlatb43){
#ifdef UNITY_ADRENO_ES3
                                            u_xlatb59 = !!(unity_DebugViewInfo.x==11.0);
#else
                                            u_xlatb59 = unity_DebugViewInfo.x==11.0;
#endif
                                            u_xlat16_10.xyz = (bool(u_xlatb59)) ? vec3(1.0, 1.0, 1.0) : u_xlat16_10.xyz;
                                            if(!u_xlatb59){
#ifdef UNITY_ADRENO_ES3
                                                u_xlatb12 = !!(unity_DebugViewInfo.x==12.0);
#else
                                                u_xlatb12 = unity_DebugViewInfo.x==12.0;
#endif
                                                u_xlat16_10.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                if(!u_xlatb12){
#ifdef UNITY_ADRENO_ES3
                                                    u_xlatb28 = !!(unity_DebugViewInfo.x==13.0);
#else
                                                    u_xlatb28 = unity_DebugViewInfo.x==13.0;
#endif
                                                    u_xlat16_10.xyz = (bool(u_xlatb28)) ? vec3(0.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                    if(!u_xlatb28){
#ifdef UNITY_ADRENO_ES3
                                                        u_xlatb44 = !!(unity_DebugViewInfo.x==51.0);
#else
                                                        u_xlatb44 = unity_DebugViewInfo.x==51.0;
#endif
                                                        u_xlat16_10.xyz = (bool(u_xlatb44)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                                        if(!u_xlatb44){
                                                            if(!u_xlatb0.x){
                                                                u_xlatb13.xyz = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 151.0, 0.0)).xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_10.xyz;
                                                                u_xlatb60 = u_xlatb0.y || u_xlatb13.y;
                                                                u_xlat16_15.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.z || u_xlatb60;
                                                                u_xlat16_14.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.y) ? u_xlat16_15.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.y || u_xlatb13.z;
                                                                u_xlat16_14.xyz = (u_xlatb0.y) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb16 = u_xlatb0.y || u_xlatb60;
                                                                u_xlat16_10.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_14.xyz;
                                                                u_xlati16 = int(uint(u_xlatb13.x) * 0xffffffffu | uint(u_xlatb16) * 0xffffffffu);
                                                            } else {
                                                                u_xlat16_10.x = float(0.200000003);
                                                                u_xlat16_10.y = float(0.200000003);
                                                                u_xlat16_10.z = float(0.200000003);
                                                                u_xlati16 = -1;
                                                            //ENDIF
                                                            }
                                                            u_xlati0 = int(uint(u_xlatb0.x) * 0xffffffffu | uint(u_xlati16));
                                                        } else {
                                                            u_xlati0 = -1;
                                                        //ENDIF
                                                        }
                                                        u_xlati0 = int(uint(u_xlatb44) * 0xffffffffu | uint(u_xlati0));
                                                    } else {
                                                        u_xlati0 = -1;
                                                    //ENDIF
                                                    }
                                                    u_xlati0 = int(uint(u_xlatb28) * 0xffffffffu | uint(u_xlati0));
                                                } else {
                                                    u_xlati0 = -1;
                                                //ENDIF
                                                }
                                                u_xlati0 = int(uint(u_xlatb12) * 0xffffffffu | uint(u_xlati0));
                                            } else {
                                                u_xlati0 = -1;
                                            //ENDIF
                                            }
                                            u_xlati0 = int(uint(u_xlatb59) * 0xffffffffu | uint(u_xlati0));
                                        } else {
                                            u_xlat16_10.x = float(1.0);
                                            u_xlat16_10.y = float(1.0);
                                            u_xlat16_10.z = float(1.0);
                                            u_xlati0 = -1;
                                        //ENDIF
                                        }
                                        u_xlati0 = int(uint(u_xlatb43) * 0xffffffffu | uint(u_xlati0));
                                    } else {
                                        u_xlati0 = -1;
                                    //ENDIF
                                    }
                                    u_xlati0 = int(uint(u_xlatb27) * 0xffffffffu | uint(u_xlati0));
                                } else {
                                    u_xlati0 = -1;
                                //ENDIF
                                }
                                u_xlati0 = int(uint(u_xlatb11) * 0xffffffffu | uint(u_xlati0));
                            } else {
                                u_xlat16_10.xyz = u_xlat23.xyz;
                                u_xlati0 = -1;
                            //ENDIF
                            }
                            u_xlati0 = int(uint(u_xlatb56) * 0xffffffffu | uint(u_xlati0));
                        } else {
                            u_xlat16_10.xyz = u_xlat23.xyz;
                            u_xlati0 = -1;
                        //ENDIF
                        }
                        u_xlati0 = int(uint(u_xlatb40) * 0xffffffffu | uint(u_xlati0));
                    } else {
                        u_xlat16_10.xyz = u_xlat23.xyz;
                        u_xlati0 = -1;
                    //ENDIF
                    }
                    u_xlati0 = int(uint(u_xlatb24) * 0xffffffffu | uint(u_xlati0));
                } else {
                    u_xlat16_10.xyz = u_xlat23.xyz;
                    u_xlati0 = -1;
                //ENDIF
                }
                u_xlati0 = int(uint(u_xlatb8) * 0xffffffffu | uint(u_xlati0));
            } else {
                u_xlati0 = -1;
            //ENDIF
            }
            u_xlati0 = int(uint(u_xlatb7) * 0xffffffffu | uint(u_xlati0));
        } else {
            u_xlati0 = -1;
        //ENDIF
        }
        u_xlati0 = int(uint(u_xlatb54) * 0xffffffffu | uint(u_xlati0));
    } else {
        u_xlat16_10.xyz = u_xlat16_1.xyz;
        u_xlati0 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb53) * 0xffffffffu | uint(u_xlati0));
    u_xlat16_49 = dot(u_xlat16_2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_14.xyz = vec3(u_xlat16_49) * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_14.xyz * vec3(u_xlat48) + u_xlat16_9.xyz;
    u_xlat16_14.xyz = u_xlat6.xyz * vec3(u_xlat51) + u_xlat5.xyz;
    u_xlat16_49 = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_14.xyz = vec3(u_xlat16_49) * u_xlat16_14.xyz;
    u_xlat16_16 = dot(u_xlat16_2.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat51 = dot(u_xlat5.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat51 = min(max(u_xlat51, 0.0), 1.0);
#else
    u_xlat51 = clamp(u_xlat51, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * -0.00399392843 + 1.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = 0.996006072 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * 0.318309873;
    u_xlat51 = (-u_xlat51) + 1.0;
    u_xlat16_49 = u_xlat51 * u_xlat51;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_51 = u_xlat16_49 * 0.00766834244 + 0.0399999991;
    u_xlat16_5 = u_xlat16_16 * u_xlat16_51;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_51 + 2.0;
    u_xlat16_16 = u_xlat16_5 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_14.xyz = vec3(u_xlat16_16) * _LightColor0.xyz;
    u_xlat16_14.xyz = vec3(u_xlat48) * u_xlat16_14.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_1.xyz + u_xlat16_14.xyz;
    u_xlat16_9.xyz = (int(u_xlati0) != 0) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat16_9.xyz = (-u_xlat16_1.xyz) + u_xlat16_9.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat0.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD10.w);
    u_xlat16 = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat48 = (-u_xlat16) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat48 + u_xlat16;
    u_xlat16 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat5.xyz = vec3(u_xlat16) * vs_TEXCOORD8.xyz;
    u_xlat16 = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat16_17.x = (-u_xlat16) + 1.0;
    u_xlat16_17.x = max(u_xlat16_17.x, 9.99999975e-05);
    u_xlat16_17.x = log2(u_xlat16_17.x);
    u_xlat16_17.x = u_xlat16_17.x * 0.200000003;
    u_xlat16_17.x = exp2(u_xlat16_17.x);
    u_xlat16 = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat16 = u_xlat16 / _FarFadeLength;
    u_xlat16_33 = (-u_xlat16) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_49 = u_xlat16_32 + (-_CloudTexThreshold);
    u_xlat16_9.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_49 = u_xlat16_49 / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_1.x = u_xlat16_49 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_17.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_33 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * u_xlat3.xxx;
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    vs_TEXCOORD7.xyz = u_xlat4.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat2.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec4 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
bool u_xlatb11;
bool u_xlatb12;
bvec3 u_xlatb13;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_15;
mediump float u_xlat16_16;
int u_xlati16;
bool u_xlatb16;
mediump vec3 u_xlat16_17;
vec3 u_xlat23;
bool u_xlatb24;
bool u_xlatb27;
bool u_xlatb28;
float u_xlat32;
mediump float u_xlat16_32;
lowp float u_xlat10_32;
bool u_xlatb32;
mediump float u_xlat16_33;
bool u_xlatb40;
bool u_xlatb43;
bool u_xlatb44;
float u_xlat48;
lowp float u_xlat10_48;
int u_xlati48;
uint u_xlatu48;
bool u_xlatb48;
mediump float u_xlat16_49;
float u_xlat51;
mediump float u_xlat16_51;
bool u_xlatb53;
bool u_xlatb54;
bool u_xlatb56;
bool u_xlatb59;
bool u_xlatb60;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb32 = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb32){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat32 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat32) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_17.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_17.xy);
    u_xlat16_49 = abs(u_xlat32) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = (-u_xlat16_49) + 1.0;
    u_xlat16_17.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_17.xy;
    u_xlat10_32 = texture(_CloudTex, u_xlat16_17.xy).x;
    u_xlat16_32 = u_xlat10_32 * u_xlat16_49;
    u_xlat10_48 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_32 = u_xlat10_48 * u_xlat16_32;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_32 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_17.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_17.xyz + _CloudColorA.xyz;
    u_xlat48 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat48 = inversesqrt(u_xlat48);
    u_xlat3.xyz = vec3(u_xlat48) * vs_TEXCOORD6.xyz;
    u_xlat10_4.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat4.x = vs_TEXCOORD7.x;
    u_xlat4.y = vs_TEXCOORD9.x;
    u_xlat4.z = vs_TEXCOORD8.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.y;
    u_xlat5.y = vs_TEXCOORD9.y;
    u_xlat5.z = vs_TEXCOORD8.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.z;
    u_xlat5.y = vs_TEXCOORD9.z;
    u_xlat5.z = vs_TEXCOORD8.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat48 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_49 = (-u_xlat48) + 1.0;
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimThreshold;
    u_xlat16_49 = exp2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_49) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat8.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.w = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_49 = u_xlat2.y + u_xlat2.x;
    u_xlat16_9.x = u_xlat2.z + u_xlat16_49;
    u_xlat5.x = -0.0;
    u_xlat5.y = (-u_xlat2.x);
    u_xlat5.z = (-u_xlat16_49);
    u_xlat5.w = (-u_xlat16_9.x);
    u_xlat2 = u_xlat2 + u_xlat5;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_49 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat16_49>=0.5);
#else
    u_xlatb48 = u_xlat16_49>=0.5;
#endif
    if(u_xlatb48){
        u_xlat48 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat48 = min(u_xlat48, 3.0);
        u_xlatu48 = uint(u_xlat48);
        u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu48)].xyz);
        u_xlati48 = int(u_xlatu48) << 2;
        u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 1)].xyz;
        u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati48].xyz * u_xlat5.xxx + u_xlat6.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
        u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
        u_xlat10_48 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_51 = (-_LightShadowData.x) + 1.0;
        u_xlat48 = u_xlat10_48 * u_xlat16_51 + _LightShadowData.x;
    } else {
        u_xlat48 = 1.0;
    //ENDIF
    }
    u_xlat16_49 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_2.xyz = vec3(u_xlat16_49) * u_xlat4.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_49 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_49 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_49);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_49) + u_xlat16_10.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat51 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
    u_xlat5.xyz = vec3(u_xlat51) * u_xlat5.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat51 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
#ifdef UNITY_ADRENO_ES3
    u_xlatb53 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb53 = unity_DebugViewInfo.x==1.0;
#endif
    if(!u_xlatb53){
#ifdef UNITY_ADRENO_ES3
        u_xlatb54 = !!(unity_DebugViewInfo.x==2.0);
#else
        u_xlatb54 = unity_DebugViewInfo.x==2.0;
#endif
        u_xlat16_10.xyz = (bool(u_xlatb54)) ? vec3(0.0399999991, 0.0399999991, 0.0399999991) : u_xlat16_1.xyz;
        if(!u_xlatb54){
#ifdef UNITY_ADRENO_ES3
            u_xlatb7 = !!(unity_DebugViewInfo.x==3.0);
#else
            u_xlatb7 = unity_DebugViewInfo.x==3.0;
#endif
            u_xlat16_10.xyz = (bool(u_xlatb7)) ? vec3(0.000999987125, 0.000999987125, 0.000999987125) : u_xlat16_10.xyz;
            if(!u_xlatb7){
                u_xlat23.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                u_xlatb8 = !!(unity_DebugViewInfo.x==4.0);
#else
                u_xlatb8 = unity_DebugViewInfo.x==4.0;
#endif
                if(!u_xlatb8){
#ifdef UNITY_ADRENO_ES3
                    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
                    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
                    if(!u_xlatb24){
#ifdef UNITY_ADRENO_ES3
                        u_xlatb40 = !!(unity_DebugViewInfo.x==6.0);
#else
                        u_xlatb40 = unity_DebugViewInfo.x==6.0;
#endif
                        if(!u_xlatb40){
#ifdef UNITY_ADRENO_ES3
                            u_xlatb56 = !!(unity_DebugViewInfo.x==7.0);
#else
                            u_xlatb56 = unity_DebugViewInfo.x==7.0;
#endif
                            if(!u_xlatb56){
#ifdef UNITY_ADRENO_ES3
                                u_xlatb11 = !!(unity_DebugViewInfo.x==8.0);
#else
                                u_xlatb11 = unity_DebugViewInfo.x==8.0;
#endif
                                u_xlat16_10.xyz = (bool(u_xlatb11)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                if(!u_xlatb11){
#ifdef UNITY_ADRENO_ES3
                                    u_xlatb27 = !!(unity_DebugViewInfo.x==9.0);
#else
                                    u_xlatb27 = unity_DebugViewInfo.x==9.0;
#endif
                                    u_xlat16_10.xyz = (bool(u_xlatb27)) ? vec3(u_xlat48) : u_xlat16_10.xyz;
                                    if(!u_xlatb27){
#ifdef UNITY_ADRENO_ES3
                                        u_xlatb43 = !!(unity_DebugViewInfo.x==10.0);
#else
                                        u_xlatb43 = unity_DebugViewInfo.x==10.0;
#endif
                                        if(!u_xlatb43){
#ifdef UNITY_ADRENO_ES3
                                            u_xlatb59 = !!(unity_DebugViewInfo.x==11.0);
#else
                                            u_xlatb59 = unity_DebugViewInfo.x==11.0;
#endif
                                            u_xlat16_10.xyz = (bool(u_xlatb59)) ? vec3(1.0, 1.0, 1.0) : u_xlat16_10.xyz;
                                            if(!u_xlatb59){
#ifdef UNITY_ADRENO_ES3
                                                u_xlatb12 = !!(unity_DebugViewInfo.x==12.0);
#else
                                                u_xlatb12 = unity_DebugViewInfo.x==12.0;
#endif
                                                u_xlat16_10.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                if(!u_xlatb12){
#ifdef UNITY_ADRENO_ES3
                                                    u_xlatb28 = !!(unity_DebugViewInfo.x==13.0);
#else
                                                    u_xlatb28 = unity_DebugViewInfo.x==13.0;
#endif
                                                    u_xlat16_10.xyz = (bool(u_xlatb28)) ? vec3(0.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                    if(!u_xlatb28){
#ifdef UNITY_ADRENO_ES3
                                                        u_xlatb44 = !!(unity_DebugViewInfo.x==51.0);
#else
                                                        u_xlatb44 = unity_DebugViewInfo.x==51.0;
#endif
                                                        u_xlat16_10.xyz = (bool(u_xlatb44)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                                        if(!u_xlatb44){
                                                            if(!u_xlatb0.x){
                                                                u_xlatb13.xyz = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 151.0, 0.0)).xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_10.xyz;
                                                                u_xlatb60 = u_xlatb0.y || u_xlatb13.y;
                                                                u_xlat16_15.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.z || u_xlatb60;
                                                                u_xlat16_14.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.y) ? u_xlat16_15.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.y || u_xlatb13.z;
                                                                u_xlat16_14.xyz = (u_xlatb0.y) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb16 = u_xlatb0.y || u_xlatb60;
                                                                u_xlat16_10.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_14.xyz;
                                                                u_xlati16 = int(uint(u_xlatb13.x) * 0xffffffffu | uint(u_xlatb16) * 0xffffffffu);
                                                            } else {
                                                                u_xlat16_10.x = float(0.200000003);
                                                                u_xlat16_10.y = float(0.200000003);
                                                                u_xlat16_10.z = float(0.200000003);
                                                                u_xlati16 = -1;
                                                            //ENDIF
                                                            }
                                                            u_xlati0 = int(uint(u_xlatb0.x) * 0xffffffffu | uint(u_xlati16));
                                                        } else {
                                                            u_xlati0 = -1;
                                                        //ENDIF
                                                        }
                                                        u_xlati0 = int(uint(u_xlatb44) * 0xffffffffu | uint(u_xlati0));
                                                    } else {
                                                        u_xlati0 = -1;
                                                    //ENDIF
                                                    }
                                                    u_xlati0 = int(uint(u_xlatb28) * 0xffffffffu | uint(u_xlati0));
                                                } else {
                                                    u_xlati0 = -1;
                                                //ENDIF
                                                }
                                                u_xlati0 = int(uint(u_xlatb12) * 0xffffffffu | uint(u_xlati0));
                                            } else {
                                                u_xlati0 = -1;
                                            //ENDIF
                                            }
                                            u_xlati0 = int(uint(u_xlatb59) * 0xffffffffu | uint(u_xlati0));
                                        } else {
                                            u_xlat16_10.x = float(1.0);
                                            u_xlat16_10.y = float(1.0);
                                            u_xlat16_10.z = float(1.0);
                                            u_xlati0 = -1;
                                        //ENDIF
                                        }
                                        u_xlati0 = int(uint(u_xlatb43) * 0xffffffffu | uint(u_xlati0));
                                    } else {
                                        u_xlati0 = -1;
                                    //ENDIF
                                    }
                                    u_xlati0 = int(uint(u_xlatb27) * 0xffffffffu | uint(u_xlati0));
                                } else {
                                    u_xlati0 = -1;
                                //ENDIF
                                }
                                u_xlati0 = int(uint(u_xlatb11) * 0xffffffffu | uint(u_xlati0));
                            } else {
                                u_xlat16_10.xyz = u_xlat23.xyz;
                                u_xlati0 = -1;
                            //ENDIF
                            }
                            u_xlati0 = int(uint(u_xlatb56) * 0xffffffffu | uint(u_xlati0));
                        } else {
                            u_xlat16_10.xyz = u_xlat23.xyz;
                            u_xlati0 = -1;
                        //ENDIF
                        }
                        u_xlati0 = int(uint(u_xlatb40) * 0xffffffffu | uint(u_xlati0));
                    } else {
                        u_xlat16_10.xyz = u_xlat23.xyz;
                        u_xlati0 = -1;
                    //ENDIF
                    }
                    u_xlati0 = int(uint(u_xlatb24) * 0xffffffffu | uint(u_xlati0));
                } else {
                    u_xlat16_10.xyz = u_xlat23.xyz;
                    u_xlati0 = -1;
                //ENDIF
                }
                u_xlati0 = int(uint(u_xlatb8) * 0xffffffffu | uint(u_xlati0));
            } else {
                u_xlati0 = -1;
            //ENDIF
            }
            u_xlati0 = int(uint(u_xlatb7) * 0xffffffffu | uint(u_xlati0));
        } else {
            u_xlati0 = -1;
        //ENDIF
        }
        u_xlati0 = int(uint(u_xlatb54) * 0xffffffffu | uint(u_xlati0));
    } else {
        u_xlat16_10.xyz = u_xlat16_1.xyz;
        u_xlati0 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb53) * 0xffffffffu | uint(u_xlati0));
    u_xlat16_49 = dot(u_xlat16_2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_14.xyz = vec3(u_xlat16_49) * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_14.xyz * vec3(u_xlat48) + u_xlat16_9.xyz;
    u_xlat16_14.xyz = u_xlat6.xyz * vec3(u_xlat51) + u_xlat5.xyz;
    u_xlat16_49 = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_14.xyz = vec3(u_xlat16_49) * u_xlat16_14.xyz;
    u_xlat16_16 = dot(u_xlat16_2.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat51 = dot(u_xlat5.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat51 = min(max(u_xlat51, 0.0), 1.0);
#else
    u_xlat51 = clamp(u_xlat51, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * -0.00399392843 + 1.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = 0.996006072 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * 0.318309873;
    u_xlat51 = (-u_xlat51) + 1.0;
    u_xlat16_49 = u_xlat51 * u_xlat51;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_51 = u_xlat16_49 * 0.00766834244 + 0.0399999991;
    u_xlat16_5 = u_xlat16_16 * u_xlat16_51;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_51 + 2.0;
    u_xlat16_16 = u_xlat16_5 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_14.xyz = vec3(u_xlat16_16) * _LightColor0.xyz;
    u_xlat16_14.xyz = vec3(u_xlat48) * u_xlat16_14.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_1.xyz + u_xlat16_14.xyz;
    u_xlat16_9.xyz = (int(u_xlati0) != 0) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat16_9.xyz = (-u_xlat16_1.xyz) + u_xlat16_9.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat0.x = dot(u_xlat0.xyw, u_xlat3.xyz);
    u_xlat16_17.x = (-u_xlat0.x) + 1.0;
    u_xlat16_17.x = max(u_xlat16_17.x, 9.99999975e-05);
    u_xlat16_17.x = log2(u_xlat16_17.x);
    u_xlat16_17.x = u_xlat16_17.x * 0.200000003;
    u_xlat16_17.x = exp2(u_xlat16_17.x);
    u_xlat0.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x / _FarFadeLength;
    u_xlat16_33 = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_49 = u_xlat16_32 + (-_CloudTexThreshold);
    u_xlat16_9.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_49 = u_xlat16_49 / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_1.x = u_xlat16_49 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_17.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_33 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * u_xlat3.xxx;
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    vs_TEXCOORD7.xyz = u_xlat4.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat2.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec4 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
bool u_xlatb11;
bool u_xlatb12;
bvec3 u_xlatb13;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
bool u_xlatb16;
mediump vec3 u_xlat16_17;
vec3 u_xlat23;
bool u_xlatb24;
bool u_xlatb27;
bool u_xlatb28;
float u_xlat32;
mediump float u_xlat16_32;
lowp float u_xlat10_32;
bool u_xlatb32;
mediump float u_xlat16_33;
bool u_xlatb40;
bool u_xlatb43;
bool u_xlatb44;
float u_xlat48;
lowp float u_xlat10_48;
int u_xlati48;
uint u_xlatu48;
bool u_xlatb48;
mediump float u_xlat16_49;
float u_xlat51;
mediump float u_xlat16_51;
bool u_xlatb53;
bool u_xlatb54;
bool u_xlatb56;
bool u_xlatb59;
bool u_xlatb60;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb32 = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb32){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat32 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat32) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_17.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_17.xy);
    u_xlat16_49 = abs(u_xlat32) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = (-u_xlat16_49) + 1.0;
    u_xlat16_17.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_17.xy;
    u_xlat10_32 = texture(_CloudTex, u_xlat16_17.xy).x;
    u_xlat16_32 = u_xlat10_32 * u_xlat16_49;
    u_xlat10_48 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_32 = u_xlat10_48 * u_xlat16_32;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_32 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_17.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_17.xyz + _CloudColorA.xyz;
    u_xlat48 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat48 = inversesqrt(u_xlat48);
    u_xlat3.xyz = vec3(u_xlat48) * vs_TEXCOORD6.xyz;
    u_xlat10_4.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat4.x = vs_TEXCOORD7.x;
    u_xlat4.y = vs_TEXCOORD9.x;
    u_xlat4.z = vs_TEXCOORD8.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.y;
    u_xlat5.y = vs_TEXCOORD9.y;
    u_xlat5.z = vs_TEXCOORD8.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.z;
    u_xlat5.y = vs_TEXCOORD9.z;
    u_xlat5.z = vs_TEXCOORD8.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat48 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_49 = (-u_xlat48) + 1.0;
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimThreshold;
    u_xlat16_49 = exp2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_49) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat8.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.w = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_49 = u_xlat2.y + u_xlat2.x;
    u_xlat16_9.x = u_xlat2.z + u_xlat16_49;
    u_xlat5.x = -0.0;
    u_xlat5.y = (-u_xlat2.x);
    u_xlat5.z = (-u_xlat16_49);
    u_xlat5.w = (-u_xlat16_9.x);
    u_xlat2 = u_xlat2 + u_xlat5;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_49 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat16_49>=0.5);
#else
    u_xlatb48 = u_xlat16_49>=0.5;
#endif
    if(u_xlatb48){
        u_xlat48 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat48 = min(u_xlat48, 3.0);
        u_xlatu48 = uint(u_xlat48);
        u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu48)].xyz);
        u_xlati48 = int(u_xlatu48) << 2;
        u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 1)].xyz;
        u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati48].xyz * u_xlat5.xxx + u_xlat6.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
        u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
        u_xlat10_48 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_51 = (-_LightShadowData.x) + 1.0;
        u_xlat48 = u_xlat10_48 * u_xlat16_51 + _LightShadowData.x;
    } else {
        u_xlat48 = 1.0;
    //ENDIF
    }
    u_xlat16_49 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_2.xyz = vec3(u_xlat16_49) * u_xlat4.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_49 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_49 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_49);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_49) + u_xlat16_10.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat51 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
    u_xlat5.xyz = vec3(u_xlat51) * u_xlat5.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat51 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
#ifdef UNITY_ADRENO_ES3
    u_xlatb53 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb53 = unity_DebugViewInfo.x==1.0;
#endif
    if(!u_xlatb53){
#ifdef UNITY_ADRENO_ES3
        u_xlatb54 = !!(unity_DebugViewInfo.x==2.0);
#else
        u_xlatb54 = unity_DebugViewInfo.x==2.0;
#endif
        u_xlat16_10.xyz = (bool(u_xlatb54)) ? vec3(0.0399999991, 0.0399999991, 0.0399999991) : u_xlat16_1.xyz;
        if(!u_xlatb54){
#ifdef UNITY_ADRENO_ES3
            u_xlatb7 = !!(unity_DebugViewInfo.x==3.0);
#else
            u_xlatb7 = unity_DebugViewInfo.x==3.0;
#endif
            u_xlat16_10.xyz = (bool(u_xlatb7)) ? vec3(0.000999987125, 0.000999987125, 0.000999987125) : u_xlat16_10.xyz;
            if(!u_xlatb7){
                u_xlat23.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                u_xlatb8 = !!(unity_DebugViewInfo.x==4.0);
#else
                u_xlatb8 = unity_DebugViewInfo.x==4.0;
#endif
                if(!u_xlatb8){
#ifdef UNITY_ADRENO_ES3
                    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
                    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
                    if(!u_xlatb24){
#ifdef UNITY_ADRENO_ES3
                        u_xlatb40 = !!(unity_DebugViewInfo.x==6.0);
#else
                        u_xlatb40 = unity_DebugViewInfo.x==6.0;
#endif
                        if(!u_xlatb40){
#ifdef UNITY_ADRENO_ES3
                            u_xlatb56 = !!(unity_DebugViewInfo.x==7.0);
#else
                            u_xlatb56 = unity_DebugViewInfo.x==7.0;
#endif
                            if(!u_xlatb56){
#ifdef UNITY_ADRENO_ES3
                                u_xlatb11 = !!(unity_DebugViewInfo.x==8.0);
#else
                                u_xlatb11 = unity_DebugViewInfo.x==8.0;
#endif
                                u_xlat16_10.xyz = (bool(u_xlatb11)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                if(!u_xlatb11){
#ifdef UNITY_ADRENO_ES3
                                    u_xlatb27 = !!(unity_DebugViewInfo.x==9.0);
#else
                                    u_xlatb27 = unity_DebugViewInfo.x==9.0;
#endif
                                    u_xlat16_10.xyz = (bool(u_xlatb27)) ? vec3(u_xlat48) : u_xlat16_10.xyz;
                                    if(!u_xlatb27){
#ifdef UNITY_ADRENO_ES3
                                        u_xlatb43 = !!(unity_DebugViewInfo.x==10.0);
#else
                                        u_xlatb43 = unity_DebugViewInfo.x==10.0;
#endif
                                        if(!u_xlatb43){
#ifdef UNITY_ADRENO_ES3
                                            u_xlatb59 = !!(unity_DebugViewInfo.x==11.0);
#else
                                            u_xlatb59 = unity_DebugViewInfo.x==11.0;
#endif
                                            u_xlat16_10.xyz = (bool(u_xlatb59)) ? vec3(1.0, 1.0, 1.0) : u_xlat16_10.xyz;
                                            if(!u_xlatb59){
#ifdef UNITY_ADRENO_ES3
                                                u_xlatb12 = !!(unity_DebugViewInfo.x==12.0);
#else
                                                u_xlatb12 = unity_DebugViewInfo.x==12.0;
#endif
                                                u_xlat16_10.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                if(!u_xlatb12){
#ifdef UNITY_ADRENO_ES3
                                                    u_xlatb28 = !!(unity_DebugViewInfo.x==13.0);
#else
                                                    u_xlatb28 = unity_DebugViewInfo.x==13.0;
#endif
                                                    u_xlat16_10.xyz = (bool(u_xlatb28)) ? vec3(0.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                    if(!u_xlatb28){
#ifdef UNITY_ADRENO_ES3
                                                        u_xlatb44 = !!(unity_DebugViewInfo.x==51.0);
#else
                                                        u_xlatb44 = unity_DebugViewInfo.x==51.0;
#endif
                                                        u_xlat16_10.xyz = (bool(u_xlatb44)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                                        if(!u_xlatb44){
                                                            if(!u_xlatb0.x){
                                                                u_xlatb13.xyz = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 151.0, 0.0)).xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_10.xyz;
                                                                u_xlatb60 = u_xlatb0.y || u_xlatb13.y;
                                                                u_xlat16_15.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.z || u_xlatb60;
                                                                u_xlat16_14.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.y) ? u_xlat16_15.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.y || u_xlatb13.z;
                                                                u_xlat16_14.xyz = (u_xlatb0.y) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb16 = u_xlatb0.y || u_xlatb60;
                                                                u_xlat16_10.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_14.xyz;
                                                                u_xlati16 = int(uint(u_xlatb13.x) * 0xffffffffu | uint(u_xlatb16) * 0xffffffffu);
                                                            } else {
                                                                u_xlat16_10.x = float(0.200000003);
                                                                u_xlat16_10.y = float(0.200000003);
                                                                u_xlat16_10.z = float(0.200000003);
                                                                u_xlati16 = -1;
                                                            //ENDIF
                                                            }
                                                            u_xlati0 = int(uint(u_xlatb0.x) * 0xffffffffu | uint(u_xlati16));
                                                        } else {
                                                            u_xlati0 = -1;
                                                        //ENDIF
                                                        }
                                                        u_xlati0 = int(uint(u_xlatb44) * 0xffffffffu | uint(u_xlati0));
                                                    } else {
                                                        u_xlati0 = -1;
                                                    //ENDIF
                                                    }
                                                    u_xlati0 = int(uint(u_xlatb28) * 0xffffffffu | uint(u_xlati0));
                                                } else {
                                                    u_xlati0 = -1;
                                                //ENDIF
                                                }
                                                u_xlati0 = int(uint(u_xlatb12) * 0xffffffffu | uint(u_xlati0));
                                            } else {
                                                u_xlati0 = -1;
                                            //ENDIF
                                            }
                                            u_xlati0 = int(uint(u_xlatb59) * 0xffffffffu | uint(u_xlati0));
                                        } else {
                                            u_xlat16_10.x = float(1.0);
                                            u_xlat16_10.y = float(1.0);
                                            u_xlat16_10.z = float(1.0);
                                            u_xlati0 = -1;
                                        //ENDIF
                                        }
                                        u_xlati0 = int(uint(u_xlatb43) * 0xffffffffu | uint(u_xlati0));
                                    } else {
                                        u_xlati0 = -1;
                                    //ENDIF
                                    }
                                    u_xlati0 = int(uint(u_xlatb27) * 0xffffffffu | uint(u_xlati0));
                                } else {
                                    u_xlati0 = -1;
                                //ENDIF
                                }
                                u_xlati0 = int(uint(u_xlatb11) * 0xffffffffu | uint(u_xlati0));
                            } else {
                                u_xlat16_10.xyz = u_xlat23.xyz;
                                u_xlati0 = -1;
                            //ENDIF
                            }
                            u_xlati0 = int(uint(u_xlatb56) * 0xffffffffu | uint(u_xlati0));
                        } else {
                            u_xlat16_10.xyz = u_xlat23.xyz;
                            u_xlati0 = -1;
                        //ENDIF
                        }
                        u_xlati0 = int(uint(u_xlatb40) * 0xffffffffu | uint(u_xlati0));
                    } else {
                        u_xlat16_10.xyz = u_xlat23.xyz;
                        u_xlati0 = -1;
                    //ENDIF
                    }
                    u_xlati0 = int(uint(u_xlatb24) * 0xffffffffu | uint(u_xlati0));
                } else {
                    u_xlat16_10.xyz = u_xlat23.xyz;
                    u_xlati0 = -1;
                //ENDIF
                }
                u_xlati0 = int(uint(u_xlatb8) * 0xffffffffu | uint(u_xlati0));
            } else {
                u_xlati0 = -1;
            //ENDIF
            }
            u_xlati0 = int(uint(u_xlatb7) * 0xffffffffu | uint(u_xlati0));
        } else {
            u_xlati0 = -1;
        //ENDIF
        }
        u_xlati0 = int(uint(u_xlatb54) * 0xffffffffu | uint(u_xlati0));
    } else {
        u_xlat16_10.xyz = u_xlat16_1.xyz;
        u_xlati0 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb53) * 0xffffffffu | uint(u_xlati0));
    u_xlat16_49 = dot(u_xlat16_2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_14.xyz = vec3(u_xlat16_49) * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_14.xyz * vec3(u_xlat48) + u_xlat16_9.xyz;
    u_xlat16_14.xyz = u_xlat6.xyz * vec3(u_xlat51) + u_xlat5.xyz;
    u_xlat16_49 = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_14.xyz = vec3(u_xlat16_49) * u_xlat16_14.xyz;
    u_xlat16_16 = dot(u_xlat16_2.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat51 = dot(u_xlat5.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat51 = min(max(u_xlat51, 0.0), 1.0);
#else
    u_xlat51 = clamp(u_xlat51, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * -0.00399392843 + 1.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = 0.996006072 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * 0.318309873;
    u_xlat51 = (-u_xlat51) + 1.0;
    u_xlat16_49 = u_xlat51 * u_xlat51;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_51 = u_xlat16_49 * 0.00766834244 + 0.0399999991;
    u_xlat16_5 = u_xlat16_16 * u_xlat16_51;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_51 + 2.0;
    u_xlat16_16 = u_xlat16_5 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_14.xyz = vec3(u_xlat16_16) * _LightColor0.xyz;
    u_xlat16_14.xyz = vec3(u_xlat48) * u_xlat16_14.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_1.xyz + u_xlat16_14.xyz;
    u_xlat16_9.xyz = (int(u_xlati0) != 0) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat16_9.xyz = (-u_xlat16_1.xyz) + u_xlat16_9.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat0.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD10.w);
    u_xlat16 = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat48 = (-u_xlat16) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat48 + u_xlat16;
    u_xlat16 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat5.xyz = vec3(u_xlat16) * vs_TEXCOORD8.xyz;
    u_xlat16 = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat16_17.x = (-u_xlat16) + 1.0;
    u_xlat16_17.x = max(u_xlat16_17.x, 9.99999975e-05);
    u_xlat16_17.x = log2(u_xlat16_17.x);
    u_xlat16_17.x = u_xlat16_17.x * 0.200000003;
    u_xlat16_17.x = exp2(u_xlat16_17.x);
    u_xlat16 = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat16 = u_xlat16 / _FarFadeLength;
    u_xlat16_33 = (-u_xlat16) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_49 = u_xlat16_32 + (-_CloudTexThreshold);
    u_xlat16_9.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_49 = u_xlat16_49 / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_1.x = u_xlat16_49 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_17.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_33 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
lowp float u_xlat10_10;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_13;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
mediump float u_xlat16_31;
float u_xlat33;
lowp float u_xlat10_33;
int u_xlati33;
uint u_xlatu33;
bool u_xlatb33;
float u_xlat35;
void main()
{
    u_xlat0 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat0) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_11.xy);
    u_xlat16_31 = abs(u_xlat0) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_31) + 1.0;
    u_xlat16_11.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_11.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat16_11.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_31;
    u_xlat10_10 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_0 = u_xlat10_10 * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_0 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_11.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_11.xyz + _CloudColorA.xyz;
    u_xlat10.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD6.xyz;
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat3.x = vs_TEXCOORD7.x;
    u_xlat3.y = vs_TEXCOORD9.x;
    u_xlat3.z = vs_TEXCOORD8.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.y;
    u_xlat4.y = vs_TEXCOORD9.y;
    u_xlat4.z = vs_TEXCOORD8.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.z;
    u_xlat4.y = vs_TEXCOORD9.z;
    u_xlat4.z = vs_TEXCOORD8.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat33 = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_31 = (-u_xlat33) + 1.0;
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimThreshold;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.w = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_31 = u_xlat2.y + u_xlat2.x;
    u_xlat16_8.x = u_xlat2.z + u_xlat16_31;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.z = (-u_xlat16_31);
    u_xlat4.w = (-u_xlat16_8.x);
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_31 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat16_31>=0.5);
#else
    u_xlatb33 = u_xlat16_31>=0.5;
#endif
    if(u_xlatb33){
        u_xlat33 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat33 = min(u_xlat33, 3.0);
        u_xlatu33 = uint(u_xlat33);
        u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu33)].xyz);
        u_xlati33 = int(u_xlatu33) << 2;
        u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 1)].xyz;
        u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati33].xyz * u_xlat4.xxx + u_xlat5.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 2)].xyz * u_xlat4.zzz + u_xlat4.xyw;
        u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
        u_xlat10_33 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_4.x = (-_LightShadowData.x) + 1.0;
        u_xlat33 = u_xlat10_33 * u_xlat16_4.x + _LightShadowData.x;
    } else {
        u_xlat33 = 1.0;
    //ENDIF
    }
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_2.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_31 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_31 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_31);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_31) + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xxx;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat35 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat16_31 = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_31) * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_9.xyz = u_xlat5.xyz * vec3(u_xlat35) + u_xlat3.xyz;
    u_xlat16_31 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_9.xyz = vec3(u_xlat16_31) * u_xlat16_9.xyz;
    u_xlat16_5 = dot(u_xlat16_2.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_13 = u_xlat16_13 * -0.00399392843 + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = 0.996006072 / u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * 0.318309873;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat16_31 = u_xlat3.x * u_xlat3.x;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_3 = u_xlat16_31 * 0.00766834244 + 0.0399999991;
    u_xlat16_23 = u_xlat16_3 * u_xlat16_13;
    u_xlat16_3 = u_xlat16_13 * u_xlat16_3 + 2.0;
    u_xlat16_3 = u_xlat16_23 / u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _LightColor0.xyz;
    u_xlat16_9.xyz = vec3(u_xlat33) * u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + u_xlat16_8.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_11.x = (-u_xlat10.x) + 1.0;
    u_xlat16_11.x = max(u_xlat16_11.x, 9.99999975e-05);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * 0.200000003;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat10.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat10.x = u_xlat10.x / _FarFadeLength;
    u_xlat16_21 = (-u_xlat10.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_8.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_31 = u_xlat16_31 / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_1.x = u_xlat16_31 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0 = u_xlat16_1.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_11.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_21 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    SV_Target0.w = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
lowp float u_xlat10_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat13;
mediump float u_xlat16_13;
mediump float u_xlat16_21;
float u_xlat23;
mediump float u_xlat16_23;
mediump float u_xlat16_31;
float u_xlat33;
lowp float u_xlat10_33;
int u_xlati33;
uint u_xlatu33;
bool u_xlatb33;
float u_xlat35;
void main()
{
    u_xlat0 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat0) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_11.xy);
    u_xlat16_31 = abs(u_xlat0) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_31) + 1.0;
    u_xlat16_11.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_11.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat16_11.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_31;
    u_xlat10_10 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_0 = u_xlat10_10 * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_0 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_11.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_11.xyz + _CloudColorA.xyz;
    u_xlat10.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD6.xyz;
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat3.x = vs_TEXCOORD7.x;
    u_xlat3.y = vs_TEXCOORD9.x;
    u_xlat3.z = vs_TEXCOORD8.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.y;
    u_xlat4.y = vs_TEXCOORD9.y;
    u_xlat4.z = vs_TEXCOORD8.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.z;
    u_xlat4.y = vs_TEXCOORD9.z;
    u_xlat4.z = vs_TEXCOORD8.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat33 = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_31 = (-u_xlat33) + 1.0;
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimThreshold;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.w = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_31 = u_xlat2.y + u_xlat2.x;
    u_xlat16_8.x = u_xlat2.z + u_xlat16_31;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.z = (-u_xlat16_31);
    u_xlat4.w = (-u_xlat16_8.x);
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_31 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat16_31>=0.5);
#else
    u_xlatb33 = u_xlat16_31>=0.5;
#endif
    if(u_xlatb33){
        u_xlat33 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat33 = min(u_xlat33, 3.0);
        u_xlatu33 = uint(u_xlat33);
        u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu33)].xyz);
        u_xlati33 = int(u_xlatu33) << 2;
        u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 1)].xyz;
        u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati33].xyz * u_xlat4.xxx + u_xlat5.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 2)].xyz * u_xlat4.zzz + u_xlat4.xyw;
        u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
        u_xlat10_33 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_4.x = (-_LightShadowData.x) + 1.0;
        u_xlat33 = u_xlat10_33 * u_xlat16_4.x + _LightShadowData.x;
    } else {
        u_xlat33 = 1.0;
    //ENDIF
    }
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_2.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_31 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_31 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_31);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_31) + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xxx;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat35 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat16_31 = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_31) * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_9.xyz = u_xlat5.xyz * vec3(u_xlat35) + u_xlat3.xyz;
    u_xlat16_31 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_9.xyz = vec3(u_xlat16_31) * u_xlat16_9.xyz;
    u_xlat16_5 = dot(u_xlat16_2.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_13 = u_xlat16_13 * -0.00399392843 + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = 0.996006072 / u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * 0.318309873;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat16_31 = u_xlat3.x * u_xlat3.x;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_3 = u_xlat16_31 * 0.00766834244 + 0.0399999991;
    u_xlat16_23 = u_xlat16_3 * u_xlat16_13;
    u_xlat16_3 = u_xlat16_13 * u_xlat16_3 + 2.0;
    u_xlat16_3 = u_xlat16_23 / u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _LightColor0.xyz;
    u_xlat16_9.xyz = vec3(u_xlat33) * u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + u_xlat16_8.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat3.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD10.w);
    u_xlat13.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat23 = (-u_xlat13.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat23 + u_xlat13.x;
    u_xlat13.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat13.x = inversesqrt(u_xlat13.x);
    u_xlat13.xyz = u_xlat13.xxx * vs_TEXCOORD8.xyz;
    u_xlat10.x = dot(u_xlat13.xyz, u_xlat10.xyz);
    u_xlat16_11.x = (-u_xlat10.x) + 1.0;
    u_xlat16_11.x = max(u_xlat16_11.x, 9.99999975e-05);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * 0.200000003;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat10.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat10.x = u_xlat10.x / _FarFadeLength;
    u_xlat16_21 = (-u_xlat10.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_8.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_31 = u_xlat16_31 / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_1.x = u_xlat16_31 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0 = u_xlat3.x * u_xlat16_1.x;
    u_xlat0 = u_xlat0 * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_11.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_21 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    SV_Target0.w = u_xlat0;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * u_xlat3.xxx;
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    vs_TEXCOORD7.xyz = u_xlat4.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat2.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
lowp float u_xlat10_10;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_13;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
mediump float u_xlat16_31;
float u_xlat33;
lowp float u_xlat10_33;
int u_xlati33;
uint u_xlatu33;
bool u_xlatb33;
float u_xlat35;
void main()
{
    u_xlat0 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat0) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_11.xy);
    u_xlat16_31 = abs(u_xlat0) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_31) + 1.0;
    u_xlat16_11.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_11.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat16_11.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_31;
    u_xlat10_10 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_0 = u_xlat10_10 * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_0 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_11.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_11.xyz + _CloudColorA.xyz;
    u_xlat10.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD6.xyz;
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat3.x = vs_TEXCOORD7.x;
    u_xlat3.y = vs_TEXCOORD9.x;
    u_xlat3.z = vs_TEXCOORD8.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.y;
    u_xlat4.y = vs_TEXCOORD9.y;
    u_xlat4.z = vs_TEXCOORD8.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.z;
    u_xlat4.y = vs_TEXCOORD9.z;
    u_xlat4.z = vs_TEXCOORD8.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat33 = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_31 = (-u_xlat33) + 1.0;
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimThreshold;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.w = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_31 = u_xlat2.y + u_xlat2.x;
    u_xlat16_8.x = u_xlat2.z + u_xlat16_31;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.z = (-u_xlat16_31);
    u_xlat4.w = (-u_xlat16_8.x);
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_31 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat16_31>=0.5);
#else
    u_xlatb33 = u_xlat16_31>=0.5;
#endif
    if(u_xlatb33){
        u_xlat33 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat33 = min(u_xlat33, 3.0);
        u_xlatu33 = uint(u_xlat33);
        u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu33)].xyz);
        u_xlati33 = int(u_xlatu33) << 2;
        u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 1)].xyz;
        u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati33].xyz * u_xlat4.xxx + u_xlat5.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 2)].xyz * u_xlat4.zzz + u_xlat4.xyw;
        u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
        u_xlat10_33 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_4.x = (-_LightShadowData.x) + 1.0;
        u_xlat33 = u_xlat10_33 * u_xlat16_4.x + _LightShadowData.x;
    } else {
        u_xlat33 = 1.0;
    //ENDIF
    }
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_2.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_31 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_31 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_31);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_31) + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xxx;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat35 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat16_31 = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_31) * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_9.xyz = u_xlat5.xyz * vec3(u_xlat35) + u_xlat3.xyz;
    u_xlat16_31 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_9.xyz = vec3(u_xlat16_31) * u_xlat16_9.xyz;
    u_xlat16_5 = dot(u_xlat16_2.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_13 = u_xlat16_13 * -0.00399392843 + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = 0.996006072 / u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * 0.318309873;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat16_31 = u_xlat3.x * u_xlat3.x;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_3 = u_xlat16_31 * 0.00766834244 + 0.0399999991;
    u_xlat16_23 = u_xlat16_3 * u_xlat16_13;
    u_xlat16_3 = u_xlat16_13 * u_xlat16_3 + 2.0;
    u_xlat16_3 = u_xlat16_23 / u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _LightColor0.xyz;
    u_xlat16_9.xyz = vec3(u_xlat33) * u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + u_xlat16_8.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_11.x = (-u_xlat10.x) + 1.0;
    u_xlat16_11.x = max(u_xlat16_11.x, 9.99999975e-05);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * 0.200000003;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat10.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat10.x = u_xlat10.x / _FarFadeLength;
    u_xlat16_21 = (-u_xlat10.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_8.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_31 = u_xlat16_31 / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_1.x = u_xlat16_31 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0 = u_xlat16_1.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_11.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_21 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    SV_Target0.w = u_xlat0;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * u_xlat3.xxx;
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    vs_TEXCOORD7.xyz = u_xlat4.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat2.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
lowp float u_xlat10_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat13;
mediump float u_xlat16_13;
mediump float u_xlat16_21;
float u_xlat23;
mediump float u_xlat16_23;
mediump float u_xlat16_31;
float u_xlat33;
lowp float u_xlat10_33;
int u_xlati33;
uint u_xlatu33;
bool u_xlatb33;
float u_xlat35;
void main()
{
    u_xlat0 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat0) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_11.xy);
    u_xlat16_31 = abs(u_xlat0) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_31) + 1.0;
    u_xlat16_11.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_11.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat16_11.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_31;
    u_xlat10_10 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_0 = u_xlat10_10 * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_0 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_11.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_11.xyz + _CloudColorA.xyz;
    u_xlat10.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD6.xyz;
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat3.x = vs_TEXCOORD7.x;
    u_xlat3.y = vs_TEXCOORD9.x;
    u_xlat3.z = vs_TEXCOORD8.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.y;
    u_xlat4.y = vs_TEXCOORD9.y;
    u_xlat4.z = vs_TEXCOORD8.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.z;
    u_xlat4.y = vs_TEXCOORD9.z;
    u_xlat4.z = vs_TEXCOORD8.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat33 = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_31 = (-u_xlat33) + 1.0;
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimThreshold;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.w = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_31 = u_xlat2.y + u_xlat2.x;
    u_xlat16_8.x = u_xlat2.z + u_xlat16_31;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.z = (-u_xlat16_31);
    u_xlat4.w = (-u_xlat16_8.x);
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_31 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat16_31>=0.5);
#else
    u_xlatb33 = u_xlat16_31>=0.5;
#endif
    if(u_xlatb33){
        u_xlat33 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat33 = min(u_xlat33, 3.0);
        u_xlatu33 = uint(u_xlat33);
        u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu33)].xyz);
        u_xlati33 = int(u_xlatu33) << 2;
        u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 1)].xyz;
        u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati33].xyz * u_xlat4.xxx + u_xlat5.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 2)].xyz * u_xlat4.zzz + u_xlat4.xyw;
        u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
        u_xlat10_33 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_4.x = (-_LightShadowData.x) + 1.0;
        u_xlat33 = u_xlat10_33 * u_xlat16_4.x + _LightShadowData.x;
    } else {
        u_xlat33 = 1.0;
    //ENDIF
    }
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_2.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_31 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_31 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_31);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_31) + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xxx;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat35 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat16_31 = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_31) * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_9.xyz = u_xlat5.xyz * vec3(u_xlat35) + u_xlat3.xyz;
    u_xlat16_31 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_9.xyz = vec3(u_xlat16_31) * u_xlat16_9.xyz;
    u_xlat16_5 = dot(u_xlat16_2.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_13 = u_xlat16_13 * -0.00399392843 + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = 0.996006072 / u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * 0.318309873;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat16_31 = u_xlat3.x * u_xlat3.x;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_3 = u_xlat16_31 * 0.00766834244 + 0.0399999991;
    u_xlat16_23 = u_xlat16_3 * u_xlat16_13;
    u_xlat16_3 = u_xlat16_13 * u_xlat16_3 + 2.0;
    u_xlat16_3 = u_xlat16_23 / u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _LightColor0.xyz;
    u_xlat16_9.xyz = vec3(u_xlat33) * u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + u_xlat16_8.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat3.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD10.w);
    u_xlat13.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat23 = (-u_xlat13.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat23 + u_xlat13.x;
    u_xlat13.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat13.x = inversesqrt(u_xlat13.x);
    u_xlat13.xyz = u_xlat13.xxx * vs_TEXCOORD8.xyz;
    u_xlat10.x = dot(u_xlat13.xyz, u_xlat10.xyz);
    u_xlat16_11.x = (-u_xlat10.x) + 1.0;
    u_xlat16_11.x = max(u_xlat16_11.x, 9.99999975e-05);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * 0.200000003;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat10.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat10.x = u_xlat10.x / _FarFadeLength;
    u_xlat16_21 = (-u_xlat10.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_8.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_31 = u_xlat16_31 / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_1.x = u_xlat16_31 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0 = u_xlat3.x * u_xlat16_1.x;
    u_xlat0 = u_xlat0 * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_11.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_21 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    SV_Target0.w = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
lowp float u_xlat10_10;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_13;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
mediump float u_xlat16_31;
float u_xlat33;
lowp float u_xlat10_33;
int u_xlati33;
uint u_xlatu33;
bool u_xlatb33;
float u_xlat35;
void main()
{
    u_xlat0 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat0) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_11.xy);
    u_xlat16_31 = abs(u_xlat0) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_31) + 1.0;
    u_xlat16_11.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_11.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat16_11.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_31;
    u_xlat10_10 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_0 = u_xlat10_10 * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_0 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_11.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_11.xyz + _CloudColorA.xyz;
    u_xlat10.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD6.xyz;
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat3.x = vs_TEXCOORD7.x;
    u_xlat3.y = vs_TEXCOORD9.x;
    u_xlat3.z = vs_TEXCOORD8.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.y;
    u_xlat4.y = vs_TEXCOORD9.y;
    u_xlat4.z = vs_TEXCOORD8.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.z;
    u_xlat4.y = vs_TEXCOORD9.z;
    u_xlat4.z = vs_TEXCOORD8.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat33 = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_31 = (-u_xlat33) + 1.0;
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimThreshold;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.w = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_31 = u_xlat2.y + u_xlat2.x;
    u_xlat16_8.x = u_xlat2.z + u_xlat16_31;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.z = (-u_xlat16_31);
    u_xlat4.w = (-u_xlat16_8.x);
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_31 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat16_31>=0.5);
#else
    u_xlatb33 = u_xlat16_31>=0.5;
#endif
    if(u_xlatb33){
        u_xlat33 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat33 = min(u_xlat33, 3.0);
        u_xlatu33 = uint(u_xlat33);
        u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu33)].xyz);
        u_xlati33 = int(u_xlatu33) << 2;
        u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 1)].xyz;
        u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati33].xyz * u_xlat4.xxx + u_xlat5.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 2)].xyz * u_xlat4.zzz + u_xlat4.xyw;
        u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
        u_xlat10_33 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_4.x = (-_LightShadowData.x) + 1.0;
        u_xlat33 = u_xlat10_33 * u_xlat16_4.x + _LightShadowData.x;
    } else {
        u_xlat33 = 1.0;
    //ENDIF
    }
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_2.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_31 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_31 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_31);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_31) + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xxx;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat35 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat16_31 = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_31) * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_9.xyz = u_xlat5.xyz * vec3(u_xlat35) + u_xlat3.xyz;
    u_xlat16_31 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_9.xyz = vec3(u_xlat16_31) * u_xlat16_9.xyz;
    u_xlat16_5 = dot(u_xlat16_2.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_13 = u_xlat16_13 * -0.00399392843 + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = 0.996006072 / u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * 0.318309873;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat16_31 = u_xlat3.x * u_xlat3.x;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_3 = u_xlat16_31 * 0.00766834244 + 0.0399999991;
    u_xlat16_23 = u_xlat16_3 * u_xlat16_13;
    u_xlat16_3 = u_xlat16_13 * u_xlat16_3 + 2.0;
    u_xlat16_3 = u_xlat16_23 / u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _LightColor0.xyz;
    u_xlat16_9.xyz = vec3(u_xlat33) * u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + u_xlat16_8.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_11.x = (-u_xlat10.x) + 1.0;
    u_xlat16_11.x = max(u_xlat16_11.x, 9.99999975e-05);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * 0.200000003;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat10.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat10.x = u_xlat10.x / _FarFadeLength;
    u_xlat16_21 = (-u_xlat10.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_8.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_31 = u_xlat16_31 / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_1.x = u_xlat16_31 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0 = u_xlat16_1.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_11.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_21 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    SV_Target0.w = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
lowp float u_xlat10_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat13;
mediump float u_xlat16_13;
mediump float u_xlat16_21;
float u_xlat23;
mediump float u_xlat16_23;
mediump float u_xlat16_31;
float u_xlat33;
lowp float u_xlat10_33;
int u_xlati33;
uint u_xlatu33;
bool u_xlatb33;
float u_xlat35;
void main()
{
    u_xlat0 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat0) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_11.xy);
    u_xlat16_31 = abs(u_xlat0) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_31) + 1.0;
    u_xlat16_11.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_11.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat16_11.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_31;
    u_xlat10_10 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_0 = u_xlat10_10 * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_0 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_11.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_11.xyz + _CloudColorA.xyz;
    u_xlat10.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD6.xyz;
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat3.x = vs_TEXCOORD7.x;
    u_xlat3.y = vs_TEXCOORD9.x;
    u_xlat3.z = vs_TEXCOORD8.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.y;
    u_xlat4.y = vs_TEXCOORD9.y;
    u_xlat4.z = vs_TEXCOORD8.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.z;
    u_xlat4.y = vs_TEXCOORD9.z;
    u_xlat4.z = vs_TEXCOORD8.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat33 = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_31 = (-u_xlat33) + 1.0;
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimThreshold;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.w = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_31 = u_xlat2.y + u_xlat2.x;
    u_xlat16_8.x = u_xlat2.z + u_xlat16_31;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.z = (-u_xlat16_31);
    u_xlat4.w = (-u_xlat16_8.x);
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_31 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat16_31>=0.5);
#else
    u_xlatb33 = u_xlat16_31>=0.5;
#endif
    if(u_xlatb33){
        u_xlat33 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat33 = min(u_xlat33, 3.0);
        u_xlatu33 = uint(u_xlat33);
        u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu33)].xyz);
        u_xlati33 = int(u_xlatu33) << 2;
        u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 1)].xyz;
        u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati33].xyz * u_xlat4.xxx + u_xlat5.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 2)].xyz * u_xlat4.zzz + u_xlat4.xyw;
        u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
        u_xlat10_33 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_4.x = (-_LightShadowData.x) + 1.0;
        u_xlat33 = u_xlat10_33 * u_xlat16_4.x + _LightShadowData.x;
    } else {
        u_xlat33 = 1.0;
    //ENDIF
    }
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_2.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_31 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_31 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_31);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_31) + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xxx;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat35 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat16_31 = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_31) * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_9.xyz = u_xlat5.xyz * vec3(u_xlat35) + u_xlat3.xyz;
    u_xlat16_31 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_9.xyz = vec3(u_xlat16_31) * u_xlat16_9.xyz;
    u_xlat16_5 = dot(u_xlat16_2.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_13 = u_xlat16_13 * -0.00399392843 + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = 0.996006072 / u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * 0.318309873;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat16_31 = u_xlat3.x * u_xlat3.x;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_3 = u_xlat16_31 * 0.00766834244 + 0.0399999991;
    u_xlat16_23 = u_xlat16_3 * u_xlat16_13;
    u_xlat16_3 = u_xlat16_13 * u_xlat16_3 + 2.0;
    u_xlat16_3 = u_xlat16_23 / u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _LightColor0.xyz;
    u_xlat16_9.xyz = vec3(u_xlat33) * u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + u_xlat16_8.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat3.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD10.w);
    u_xlat13.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat23 = (-u_xlat13.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat23 + u_xlat13.x;
    u_xlat13.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat13.x = inversesqrt(u_xlat13.x);
    u_xlat13.xyz = u_xlat13.xxx * vs_TEXCOORD8.xyz;
    u_xlat10.x = dot(u_xlat13.xyz, u_xlat10.xyz);
    u_xlat16_11.x = (-u_xlat10.x) + 1.0;
    u_xlat16_11.x = max(u_xlat16_11.x, 9.99999975e-05);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * 0.200000003;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat10.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat10.x = u_xlat10.x / _FarFadeLength;
    u_xlat16_21 = (-u_xlat10.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_8.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_31 = u_xlat16_31 / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_1.x = u_xlat16_31 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0 = u_xlat3.x * u_xlat16_1.x;
    u_xlat0 = u_xlat0 * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_11.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_21 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    SV_Target0.w = u_xlat0;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * u_xlat3.xxx;
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    vs_TEXCOORD7.xyz = u_xlat4.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat2.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
lowp float u_xlat10_10;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_13;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
mediump float u_xlat16_31;
float u_xlat33;
lowp float u_xlat10_33;
int u_xlati33;
uint u_xlatu33;
bool u_xlatb33;
float u_xlat35;
void main()
{
    u_xlat0 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat0) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_11.xy);
    u_xlat16_31 = abs(u_xlat0) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_31) + 1.0;
    u_xlat16_11.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_11.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat16_11.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_31;
    u_xlat10_10 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_0 = u_xlat10_10 * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_0 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_11.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_11.xyz + _CloudColorA.xyz;
    u_xlat10.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD6.xyz;
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat3.x = vs_TEXCOORD7.x;
    u_xlat3.y = vs_TEXCOORD9.x;
    u_xlat3.z = vs_TEXCOORD8.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.y;
    u_xlat4.y = vs_TEXCOORD9.y;
    u_xlat4.z = vs_TEXCOORD8.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.z;
    u_xlat4.y = vs_TEXCOORD9.z;
    u_xlat4.z = vs_TEXCOORD8.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat33 = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_31 = (-u_xlat33) + 1.0;
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimThreshold;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.w = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_31 = u_xlat2.y + u_xlat2.x;
    u_xlat16_8.x = u_xlat2.z + u_xlat16_31;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.z = (-u_xlat16_31);
    u_xlat4.w = (-u_xlat16_8.x);
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_31 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat16_31>=0.5);
#else
    u_xlatb33 = u_xlat16_31>=0.5;
#endif
    if(u_xlatb33){
        u_xlat33 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat33 = min(u_xlat33, 3.0);
        u_xlatu33 = uint(u_xlat33);
        u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu33)].xyz);
        u_xlati33 = int(u_xlatu33) << 2;
        u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 1)].xyz;
        u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati33].xyz * u_xlat4.xxx + u_xlat5.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 2)].xyz * u_xlat4.zzz + u_xlat4.xyw;
        u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
        u_xlat10_33 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_4.x = (-_LightShadowData.x) + 1.0;
        u_xlat33 = u_xlat10_33 * u_xlat16_4.x + _LightShadowData.x;
    } else {
        u_xlat33 = 1.0;
    //ENDIF
    }
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_2.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_31 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_31 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_31);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_31) + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xxx;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat35 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat16_31 = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_31) * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_9.xyz = u_xlat5.xyz * vec3(u_xlat35) + u_xlat3.xyz;
    u_xlat16_31 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_9.xyz = vec3(u_xlat16_31) * u_xlat16_9.xyz;
    u_xlat16_5 = dot(u_xlat16_2.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_13 = u_xlat16_13 * -0.00399392843 + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = 0.996006072 / u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * 0.318309873;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat16_31 = u_xlat3.x * u_xlat3.x;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_3 = u_xlat16_31 * 0.00766834244 + 0.0399999991;
    u_xlat16_23 = u_xlat16_3 * u_xlat16_13;
    u_xlat16_3 = u_xlat16_13 * u_xlat16_3 + 2.0;
    u_xlat16_3 = u_xlat16_23 / u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _LightColor0.xyz;
    u_xlat16_9.xyz = vec3(u_xlat33) * u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + u_xlat16_8.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_11.x = (-u_xlat10.x) + 1.0;
    u_xlat16_11.x = max(u_xlat16_11.x, 9.99999975e-05);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * 0.200000003;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat10.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat10.x = u_xlat10.x / _FarFadeLength;
    u_xlat16_21 = (-u_xlat10.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_8.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_31 = u_xlat16_31 / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_1.x = u_xlat16_31 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0 = u_xlat16_1.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_11.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_21 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    SV_Target0.w = u_xlat0;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * u_xlat3.xxx;
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    vs_TEXCOORD7.xyz = u_xlat4.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat2.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump float u_xlat16_3;
lowp vec3 u_xlat10_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
lowp float u_xlat10_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat13;
mediump float u_xlat16_13;
mediump float u_xlat16_21;
float u_xlat23;
mediump float u_xlat16_23;
mediump float u_xlat16_31;
float u_xlat33;
lowp float u_xlat10_33;
int u_xlati33;
uint u_xlatu33;
bool u_xlatb33;
float u_xlat35;
void main()
{
    u_xlat0 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat0) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_11.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_11.xy);
    u_xlat16_31 = abs(u_xlat0) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_31) + 1.0;
    u_xlat16_11.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_11.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat16_11.xy).x;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_31;
    u_xlat10_10 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_0 = u_xlat10_10 * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_0 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_11.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_11.xyz + _CloudColorA.xyz;
    u_xlat10.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * vs_TEXCOORD6.xyz;
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat3.x = vs_TEXCOORD7.x;
    u_xlat3.y = vs_TEXCOORD9.x;
    u_xlat3.z = vs_TEXCOORD8.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.y;
    u_xlat4.y = vs_TEXCOORD9.y;
    u_xlat4.z = vs_TEXCOORD8.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat4.x = vs_TEXCOORD7.z;
    u_xlat4.y = vs_TEXCOORD9.z;
    u_xlat4.z = vs_TEXCOORD8.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat33 = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat16_31 = (-u_xlat33) + 1.0;
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimThreshold;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_31 = u_xlat16_31 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.w = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_31 = u_xlat2.y + u_xlat2.x;
    u_xlat16_8.x = u_xlat2.z + u_xlat16_31;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.z = (-u_xlat16_31);
    u_xlat4.w = (-u_xlat16_8.x);
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_31 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat16_31>=0.5);
#else
    u_xlatb33 = u_xlat16_31>=0.5;
#endif
    if(u_xlatb33){
        u_xlat33 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat33 = min(u_xlat33, 3.0);
        u_xlatu33 = uint(u_xlat33);
        u_xlat4.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu33)].xyz);
        u_xlati33 = int(u_xlatu33) << 2;
        u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 1)].xyz;
        u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati33].xyz * u_xlat4.xxx + u_xlat5.xyz;
        u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 2)].xyz * u_xlat4.zzz + u_xlat4.xyw;
        u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat4.xy,u_xlat4.z);
        u_xlat10_33 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_4.x = (-_LightShadowData.x) + 1.0;
        u_xlat33 = u_xlat10_33 * u_xlat16_4.x + _LightShadowData.x;
    } else {
        u_xlat33 = 1.0;
    //ENDIF
    }
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_2.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_31 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_31 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_31);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_31) + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat5.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xxx;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat35 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat35 = inversesqrt(u_xlat35);
    u_xlat16_31 = dot(u_xlat16_2.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_31) * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_9.xyz * vec3(u_xlat33) + u_xlat16_8.xyz;
    u_xlat16_9.xyz = u_xlat5.xyz * vec3(u_xlat35) + u_xlat3.xyz;
    u_xlat16_31 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_9.xyz = vec3(u_xlat16_31) * u_xlat16_9.xyz;
    u_xlat16_5 = dot(u_xlat16_2.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_13 = u_xlat16_13 * -0.00399392843 + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = 0.996006072 / u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * 0.318309873;
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat16_31 = u_xlat3.x * u_xlat3.x;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_31 = u_xlat3.x * u_xlat16_31;
    u_xlat16_3 = u_xlat16_31 * 0.00766834244 + 0.0399999991;
    u_xlat16_23 = u_xlat16_3 * u_xlat16_13;
    u_xlat16_3 = u_xlat16_13 * u_xlat16_3 + 2.0;
    u_xlat16_3 = u_xlat16_23 / u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 + u_xlat16_3;
    u_xlat16_9.xyz = vec3(u_xlat16_3) * _LightColor0.xyz;
    u_xlat16_9.xyz = vec3(u_xlat33) * u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + u_xlat16_8.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_8.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat3.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD10.w);
    u_xlat13.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat23 = (-u_xlat13.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat23 + u_xlat13.x;
    u_xlat13.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat13.x = inversesqrt(u_xlat13.x);
    u_xlat13.xyz = u_xlat13.xxx * vs_TEXCOORD8.xyz;
    u_xlat10.x = dot(u_xlat13.xyz, u_xlat10.xyz);
    u_xlat16_11.x = (-u_xlat10.x) + 1.0;
    u_xlat16_11.x = max(u_xlat16_11.x, 9.99999975e-05);
    u_xlat16_11.x = log2(u_xlat16_11.x);
    u_xlat16_11.x = u_xlat16_11.x * 0.200000003;
    u_xlat16_11.x = exp2(u_xlat16_11.x);
    u_xlat10.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat10.x = u_xlat10.x / _FarFadeLength;
    u_xlat16_21 = (-u_xlat10.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_31 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_8.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_31 = u_xlat16_31 / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_31 = max(u_xlat16_31, 9.99999975e-05);
    u_xlat16_31 = log2(u_xlat16_31);
    u_xlat16_1.x = u_xlat16_31 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0 = u_xlat3.x * u_xlat16_1.x;
    u_xlat0 = u_xlat0 * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_11.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_21 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    SV_Target0.w = u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec4 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
bool u_xlatb11;
bool u_xlatb12;
bvec3 u_xlatb13;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_15;
mediump float u_xlat16_16;
int u_xlati16;
bool u_xlatb16;
mediump vec3 u_xlat16_17;
vec3 u_xlat23;
bool u_xlatb24;
bool u_xlatb27;
bool u_xlatb28;
float u_xlat32;
mediump float u_xlat16_32;
lowp float u_xlat10_32;
bool u_xlatb32;
mediump float u_xlat16_33;
bool u_xlatb40;
bool u_xlatb43;
bool u_xlatb44;
float u_xlat48;
lowp float u_xlat10_48;
int u_xlati48;
uint u_xlatu48;
bool u_xlatb48;
mediump float u_xlat16_49;
float u_xlat51;
mediump float u_xlat16_51;
bool u_xlatb53;
bool u_xlatb54;
bool u_xlatb56;
bool u_xlatb59;
bool u_xlatb60;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb32 = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb32){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat32 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat32) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_17.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_17.xy);
    u_xlat16_49 = abs(u_xlat32) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = (-u_xlat16_49) + 1.0;
    u_xlat16_17.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_17.xy;
    u_xlat10_32 = texture(_CloudTex, u_xlat16_17.xy).x;
    u_xlat16_32 = u_xlat10_32 * u_xlat16_49;
    u_xlat10_48 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_32 = u_xlat10_48 * u_xlat16_32;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_32 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_17.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_17.xyz + _CloudColorA.xyz;
    u_xlat48 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat48 = inversesqrt(u_xlat48);
    u_xlat3.xyz = vec3(u_xlat48) * vs_TEXCOORD6.xyz;
    u_xlat10_4.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat4.x = vs_TEXCOORD7.x;
    u_xlat4.y = vs_TEXCOORD9.x;
    u_xlat4.z = vs_TEXCOORD8.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.y;
    u_xlat5.y = vs_TEXCOORD9.y;
    u_xlat5.z = vs_TEXCOORD8.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.z;
    u_xlat5.y = vs_TEXCOORD9.z;
    u_xlat5.z = vs_TEXCOORD8.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat48 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_49 = (-u_xlat48) + 1.0;
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimThreshold;
    u_xlat16_49 = exp2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_49) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat8.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.w = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_49 = u_xlat2.y + u_xlat2.x;
    u_xlat16_9.x = u_xlat2.z + u_xlat16_49;
    u_xlat5.x = -0.0;
    u_xlat5.y = (-u_xlat2.x);
    u_xlat5.z = (-u_xlat16_49);
    u_xlat5.w = (-u_xlat16_9.x);
    u_xlat2 = u_xlat2 + u_xlat5;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_49 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat16_49>=0.5);
#else
    u_xlatb48 = u_xlat16_49>=0.5;
#endif
    if(u_xlatb48){
        u_xlat48 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat48 = min(u_xlat48, 3.0);
        u_xlatu48 = uint(u_xlat48);
        u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu48)].xyz);
        u_xlati48 = int(u_xlatu48) << 2;
        u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 1)].xyz;
        u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati48].xyz * u_xlat5.xxx + u_xlat6.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
        u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
        u_xlat10_48 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_51 = (-_LightShadowData.x) + 1.0;
        u_xlat48 = u_xlat10_48 * u_xlat16_51 + _LightShadowData.x;
    } else {
        u_xlat48 = 1.0;
    //ENDIF
    }
    u_xlat16_49 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_2.xyz = vec3(u_xlat16_49) * u_xlat4.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_49 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_49 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_49);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_49) + u_xlat16_10.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat51 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
    u_xlat5.xyz = vec3(u_xlat51) * u_xlat5.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat51 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
#ifdef UNITY_ADRENO_ES3
    u_xlatb53 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb53 = unity_DebugViewInfo.x==1.0;
#endif
    if(!u_xlatb53){
#ifdef UNITY_ADRENO_ES3
        u_xlatb54 = !!(unity_DebugViewInfo.x==2.0);
#else
        u_xlatb54 = unity_DebugViewInfo.x==2.0;
#endif
        u_xlat16_10.xyz = (bool(u_xlatb54)) ? vec3(0.0399999991, 0.0399999991, 0.0399999991) : u_xlat16_1.xyz;
        if(!u_xlatb54){
#ifdef UNITY_ADRENO_ES3
            u_xlatb7 = !!(unity_DebugViewInfo.x==3.0);
#else
            u_xlatb7 = unity_DebugViewInfo.x==3.0;
#endif
            u_xlat16_10.xyz = (bool(u_xlatb7)) ? vec3(0.000999987125, 0.000999987125, 0.000999987125) : u_xlat16_10.xyz;
            if(!u_xlatb7){
                u_xlat23.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                u_xlatb8 = !!(unity_DebugViewInfo.x==4.0);
#else
                u_xlatb8 = unity_DebugViewInfo.x==4.0;
#endif
                if(!u_xlatb8){
#ifdef UNITY_ADRENO_ES3
                    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
                    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
                    if(!u_xlatb24){
#ifdef UNITY_ADRENO_ES3
                        u_xlatb40 = !!(unity_DebugViewInfo.x==6.0);
#else
                        u_xlatb40 = unity_DebugViewInfo.x==6.0;
#endif
                        if(!u_xlatb40){
#ifdef UNITY_ADRENO_ES3
                            u_xlatb56 = !!(unity_DebugViewInfo.x==7.0);
#else
                            u_xlatb56 = unity_DebugViewInfo.x==7.0;
#endif
                            if(!u_xlatb56){
#ifdef UNITY_ADRENO_ES3
                                u_xlatb11 = !!(unity_DebugViewInfo.x==8.0);
#else
                                u_xlatb11 = unity_DebugViewInfo.x==8.0;
#endif
                                u_xlat16_10.xyz = (bool(u_xlatb11)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                if(!u_xlatb11){
#ifdef UNITY_ADRENO_ES3
                                    u_xlatb27 = !!(unity_DebugViewInfo.x==9.0);
#else
                                    u_xlatb27 = unity_DebugViewInfo.x==9.0;
#endif
                                    u_xlat16_10.xyz = (bool(u_xlatb27)) ? vec3(u_xlat48) : u_xlat16_10.xyz;
                                    if(!u_xlatb27){
#ifdef UNITY_ADRENO_ES3
                                        u_xlatb43 = !!(unity_DebugViewInfo.x==10.0);
#else
                                        u_xlatb43 = unity_DebugViewInfo.x==10.0;
#endif
                                        if(!u_xlatb43){
#ifdef UNITY_ADRENO_ES3
                                            u_xlatb59 = !!(unity_DebugViewInfo.x==11.0);
#else
                                            u_xlatb59 = unity_DebugViewInfo.x==11.0;
#endif
                                            u_xlat16_10.xyz = (bool(u_xlatb59)) ? vec3(1.0, 1.0, 1.0) : u_xlat16_10.xyz;
                                            if(!u_xlatb59){
#ifdef UNITY_ADRENO_ES3
                                                u_xlatb12 = !!(unity_DebugViewInfo.x==12.0);
#else
                                                u_xlatb12 = unity_DebugViewInfo.x==12.0;
#endif
                                                u_xlat16_10.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                if(!u_xlatb12){
#ifdef UNITY_ADRENO_ES3
                                                    u_xlatb28 = !!(unity_DebugViewInfo.x==13.0);
#else
                                                    u_xlatb28 = unity_DebugViewInfo.x==13.0;
#endif
                                                    u_xlat16_10.xyz = (bool(u_xlatb28)) ? vec3(0.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                    if(!u_xlatb28){
#ifdef UNITY_ADRENO_ES3
                                                        u_xlatb44 = !!(unity_DebugViewInfo.x==51.0);
#else
                                                        u_xlatb44 = unity_DebugViewInfo.x==51.0;
#endif
                                                        u_xlat16_10.xyz = (bool(u_xlatb44)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                                        if(!u_xlatb44){
                                                            if(!u_xlatb0.x){
                                                                u_xlatb13.xyz = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 151.0, 0.0)).xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_10.xyz;
                                                                u_xlatb60 = u_xlatb0.y || u_xlatb13.y;
                                                                u_xlat16_15.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.z || u_xlatb60;
                                                                u_xlat16_14.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.y) ? u_xlat16_15.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.y || u_xlatb13.z;
                                                                u_xlat16_14.xyz = (u_xlatb0.y) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb16 = u_xlatb0.y || u_xlatb60;
                                                                u_xlat16_10.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_14.xyz;
                                                                u_xlati16 = int(uint(u_xlatb13.x) * 0xffffffffu | uint(u_xlatb16) * 0xffffffffu);
                                                            } else {
                                                                u_xlat16_10.x = float(0.200000003);
                                                                u_xlat16_10.y = float(0.200000003);
                                                                u_xlat16_10.z = float(0.200000003);
                                                                u_xlati16 = -1;
                                                            //ENDIF
                                                            }
                                                            u_xlati0 = int(uint(u_xlatb0.x) * 0xffffffffu | uint(u_xlati16));
                                                        } else {
                                                            u_xlati0 = -1;
                                                        //ENDIF
                                                        }
                                                        u_xlati0 = int(uint(u_xlatb44) * 0xffffffffu | uint(u_xlati0));
                                                    } else {
                                                        u_xlati0 = -1;
                                                    //ENDIF
                                                    }
                                                    u_xlati0 = int(uint(u_xlatb28) * 0xffffffffu | uint(u_xlati0));
                                                } else {
                                                    u_xlati0 = -1;
                                                //ENDIF
                                                }
                                                u_xlati0 = int(uint(u_xlatb12) * 0xffffffffu | uint(u_xlati0));
                                            } else {
                                                u_xlati0 = -1;
                                            //ENDIF
                                            }
                                            u_xlati0 = int(uint(u_xlatb59) * 0xffffffffu | uint(u_xlati0));
                                        } else {
                                            u_xlat16_10.x = float(1.0);
                                            u_xlat16_10.y = float(1.0);
                                            u_xlat16_10.z = float(1.0);
                                            u_xlati0 = -1;
                                        //ENDIF
                                        }
                                        u_xlati0 = int(uint(u_xlatb43) * 0xffffffffu | uint(u_xlati0));
                                    } else {
                                        u_xlati0 = -1;
                                    //ENDIF
                                    }
                                    u_xlati0 = int(uint(u_xlatb27) * 0xffffffffu | uint(u_xlati0));
                                } else {
                                    u_xlati0 = -1;
                                //ENDIF
                                }
                                u_xlati0 = int(uint(u_xlatb11) * 0xffffffffu | uint(u_xlati0));
                            } else {
                                u_xlat16_10.xyz = u_xlat23.xyz;
                                u_xlati0 = -1;
                            //ENDIF
                            }
                            u_xlati0 = int(uint(u_xlatb56) * 0xffffffffu | uint(u_xlati0));
                        } else {
                            u_xlat16_10.xyz = u_xlat23.xyz;
                            u_xlati0 = -1;
                        //ENDIF
                        }
                        u_xlati0 = int(uint(u_xlatb40) * 0xffffffffu | uint(u_xlati0));
                    } else {
                        u_xlat16_10.xyz = u_xlat23.xyz;
                        u_xlati0 = -1;
                    //ENDIF
                    }
                    u_xlati0 = int(uint(u_xlatb24) * 0xffffffffu | uint(u_xlati0));
                } else {
                    u_xlat16_10.xyz = u_xlat23.xyz;
                    u_xlati0 = -1;
                //ENDIF
                }
                u_xlati0 = int(uint(u_xlatb8) * 0xffffffffu | uint(u_xlati0));
            } else {
                u_xlati0 = -1;
            //ENDIF
            }
            u_xlati0 = int(uint(u_xlatb7) * 0xffffffffu | uint(u_xlati0));
        } else {
            u_xlati0 = -1;
        //ENDIF
        }
        u_xlati0 = int(uint(u_xlatb54) * 0xffffffffu | uint(u_xlati0));
    } else {
        u_xlat16_10.xyz = u_xlat16_1.xyz;
        u_xlati0 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb53) * 0xffffffffu | uint(u_xlati0));
    u_xlat16_49 = dot(u_xlat16_2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_14.xyz = vec3(u_xlat16_49) * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_14.xyz * vec3(u_xlat48) + u_xlat16_9.xyz;
    u_xlat16_14.xyz = u_xlat6.xyz * vec3(u_xlat51) + u_xlat5.xyz;
    u_xlat16_49 = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_14.xyz = vec3(u_xlat16_49) * u_xlat16_14.xyz;
    u_xlat16_16 = dot(u_xlat16_2.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat51 = dot(u_xlat5.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat51 = min(max(u_xlat51, 0.0), 1.0);
#else
    u_xlat51 = clamp(u_xlat51, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * -0.00399392843 + 1.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = 0.996006072 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * 0.318309873;
    u_xlat51 = (-u_xlat51) + 1.0;
    u_xlat16_49 = u_xlat51 * u_xlat51;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_51 = u_xlat16_49 * 0.00766834244 + 0.0399999991;
    u_xlat16_5 = u_xlat16_16 * u_xlat16_51;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_51 + 2.0;
    u_xlat16_16 = u_xlat16_5 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_14.xyz = vec3(u_xlat16_16) * _LightColor0.xyz;
    u_xlat16_14.xyz = vec3(u_xlat48) * u_xlat16_14.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_1.xyz + u_xlat16_14.xyz;
    u_xlat16_9.xyz = (int(u_xlati0) != 0) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat16_9.xyz = (-u_xlat16_1.xyz) + u_xlat16_9.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat0.x = dot(u_xlat0.xyw, u_xlat3.xyz);
    u_xlat16_17.x = (-u_xlat0.x) + 1.0;
    u_xlat16_17.x = max(u_xlat16_17.x, 9.99999975e-05);
    u_xlat16_17.x = log2(u_xlat16_17.x);
    u_xlat16_17.x = u_xlat16_17.x * 0.200000003;
    u_xlat16_17.x = exp2(u_xlat16_17.x);
    u_xlat0.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x / _FarFadeLength;
    u_xlat16_33 = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_49 = u_xlat16_32 + (-_CloudTexThreshold);
    u_xlat16_9.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_49 = u_xlat16_49 / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_1.x = u_xlat16_49 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_17.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_33 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec4 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
bool u_xlatb11;
bool u_xlatb12;
bvec3 u_xlatb13;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
bool u_xlatb16;
mediump vec3 u_xlat16_17;
vec3 u_xlat23;
bool u_xlatb24;
bool u_xlatb27;
bool u_xlatb28;
float u_xlat32;
mediump float u_xlat16_32;
lowp float u_xlat10_32;
bool u_xlatb32;
mediump float u_xlat16_33;
bool u_xlatb40;
bool u_xlatb43;
bool u_xlatb44;
float u_xlat48;
lowp float u_xlat10_48;
int u_xlati48;
uint u_xlatu48;
bool u_xlatb48;
mediump float u_xlat16_49;
float u_xlat51;
mediump float u_xlat16_51;
bool u_xlatb53;
bool u_xlatb54;
bool u_xlatb56;
bool u_xlatb59;
bool u_xlatb60;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb32 = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb32){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat32 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat32) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_17.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_17.xy);
    u_xlat16_49 = abs(u_xlat32) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = (-u_xlat16_49) + 1.0;
    u_xlat16_17.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_17.xy;
    u_xlat10_32 = texture(_CloudTex, u_xlat16_17.xy).x;
    u_xlat16_32 = u_xlat10_32 * u_xlat16_49;
    u_xlat10_48 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_32 = u_xlat10_48 * u_xlat16_32;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_32 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_17.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_17.xyz + _CloudColorA.xyz;
    u_xlat48 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat48 = inversesqrt(u_xlat48);
    u_xlat3.xyz = vec3(u_xlat48) * vs_TEXCOORD6.xyz;
    u_xlat10_4.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat4.x = vs_TEXCOORD7.x;
    u_xlat4.y = vs_TEXCOORD9.x;
    u_xlat4.z = vs_TEXCOORD8.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.y;
    u_xlat5.y = vs_TEXCOORD9.y;
    u_xlat5.z = vs_TEXCOORD8.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.z;
    u_xlat5.y = vs_TEXCOORD9.z;
    u_xlat5.z = vs_TEXCOORD8.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat48 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_49 = (-u_xlat48) + 1.0;
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimThreshold;
    u_xlat16_49 = exp2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_49) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat8.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.w = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_49 = u_xlat2.y + u_xlat2.x;
    u_xlat16_9.x = u_xlat2.z + u_xlat16_49;
    u_xlat5.x = -0.0;
    u_xlat5.y = (-u_xlat2.x);
    u_xlat5.z = (-u_xlat16_49);
    u_xlat5.w = (-u_xlat16_9.x);
    u_xlat2 = u_xlat2 + u_xlat5;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_49 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat16_49>=0.5);
#else
    u_xlatb48 = u_xlat16_49>=0.5;
#endif
    if(u_xlatb48){
        u_xlat48 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat48 = min(u_xlat48, 3.0);
        u_xlatu48 = uint(u_xlat48);
        u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu48)].xyz);
        u_xlati48 = int(u_xlatu48) << 2;
        u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 1)].xyz;
        u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati48].xyz * u_xlat5.xxx + u_xlat6.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
        u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
        u_xlat10_48 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_51 = (-_LightShadowData.x) + 1.0;
        u_xlat48 = u_xlat10_48 * u_xlat16_51 + _LightShadowData.x;
    } else {
        u_xlat48 = 1.0;
    //ENDIF
    }
    u_xlat16_49 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_2.xyz = vec3(u_xlat16_49) * u_xlat4.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_49 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_49 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_49);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_49) + u_xlat16_10.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat51 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
    u_xlat5.xyz = vec3(u_xlat51) * u_xlat5.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat51 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
#ifdef UNITY_ADRENO_ES3
    u_xlatb53 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb53 = unity_DebugViewInfo.x==1.0;
#endif
    if(!u_xlatb53){
#ifdef UNITY_ADRENO_ES3
        u_xlatb54 = !!(unity_DebugViewInfo.x==2.0);
#else
        u_xlatb54 = unity_DebugViewInfo.x==2.0;
#endif
        u_xlat16_10.xyz = (bool(u_xlatb54)) ? vec3(0.0399999991, 0.0399999991, 0.0399999991) : u_xlat16_1.xyz;
        if(!u_xlatb54){
#ifdef UNITY_ADRENO_ES3
            u_xlatb7 = !!(unity_DebugViewInfo.x==3.0);
#else
            u_xlatb7 = unity_DebugViewInfo.x==3.0;
#endif
            u_xlat16_10.xyz = (bool(u_xlatb7)) ? vec3(0.000999987125, 0.000999987125, 0.000999987125) : u_xlat16_10.xyz;
            if(!u_xlatb7){
                u_xlat23.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                u_xlatb8 = !!(unity_DebugViewInfo.x==4.0);
#else
                u_xlatb8 = unity_DebugViewInfo.x==4.0;
#endif
                if(!u_xlatb8){
#ifdef UNITY_ADRENO_ES3
                    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
                    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
                    if(!u_xlatb24){
#ifdef UNITY_ADRENO_ES3
                        u_xlatb40 = !!(unity_DebugViewInfo.x==6.0);
#else
                        u_xlatb40 = unity_DebugViewInfo.x==6.0;
#endif
                        if(!u_xlatb40){
#ifdef UNITY_ADRENO_ES3
                            u_xlatb56 = !!(unity_DebugViewInfo.x==7.0);
#else
                            u_xlatb56 = unity_DebugViewInfo.x==7.0;
#endif
                            if(!u_xlatb56){
#ifdef UNITY_ADRENO_ES3
                                u_xlatb11 = !!(unity_DebugViewInfo.x==8.0);
#else
                                u_xlatb11 = unity_DebugViewInfo.x==8.0;
#endif
                                u_xlat16_10.xyz = (bool(u_xlatb11)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                if(!u_xlatb11){
#ifdef UNITY_ADRENO_ES3
                                    u_xlatb27 = !!(unity_DebugViewInfo.x==9.0);
#else
                                    u_xlatb27 = unity_DebugViewInfo.x==9.0;
#endif
                                    u_xlat16_10.xyz = (bool(u_xlatb27)) ? vec3(u_xlat48) : u_xlat16_10.xyz;
                                    if(!u_xlatb27){
#ifdef UNITY_ADRENO_ES3
                                        u_xlatb43 = !!(unity_DebugViewInfo.x==10.0);
#else
                                        u_xlatb43 = unity_DebugViewInfo.x==10.0;
#endif
                                        if(!u_xlatb43){
#ifdef UNITY_ADRENO_ES3
                                            u_xlatb59 = !!(unity_DebugViewInfo.x==11.0);
#else
                                            u_xlatb59 = unity_DebugViewInfo.x==11.0;
#endif
                                            u_xlat16_10.xyz = (bool(u_xlatb59)) ? vec3(1.0, 1.0, 1.0) : u_xlat16_10.xyz;
                                            if(!u_xlatb59){
#ifdef UNITY_ADRENO_ES3
                                                u_xlatb12 = !!(unity_DebugViewInfo.x==12.0);
#else
                                                u_xlatb12 = unity_DebugViewInfo.x==12.0;
#endif
                                                u_xlat16_10.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                if(!u_xlatb12){
#ifdef UNITY_ADRENO_ES3
                                                    u_xlatb28 = !!(unity_DebugViewInfo.x==13.0);
#else
                                                    u_xlatb28 = unity_DebugViewInfo.x==13.0;
#endif
                                                    u_xlat16_10.xyz = (bool(u_xlatb28)) ? vec3(0.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                    if(!u_xlatb28){
#ifdef UNITY_ADRENO_ES3
                                                        u_xlatb44 = !!(unity_DebugViewInfo.x==51.0);
#else
                                                        u_xlatb44 = unity_DebugViewInfo.x==51.0;
#endif
                                                        u_xlat16_10.xyz = (bool(u_xlatb44)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                                        if(!u_xlatb44){
                                                            if(!u_xlatb0.x){
                                                                u_xlatb13.xyz = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 151.0, 0.0)).xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_10.xyz;
                                                                u_xlatb60 = u_xlatb0.y || u_xlatb13.y;
                                                                u_xlat16_15.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.z || u_xlatb60;
                                                                u_xlat16_14.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.y) ? u_xlat16_15.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.y || u_xlatb13.z;
                                                                u_xlat16_14.xyz = (u_xlatb0.y) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb16 = u_xlatb0.y || u_xlatb60;
                                                                u_xlat16_10.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_14.xyz;
                                                                u_xlati16 = int(uint(u_xlatb13.x) * 0xffffffffu | uint(u_xlatb16) * 0xffffffffu);
                                                            } else {
                                                                u_xlat16_10.x = float(0.200000003);
                                                                u_xlat16_10.y = float(0.200000003);
                                                                u_xlat16_10.z = float(0.200000003);
                                                                u_xlati16 = -1;
                                                            //ENDIF
                                                            }
                                                            u_xlati0 = int(uint(u_xlatb0.x) * 0xffffffffu | uint(u_xlati16));
                                                        } else {
                                                            u_xlati0 = -1;
                                                        //ENDIF
                                                        }
                                                        u_xlati0 = int(uint(u_xlatb44) * 0xffffffffu | uint(u_xlati0));
                                                    } else {
                                                        u_xlati0 = -1;
                                                    //ENDIF
                                                    }
                                                    u_xlati0 = int(uint(u_xlatb28) * 0xffffffffu | uint(u_xlati0));
                                                } else {
                                                    u_xlati0 = -1;
                                                //ENDIF
                                                }
                                                u_xlati0 = int(uint(u_xlatb12) * 0xffffffffu | uint(u_xlati0));
                                            } else {
                                                u_xlati0 = -1;
                                            //ENDIF
                                            }
                                            u_xlati0 = int(uint(u_xlatb59) * 0xffffffffu | uint(u_xlati0));
                                        } else {
                                            u_xlat16_10.x = float(1.0);
                                            u_xlat16_10.y = float(1.0);
                                            u_xlat16_10.z = float(1.0);
                                            u_xlati0 = -1;
                                        //ENDIF
                                        }
                                        u_xlati0 = int(uint(u_xlatb43) * 0xffffffffu | uint(u_xlati0));
                                    } else {
                                        u_xlati0 = -1;
                                    //ENDIF
                                    }
                                    u_xlati0 = int(uint(u_xlatb27) * 0xffffffffu | uint(u_xlati0));
                                } else {
                                    u_xlati0 = -1;
                                //ENDIF
                                }
                                u_xlati0 = int(uint(u_xlatb11) * 0xffffffffu | uint(u_xlati0));
                            } else {
                                u_xlat16_10.xyz = u_xlat23.xyz;
                                u_xlati0 = -1;
                            //ENDIF
                            }
                            u_xlati0 = int(uint(u_xlatb56) * 0xffffffffu | uint(u_xlati0));
                        } else {
                            u_xlat16_10.xyz = u_xlat23.xyz;
                            u_xlati0 = -1;
                        //ENDIF
                        }
                        u_xlati0 = int(uint(u_xlatb40) * 0xffffffffu | uint(u_xlati0));
                    } else {
                        u_xlat16_10.xyz = u_xlat23.xyz;
                        u_xlati0 = -1;
                    //ENDIF
                    }
                    u_xlati0 = int(uint(u_xlatb24) * 0xffffffffu | uint(u_xlati0));
                } else {
                    u_xlat16_10.xyz = u_xlat23.xyz;
                    u_xlati0 = -1;
                //ENDIF
                }
                u_xlati0 = int(uint(u_xlatb8) * 0xffffffffu | uint(u_xlati0));
            } else {
                u_xlati0 = -1;
            //ENDIF
            }
            u_xlati0 = int(uint(u_xlatb7) * 0xffffffffu | uint(u_xlati0));
        } else {
            u_xlati0 = -1;
        //ENDIF
        }
        u_xlati0 = int(uint(u_xlatb54) * 0xffffffffu | uint(u_xlati0));
    } else {
        u_xlat16_10.xyz = u_xlat16_1.xyz;
        u_xlati0 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb53) * 0xffffffffu | uint(u_xlati0));
    u_xlat16_49 = dot(u_xlat16_2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_14.xyz = vec3(u_xlat16_49) * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_14.xyz * vec3(u_xlat48) + u_xlat16_9.xyz;
    u_xlat16_14.xyz = u_xlat6.xyz * vec3(u_xlat51) + u_xlat5.xyz;
    u_xlat16_49 = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_14.xyz = vec3(u_xlat16_49) * u_xlat16_14.xyz;
    u_xlat16_16 = dot(u_xlat16_2.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat51 = dot(u_xlat5.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat51 = min(max(u_xlat51, 0.0), 1.0);
#else
    u_xlat51 = clamp(u_xlat51, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * -0.00399392843 + 1.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = 0.996006072 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * 0.318309873;
    u_xlat51 = (-u_xlat51) + 1.0;
    u_xlat16_49 = u_xlat51 * u_xlat51;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_51 = u_xlat16_49 * 0.00766834244 + 0.0399999991;
    u_xlat16_5 = u_xlat16_16 * u_xlat16_51;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_51 + 2.0;
    u_xlat16_16 = u_xlat16_5 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_14.xyz = vec3(u_xlat16_16) * _LightColor0.xyz;
    u_xlat16_14.xyz = vec3(u_xlat48) * u_xlat16_14.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_1.xyz + u_xlat16_14.xyz;
    u_xlat16_9.xyz = (int(u_xlati0) != 0) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat16_9.xyz = (-u_xlat16_1.xyz) + u_xlat16_9.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat0.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD10.w);
    u_xlat16 = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat48 = (-u_xlat16) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat48 + u_xlat16;
    u_xlat16 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat5.xyz = vec3(u_xlat16) * vs_TEXCOORD8.xyz;
    u_xlat16 = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat16_17.x = (-u_xlat16) + 1.0;
    u_xlat16_17.x = max(u_xlat16_17.x, 9.99999975e-05);
    u_xlat16_17.x = log2(u_xlat16_17.x);
    u_xlat16_17.x = u_xlat16_17.x * 0.200000003;
    u_xlat16_17.x = exp2(u_xlat16_17.x);
    u_xlat16 = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat16 = u_xlat16 / _FarFadeLength;
    u_xlat16_33 = (-u_xlat16) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_49 = u_xlat16_32 + (-_CloudTexThreshold);
    u_xlat16_9.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_49 = u_xlat16_49 / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_1.x = u_xlat16_49 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_17.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_33 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * u_xlat3.xxx;
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    vs_TEXCOORD7.xyz = u_xlat4.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat2.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec4 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
bool u_xlatb11;
bool u_xlatb12;
bvec3 u_xlatb13;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_15;
mediump float u_xlat16_16;
int u_xlati16;
bool u_xlatb16;
mediump vec3 u_xlat16_17;
vec3 u_xlat23;
bool u_xlatb24;
bool u_xlatb27;
bool u_xlatb28;
float u_xlat32;
mediump float u_xlat16_32;
lowp float u_xlat10_32;
bool u_xlatb32;
mediump float u_xlat16_33;
bool u_xlatb40;
bool u_xlatb43;
bool u_xlatb44;
float u_xlat48;
lowp float u_xlat10_48;
int u_xlati48;
uint u_xlatu48;
bool u_xlatb48;
mediump float u_xlat16_49;
float u_xlat51;
mediump float u_xlat16_51;
bool u_xlatb53;
bool u_xlatb54;
bool u_xlatb56;
bool u_xlatb59;
bool u_xlatb60;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb32 = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb32){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat32 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat32) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_17.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_17.xy);
    u_xlat16_49 = abs(u_xlat32) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = (-u_xlat16_49) + 1.0;
    u_xlat16_17.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_17.xy;
    u_xlat10_32 = texture(_CloudTex, u_xlat16_17.xy).x;
    u_xlat16_32 = u_xlat10_32 * u_xlat16_49;
    u_xlat10_48 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_32 = u_xlat10_48 * u_xlat16_32;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_32 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_17.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_17.xyz + _CloudColorA.xyz;
    u_xlat48 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat48 = inversesqrt(u_xlat48);
    u_xlat3.xyz = vec3(u_xlat48) * vs_TEXCOORD6.xyz;
    u_xlat10_4.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat4.x = vs_TEXCOORD7.x;
    u_xlat4.y = vs_TEXCOORD9.x;
    u_xlat4.z = vs_TEXCOORD8.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.y;
    u_xlat5.y = vs_TEXCOORD9.y;
    u_xlat5.z = vs_TEXCOORD8.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.z;
    u_xlat5.y = vs_TEXCOORD9.z;
    u_xlat5.z = vs_TEXCOORD8.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat48 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_49 = (-u_xlat48) + 1.0;
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimThreshold;
    u_xlat16_49 = exp2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_49) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat8.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.w = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_49 = u_xlat2.y + u_xlat2.x;
    u_xlat16_9.x = u_xlat2.z + u_xlat16_49;
    u_xlat5.x = -0.0;
    u_xlat5.y = (-u_xlat2.x);
    u_xlat5.z = (-u_xlat16_49);
    u_xlat5.w = (-u_xlat16_9.x);
    u_xlat2 = u_xlat2 + u_xlat5;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_49 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat16_49>=0.5);
#else
    u_xlatb48 = u_xlat16_49>=0.5;
#endif
    if(u_xlatb48){
        u_xlat48 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat48 = min(u_xlat48, 3.0);
        u_xlatu48 = uint(u_xlat48);
        u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu48)].xyz);
        u_xlati48 = int(u_xlatu48) << 2;
        u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 1)].xyz;
        u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati48].xyz * u_xlat5.xxx + u_xlat6.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
        u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
        u_xlat10_48 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_51 = (-_LightShadowData.x) + 1.0;
        u_xlat48 = u_xlat10_48 * u_xlat16_51 + _LightShadowData.x;
    } else {
        u_xlat48 = 1.0;
    //ENDIF
    }
    u_xlat16_49 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_2.xyz = vec3(u_xlat16_49) * u_xlat4.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_49 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_49 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_49);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_49) + u_xlat16_10.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat51 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
    u_xlat5.xyz = vec3(u_xlat51) * u_xlat5.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat51 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
#ifdef UNITY_ADRENO_ES3
    u_xlatb53 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb53 = unity_DebugViewInfo.x==1.0;
#endif
    if(!u_xlatb53){
#ifdef UNITY_ADRENO_ES3
        u_xlatb54 = !!(unity_DebugViewInfo.x==2.0);
#else
        u_xlatb54 = unity_DebugViewInfo.x==2.0;
#endif
        u_xlat16_10.xyz = (bool(u_xlatb54)) ? vec3(0.0399999991, 0.0399999991, 0.0399999991) : u_xlat16_1.xyz;
        if(!u_xlatb54){
#ifdef UNITY_ADRENO_ES3
            u_xlatb7 = !!(unity_DebugViewInfo.x==3.0);
#else
            u_xlatb7 = unity_DebugViewInfo.x==3.0;
#endif
            u_xlat16_10.xyz = (bool(u_xlatb7)) ? vec3(0.000999987125, 0.000999987125, 0.000999987125) : u_xlat16_10.xyz;
            if(!u_xlatb7){
                u_xlat23.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                u_xlatb8 = !!(unity_DebugViewInfo.x==4.0);
#else
                u_xlatb8 = unity_DebugViewInfo.x==4.0;
#endif
                if(!u_xlatb8){
#ifdef UNITY_ADRENO_ES3
                    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
                    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
                    if(!u_xlatb24){
#ifdef UNITY_ADRENO_ES3
                        u_xlatb40 = !!(unity_DebugViewInfo.x==6.0);
#else
                        u_xlatb40 = unity_DebugViewInfo.x==6.0;
#endif
                        if(!u_xlatb40){
#ifdef UNITY_ADRENO_ES3
                            u_xlatb56 = !!(unity_DebugViewInfo.x==7.0);
#else
                            u_xlatb56 = unity_DebugViewInfo.x==7.0;
#endif
                            if(!u_xlatb56){
#ifdef UNITY_ADRENO_ES3
                                u_xlatb11 = !!(unity_DebugViewInfo.x==8.0);
#else
                                u_xlatb11 = unity_DebugViewInfo.x==8.0;
#endif
                                u_xlat16_10.xyz = (bool(u_xlatb11)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                if(!u_xlatb11){
#ifdef UNITY_ADRENO_ES3
                                    u_xlatb27 = !!(unity_DebugViewInfo.x==9.0);
#else
                                    u_xlatb27 = unity_DebugViewInfo.x==9.0;
#endif
                                    u_xlat16_10.xyz = (bool(u_xlatb27)) ? vec3(u_xlat48) : u_xlat16_10.xyz;
                                    if(!u_xlatb27){
#ifdef UNITY_ADRENO_ES3
                                        u_xlatb43 = !!(unity_DebugViewInfo.x==10.0);
#else
                                        u_xlatb43 = unity_DebugViewInfo.x==10.0;
#endif
                                        if(!u_xlatb43){
#ifdef UNITY_ADRENO_ES3
                                            u_xlatb59 = !!(unity_DebugViewInfo.x==11.0);
#else
                                            u_xlatb59 = unity_DebugViewInfo.x==11.0;
#endif
                                            u_xlat16_10.xyz = (bool(u_xlatb59)) ? vec3(1.0, 1.0, 1.0) : u_xlat16_10.xyz;
                                            if(!u_xlatb59){
#ifdef UNITY_ADRENO_ES3
                                                u_xlatb12 = !!(unity_DebugViewInfo.x==12.0);
#else
                                                u_xlatb12 = unity_DebugViewInfo.x==12.0;
#endif
                                                u_xlat16_10.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                if(!u_xlatb12){
#ifdef UNITY_ADRENO_ES3
                                                    u_xlatb28 = !!(unity_DebugViewInfo.x==13.0);
#else
                                                    u_xlatb28 = unity_DebugViewInfo.x==13.0;
#endif
                                                    u_xlat16_10.xyz = (bool(u_xlatb28)) ? vec3(0.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                    if(!u_xlatb28){
#ifdef UNITY_ADRENO_ES3
                                                        u_xlatb44 = !!(unity_DebugViewInfo.x==51.0);
#else
                                                        u_xlatb44 = unity_DebugViewInfo.x==51.0;
#endif
                                                        u_xlat16_10.xyz = (bool(u_xlatb44)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                                        if(!u_xlatb44){
                                                            if(!u_xlatb0.x){
                                                                u_xlatb13.xyz = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 151.0, 0.0)).xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_10.xyz;
                                                                u_xlatb60 = u_xlatb0.y || u_xlatb13.y;
                                                                u_xlat16_15.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.z || u_xlatb60;
                                                                u_xlat16_14.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.y) ? u_xlat16_15.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.y || u_xlatb13.z;
                                                                u_xlat16_14.xyz = (u_xlatb0.y) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb16 = u_xlatb0.y || u_xlatb60;
                                                                u_xlat16_10.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_14.xyz;
                                                                u_xlati16 = int(uint(u_xlatb13.x) * 0xffffffffu | uint(u_xlatb16) * 0xffffffffu);
                                                            } else {
                                                                u_xlat16_10.x = float(0.200000003);
                                                                u_xlat16_10.y = float(0.200000003);
                                                                u_xlat16_10.z = float(0.200000003);
                                                                u_xlati16 = -1;
                                                            //ENDIF
                                                            }
                                                            u_xlati0 = int(uint(u_xlatb0.x) * 0xffffffffu | uint(u_xlati16));
                                                        } else {
                                                            u_xlati0 = -1;
                                                        //ENDIF
                                                        }
                                                        u_xlati0 = int(uint(u_xlatb44) * 0xffffffffu | uint(u_xlati0));
                                                    } else {
                                                        u_xlati0 = -1;
                                                    //ENDIF
                                                    }
                                                    u_xlati0 = int(uint(u_xlatb28) * 0xffffffffu | uint(u_xlati0));
                                                } else {
                                                    u_xlati0 = -1;
                                                //ENDIF
                                                }
                                                u_xlati0 = int(uint(u_xlatb12) * 0xffffffffu | uint(u_xlati0));
                                            } else {
                                                u_xlati0 = -1;
                                            //ENDIF
                                            }
                                            u_xlati0 = int(uint(u_xlatb59) * 0xffffffffu | uint(u_xlati0));
                                        } else {
                                            u_xlat16_10.x = float(1.0);
                                            u_xlat16_10.y = float(1.0);
                                            u_xlat16_10.z = float(1.0);
                                            u_xlati0 = -1;
                                        //ENDIF
                                        }
                                        u_xlati0 = int(uint(u_xlatb43) * 0xffffffffu | uint(u_xlati0));
                                    } else {
                                        u_xlati0 = -1;
                                    //ENDIF
                                    }
                                    u_xlati0 = int(uint(u_xlatb27) * 0xffffffffu | uint(u_xlati0));
                                } else {
                                    u_xlati0 = -1;
                                //ENDIF
                                }
                                u_xlati0 = int(uint(u_xlatb11) * 0xffffffffu | uint(u_xlati0));
                            } else {
                                u_xlat16_10.xyz = u_xlat23.xyz;
                                u_xlati0 = -1;
                            //ENDIF
                            }
                            u_xlati0 = int(uint(u_xlatb56) * 0xffffffffu | uint(u_xlati0));
                        } else {
                            u_xlat16_10.xyz = u_xlat23.xyz;
                            u_xlati0 = -1;
                        //ENDIF
                        }
                        u_xlati0 = int(uint(u_xlatb40) * 0xffffffffu | uint(u_xlati0));
                    } else {
                        u_xlat16_10.xyz = u_xlat23.xyz;
                        u_xlati0 = -1;
                    //ENDIF
                    }
                    u_xlati0 = int(uint(u_xlatb24) * 0xffffffffu | uint(u_xlati0));
                } else {
                    u_xlat16_10.xyz = u_xlat23.xyz;
                    u_xlati0 = -1;
                //ENDIF
                }
                u_xlati0 = int(uint(u_xlatb8) * 0xffffffffu | uint(u_xlati0));
            } else {
                u_xlati0 = -1;
            //ENDIF
            }
            u_xlati0 = int(uint(u_xlatb7) * 0xffffffffu | uint(u_xlati0));
        } else {
            u_xlati0 = -1;
        //ENDIF
        }
        u_xlati0 = int(uint(u_xlatb54) * 0xffffffffu | uint(u_xlati0));
    } else {
        u_xlat16_10.xyz = u_xlat16_1.xyz;
        u_xlati0 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb53) * 0xffffffffu | uint(u_xlati0));
    u_xlat16_49 = dot(u_xlat16_2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_14.xyz = vec3(u_xlat16_49) * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_14.xyz * vec3(u_xlat48) + u_xlat16_9.xyz;
    u_xlat16_14.xyz = u_xlat6.xyz * vec3(u_xlat51) + u_xlat5.xyz;
    u_xlat16_49 = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_14.xyz = vec3(u_xlat16_49) * u_xlat16_14.xyz;
    u_xlat16_16 = dot(u_xlat16_2.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat51 = dot(u_xlat5.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat51 = min(max(u_xlat51, 0.0), 1.0);
#else
    u_xlat51 = clamp(u_xlat51, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * -0.00399392843 + 1.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = 0.996006072 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * 0.318309873;
    u_xlat51 = (-u_xlat51) + 1.0;
    u_xlat16_49 = u_xlat51 * u_xlat51;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_51 = u_xlat16_49 * 0.00766834244 + 0.0399999991;
    u_xlat16_5 = u_xlat16_16 * u_xlat16_51;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_51 + 2.0;
    u_xlat16_16 = u_xlat16_5 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_14.xyz = vec3(u_xlat16_16) * _LightColor0.xyz;
    u_xlat16_14.xyz = vec3(u_xlat48) * u_xlat16_14.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_1.xyz + u_xlat16_14.xyz;
    u_xlat16_9.xyz = (int(u_xlati0) != 0) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat16_9.xyz = (-u_xlat16_1.xyz) + u_xlat16_9.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat0.x = dot(u_xlat0.xyw, u_xlat3.xyz);
    u_xlat16_17.x = (-u_xlat0.x) + 1.0;
    u_xlat16_17.x = max(u_xlat16_17.x, 9.99999975e-05);
    u_xlat16_17.x = log2(u_xlat16_17.x);
    u_xlat16_17.x = u_xlat16_17.x * 0.200000003;
    u_xlat16_17.x = exp2(u_xlat16_17.x);
    u_xlat0.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x / _FarFadeLength;
    u_xlat16_33 = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_49 = u_xlat16_32 + (-_CloudTexThreshold);
    u_xlat16_9.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_49 = u_xlat16_49 / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_1.x = u_xlat16_49 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_17.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_33 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * u_xlat3.xxx;
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    vs_TEXCOORD7.xyz = u_xlat4.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat2.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec4 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
bool u_xlatb11;
bool u_xlatb12;
bvec3 u_xlatb13;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
bool u_xlatb16;
mediump vec3 u_xlat16_17;
vec3 u_xlat23;
bool u_xlatb24;
bool u_xlatb27;
bool u_xlatb28;
float u_xlat32;
mediump float u_xlat16_32;
lowp float u_xlat10_32;
bool u_xlatb32;
mediump float u_xlat16_33;
bool u_xlatb40;
bool u_xlatb43;
bool u_xlatb44;
float u_xlat48;
lowp float u_xlat10_48;
int u_xlati48;
uint u_xlatu48;
bool u_xlatb48;
mediump float u_xlat16_49;
float u_xlat51;
mediump float u_xlat16_51;
bool u_xlatb53;
bool u_xlatb54;
bool u_xlatb56;
bool u_xlatb59;
bool u_xlatb60;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb32 = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb32){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat32 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat32) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_17.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_17.xy);
    u_xlat16_49 = abs(u_xlat32) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = (-u_xlat16_49) + 1.0;
    u_xlat16_17.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_17.xy;
    u_xlat10_32 = texture(_CloudTex, u_xlat16_17.xy).x;
    u_xlat16_32 = u_xlat10_32 * u_xlat16_49;
    u_xlat10_48 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_32 = u_xlat10_48 * u_xlat16_32;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_32 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_17.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_17.xyz + _CloudColorA.xyz;
    u_xlat48 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat48 = inversesqrt(u_xlat48);
    u_xlat3.xyz = vec3(u_xlat48) * vs_TEXCOORD6.xyz;
    u_xlat10_4.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat4.x = vs_TEXCOORD7.x;
    u_xlat4.y = vs_TEXCOORD9.x;
    u_xlat4.z = vs_TEXCOORD8.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.y;
    u_xlat5.y = vs_TEXCOORD9.y;
    u_xlat5.z = vs_TEXCOORD8.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.z;
    u_xlat5.y = vs_TEXCOORD9.z;
    u_xlat5.z = vs_TEXCOORD8.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat48 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_49 = (-u_xlat48) + 1.0;
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimThreshold;
    u_xlat16_49 = exp2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_49) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat8.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.w = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_49 = u_xlat2.y + u_xlat2.x;
    u_xlat16_9.x = u_xlat2.z + u_xlat16_49;
    u_xlat5.x = -0.0;
    u_xlat5.y = (-u_xlat2.x);
    u_xlat5.z = (-u_xlat16_49);
    u_xlat5.w = (-u_xlat16_9.x);
    u_xlat2 = u_xlat2 + u_xlat5;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_49 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat16_49>=0.5);
#else
    u_xlatb48 = u_xlat16_49>=0.5;
#endif
    if(u_xlatb48){
        u_xlat48 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat48 = min(u_xlat48, 3.0);
        u_xlatu48 = uint(u_xlat48);
        u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu48)].xyz);
        u_xlati48 = int(u_xlatu48) << 2;
        u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 1)].xyz;
        u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati48].xyz * u_xlat5.xxx + u_xlat6.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
        u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
        u_xlat10_48 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_51 = (-_LightShadowData.x) + 1.0;
        u_xlat48 = u_xlat10_48 * u_xlat16_51 + _LightShadowData.x;
    } else {
        u_xlat48 = 1.0;
    //ENDIF
    }
    u_xlat16_49 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_2.xyz = vec3(u_xlat16_49) * u_xlat4.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_49 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_49 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_49);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_49) + u_xlat16_10.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat51 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
    u_xlat5.xyz = vec3(u_xlat51) * u_xlat5.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat51 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
#ifdef UNITY_ADRENO_ES3
    u_xlatb53 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb53 = unity_DebugViewInfo.x==1.0;
#endif
    if(!u_xlatb53){
#ifdef UNITY_ADRENO_ES3
        u_xlatb54 = !!(unity_DebugViewInfo.x==2.0);
#else
        u_xlatb54 = unity_DebugViewInfo.x==2.0;
#endif
        u_xlat16_10.xyz = (bool(u_xlatb54)) ? vec3(0.0399999991, 0.0399999991, 0.0399999991) : u_xlat16_1.xyz;
        if(!u_xlatb54){
#ifdef UNITY_ADRENO_ES3
            u_xlatb7 = !!(unity_DebugViewInfo.x==3.0);
#else
            u_xlatb7 = unity_DebugViewInfo.x==3.0;
#endif
            u_xlat16_10.xyz = (bool(u_xlatb7)) ? vec3(0.000999987125, 0.000999987125, 0.000999987125) : u_xlat16_10.xyz;
            if(!u_xlatb7){
                u_xlat23.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                u_xlatb8 = !!(unity_DebugViewInfo.x==4.0);
#else
                u_xlatb8 = unity_DebugViewInfo.x==4.0;
#endif
                if(!u_xlatb8){
#ifdef UNITY_ADRENO_ES3
                    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
                    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
                    if(!u_xlatb24){
#ifdef UNITY_ADRENO_ES3
                        u_xlatb40 = !!(unity_DebugViewInfo.x==6.0);
#else
                        u_xlatb40 = unity_DebugViewInfo.x==6.0;
#endif
                        if(!u_xlatb40){
#ifdef UNITY_ADRENO_ES3
                            u_xlatb56 = !!(unity_DebugViewInfo.x==7.0);
#else
                            u_xlatb56 = unity_DebugViewInfo.x==7.0;
#endif
                            if(!u_xlatb56){
#ifdef UNITY_ADRENO_ES3
                                u_xlatb11 = !!(unity_DebugViewInfo.x==8.0);
#else
                                u_xlatb11 = unity_DebugViewInfo.x==8.0;
#endif
                                u_xlat16_10.xyz = (bool(u_xlatb11)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                if(!u_xlatb11){
#ifdef UNITY_ADRENO_ES3
                                    u_xlatb27 = !!(unity_DebugViewInfo.x==9.0);
#else
                                    u_xlatb27 = unity_DebugViewInfo.x==9.0;
#endif
                                    u_xlat16_10.xyz = (bool(u_xlatb27)) ? vec3(u_xlat48) : u_xlat16_10.xyz;
                                    if(!u_xlatb27){
#ifdef UNITY_ADRENO_ES3
                                        u_xlatb43 = !!(unity_DebugViewInfo.x==10.0);
#else
                                        u_xlatb43 = unity_DebugViewInfo.x==10.0;
#endif
                                        if(!u_xlatb43){
#ifdef UNITY_ADRENO_ES3
                                            u_xlatb59 = !!(unity_DebugViewInfo.x==11.0);
#else
                                            u_xlatb59 = unity_DebugViewInfo.x==11.0;
#endif
                                            u_xlat16_10.xyz = (bool(u_xlatb59)) ? vec3(1.0, 1.0, 1.0) : u_xlat16_10.xyz;
                                            if(!u_xlatb59){
#ifdef UNITY_ADRENO_ES3
                                                u_xlatb12 = !!(unity_DebugViewInfo.x==12.0);
#else
                                                u_xlatb12 = unity_DebugViewInfo.x==12.0;
#endif
                                                u_xlat16_10.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                if(!u_xlatb12){
#ifdef UNITY_ADRENO_ES3
                                                    u_xlatb28 = !!(unity_DebugViewInfo.x==13.0);
#else
                                                    u_xlatb28 = unity_DebugViewInfo.x==13.0;
#endif
                                                    u_xlat16_10.xyz = (bool(u_xlatb28)) ? vec3(0.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                    if(!u_xlatb28){
#ifdef UNITY_ADRENO_ES3
                                                        u_xlatb44 = !!(unity_DebugViewInfo.x==51.0);
#else
                                                        u_xlatb44 = unity_DebugViewInfo.x==51.0;
#endif
                                                        u_xlat16_10.xyz = (bool(u_xlatb44)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                                        if(!u_xlatb44){
                                                            if(!u_xlatb0.x){
                                                                u_xlatb13.xyz = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 151.0, 0.0)).xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_10.xyz;
                                                                u_xlatb60 = u_xlatb0.y || u_xlatb13.y;
                                                                u_xlat16_15.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.z || u_xlatb60;
                                                                u_xlat16_14.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.y) ? u_xlat16_15.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.y || u_xlatb13.z;
                                                                u_xlat16_14.xyz = (u_xlatb0.y) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb16 = u_xlatb0.y || u_xlatb60;
                                                                u_xlat16_10.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_14.xyz;
                                                                u_xlati16 = int(uint(u_xlatb13.x) * 0xffffffffu | uint(u_xlatb16) * 0xffffffffu);
                                                            } else {
                                                                u_xlat16_10.x = float(0.200000003);
                                                                u_xlat16_10.y = float(0.200000003);
                                                                u_xlat16_10.z = float(0.200000003);
                                                                u_xlati16 = -1;
                                                            //ENDIF
                                                            }
                                                            u_xlati0 = int(uint(u_xlatb0.x) * 0xffffffffu | uint(u_xlati16));
                                                        } else {
                                                            u_xlati0 = -1;
                                                        //ENDIF
                                                        }
                                                        u_xlati0 = int(uint(u_xlatb44) * 0xffffffffu | uint(u_xlati0));
                                                    } else {
                                                        u_xlati0 = -1;
                                                    //ENDIF
                                                    }
                                                    u_xlati0 = int(uint(u_xlatb28) * 0xffffffffu | uint(u_xlati0));
                                                } else {
                                                    u_xlati0 = -1;
                                                //ENDIF
                                                }
                                                u_xlati0 = int(uint(u_xlatb12) * 0xffffffffu | uint(u_xlati0));
                                            } else {
                                                u_xlati0 = -1;
                                            //ENDIF
                                            }
                                            u_xlati0 = int(uint(u_xlatb59) * 0xffffffffu | uint(u_xlati0));
                                        } else {
                                            u_xlat16_10.x = float(1.0);
                                            u_xlat16_10.y = float(1.0);
                                            u_xlat16_10.z = float(1.0);
                                            u_xlati0 = -1;
                                        //ENDIF
                                        }
                                        u_xlati0 = int(uint(u_xlatb43) * 0xffffffffu | uint(u_xlati0));
                                    } else {
                                        u_xlati0 = -1;
                                    //ENDIF
                                    }
                                    u_xlati0 = int(uint(u_xlatb27) * 0xffffffffu | uint(u_xlati0));
                                } else {
                                    u_xlati0 = -1;
                                //ENDIF
                                }
                                u_xlati0 = int(uint(u_xlatb11) * 0xffffffffu | uint(u_xlati0));
                            } else {
                                u_xlat16_10.xyz = u_xlat23.xyz;
                                u_xlati0 = -1;
                            //ENDIF
                            }
                            u_xlati0 = int(uint(u_xlatb56) * 0xffffffffu | uint(u_xlati0));
                        } else {
                            u_xlat16_10.xyz = u_xlat23.xyz;
                            u_xlati0 = -1;
                        //ENDIF
                        }
                        u_xlati0 = int(uint(u_xlatb40) * 0xffffffffu | uint(u_xlati0));
                    } else {
                        u_xlat16_10.xyz = u_xlat23.xyz;
                        u_xlati0 = -1;
                    //ENDIF
                    }
                    u_xlati0 = int(uint(u_xlatb24) * 0xffffffffu | uint(u_xlati0));
                } else {
                    u_xlat16_10.xyz = u_xlat23.xyz;
                    u_xlati0 = -1;
                //ENDIF
                }
                u_xlati0 = int(uint(u_xlatb8) * 0xffffffffu | uint(u_xlati0));
            } else {
                u_xlati0 = -1;
            //ENDIF
            }
            u_xlati0 = int(uint(u_xlatb7) * 0xffffffffu | uint(u_xlati0));
        } else {
            u_xlati0 = -1;
        //ENDIF
        }
        u_xlati0 = int(uint(u_xlatb54) * 0xffffffffu | uint(u_xlati0));
    } else {
        u_xlat16_10.xyz = u_xlat16_1.xyz;
        u_xlati0 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb53) * 0xffffffffu | uint(u_xlati0));
    u_xlat16_49 = dot(u_xlat16_2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_14.xyz = vec3(u_xlat16_49) * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_14.xyz * vec3(u_xlat48) + u_xlat16_9.xyz;
    u_xlat16_14.xyz = u_xlat6.xyz * vec3(u_xlat51) + u_xlat5.xyz;
    u_xlat16_49 = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_14.xyz = vec3(u_xlat16_49) * u_xlat16_14.xyz;
    u_xlat16_16 = dot(u_xlat16_2.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat51 = dot(u_xlat5.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat51 = min(max(u_xlat51, 0.0), 1.0);
#else
    u_xlat51 = clamp(u_xlat51, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * -0.00399392843 + 1.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = 0.996006072 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * 0.318309873;
    u_xlat51 = (-u_xlat51) + 1.0;
    u_xlat16_49 = u_xlat51 * u_xlat51;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_51 = u_xlat16_49 * 0.00766834244 + 0.0399999991;
    u_xlat16_5 = u_xlat16_16 * u_xlat16_51;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_51 + 2.0;
    u_xlat16_16 = u_xlat16_5 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_14.xyz = vec3(u_xlat16_16) * _LightColor0.xyz;
    u_xlat16_14.xyz = vec3(u_xlat48) * u_xlat16_14.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_1.xyz + u_xlat16_14.xyz;
    u_xlat16_9.xyz = (int(u_xlati0) != 0) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat16_9.xyz = (-u_xlat16_1.xyz) + u_xlat16_9.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat0.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD10.w);
    u_xlat16 = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat48 = (-u_xlat16) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat48 + u_xlat16;
    u_xlat16 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat5.xyz = vec3(u_xlat16) * vs_TEXCOORD8.xyz;
    u_xlat16 = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat16_17.x = (-u_xlat16) + 1.0;
    u_xlat16_17.x = max(u_xlat16_17.x, 9.99999975e-05);
    u_xlat16_17.x = log2(u_xlat16_17.x);
    u_xlat16_17.x = u_xlat16_17.x * 0.200000003;
    u_xlat16_17.x = exp2(u_xlat16_17.x);
    u_xlat16 = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat16 = u_xlat16 / _FarFadeLength;
    u_xlat16_33 = (-u_xlat16) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_49 = u_xlat16_32 + (-_CloudTexThreshold);
    u_xlat16_9.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_49 = u_xlat16_49 / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_1.x = u_xlat16_49 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_17.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_33 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec4 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
bool u_xlatb11;
bool u_xlatb12;
bvec3 u_xlatb13;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_15;
mediump float u_xlat16_16;
int u_xlati16;
bool u_xlatb16;
mediump vec3 u_xlat16_17;
vec3 u_xlat23;
bool u_xlatb24;
bool u_xlatb27;
bool u_xlatb28;
float u_xlat32;
mediump float u_xlat16_32;
lowp float u_xlat10_32;
bool u_xlatb32;
mediump float u_xlat16_33;
bool u_xlatb40;
bool u_xlatb43;
bool u_xlatb44;
float u_xlat48;
lowp float u_xlat10_48;
int u_xlati48;
uint u_xlatu48;
bool u_xlatb48;
mediump float u_xlat16_49;
float u_xlat51;
mediump float u_xlat16_51;
bool u_xlatb53;
bool u_xlatb54;
bool u_xlatb56;
bool u_xlatb59;
bool u_xlatb60;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb32 = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb32){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat32 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat32) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_17.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_17.xy);
    u_xlat16_49 = abs(u_xlat32) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = (-u_xlat16_49) + 1.0;
    u_xlat16_17.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_17.xy;
    u_xlat10_32 = texture(_CloudTex, u_xlat16_17.xy).x;
    u_xlat16_32 = u_xlat10_32 * u_xlat16_49;
    u_xlat10_48 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_32 = u_xlat10_48 * u_xlat16_32;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_32 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_17.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_17.xyz + _CloudColorA.xyz;
    u_xlat48 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat48 = inversesqrt(u_xlat48);
    u_xlat3.xyz = vec3(u_xlat48) * vs_TEXCOORD6.xyz;
    u_xlat10_4.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat4.x = vs_TEXCOORD7.x;
    u_xlat4.y = vs_TEXCOORD9.x;
    u_xlat4.z = vs_TEXCOORD8.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.y;
    u_xlat5.y = vs_TEXCOORD9.y;
    u_xlat5.z = vs_TEXCOORD8.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.z;
    u_xlat5.y = vs_TEXCOORD9.z;
    u_xlat5.z = vs_TEXCOORD8.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat48 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_49 = (-u_xlat48) + 1.0;
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimThreshold;
    u_xlat16_49 = exp2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_49) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat8.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.w = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_49 = u_xlat2.y + u_xlat2.x;
    u_xlat16_9.x = u_xlat2.z + u_xlat16_49;
    u_xlat5.x = -0.0;
    u_xlat5.y = (-u_xlat2.x);
    u_xlat5.z = (-u_xlat16_49);
    u_xlat5.w = (-u_xlat16_9.x);
    u_xlat2 = u_xlat2 + u_xlat5;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_49 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat16_49>=0.5);
#else
    u_xlatb48 = u_xlat16_49>=0.5;
#endif
    if(u_xlatb48){
        u_xlat48 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat48 = min(u_xlat48, 3.0);
        u_xlatu48 = uint(u_xlat48);
        u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu48)].xyz);
        u_xlati48 = int(u_xlatu48) << 2;
        u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 1)].xyz;
        u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati48].xyz * u_xlat5.xxx + u_xlat6.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
        u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
        u_xlat10_48 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_51 = (-_LightShadowData.x) + 1.0;
        u_xlat48 = u_xlat10_48 * u_xlat16_51 + _LightShadowData.x;
    } else {
        u_xlat48 = 1.0;
    //ENDIF
    }
    u_xlat16_49 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_2.xyz = vec3(u_xlat16_49) * u_xlat4.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_49 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_49 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_49);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_49) + u_xlat16_10.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat51 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
    u_xlat5.xyz = vec3(u_xlat51) * u_xlat5.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat51 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
#ifdef UNITY_ADRENO_ES3
    u_xlatb53 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb53 = unity_DebugViewInfo.x==1.0;
#endif
    if(!u_xlatb53){
#ifdef UNITY_ADRENO_ES3
        u_xlatb54 = !!(unity_DebugViewInfo.x==2.0);
#else
        u_xlatb54 = unity_DebugViewInfo.x==2.0;
#endif
        u_xlat16_10.xyz = (bool(u_xlatb54)) ? vec3(0.0399999991, 0.0399999991, 0.0399999991) : u_xlat16_1.xyz;
        if(!u_xlatb54){
#ifdef UNITY_ADRENO_ES3
            u_xlatb7 = !!(unity_DebugViewInfo.x==3.0);
#else
            u_xlatb7 = unity_DebugViewInfo.x==3.0;
#endif
            u_xlat16_10.xyz = (bool(u_xlatb7)) ? vec3(0.000999987125, 0.000999987125, 0.000999987125) : u_xlat16_10.xyz;
            if(!u_xlatb7){
                u_xlat23.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                u_xlatb8 = !!(unity_DebugViewInfo.x==4.0);
#else
                u_xlatb8 = unity_DebugViewInfo.x==4.0;
#endif
                if(!u_xlatb8){
#ifdef UNITY_ADRENO_ES3
                    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
                    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
                    if(!u_xlatb24){
#ifdef UNITY_ADRENO_ES3
                        u_xlatb40 = !!(unity_DebugViewInfo.x==6.0);
#else
                        u_xlatb40 = unity_DebugViewInfo.x==6.0;
#endif
                        if(!u_xlatb40){
#ifdef UNITY_ADRENO_ES3
                            u_xlatb56 = !!(unity_DebugViewInfo.x==7.0);
#else
                            u_xlatb56 = unity_DebugViewInfo.x==7.0;
#endif
                            if(!u_xlatb56){
#ifdef UNITY_ADRENO_ES3
                                u_xlatb11 = !!(unity_DebugViewInfo.x==8.0);
#else
                                u_xlatb11 = unity_DebugViewInfo.x==8.0;
#endif
                                u_xlat16_10.xyz = (bool(u_xlatb11)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                if(!u_xlatb11){
#ifdef UNITY_ADRENO_ES3
                                    u_xlatb27 = !!(unity_DebugViewInfo.x==9.0);
#else
                                    u_xlatb27 = unity_DebugViewInfo.x==9.0;
#endif
                                    u_xlat16_10.xyz = (bool(u_xlatb27)) ? vec3(u_xlat48) : u_xlat16_10.xyz;
                                    if(!u_xlatb27){
#ifdef UNITY_ADRENO_ES3
                                        u_xlatb43 = !!(unity_DebugViewInfo.x==10.0);
#else
                                        u_xlatb43 = unity_DebugViewInfo.x==10.0;
#endif
                                        if(!u_xlatb43){
#ifdef UNITY_ADRENO_ES3
                                            u_xlatb59 = !!(unity_DebugViewInfo.x==11.0);
#else
                                            u_xlatb59 = unity_DebugViewInfo.x==11.0;
#endif
                                            u_xlat16_10.xyz = (bool(u_xlatb59)) ? vec3(1.0, 1.0, 1.0) : u_xlat16_10.xyz;
                                            if(!u_xlatb59){
#ifdef UNITY_ADRENO_ES3
                                                u_xlatb12 = !!(unity_DebugViewInfo.x==12.0);
#else
                                                u_xlatb12 = unity_DebugViewInfo.x==12.0;
#endif
                                                u_xlat16_10.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                if(!u_xlatb12){
#ifdef UNITY_ADRENO_ES3
                                                    u_xlatb28 = !!(unity_DebugViewInfo.x==13.0);
#else
                                                    u_xlatb28 = unity_DebugViewInfo.x==13.0;
#endif
                                                    u_xlat16_10.xyz = (bool(u_xlatb28)) ? vec3(0.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                    if(!u_xlatb28){
#ifdef UNITY_ADRENO_ES3
                                                        u_xlatb44 = !!(unity_DebugViewInfo.x==51.0);
#else
                                                        u_xlatb44 = unity_DebugViewInfo.x==51.0;
#endif
                                                        u_xlat16_10.xyz = (bool(u_xlatb44)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                                        if(!u_xlatb44){
                                                            if(!u_xlatb0.x){
                                                                u_xlatb13.xyz = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 151.0, 0.0)).xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_10.xyz;
                                                                u_xlatb60 = u_xlatb0.y || u_xlatb13.y;
                                                                u_xlat16_15.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.z || u_xlatb60;
                                                                u_xlat16_14.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.y) ? u_xlat16_15.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.y || u_xlatb13.z;
                                                                u_xlat16_14.xyz = (u_xlatb0.y) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb16 = u_xlatb0.y || u_xlatb60;
                                                                u_xlat16_10.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_14.xyz;
                                                                u_xlati16 = int(uint(u_xlatb13.x) * 0xffffffffu | uint(u_xlatb16) * 0xffffffffu);
                                                            } else {
                                                                u_xlat16_10.x = float(0.200000003);
                                                                u_xlat16_10.y = float(0.200000003);
                                                                u_xlat16_10.z = float(0.200000003);
                                                                u_xlati16 = -1;
                                                            //ENDIF
                                                            }
                                                            u_xlati0 = int(uint(u_xlatb0.x) * 0xffffffffu | uint(u_xlati16));
                                                        } else {
                                                            u_xlati0 = -1;
                                                        //ENDIF
                                                        }
                                                        u_xlati0 = int(uint(u_xlatb44) * 0xffffffffu | uint(u_xlati0));
                                                    } else {
                                                        u_xlati0 = -1;
                                                    //ENDIF
                                                    }
                                                    u_xlati0 = int(uint(u_xlatb28) * 0xffffffffu | uint(u_xlati0));
                                                } else {
                                                    u_xlati0 = -1;
                                                //ENDIF
                                                }
                                                u_xlati0 = int(uint(u_xlatb12) * 0xffffffffu | uint(u_xlati0));
                                            } else {
                                                u_xlati0 = -1;
                                            //ENDIF
                                            }
                                            u_xlati0 = int(uint(u_xlatb59) * 0xffffffffu | uint(u_xlati0));
                                        } else {
                                            u_xlat16_10.x = float(1.0);
                                            u_xlat16_10.y = float(1.0);
                                            u_xlat16_10.z = float(1.0);
                                            u_xlati0 = -1;
                                        //ENDIF
                                        }
                                        u_xlati0 = int(uint(u_xlatb43) * 0xffffffffu | uint(u_xlati0));
                                    } else {
                                        u_xlati0 = -1;
                                    //ENDIF
                                    }
                                    u_xlati0 = int(uint(u_xlatb27) * 0xffffffffu | uint(u_xlati0));
                                } else {
                                    u_xlati0 = -1;
                                //ENDIF
                                }
                                u_xlati0 = int(uint(u_xlatb11) * 0xffffffffu | uint(u_xlati0));
                            } else {
                                u_xlat16_10.xyz = u_xlat23.xyz;
                                u_xlati0 = -1;
                            //ENDIF
                            }
                            u_xlati0 = int(uint(u_xlatb56) * 0xffffffffu | uint(u_xlati0));
                        } else {
                            u_xlat16_10.xyz = u_xlat23.xyz;
                            u_xlati0 = -1;
                        //ENDIF
                        }
                        u_xlati0 = int(uint(u_xlatb40) * 0xffffffffu | uint(u_xlati0));
                    } else {
                        u_xlat16_10.xyz = u_xlat23.xyz;
                        u_xlati0 = -1;
                    //ENDIF
                    }
                    u_xlati0 = int(uint(u_xlatb24) * 0xffffffffu | uint(u_xlati0));
                } else {
                    u_xlat16_10.xyz = u_xlat23.xyz;
                    u_xlati0 = -1;
                //ENDIF
                }
                u_xlati0 = int(uint(u_xlatb8) * 0xffffffffu | uint(u_xlati0));
            } else {
                u_xlati0 = -1;
            //ENDIF
            }
            u_xlati0 = int(uint(u_xlatb7) * 0xffffffffu | uint(u_xlati0));
        } else {
            u_xlati0 = -1;
        //ENDIF
        }
        u_xlati0 = int(uint(u_xlatb54) * 0xffffffffu | uint(u_xlati0));
    } else {
        u_xlat16_10.xyz = u_xlat16_1.xyz;
        u_xlati0 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb53) * 0xffffffffu | uint(u_xlati0));
    u_xlat16_49 = dot(u_xlat16_2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_14.xyz = vec3(u_xlat16_49) * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_14.xyz * vec3(u_xlat48) + u_xlat16_9.xyz;
    u_xlat16_14.xyz = u_xlat6.xyz * vec3(u_xlat51) + u_xlat5.xyz;
    u_xlat16_49 = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_14.xyz = vec3(u_xlat16_49) * u_xlat16_14.xyz;
    u_xlat16_16 = dot(u_xlat16_2.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat51 = dot(u_xlat5.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat51 = min(max(u_xlat51, 0.0), 1.0);
#else
    u_xlat51 = clamp(u_xlat51, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * -0.00399392843 + 1.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = 0.996006072 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * 0.318309873;
    u_xlat51 = (-u_xlat51) + 1.0;
    u_xlat16_49 = u_xlat51 * u_xlat51;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_51 = u_xlat16_49 * 0.00766834244 + 0.0399999991;
    u_xlat16_5 = u_xlat16_16 * u_xlat16_51;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_51 + 2.0;
    u_xlat16_16 = u_xlat16_5 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_14.xyz = vec3(u_xlat16_16) * _LightColor0.xyz;
    u_xlat16_14.xyz = vec3(u_xlat48) * u_xlat16_14.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_1.xyz + u_xlat16_14.xyz;
    u_xlat16_9.xyz = (int(u_xlati0) != 0) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat16_9.xyz = (-u_xlat16_1.xyz) + u_xlat16_9.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat0.x = dot(u_xlat0.xyw, u_xlat3.xyz);
    u_xlat16_17.x = (-u_xlat0.x) + 1.0;
    u_xlat16_17.x = max(u_xlat16_17.x, 9.99999975e-05);
    u_xlat16_17.x = log2(u_xlat16_17.x);
    u_xlat16_17.x = u_xlat16_17.x * 0.200000003;
    u_xlat16_17.x = exp2(u_xlat16_17.x);
    u_xlat0.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x / _FarFadeLength;
    u_xlat16_33 = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_49 = u_xlat16_32 + (-_CloudTexThreshold);
    u_xlat16_9.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_49 = u_xlat16_49 / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_1.x = u_xlat16_49 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_17.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_33 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD6.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD8.xyz = u_xlat2.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat1.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec4 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
bool u_xlatb11;
bool u_xlatb12;
bvec3 u_xlatb13;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
bool u_xlatb16;
mediump vec3 u_xlat16_17;
vec3 u_xlat23;
bool u_xlatb24;
bool u_xlatb27;
bool u_xlatb28;
float u_xlat32;
mediump float u_xlat16_32;
lowp float u_xlat10_32;
bool u_xlatb32;
mediump float u_xlat16_33;
bool u_xlatb40;
bool u_xlatb43;
bool u_xlatb44;
float u_xlat48;
lowp float u_xlat10_48;
int u_xlati48;
uint u_xlatu48;
bool u_xlatb48;
mediump float u_xlat16_49;
float u_xlat51;
mediump float u_xlat16_51;
bool u_xlatb53;
bool u_xlatb54;
bool u_xlatb56;
bool u_xlatb59;
bool u_xlatb60;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb32 = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb32){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat32 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat32) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_17.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_17.xy);
    u_xlat16_49 = abs(u_xlat32) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = (-u_xlat16_49) + 1.0;
    u_xlat16_17.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_17.xy;
    u_xlat10_32 = texture(_CloudTex, u_xlat16_17.xy).x;
    u_xlat16_32 = u_xlat10_32 * u_xlat16_49;
    u_xlat10_48 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_32 = u_xlat10_48 * u_xlat16_32;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_32 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_17.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_17.xyz + _CloudColorA.xyz;
    u_xlat48 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat48 = inversesqrt(u_xlat48);
    u_xlat3.xyz = vec3(u_xlat48) * vs_TEXCOORD6.xyz;
    u_xlat10_4.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat4.x = vs_TEXCOORD7.x;
    u_xlat4.y = vs_TEXCOORD9.x;
    u_xlat4.z = vs_TEXCOORD8.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.y;
    u_xlat5.y = vs_TEXCOORD9.y;
    u_xlat5.z = vs_TEXCOORD8.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.z;
    u_xlat5.y = vs_TEXCOORD9.z;
    u_xlat5.z = vs_TEXCOORD8.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat48 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_49 = (-u_xlat48) + 1.0;
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimThreshold;
    u_xlat16_49 = exp2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_49) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat8.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.w = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_49 = u_xlat2.y + u_xlat2.x;
    u_xlat16_9.x = u_xlat2.z + u_xlat16_49;
    u_xlat5.x = -0.0;
    u_xlat5.y = (-u_xlat2.x);
    u_xlat5.z = (-u_xlat16_49);
    u_xlat5.w = (-u_xlat16_9.x);
    u_xlat2 = u_xlat2 + u_xlat5;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_49 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat16_49>=0.5);
#else
    u_xlatb48 = u_xlat16_49>=0.5;
#endif
    if(u_xlatb48){
        u_xlat48 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat48 = min(u_xlat48, 3.0);
        u_xlatu48 = uint(u_xlat48);
        u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu48)].xyz);
        u_xlati48 = int(u_xlatu48) << 2;
        u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 1)].xyz;
        u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati48].xyz * u_xlat5.xxx + u_xlat6.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
        u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
        u_xlat10_48 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_51 = (-_LightShadowData.x) + 1.0;
        u_xlat48 = u_xlat10_48 * u_xlat16_51 + _LightShadowData.x;
    } else {
        u_xlat48 = 1.0;
    //ENDIF
    }
    u_xlat16_49 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_2.xyz = vec3(u_xlat16_49) * u_xlat4.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_49 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_49 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_49);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_49) + u_xlat16_10.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat51 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
    u_xlat5.xyz = vec3(u_xlat51) * u_xlat5.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat51 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
#ifdef UNITY_ADRENO_ES3
    u_xlatb53 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb53 = unity_DebugViewInfo.x==1.0;
#endif
    if(!u_xlatb53){
#ifdef UNITY_ADRENO_ES3
        u_xlatb54 = !!(unity_DebugViewInfo.x==2.0);
#else
        u_xlatb54 = unity_DebugViewInfo.x==2.0;
#endif
        u_xlat16_10.xyz = (bool(u_xlatb54)) ? vec3(0.0399999991, 0.0399999991, 0.0399999991) : u_xlat16_1.xyz;
        if(!u_xlatb54){
#ifdef UNITY_ADRENO_ES3
            u_xlatb7 = !!(unity_DebugViewInfo.x==3.0);
#else
            u_xlatb7 = unity_DebugViewInfo.x==3.0;
#endif
            u_xlat16_10.xyz = (bool(u_xlatb7)) ? vec3(0.000999987125, 0.000999987125, 0.000999987125) : u_xlat16_10.xyz;
            if(!u_xlatb7){
                u_xlat23.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                u_xlatb8 = !!(unity_DebugViewInfo.x==4.0);
#else
                u_xlatb8 = unity_DebugViewInfo.x==4.0;
#endif
                if(!u_xlatb8){
#ifdef UNITY_ADRENO_ES3
                    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
                    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
                    if(!u_xlatb24){
#ifdef UNITY_ADRENO_ES3
                        u_xlatb40 = !!(unity_DebugViewInfo.x==6.0);
#else
                        u_xlatb40 = unity_DebugViewInfo.x==6.0;
#endif
                        if(!u_xlatb40){
#ifdef UNITY_ADRENO_ES3
                            u_xlatb56 = !!(unity_DebugViewInfo.x==7.0);
#else
                            u_xlatb56 = unity_DebugViewInfo.x==7.0;
#endif
                            if(!u_xlatb56){
#ifdef UNITY_ADRENO_ES3
                                u_xlatb11 = !!(unity_DebugViewInfo.x==8.0);
#else
                                u_xlatb11 = unity_DebugViewInfo.x==8.0;
#endif
                                u_xlat16_10.xyz = (bool(u_xlatb11)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                if(!u_xlatb11){
#ifdef UNITY_ADRENO_ES3
                                    u_xlatb27 = !!(unity_DebugViewInfo.x==9.0);
#else
                                    u_xlatb27 = unity_DebugViewInfo.x==9.0;
#endif
                                    u_xlat16_10.xyz = (bool(u_xlatb27)) ? vec3(u_xlat48) : u_xlat16_10.xyz;
                                    if(!u_xlatb27){
#ifdef UNITY_ADRENO_ES3
                                        u_xlatb43 = !!(unity_DebugViewInfo.x==10.0);
#else
                                        u_xlatb43 = unity_DebugViewInfo.x==10.0;
#endif
                                        if(!u_xlatb43){
#ifdef UNITY_ADRENO_ES3
                                            u_xlatb59 = !!(unity_DebugViewInfo.x==11.0);
#else
                                            u_xlatb59 = unity_DebugViewInfo.x==11.0;
#endif
                                            u_xlat16_10.xyz = (bool(u_xlatb59)) ? vec3(1.0, 1.0, 1.0) : u_xlat16_10.xyz;
                                            if(!u_xlatb59){
#ifdef UNITY_ADRENO_ES3
                                                u_xlatb12 = !!(unity_DebugViewInfo.x==12.0);
#else
                                                u_xlatb12 = unity_DebugViewInfo.x==12.0;
#endif
                                                u_xlat16_10.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                if(!u_xlatb12){
#ifdef UNITY_ADRENO_ES3
                                                    u_xlatb28 = !!(unity_DebugViewInfo.x==13.0);
#else
                                                    u_xlatb28 = unity_DebugViewInfo.x==13.0;
#endif
                                                    u_xlat16_10.xyz = (bool(u_xlatb28)) ? vec3(0.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                    if(!u_xlatb28){
#ifdef UNITY_ADRENO_ES3
                                                        u_xlatb44 = !!(unity_DebugViewInfo.x==51.0);
#else
                                                        u_xlatb44 = unity_DebugViewInfo.x==51.0;
#endif
                                                        u_xlat16_10.xyz = (bool(u_xlatb44)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                                        if(!u_xlatb44){
                                                            if(!u_xlatb0.x){
                                                                u_xlatb13.xyz = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 151.0, 0.0)).xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_10.xyz;
                                                                u_xlatb60 = u_xlatb0.y || u_xlatb13.y;
                                                                u_xlat16_15.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.z || u_xlatb60;
                                                                u_xlat16_14.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.y) ? u_xlat16_15.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.y || u_xlatb13.z;
                                                                u_xlat16_14.xyz = (u_xlatb0.y) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb16 = u_xlatb0.y || u_xlatb60;
                                                                u_xlat16_10.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_14.xyz;
                                                                u_xlati16 = int(uint(u_xlatb13.x) * 0xffffffffu | uint(u_xlatb16) * 0xffffffffu);
                                                            } else {
                                                                u_xlat16_10.x = float(0.200000003);
                                                                u_xlat16_10.y = float(0.200000003);
                                                                u_xlat16_10.z = float(0.200000003);
                                                                u_xlati16 = -1;
                                                            //ENDIF
                                                            }
                                                            u_xlati0 = int(uint(u_xlatb0.x) * 0xffffffffu | uint(u_xlati16));
                                                        } else {
                                                            u_xlati0 = -1;
                                                        //ENDIF
                                                        }
                                                        u_xlati0 = int(uint(u_xlatb44) * 0xffffffffu | uint(u_xlati0));
                                                    } else {
                                                        u_xlati0 = -1;
                                                    //ENDIF
                                                    }
                                                    u_xlati0 = int(uint(u_xlatb28) * 0xffffffffu | uint(u_xlati0));
                                                } else {
                                                    u_xlati0 = -1;
                                                //ENDIF
                                                }
                                                u_xlati0 = int(uint(u_xlatb12) * 0xffffffffu | uint(u_xlati0));
                                            } else {
                                                u_xlati0 = -1;
                                            //ENDIF
                                            }
                                            u_xlati0 = int(uint(u_xlatb59) * 0xffffffffu | uint(u_xlati0));
                                        } else {
                                            u_xlat16_10.x = float(1.0);
                                            u_xlat16_10.y = float(1.0);
                                            u_xlat16_10.z = float(1.0);
                                            u_xlati0 = -1;
                                        //ENDIF
                                        }
                                        u_xlati0 = int(uint(u_xlatb43) * 0xffffffffu | uint(u_xlati0));
                                    } else {
                                        u_xlati0 = -1;
                                    //ENDIF
                                    }
                                    u_xlati0 = int(uint(u_xlatb27) * 0xffffffffu | uint(u_xlati0));
                                } else {
                                    u_xlati0 = -1;
                                //ENDIF
                                }
                                u_xlati0 = int(uint(u_xlatb11) * 0xffffffffu | uint(u_xlati0));
                            } else {
                                u_xlat16_10.xyz = u_xlat23.xyz;
                                u_xlati0 = -1;
                            //ENDIF
                            }
                            u_xlati0 = int(uint(u_xlatb56) * 0xffffffffu | uint(u_xlati0));
                        } else {
                            u_xlat16_10.xyz = u_xlat23.xyz;
                            u_xlati0 = -1;
                        //ENDIF
                        }
                        u_xlati0 = int(uint(u_xlatb40) * 0xffffffffu | uint(u_xlati0));
                    } else {
                        u_xlat16_10.xyz = u_xlat23.xyz;
                        u_xlati0 = -1;
                    //ENDIF
                    }
                    u_xlati0 = int(uint(u_xlatb24) * 0xffffffffu | uint(u_xlati0));
                } else {
                    u_xlat16_10.xyz = u_xlat23.xyz;
                    u_xlati0 = -1;
                //ENDIF
                }
                u_xlati0 = int(uint(u_xlatb8) * 0xffffffffu | uint(u_xlati0));
            } else {
                u_xlati0 = -1;
            //ENDIF
            }
            u_xlati0 = int(uint(u_xlatb7) * 0xffffffffu | uint(u_xlati0));
        } else {
            u_xlati0 = -1;
        //ENDIF
        }
        u_xlati0 = int(uint(u_xlatb54) * 0xffffffffu | uint(u_xlati0));
    } else {
        u_xlat16_10.xyz = u_xlat16_1.xyz;
        u_xlati0 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb53) * 0xffffffffu | uint(u_xlati0));
    u_xlat16_49 = dot(u_xlat16_2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_14.xyz = vec3(u_xlat16_49) * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_14.xyz * vec3(u_xlat48) + u_xlat16_9.xyz;
    u_xlat16_14.xyz = u_xlat6.xyz * vec3(u_xlat51) + u_xlat5.xyz;
    u_xlat16_49 = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_14.xyz = vec3(u_xlat16_49) * u_xlat16_14.xyz;
    u_xlat16_16 = dot(u_xlat16_2.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat51 = dot(u_xlat5.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat51 = min(max(u_xlat51, 0.0), 1.0);
#else
    u_xlat51 = clamp(u_xlat51, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * -0.00399392843 + 1.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = 0.996006072 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * 0.318309873;
    u_xlat51 = (-u_xlat51) + 1.0;
    u_xlat16_49 = u_xlat51 * u_xlat51;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_51 = u_xlat16_49 * 0.00766834244 + 0.0399999991;
    u_xlat16_5 = u_xlat16_16 * u_xlat16_51;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_51 + 2.0;
    u_xlat16_16 = u_xlat16_5 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_14.xyz = vec3(u_xlat16_16) * _LightColor0.xyz;
    u_xlat16_14.xyz = vec3(u_xlat48) * u_xlat16_14.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_1.xyz + u_xlat16_14.xyz;
    u_xlat16_9.xyz = (int(u_xlati0) != 0) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat16_9.xyz = (-u_xlat16_1.xyz) + u_xlat16_9.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat0.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD10.w);
    u_xlat16 = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat48 = (-u_xlat16) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat48 + u_xlat16;
    u_xlat16 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat5.xyz = vec3(u_xlat16) * vs_TEXCOORD8.xyz;
    u_xlat16 = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat16_17.x = (-u_xlat16) + 1.0;
    u_xlat16_17.x = max(u_xlat16_17.x, 9.99999975e-05);
    u_xlat16_17.x = log2(u_xlat16_17.x);
    u_xlat16_17.x = u_xlat16_17.x * 0.200000003;
    u_xlat16_17.x = exp2(u_xlat16_17.x);
    u_xlat16 = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat16 = u_xlat16 / _FarFadeLength;
    u_xlat16_33 = (-u_xlat16) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_49 = u_xlat16_32 + (-_CloudTexThreshold);
    u_xlat16_9.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_49 = u_xlat16_49 / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_1.x = u_xlat16_49 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_17.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_33 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * u_xlat3.xxx;
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    vs_TEXCOORD7.xyz = u_xlat4.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat2.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec4 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
bool u_xlatb11;
bool u_xlatb12;
bvec3 u_xlatb13;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_15;
mediump float u_xlat16_16;
int u_xlati16;
bool u_xlatb16;
mediump vec3 u_xlat16_17;
vec3 u_xlat23;
bool u_xlatb24;
bool u_xlatb27;
bool u_xlatb28;
float u_xlat32;
mediump float u_xlat16_32;
lowp float u_xlat10_32;
bool u_xlatb32;
mediump float u_xlat16_33;
bool u_xlatb40;
bool u_xlatb43;
bool u_xlatb44;
float u_xlat48;
lowp float u_xlat10_48;
int u_xlati48;
uint u_xlatu48;
bool u_xlatb48;
mediump float u_xlat16_49;
float u_xlat51;
mediump float u_xlat16_51;
bool u_xlatb53;
bool u_xlatb54;
bool u_xlatb56;
bool u_xlatb59;
bool u_xlatb60;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb32 = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb32){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat32 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat32) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_17.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_17.xy);
    u_xlat16_49 = abs(u_xlat32) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = (-u_xlat16_49) + 1.0;
    u_xlat16_17.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_17.xy;
    u_xlat10_32 = texture(_CloudTex, u_xlat16_17.xy).x;
    u_xlat16_32 = u_xlat10_32 * u_xlat16_49;
    u_xlat10_48 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_32 = u_xlat10_48 * u_xlat16_32;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_32 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_17.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_17.xyz + _CloudColorA.xyz;
    u_xlat48 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat48 = inversesqrt(u_xlat48);
    u_xlat3.xyz = vec3(u_xlat48) * vs_TEXCOORD6.xyz;
    u_xlat10_4.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat4.x = vs_TEXCOORD7.x;
    u_xlat4.y = vs_TEXCOORD9.x;
    u_xlat4.z = vs_TEXCOORD8.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.y;
    u_xlat5.y = vs_TEXCOORD9.y;
    u_xlat5.z = vs_TEXCOORD8.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.z;
    u_xlat5.y = vs_TEXCOORD9.z;
    u_xlat5.z = vs_TEXCOORD8.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat48 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_49 = (-u_xlat48) + 1.0;
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimThreshold;
    u_xlat16_49 = exp2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_49) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat8.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.w = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_49 = u_xlat2.y + u_xlat2.x;
    u_xlat16_9.x = u_xlat2.z + u_xlat16_49;
    u_xlat5.x = -0.0;
    u_xlat5.y = (-u_xlat2.x);
    u_xlat5.z = (-u_xlat16_49);
    u_xlat5.w = (-u_xlat16_9.x);
    u_xlat2 = u_xlat2 + u_xlat5;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_49 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat16_49>=0.5);
#else
    u_xlatb48 = u_xlat16_49>=0.5;
#endif
    if(u_xlatb48){
        u_xlat48 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat48 = min(u_xlat48, 3.0);
        u_xlatu48 = uint(u_xlat48);
        u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu48)].xyz);
        u_xlati48 = int(u_xlatu48) << 2;
        u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 1)].xyz;
        u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati48].xyz * u_xlat5.xxx + u_xlat6.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
        u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
        u_xlat10_48 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_51 = (-_LightShadowData.x) + 1.0;
        u_xlat48 = u_xlat10_48 * u_xlat16_51 + _LightShadowData.x;
    } else {
        u_xlat48 = 1.0;
    //ENDIF
    }
    u_xlat16_49 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_2.xyz = vec3(u_xlat16_49) * u_xlat4.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_49 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_49 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_49);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_49) + u_xlat16_10.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat51 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
    u_xlat5.xyz = vec3(u_xlat51) * u_xlat5.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat51 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
#ifdef UNITY_ADRENO_ES3
    u_xlatb53 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb53 = unity_DebugViewInfo.x==1.0;
#endif
    if(!u_xlatb53){
#ifdef UNITY_ADRENO_ES3
        u_xlatb54 = !!(unity_DebugViewInfo.x==2.0);
#else
        u_xlatb54 = unity_DebugViewInfo.x==2.0;
#endif
        u_xlat16_10.xyz = (bool(u_xlatb54)) ? vec3(0.0399999991, 0.0399999991, 0.0399999991) : u_xlat16_1.xyz;
        if(!u_xlatb54){
#ifdef UNITY_ADRENO_ES3
            u_xlatb7 = !!(unity_DebugViewInfo.x==3.0);
#else
            u_xlatb7 = unity_DebugViewInfo.x==3.0;
#endif
            u_xlat16_10.xyz = (bool(u_xlatb7)) ? vec3(0.000999987125, 0.000999987125, 0.000999987125) : u_xlat16_10.xyz;
            if(!u_xlatb7){
                u_xlat23.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                u_xlatb8 = !!(unity_DebugViewInfo.x==4.0);
#else
                u_xlatb8 = unity_DebugViewInfo.x==4.0;
#endif
                if(!u_xlatb8){
#ifdef UNITY_ADRENO_ES3
                    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
                    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
                    if(!u_xlatb24){
#ifdef UNITY_ADRENO_ES3
                        u_xlatb40 = !!(unity_DebugViewInfo.x==6.0);
#else
                        u_xlatb40 = unity_DebugViewInfo.x==6.0;
#endif
                        if(!u_xlatb40){
#ifdef UNITY_ADRENO_ES3
                            u_xlatb56 = !!(unity_DebugViewInfo.x==7.0);
#else
                            u_xlatb56 = unity_DebugViewInfo.x==7.0;
#endif
                            if(!u_xlatb56){
#ifdef UNITY_ADRENO_ES3
                                u_xlatb11 = !!(unity_DebugViewInfo.x==8.0);
#else
                                u_xlatb11 = unity_DebugViewInfo.x==8.0;
#endif
                                u_xlat16_10.xyz = (bool(u_xlatb11)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                if(!u_xlatb11){
#ifdef UNITY_ADRENO_ES3
                                    u_xlatb27 = !!(unity_DebugViewInfo.x==9.0);
#else
                                    u_xlatb27 = unity_DebugViewInfo.x==9.0;
#endif
                                    u_xlat16_10.xyz = (bool(u_xlatb27)) ? vec3(u_xlat48) : u_xlat16_10.xyz;
                                    if(!u_xlatb27){
#ifdef UNITY_ADRENO_ES3
                                        u_xlatb43 = !!(unity_DebugViewInfo.x==10.0);
#else
                                        u_xlatb43 = unity_DebugViewInfo.x==10.0;
#endif
                                        if(!u_xlatb43){
#ifdef UNITY_ADRENO_ES3
                                            u_xlatb59 = !!(unity_DebugViewInfo.x==11.0);
#else
                                            u_xlatb59 = unity_DebugViewInfo.x==11.0;
#endif
                                            u_xlat16_10.xyz = (bool(u_xlatb59)) ? vec3(1.0, 1.0, 1.0) : u_xlat16_10.xyz;
                                            if(!u_xlatb59){
#ifdef UNITY_ADRENO_ES3
                                                u_xlatb12 = !!(unity_DebugViewInfo.x==12.0);
#else
                                                u_xlatb12 = unity_DebugViewInfo.x==12.0;
#endif
                                                u_xlat16_10.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                if(!u_xlatb12){
#ifdef UNITY_ADRENO_ES3
                                                    u_xlatb28 = !!(unity_DebugViewInfo.x==13.0);
#else
                                                    u_xlatb28 = unity_DebugViewInfo.x==13.0;
#endif
                                                    u_xlat16_10.xyz = (bool(u_xlatb28)) ? vec3(0.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                    if(!u_xlatb28){
#ifdef UNITY_ADRENO_ES3
                                                        u_xlatb44 = !!(unity_DebugViewInfo.x==51.0);
#else
                                                        u_xlatb44 = unity_DebugViewInfo.x==51.0;
#endif
                                                        u_xlat16_10.xyz = (bool(u_xlatb44)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                                        if(!u_xlatb44){
                                                            if(!u_xlatb0.x){
                                                                u_xlatb13.xyz = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 151.0, 0.0)).xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_10.xyz;
                                                                u_xlatb60 = u_xlatb0.y || u_xlatb13.y;
                                                                u_xlat16_15.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.z || u_xlatb60;
                                                                u_xlat16_14.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.y) ? u_xlat16_15.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.y || u_xlatb13.z;
                                                                u_xlat16_14.xyz = (u_xlatb0.y) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb16 = u_xlatb0.y || u_xlatb60;
                                                                u_xlat16_10.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_14.xyz;
                                                                u_xlati16 = int(uint(u_xlatb13.x) * 0xffffffffu | uint(u_xlatb16) * 0xffffffffu);
                                                            } else {
                                                                u_xlat16_10.x = float(0.200000003);
                                                                u_xlat16_10.y = float(0.200000003);
                                                                u_xlat16_10.z = float(0.200000003);
                                                                u_xlati16 = -1;
                                                            //ENDIF
                                                            }
                                                            u_xlati0 = int(uint(u_xlatb0.x) * 0xffffffffu | uint(u_xlati16));
                                                        } else {
                                                            u_xlati0 = -1;
                                                        //ENDIF
                                                        }
                                                        u_xlati0 = int(uint(u_xlatb44) * 0xffffffffu | uint(u_xlati0));
                                                    } else {
                                                        u_xlati0 = -1;
                                                    //ENDIF
                                                    }
                                                    u_xlati0 = int(uint(u_xlatb28) * 0xffffffffu | uint(u_xlati0));
                                                } else {
                                                    u_xlati0 = -1;
                                                //ENDIF
                                                }
                                                u_xlati0 = int(uint(u_xlatb12) * 0xffffffffu | uint(u_xlati0));
                                            } else {
                                                u_xlati0 = -1;
                                            //ENDIF
                                            }
                                            u_xlati0 = int(uint(u_xlatb59) * 0xffffffffu | uint(u_xlati0));
                                        } else {
                                            u_xlat16_10.x = float(1.0);
                                            u_xlat16_10.y = float(1.0);
                                            u_xlat16_10.z = float(1.0);
                                            u_xlati0 = -1;
                                        //ENDIF
                                        }
                                        u_xlati0 = int(uint(u_xlatb43) * 0xffffffffu | uint(u_xlati0));
                                    } else {
                                        u_xlati0 = -1;
                                    //ENDIF
                                    }
                                    u_xlati0 = int(uint(u_xlatb27) * 0xffffffffu | uint(u_xlati0));
                                } else {
                                    u_xlati0 = -1;
                                //ENDIF
                                }
                                u_xlati0 = int(uint(u_xlatb11) * 0xffffffffu | uint(u_xlati0));
                            } else {
                                u_xlat16_10.xyz = u_xlat23.xyz;
                                u_xlati0 = -1;
                            //ENDIF
                            }
                            u_xlati0 = int(uint(u_xlatb56) * 0xffffffffu | uint(u_xlati0));
                        } else {
                            u_xlat16_10.xyz = u_xlat23.xyz;
                            u_xlati0 = -1;
                        //ENDIF
                        }
                        u_xlati0 = int(uint(u_xlatb40) * 0xffffffffu | uint(u_xlati0));
                    } else {
                        u_xlat16_10.xyz = u_xlat23.xyz;
                        u_xlati0 = -1;
                    //ENDIF
                    }
                    u_xlati0 = int(uint(u_xlatb24) * 0xffffffffu | uint(u_xlati0));
                } else {
                    u_xlat16_10.xyz = u_xlat23.xyz;
                    u_xlati0 = -1;
                //ENDIF
                }
                u_xlati0 = int(uint(u_xlatb8) * 0xffffffffu | uint(u_xlati0));
            } else {
                u_xlati0 = -1;
            //ENDIF
            }
            u_xlati0 = int(uint(u_xlatb7) * 0xffffffffu | uint(u_xlati0));
        } else {
            u_xlati0 = -1;
        //ENDIF
        }
        u_xlati0 = int(uint(u_xlatb54) * 0xffffffffu | uint(u_xlati0));
    } else {
        u_xlat16_10.xyz = u_xlat16_1.xyz;
        u_xlati0 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb53) * 0xffffffffu | uint(u_xlati0));
    u_xlat16_49 = dot(u_xlat16_2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_14.xyz = vec3(u_xlat16_49) * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_14.xyz * vec3(u_xlat48) + u_xlat16_9.xyz;
    u_xlat16_14.xyz = u_xlat6.xyz * vec3(u_xlat51) + u_xlat5.xyz;
    u_xlat16_49 = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_14.xyz = vec3(u_xlat16_49) * u_xlat16_14.xyz;
    u_xlat16_16 = dot(u_xlat16_2.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat51 = dot(u_xlat5.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat51 = min(max(u_xlat51, 0.0), 1.0);
#else
    u_xlat51 = clamp(u_xlat51, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * -0.00399392843 + 1.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = 0.996006072 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * 0.318309873;
    u_xlat51 = (-u_xlat51) + 1.0;
    u_xlat16_49 = u_xlat51 * u_xlat51;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_51 = u_xlat16_49 * 0.00766834244 + 0.0399999991;
    u_xlat16_5 = u_xlat16_16 * u_xlat16_51;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_51 + 2.0;
    u_xlat16_16 = u_xlat16_5 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_14.xyz = vec3(u_xlat16_16) * _LightColor0.xyz;
    u_xlat16_14.xyz = vec3(u_xlat48) * u_xlat16_14.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_1.xyz + u_xlat16_14.xyz;
    u_xlat16_9.xyz = (int(u_xlati0) != 0) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat16_9.xyz = (-u_xlat16_1.xyz) + u_xlat16_9.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat0.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * vs_TEXCOORD8.xyz;
    u_xlat0.x = dot(u_xlat0.xyw, u_xlat3.xyz);
    u_xlat16_17.x = (-u_xlat0.x) + 1.0;
    u_xlat16_17.x = max(u_xlat16_17.x, 9.99999975e-05);
    u_xlat16_17.x = log2(u_xlat16_17.x);
    u_xlat16_17.x = u_xlat16_17.x * 0.200000003;
    u_xlat16_17.x = exp2(u_xlat16_17.x);
    u_xlat0.x = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x / _FarFadeLength;
    u_xlat16_33 = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_49 = u_xlat16_32 + (-_CloudTexThreshold);
    u_xlat16_9.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_49 = u_xlat16_49 / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_1.x = u_xlat16_49 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0.x = u_xlat16_1.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_17.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_33 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec4 in_TANGENT0;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
out highp vec4 vs_TEXCOORD10;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * u_xlat3.xxx;
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    vs_TEXCOORD7.xyz = u_xlat4.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD9.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD9.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD10.zw = u_xlat2.zw;
    vs_TEXCOORD10.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _CloudColorA;
uniform 	mediump vec4 _CloudColorB;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _ColorAThresholdScale;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _ColorAThreshold;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _NormalScale;
uniform 	mediump float _RimScale;
uniform 	mediump float _RimThreshold;
uniform 	mediump float _SuitEnv;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _NormalTex;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
in highp vec4 vs_TEXCOORD10;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec4 u_xlat5;
mediump float u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
bool u_xlatb8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
bool u_xlatb11;
bool u_xlatb12;
bvec3 u_xlatb13;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_15;
float u_xlat16;
mediump float u_xlat16_16;
int u_xlati16;
bool u_xlatb16;
mediump vec3 u_xlat16_17;
vec3 u_xlat23;
bool u_xlatb24;
bool u_xlatb27;
bool u_xlatb28;
float u_xlat32;
mediump float u_xlat16_32;
lowp float u_xlat10_32;
bool u_xlatb32;
mediump float u_xlat16_33;
bool u_xlatb40;
bool u_xlatb43;
bool u_xlatb44;
float u_xlat48;
lowp float u_xlat10_48;
int u_xlati48;
uint u_xlatu48;
bool u_xlatb48;
mediump float u_xlat16_49;
float u_xlat51;
mediump float u_xlat16_51;
bool u_xlatb53;
bool u_xlatb54;
bool u_xlatb56;
bool u_xlatb59;
bool u_xlatb60;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb32 = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb32){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat32 = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1.x = _CloudThickness * _ColorAThresholdScale;
    u_xlat16_1.x = abs(u_xlat32) / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_17.xy = vs_TEXCOORD5.xz * vec2(_CloudScale);
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_17.xy);
    u_xlat16_49 = abs(u_xlat32) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = (-u_xlat16_49) + 1.0;
    u_xlat16_17.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_17.xy;
    u_xlat10_32 = texture(_CloudTex, u_xlat16_17.xy).x;
    u_xlat16_32 = u_xlat10_32 * u_xlat16_49;
    u_xlat10_48 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_32 = u_xlat10_48 * u_xlat16_32;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_32 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _ColorAThreshold;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_17.xyz = (-_CloudColorA.xyz) + _CloudColorB.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_17.xyz + _CloudColorA.xyz;
    u_xlat48 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat48 = inversesqrt(u_xlat48);
    u_xlat3.xyz = vec3(u_xlat48) * vs_TEXCOORD6.xyz;
    u_xlat10_4.xyz = texture(_NormalTex, u_xlat16_2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalScale);
    u_xlat4.x = vs_TEXCOORD7.x;
    u_xlat4.y = vs_TEXCOORD9.x;
    u_xlat4.z = vs_TEXCOORD8.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.y;
    u_xlat5.y = vs_TEXCOORD9.y;
    u_xlat5.z = vs_TEXCOORD8.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat5.x = vs_TEXCOORD7.z;
    u_xlat5.y = vs_TEXCOORD9.z;
    u_xlat5.z = vs_TEXCOORD8.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat16_2.xyz);
    u_xlat48 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_49 = (-u_xlat48) + 1.0;
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimThreshold;
    u_xlat16_49 = exp2(u_xlat16_49);
    u_xlat16_49 = u_xlat16_49 * _RimScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _RimColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_49) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat6.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat7.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat8.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.z = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.w = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_49 = u_xlat2.y + u_xlat2.x;
    u_xlat16_9.x = u_xlat2.z + u_xlat16_49;
    u_xlat5.x = -0.0;
    u_xlat5.y = (-u_xlat2.x);
    u_xlat5.z = (-u_xlat16_49);
    u_xlat5.w = (-u_xlat16_9.x);
    u_xlat2 = u_xlat2 + u_xlat5;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_49 = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlat16_49>=0.5);
#else
    u_xlatb48 = u_xlat16_49>=0.5;
#endif
    if(u_xlatb48){
        u_xlat48 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat48 = min(u_xlat48, 3.0);
        u_xlatu48 = uint(u_xlat48);
        u_xlat5.xyz = vs_TEXCOORD5.xyz + (-unity_ShadowPos[int(u_xlatu48)].xyz);
        u_xlati48 = int(u_xlatu48) << 2;
        u_xlat6.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 1)].xyz;
        u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati48].xyz * u_xlat5.xxx + u_xlat6.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
        u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati48 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
        u_xlat10_48 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_51 = (-_LightShadowData.x) + 1.0;
        u_xlat48 = u_xlat10_48 * u_xlat16_51 + _LightShadowData.x;
    } else {
        u_xlat48 = 1.0;
    //ENDIF
    }
    u_xlat16_49 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_2.xyz = vec3(u_xlat16_49) * u_xlat4.xyz;
    u_xlat16_2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat16_2);
    u_xlat16_4 = u_xlat16_2.yzzx * u_xlat16_2.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_49 = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_49 = u_xlat16_2.x * u_xlat16_2.x + (-u_xlat16_49);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_49) + u_xlat16_10.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD5.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat51 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
    u_xlat5.xyz = vec3(u_xlat51) * u_xlat5.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat51 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat51 = inversesqrt(u_xlat51);
#ifdef UNITY_ADRENO_ES3
    u_xlatb53 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb53 = unity_DebugViewInfo.x==1.0;
#endif
    if(!u_xlatb53){
#ifdef UNITY_ADRENO_ES3
        u_xlatb54 = !!(unity_DebugViewInfo.x==2.0);
#else
        u_xlatb54 = unity_DebugViewInfo.x==2.0;
#endif
        u_xlat16_10.xyz = (bool(u_xlatb54)) ? vec3(0.0399999991, 0.0399999991, 0.0399999991) : u_xlat16_1.xyz;
        if(!u_xlatb54){
#ifdef UNITY_ADRENO_ES3
            u_xlatb7 = !!(unity_DebugViewInfo.x==3.0);
#else
            u_xlatb7 = unity_DebugViewInfo.x==3.0;
#endif
            u_xlat16_10.xyz = (bool(u_xlatb7)) ? vec3(0.000999987125, 0.000999987125, 0.000999987125) : u_xlat16_10.xyz;
            if(!u_xlatb7){
                u_xlat23.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
                u_xlatb8 = !!(unity_DebugViewInfo.x==4.0);
#else
                u_xlatb8 = unity_DebugViewInfo.x==4.0;
#endif
                if(!u_xlatb8){
#ifdef UNITY_ADRENO_ES3
                    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
                    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
                    if(!u_xlatb24){
#ifdef UNITY_ADRENO_ES3
                        u_xlatb40 = !!(unity_DebugViewInfo.x==6.0);
#else
                        u_xlatb40 = unity_DebugViewInfo.x==6.0;
#endif
                        if(!u_xlatb40){
#ifdef UNITY_ADRENO_ES3
                            u_xlatb56 = !!(unity_DebugViewInfo.x==7.0);
#else
                            u_xlatb56 = unity_DebugViewInfo.x==7.0;
#endif
                            if(!u_xlatb56){
#ifdef UNITY_ADRENO_ES3
                                u_xlatb11 = !!(unity_DebugViewInfo.x==8.0);
#else
                                u_xlatb11 = unity_DebugViewInfo.x==8.0;
#endif
                                u_xlat16_10.xyz = (bool(u_xlatb11)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                if(!u_xlatb11){
#ifdef UNITY_ADRENO_ES3
                                    u_xlatb27 = !!(unity_DebugViewInfo.x==9.0);
#else
                                    u_xlatb27 = unity_DebugViewInfo.x==9.0;
#endif
                                    u_xlat16_10.xyz = (bool(u_xlatb27)) ? vec3(u_xlat48) : u_xlat16_10.xyz;
                                    if(!u_xlatb27){
#ifdef UNITY_ADRENO_ES3
                                        u_xlatb43 = !!(unity_DebugViewInfo.x==10.0);
#else
                                        u_xlatb43 = unity_DebugViewInfo.x==10.0;
#endif
                                        if(!u_xlatb43){
#ifdef UNITY_ADRENO_ES3
                                            u_xlatb59 = !!(unity_DebugViewInfo.x==11.0);
#else
                                            u_xlatb59 = unity_DebugViewInfo.x==11.0;
#endif
                                            u_xlat16_10.xyz = (bool(u_xlatb59)) ? vec3(1.0, 1.0, 1.0) : u_xlat16_10.xyz;
                                            if(!u_xlatb59){
#ifdef UNITY_ADRENO_ES3
                                                u_xlatb12 = !!(unity_DebugViewInfo.x==12.0);
#else
                                                u_xlatb12 = unity_DebugViewInfo.x==12.0;
#endif
                                                u_xlat16_10.xyz = (bool(u_xlatb12)) ? vec3(1.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                if(!u_xlatb12){
#ifdef UNITY_ADRENO_ES3
                                                    u_xlatb28 = !!(unity_DebugViewInfo.x==13.0);
#else
                                                    u_xlatb28 = unity_DebugViewInfo.x==13.0;
#endif
                                                    u_xlat16_10.xyz = (bool(u_xlatb28)) ? vec3(0.0, 0.0, 0.0) : u_xlat16_10.xyz;
                                                    if(!u_xlatb28){
#ifdef UNITY_ADRENO_ES3
                                                        u_xlatb44 = !!(unity_DebugViewInfo.x==51.0);
#else
                                                        u_xlatb44 = unity_DebugViewInfo.x==51.0;
#endif
                                                        u_xlat16_10.xyz = (bool(u_xlatb44)) ? u_xlat23.xyz : u_xlat16_10.xyz;
                                                        if(!u_xlatb44){
                                                            if(!u_xlatb0.x){
                                                                u_xlatb13.xyz = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 151.0, 0.0)).xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_10.xyz;
                                                                u_xlatb60 = u_xlatb0.y || u_xlatb13.y;
                                                                u_xlat16_15.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.z || u_xlatb60;
                                                                u_xlat16_14.xyz = (bool(u_xlatb60)) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlat16_14.xyz = (u_xlatb13.y) ? u_xlat16_15.xyz : u_xlat16_14.xyz;
                                                                u_xlatb60 = u_xlatb13.y || u_xlatb13.z;
                                                                u_xlat16_14.xyz = (u_xlatb0.y) ? u_xlat23.xyz : u_xlat16_14.xyz;
                                                                u_xlatb16 = u_xlatb0.y || u_xlatb60;
                                                                u_xlat16_10.xyz = (u_xlatb13.x) ? vec3(0.200000003, 0.200000003, 0.200000003) : u_xlat16_14.xyz;
                                                                u_xlati16 = int(uint(u_xlatb13.x) * 0xffffffffu | uint(u_xlatb16) * 0xffffffffu);
                                                            } else {
                                                                u_xlat16_10.x = float(0.200000003);
                                                                u_xlat16_10.y = float(0.200000003);
                                                                u_xlat16_10.z = float(0.200000003);
                                                                u_xlati16 = -1;
                                                            //ENDIF
                                                            }
                                                            u_xlati0 = int(uint(u_xlatb0.x) * 0xffffffffu | uint(u_xlati16));
                                                        } else {
                                                            u_xlati0 = -1;
                                                        //ENDIF
                                                        }
                                                        u_xlati0 = int(uint(u_xlatb44) * 0xffffffffu | uint(u_xlati0));
                                                    } else {
                                                        u_xlati0 = -1;
                                                    //ENDIF
                                                    }
                                                    u_xlati0 = int(uint(u_xlatb28) * 0xffffffffu | uint(u_xlati0));
                                                } else {
                                                    u_xlati0 = -1;
                                                //ENDIF
                                                }
                                                u_xlati0 = int(uint(u_xlatb12) * 0xffffffffu | uint(u_xlati0));
                                            } else {
                                                u_xlati0 = -1;
                                            //ENDIF
                                            }
                                            u_xlati0 = int(uint(u_xlatb59) * 0xffffffffu | uint(u_xlati0));
                                        } else {
                                            u_xlat16_10.x = float(1.0);
                                            u_xlat16_10.y = float(1.0);
                                            u_xlat16_10.z = float(1.0);
                                            u_xlati0 = -1;
                                        //ENDIF
                                        }
                                        u_xlati0 = int(uint(u_xlatb43) * 0xffffffffu | uint(u_xlati0));
                                    } else {
                                        u_xlati0 = -1;
                                    //ENDIF
                                    }
                                    u_xlati0 = int(uint(u_xlatb27) * 0xffffffffu | uint(u_xlati0));
                                } else {
                                    u_xlati0 = -1;
                                //ENDIF
                                }
                                u_xlati0 = int(uint(u_xlatb11) * 0xffffffffu | uint(u_xlati0));
                            } else {
                                u_xlat16_10.xyz = u_xlat23.xyz;
                                u_xlati0 = -1;
                            //ENDIF
                            }
                            u_xlati0 = int(uint(u_xlatb56) * 0xffffffffu | uint(u_xlati0));
                        } else {
                            u_xlat16_10.xyz = u_xlat23.xyz;
                            u_xlati0 = -1;
                        //ENDIF
                        }
                        u_xlati0 = int(uint(u_xlatb40) * 0xffffffffu | uint(u_xlati0));
                    } else {
                        u_xlat16_10.xyz = u_xlat23.xyz;
                        u_xlati0 = -1;
                    //ENDIF
                    }
                    u_xlati0 = int(uint(u_xlatb24) * 0xffffffffu | uint(u_xlati0));
                } else {
                    u_xlat16_10.xyz = u_xlat23.xyz;
                    u_xlati0 = -1;
                //ENDIF
                }
                u_xlati0 = int(uint(u_xlatb8) * 0xffffffffu | uint(u_xlati0));
            } else {
                u_xlati0 = -1;
            //ENDIF
            }
            u_xlati0 = int(uint(u_xlatb7) * 0xffffffffu | uint(u_xlati0));
        } else {
            u_xlati0 = -1;
        //ENDIF
        }
        u_xlati0 = int(uint(u_xlatb54) * 0xffffffffu | uint(u_xlati0));
    } else {
        u_xlat16_10.xyz = u_xlat16_1.xyz;
        u_xlati0 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb53) * 0xffffffffu | uint(u_xlati0));
    u_xlat16_49 = dot(u_xlat16_2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_14.xyz = vec3(u_xlat16_49) * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_14.xyz * vec3(u_xlat48) + u_xlat16_9.xyz;
    u_xlat16_14.xyz = u_xlat6.xyz * vec3(u_xlat51) + u_xlat5.xyz;
    u_xlat16_49 = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_49 = inversesqrt(u_xlat16_49);
    u_xlat16_14.xyz = vec3(u_xlat16_49) * u_xlat16_14.xyz;
    u_xlat16_16 = dot(u_xlat16_2.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat51 = dot(u_xlat5.xyz, u_xlat16_14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat51 = min(max(u_xlat51, 0.0), 1.0);
#else
    u_xlat51 = clamp(u_xlat51, 0.0, 1.0);
#endif
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * -0.00399392843 + 1.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
    u_xlat16_16 = 0.996006072 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 * 0.318309873;
    u_xlat51 = (-u_xlat51) + 1.0;
    u_xlat16_49 = u_xlat51 * u_xlat51;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_49 = u_xlat51 * u_xlat16_49;
    u_xlat16_51 = u_xlat16_49 * 0.00766834244 + 0.0399999991;
    u_xlat16_5 = u_xlat16_16 * u_xlat16_51;
    u_xlat16_16 = u_xlat16_16 * u_xlat16_51 + 2.0;
    u_xlat16_16 = u_xlat16_5 / u_xlat16_16;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
    u_xlat16_14.xyz = vec3(u_xlat16_16) * _LightColor0.xyz;
    u_xlat16_14.xyz = vec3(u_xlat48) * u_xlat16_14.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_1.xyz + u_xlat16_14.xyz;
    u_xlat16_9.xyz = (int(u_xlati0) != 0) ? u_xlat16_10.xyz : u_xlat16_9.xyz;
    u_xlat16_9.xyz = (-u_xlat16_1.xyz) + u_xlat16_9.xyz;
    SV_Target0.xyz = vec3(vec3(_SuitEnv, _SuitEnv, _SuitEnv)) * u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat16_1.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat0.xy = vs_TEXCOORD10.xy / vs_TEXCOORD10.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD10.w);
    u_xlat16 = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat48 = (-u_xlat16) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat48 + u_xlat16;
    u_xlat16 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat5.xyz = vec3(u_xlat16) * vs_TEXCOORD8.xyz;
    u_xlat16 = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat16_17.x = (-u_xlat16) + 1.0;
    u_xlat16_17.x = max(u_xlat16_17.x, 9.99999975e-05);
    u_xlat16_17.x = log2(u_xlat16_17.x);
    u_xlat16_17.x = u_xlat16_17.x * 0.200000003;
    u_xlat16_17.x = exp2(u_xlat16_17.x);
    u_xlat16 = vs_TEXCOORD6.w + (-_ProjectionParams.y);
    u_xlat16 = u_xlat16 / _FarFadeLength;
    u_xlat16_33 = (-u_xlat16) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_49 = u_xlat16_32 + (-_CloudTexThreshold);
    u_xlat16_9.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_49 = u_xlat16_49 / u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_49 = min(max(u_xlat16_49, 0.0), 1.0);
#else
    u_xlat16_49 = clamp(u_xlat16_49, 0.0, 1.0);
#endif
    u_xlat16_49 = max(u_xlat16_49, 9.99999975e-05);
    u_xlat16_49 = log2(u_xlat16_49);
    u_xlat16_1.x = u_xlat16_49 * u_xlat16_1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat16_1.x = (-u_xlat16_17.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_33 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
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
  GpuProgramID 71552
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
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
  GpuProgramID 162371
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
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
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position.z = u_xlat0.x * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat0.x * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.x = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat0.x;
    vs_TEXCOORD7.w = (-u_xlat0.x);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat2.wwww + u_xlat0;
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
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
ivec2 u_xlati3;
vec3 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump vec2 u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1 = abs(u_xlat0.x) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_5.xy = vs_TEXCOORD5.xz * vec2(vec2(_CloudScale, _CloudScale));
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_5.xy;
    u_xlat16_5.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_5.xy);
    u_xlat10_0 = texture(_CloudTex, u_xlat16_5.xy).x;
    u_xlat10_4 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_4 = u_xlat10_4 * u_xlat16_1;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_5.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_1 = u_xlat16_1 / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = max(u_xlat16_1, 9.99999975e-05);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_5.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_5.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _AlphaScale;
    u_xlat0.x = u_xlat16_1 * vs_COLOR0.w;
    u_xlat4.x = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD7.xyz;
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat16_1 = (-u_xlat4.x) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 9.99999975e-05);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * 0.200000003;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat4.x = vs_TEXCOORD7.w + (-_ProjectionParams.y);
    u_xlat4.x = u_xlat4.x / _FarFadeLength;
    u_xlat16_5.x = (-u_xlat4.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_5.x + u_xlat16_1;
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1 = (-_FadeOut) + 1.0;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati3.xy;
    u_xlat8.xy = vec2(u_xlati8.xy);
    u_xlat0.xy = u_xlat8.xy * u_xlat0.xy;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
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
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position.z = u_xlat0.x * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat0.x * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.x = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat0.x;
    vs_TEXCOORD7.w = (-u_xlat0.x);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat2.wwww + u_xlat0;
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
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
ivec2 u_xlati3;
vec3 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump vec2 u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1 = abs(u_xlat0.x) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_5.xy = vs_TEXCOORD5.xz * vec2(vec2(_CloudScale, _CloudScale));
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_5.xy;
    u_xlat16_5.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_5.xy);
    u_xlat10_0 = texture(_CloudTex, u_xlat16_5.xy).x;
    u_xlat10_4 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_4 = u_xlat10_4 * u_xlat16_1;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_5.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_1 = u_xlat16_1 / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = max(u_xlat16_1, 9.99999975e-05);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_5.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_5.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _AlphaScale;
    u_xlat0.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD6.w);
    u_xlat4.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4.x * u_xlat8.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat4.x = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD7.xyz;
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat16_1 = (-u_xlat4.x) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 9.99999975e-05);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * 0.200000003;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat4.x = vs_TEXCOORD7.w + (-_ProjectionParams.y);
    u_xlat4.x = u_xlat4.x / _FarFadeLength;
    u_xlat16_5.x = (-u_xlat4.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_5.x + u_xlat16_1;
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1 = (-_FadeOut) + 1.0;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati3.xy;
    u_xlat8.xy = vec2(u_xlati8.xy);
    u_xlat0.xy = u_xlat8.xy * u_xlat0.xy;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
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
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
int u_xlati4;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1.xyz = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.z = u_xlat0.x * u_xlat3.w + u_xlat3.z;
    gl_Position.xyw = u_xlat3.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat0.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat3.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat0.x;
    vs_TEXCOORD7.w = (-u_xlat0.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD8.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat2.wwww + u_xlat0;
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
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
ivec2 u_xlati3;
vec3 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump vec2 u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1 = abs(u_xlat0.x) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_5.xy = vs_TEXCOORD5.xz * vec2(vec2(_CloudScale, _CloudScale));
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_5.xy;
    u_xlat16_5.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_5.xy);
    u_xlat10_0 = texture(_CloudTex, u_xlat16_5.xy).x;
    u_xlat10_4 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_4 = u_xlat10_4 * u_xlat16_1;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_5.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_1 = u_xlat16_1 / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = max(u_xlat16_1, 9.99999975e-05);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_5.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_5.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _AlphaScale;
    u_xlat0.x = u_xlat16_1 * vs_COLOR0.w;
    u_xlat4.x = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD7.xyz;
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat16_1 = (-u_xlat4.x) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 9.99999975e-05);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * 0.200000003;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat4.x = vs_TEXCOORD7.w + (-_ProjectionParams.y);
    u_xlat4.x = u_xlat4.x / _FarFadeLength;
    u_xlat16_5.x = (-u_xlat4.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_5.x + u_xlat16_1;
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1 = (-_FadeOut) + 1.0;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati3.xy;
    u_xlat8.xy = vec2(u_xlati8.xy);
    u_xlat0.xy = u_xlat8.xy * u_xlat0.xy;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
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
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
int u_xlati4;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1.xyz = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.z = u_xlat0.x * u_xlat3.w + u_xlat3.z;
    gl_Position.xyw = u_xlat3.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat0.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat3.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat0.x;
    vs_TEXCOORD7.w = (-u_xlat0.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD8.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat2.wwww + u_xlat0;
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
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
ivec2 u_xlati3;
vec3 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump vec2 u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1 = abs(u_xlat0.x) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_5.xy = vs_TEXCOORD5.xz * vec2(vec2(_CloudScale, _CloudScale));
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_5.xy;
    u_xlat16_5.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_5.xy);
    u_xlat10_0 = texture(_CloudTex, u_xlat16_5.xy).x;
    u_xlat10_4 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_4 = u_xlat10_4 * u_xlat16_1;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_5.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_1 = u_xlat16_1 / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = max(u_xlat16_1, 9.99999975e-05);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_5.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_5.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _AlphaScale;
    u_xlat0.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD6.w);
    u_xlat4.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4.x * u_xlat8.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat4.x = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD7.xyz;
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat16_1 = (-u_xlat4.x) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 9.99999975e-05);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * 0.200000003;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat4.x = vs_TEXCOORD7.w + (-_ProjectionParams.y);
    u_xlat4.x = u_xlat4.x / _FarFadeLength;
    u_xlat16_5.x = (-u_xlat4.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_5.x + u_xlat16_1;
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1 = (-_FadeOut) + 1.0;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati3.xy;
    u_xlat8.xy = vec2(u_xlati8.xy);
    u_xlat0.xy = u_xlat8.xy * u_xlat0.xy;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
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
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position.z = u_xlat0.x * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat0.x * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.x = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat0.x;
    vs_TEXCOORD7.w = (-u_xlat0.x);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat2.wwww + u_xlat0;
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
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
ivec2 u_xlati3;
vec3 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump vec2 u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1 = abs(u_xlat0.x) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_5.xy = vs_TEXCOORD5.xz * vec2(vec2(_CloudScale, _CloudScale));
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_5.xy;
    u_xlat16_5.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_5.xy);
    u_xlat10_0 = texture(_CloudTex, u_xlat16_5.xy).x;
    u_xlat10_4 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_4 = u_xlat10_4 * u_xlat16_1;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_5.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_1 = u_xlat16_1 / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = max(u_xlat16_1, 9.99999975e-05);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_5.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_5.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _AlphaScale;
    u_xlat0.x = u_xlat16_1 * vs_COLOR0.w;
    u_xlat4.x = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD7.xyz;
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat16_1 = (-u_xlat4.x) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 9.99999975e-05);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * 0.200000003;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat4.x = vs_TEXCOORD7.w + (-_ProjectionParams.y);
    u_xlat4.x = u_xlat4.x / _FarFadeLength;
    u_xlat16_5.x = (-u_xlat4.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_5.x + u_xlat16_1;
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1 = (-_FadeOut) + 1.0;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati3.xy;
    u_xlat8.xy = vec2(u_xlati8.xy);
    u_xlat0.xy = u_xlat8.xy * u_xlat0.xy;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
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
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position.z = u_xlat0.x * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat0.x * 0.5;
    u_xlat3.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat1.zw;
    vs_TEXCOORD6.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat0.x = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat0.x;
    vs_TEXCOORD7.w = (-u_xlat0.x);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat2.wwww + u_xlat0;
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
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
ivec2 u_xlati3;
vec3 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump vec2 u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1 = abs(u_xlat0.x) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_5.xy = vs_TEXCOORD5.xz * vec2(vec2(_CloudScale, _CloudScale));
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_5.xy;
    u_xlat16_5.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_5.xy);
    u_xlat10_0 = texture(_CloudTex, u_xlat16_5.xy).x;
    u_xlat10_4 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_4 = u_xlat10_4 * u_xlat16_1;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_5.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_1 = u_xlat16_1 / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = max(u_xlat16_1, 9.99999975e-05);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_5.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_5.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _AlphaScale;
    u_xlat0.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD6.w);
    u_xlat4.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4.x * u_xlat8.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat4.x = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD7.xyz;
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat16_1 = (-u_xlat4.x) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 9.99999975e-05);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * 0.200000003;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat4.x = vs_TEXCOORD7.w + (-_ProjectionParams.y);
    u_xlat4.x = u_xlat4.x / _FarFadeLength;
    u_xlat16_5.x = (-u_xlat4.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_5.x + u_xlat16_1;
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1 = (-_FadeOut) + 1.0;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati3.xy;
    u_xlat8.xy = vec2(u_xlati8.xy);
    u_xlat0.xy = u_xlat8.xy * u_xlat0.xy;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
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
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
int u_xlati4;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1.xyz = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.z = u_xlat0.x * u_xlat3.w + u_xlat3.z;
    gl_Position.xyw = u_xlat3.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat0.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat3.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat0.x;
    vs_TEXCOORD7.w = (-u_xlat0.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD8.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat2.wwww + u_xlat0;
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
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
ivec2 u_xlati3;
vec3 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump vec2 u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1 = abs(u_xlat0.x) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_5.xy = vs_TEXCOORD5.xz * vec2(vec2(_CloudScale, _CloudScale));
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_5.xy;
    u_xlat16_5.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_5.xy);
    u_xlat10_0 = texture(_CloudTex, u_xlat16_5.xy).x;
    u_xlat10_4 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_4 = u_xlat10_4 * u_xlat16_1;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_5.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_1 = u_xlat16_1 / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = max(u_xlat16_1, 9.99999975e-05);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_5.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_5.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _AlphaScale;
    u_xlat0.x = u_xlat16_1 * vs_COLOR0.w;
    u_xlat4.x = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD7.xyz;
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat16_1 = (-u_xlat4.x) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 9.99999975e-05);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * 0.200000003;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat4.x = vs_TEXCOORD7.w + (-_ProjectionParams.y);
    u_xlat4.x = u_xlat4.x / _FarFadeLength;
    u_xlat16_5.x = (-u_xlat4.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_5.x + u_xlat16_1;
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1 = (-_FadeOut) + 1.0;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati3.xy;
    u_xlat8.xy = vec2(u_xlati8.xy);
    u_xlat0.xy = u_xlat8.xy * u_xlat0.xy;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
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
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
int u_xlati4;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1.xyz = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.z = u_xlat0.x * u_xlat3.w + u_xlat3.z;
    gl_Position.xyw = u_xlat3.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_POSITION0;
    u_xlat0.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.zw = u_xlat3.zw;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat0.x;
    vs_TEXCOORD7.w = (-u_xlat0.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD8.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat2.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat2.wwww + u_xlat0;
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
uniform 	mediump float _CloudClipOffset;
uniform 	mediump float _CloudThickness;
uniform 	mediump float _TimeScale;
uniform 	mediump float _CloudScale;
uniform 	mediump float _CloudTexThreshold;
uniform 	mediump float _CloudHardToSoft;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FarFadeLength;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _CloudTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
ivec2 u_xlati3;
vec3 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump vec2 u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
    u_xlat0.x = vs_TEXCOORD5.y + (-_CloudClipOffset);
    u_xlat16_1 = abs(u_xlat0.x) / _CloudThickness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_5.xy = vs_TEXCOORD5.xz * vec2(vec2(_CloudScale, _CloudScale));
    u_xlat16_2.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + u_xlat16_5.xy;
    u_xlat16_5.xy = _Time.yy * vec2(vec2(_TimeScale, _TimeScale)) + (-u_xlat16_5.xy);
    u_xlat10_0 = texture(_CloudTex, u_xlat16_5.xy).x;
    u_xlat10_4 = texture(_CloudTex, u_xlat16_2.xy).x;
    u_xlat16_4 = u_xlat10_4 * u_xlat16_1;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_0 + (-_CloudTexThreshold);
    u_xlat16_5.x = (-_CloudTexThreshold) + 1.0;
    u_xlat16_1 = u_xlat16_1 / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = max(u_xlat16_1, 9.99999975e-05);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_5.x = _CloudHardToSoft * 2.0 + 0.550000012;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_5.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _AlphaScale;
    u_xlat0.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD6.w);
    u_xlat4.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4.x * u_xlat8.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat4.x = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD7.xyz;
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat16_1 = (-u_xlat4.x) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 9.99999975e-05);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * 0.200000003;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat4.x = vs_TEXCOORD7.w + (-_ProjectionParams.y);
    u_xlat4.x = u_xlat4.x / _FarFadeLength;
    u_xlat16_5.x = (-u_xlat4.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_5.x + u_xlat16_1;
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1 = (-_FadeOut) + 1.0;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati3.xy;
    u_xlat8.xy = vec2(u_xlati8.xy);
    u_xlat0.xy = u_xlat8.xy * u_xlat0.xy;
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