//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/Transparent_VertexAni" {
Properties {
_MainColor ("MainColor", Color) = (0,0,0,0)
_AlphaScale ("AlphaScale", Float) = 1
_MainTex ("MainTex", 2D) = "white" { }
_ShadowIntensity ("Shadow Intensity", Range(0, 1)) = 1
_VertexAniSpeed ("VertexAniSpeed", Range(0, 5)) = 1
_VertexAniScale ("VertexAniScale", Range(-1, 1)) = 0.2
_EmissionColor ("Emission Color", Color) = (0,0,0,0)
_Cutoff ("Cut Off", Range(0, 1.01)) = 0
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "DebugView" = "On" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 36230
Program "vp" {
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _VertexAniSpeed;
uniform 	mediump float _VertexAniScale;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform lowp sampler2D _MainTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat9;
mediump float u_xlat16_10;
vec3 u_xlat11;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
bool u_xlatb23;
float u_xlat26;
void main()
{
    u_xlat0.y = _Time.y * _VertexAniSpeed;
    u_xlat0.x = 0.0;
    u_xlat16_1.xy = u_xlat0.xy + in_TEXCOORD0.xy;
    u_xlat0.x = textureLod(_MainTex, u_xlat16_1.xy, 0.0).y;
    u_xlat0.x = u_xlat0.x * 0.800000012 + -0.400000006;
    u_xlat0.xyz = u_xlat0.xxx * abs(in_NORMAL0.xyz);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat21 = textureLod(_MainTex, u_xlat2.xy, 0.0).z;
    vs_TEXCOORD2.xy = u_xlat2.xy;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniScale, _VertexAniScale, _VertexAniScale)) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat23 = u_xlat21 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.00999999978<abs(u_xlat21));
#else
    u_xlatb21 = 0.00999999978<abs(u_xlat21);
#endif
    u_xlat16_3.x = (u_xlatb21) ? u_xlat23 : 1.0;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat23 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat4 = u_xlat23 * -1.44269502;
    u_xlat4 = exp2(u_xlat4);
    u_xlat4 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat23;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat16_10 = (u_xlatb23) ? u_xlat4 : 1.0;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat23 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat23 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat23) + 2.0;
    u_xlat16_10 = u_xlat23 * u_xlat16_10;
    u_xlat23 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat23 = u_xlat23 + 1.0;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat23 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat23) + 1.0;
    u_xlat11.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat11.x) + 2.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat11.x;
    u_xlat11.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat11.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat26 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat21 = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat26 = u_xlat26 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat11.xyz = vec3(u_xlat26) * u_xlat5.xyz + u_xlat11.xyz;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat9);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat9;
#endif
    u_xlat9 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat9;
    u_xlat9 = u_xlat21 * _HeigtFogColDelta.w;
    u_xlat21 = (u_xlatb2) ? u_xlat9 : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * unity_FogColor.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColBase.w);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat11.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    vs_TEXCOORD0.w = u_xlat4 * u_xlat21;
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat23) + u_xlat2.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec3 _EmissionColor;
uniform 	float _ShadowIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
bvec4 u_xlatb6;
vec4 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
float u_xlat12;
float u_xlat13;
mediump vec2 u_xlat16_14;
float u_xlat22;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
lowp float u_xlat10_34;
int u_xlati34;
uint u_xlatu34;
bool u_xlatb34;
mediump float u_xlat16_35;
mediump float u_xlat16_36;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat4 = vs_COLOR0 * _MainColor;
    u_xlat10_34 = texture(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat34 = u_xlat4.w * u_xlat10_34;
    u_xlat5.w = u_xlat34 * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.w = min(max(u_xlat5.w, 0.0), 1.0);
#else
    u_xlat5.w = clamp(u_xlat5.w, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat7.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat8.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.y = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat6.z = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat6.w = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlatb6 = lessThan(u_xlat6, unity_ShadowSplitSqRadii);
    u_xlat6 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb6));
    u_xlat16_14.x = u_xlat6.y + u_xlat6.x;
    u_xlat16_14.y = u_xlat6.z + u_xlat16_14.x;
    u_xlat7.x = -0.0;
    u_xlat7.y = (-u_xlat6.x);
    u_xlat7.zw = (-u_xlat16_14.xy);
    u_xlat6 = u_xlat6 + u_xlat7;
    u_xlat6 = max(u_xlat6, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_14.x = dot(u_xlat6, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat16_14.x>=0.5);
#else
    u_xlatb34 = u_xlat16_14.x>=0.5;
#endif
    if(u_xlatb34){
        u_xlat34 = dot(u_xlat6.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat34 = min(u_xlat34, 3.0);
        u_xlatu34 = uint(u_xlat34);
        u_xlat6.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowPos[int(u_xlatu34)].xyz);
        u_xlati34 = int(u_xlatu34) << 2;
        u_xlat7.xyz = u_xlat6.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 1)].xyz;
        u_xlat6.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati34].xyz * u_xlat6.xxx + u_xlat7.xyz;
        u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 2)].xyz * u_xlat6.zzz + u_xlat6.xyw;
        u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
        u_xlat10_34 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_35 = (-_LightShadowData.x) + 1.0;
        u_xlat34 = u_xlat10_34 * u_xlat16_35 + _LightShadowData.x;
    } else {
        u_xlat34 = 1.0;
    //ENDIF
    }
    u_xlat34 = u_xlat34 + -1.0;
    u_xlat34 = _ShadowIntensity * u_xlat34 + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _LightColor0.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(u_xlat34) + vs_TEXCOORD1.xyz;
    u_xlat16_3.xyz = u_xlat2.xyz * vec3(u_xlat33) + u_xlat1.xyz;
    u_xlat16_36 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_36 = inversesqrt(u_xlat16_36);
    u_xlat16_3.xyz = vec3(u_xlat16_36) * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat11 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * -0.0394039154 + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = 0.960596085 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat16_3.x = u_xlat11 * u_xlat11;
    u_xlat16_3.x = u_xlat11 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat11 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat11 * u_xlat16_3.x;
    u_xlat16_11 = u_xlat16_3.x * 0.0756555125 + 0.0399999991;
    u_xlat22 = u_xlat16_11 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + 2.0;
    u_xlat0.x = u_xlat22 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat16_3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_3.xyz = vec3(u_xlat34) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat6.xyz * u_xlat4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + _EmissionColor.xyz;
    u_xlat0.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat22 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat1.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat1.x) + 2.0;
    u_xlat1.x = u_xlat12 * u_xlat1.x;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!((-u_xlat33)>=u_xlat12);
#else
    u_xlatb33 = (-u_xlat33)>=u_xlat12;
#endif
    u_xlat12 = u_xlat1.x * _HeigtFogColDelta.w;
    u_xlat33 = (u_xlatb33) ? u_xlat12 : u_xlat1.x;
    u_xlat33 = log2(u_xlat33);
    u_xlat33 = u_xlat33 * unity_FogColor.w;
    u_xlat33 = exp2(u_xlat33);
    u_xlat33 = min(u_xlat33, _HeigtFogColBase.w);
    u_xlat1.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_36 = (-u_xlat1.x) + 2.0;
    u_xlat16_36 = u_xlat1.x * u_xlat16_36;
    u_xlat1.xyz = vec3(u_xlat16_36) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat34 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat34 = u_xlat34 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat1.xyz = vec3(u_xlat34) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat34 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat34));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat34);
#endif
    u_xlat13 = u_xlat34 * -1.44269502;
    u_xlat13 = exp2(u_xlat13);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat34 = u_xlat13 / u_xlat34;
    u_xlat16_36 = (u_xlatb2) ? u_xlat34 : 1.0;
    u_xlat11 = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb34 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat2.x = u_xlat11 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat11 = u_xlat2.x / u_xlat11;
    u_xlat16_10 = (u_xlatb34) ? u_xlat11 : 1.0;
    u_xlat11 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_36 = u_xlat22 * u_xlat16_36;
    u_xlat16_10 = u_xlat11 * u_xlat16_10;
    u_xlat16_36 = exp2((-u_xlat16_36));
    u_xlat16_36 = (-u_xlat16_36) + 1.0;
    u_xlat16_36 = max(u_xlat16_36, 0.0);
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_10 = (-u_xlat16_10) + 1.0;
    u_xlat16_10 = max(u_xlat16_10, 0.0);
    u_xlat16_36 = u_xlat16_36 + u_xlat16_10;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat0.x) + 2.0;
    u_xlat16_10 = u_xlat0.x * u_xlat16_10;
    u_xlat0.x = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_36 = u_xlat0.x * u_xlat16_36;
    u_xlat0.x = min(u_xlat16_36, _HeigtFogColBase.w);
    u_xlat11 = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat11) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat11 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat11) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.x = (-u_xlat33) + 1.0;
    u_xlat0.x = u_xlat11 * u_xlat0.x;
    u_xlat5.xyz = u_xlat0.xxx * u_xlat16_3.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat5;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_HIGH" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _VertexAniSpeed;
uniform 	mediump float _VertexAniScale;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
float u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat10;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
float u_xlat24;
int u_xlati24;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.y = _Time.y * _VertexAniSpeed;
    u_xlat0.x = 0.0;
    u_xlat16_1.xy = u_xlat0.xy + in_TEXCOORD0.xy;
    u_xlat0.x = textureLod(_MainTex, u_xlat16_1.xy, 0.0).y;
    u_xlat0.x = u_xlat0.x * 0.800000012 + -0.400000006;
    u_xlat0.xyz = u_xlat0.xxx * abs(in_NORMAL0.xyz);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat24 = textureLod(_MainTex, u_xlat2.xy, 0.0).z;
    vs_TEXCOORD2.xy = u_xlat2.xy;
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniScale, _VertexAniScale, _VertexAniScale)) + in_POSITION0.xyz;
    u_xlati24 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati24 = u_xlati24 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat0.xyz = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat3 = u_xlat26 * -1.44269502;
    u_xlat3 = exp2(u_xlat3);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_4.x = (u_xlatb26) ? u_xlat3 : 1.0;
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat3 = u_xlat26 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat3 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat11 = u_xlat3 * -1.44269502;
    u_xlat11 = exp2(u_xlat11);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat11 = u_xlat11 / u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3);
#endif
    u_xlat16_12 = (u_xlatb3) ? u_xlat11 : 1.0;
    u_xlat3 = u_xlat26 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat3 = u_xlat26 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat3) + 2.0;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat3 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat3 = u_xlat3 + 1.0;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat3 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat11 = (-u_xlat3) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat10.x);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat10.x;
#endif
    u_xlat10.x = u_xlat26 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat26 + (-_HeigtFogRamp.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat10.x) + 2.0;
    u_xlat10.x = u_xlat26 * u_xlat10.x;
    u_xlat26 = u_xlat10.x * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat26 : u_xlat10.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat10.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat10.x) + 2.0;
    u_xlat16_4.x = u_xlat10.x * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat10.xyz = vec3(u_xlat18) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat10.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat11 * u_xlat2.x;
    u_xlat2.xyz = vec3(u_xlat11) * u_xlat10.xyz;
    u_xlat26 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat26) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat3) + u_xlat2.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_4.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_4.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec3 _EmissionColor;
uniform 	float _ShadowIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
bvec4 u_xlatb6;
vec4 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
float u_xlat12;
float u_xlat13;
mediump vec2 u_xlat16_14;
float u_xlat22;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
lowp float u_xlat10_34;
int u_xlati34;
uint u_xlatu34;
bool u_xlatb34;
mediump float u_xlat16_35;
mediump float u_xlat16_36;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat4 = vs_COLOR0 * _MainColor;
    u_xlat10_34 = texture(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat34 = u_xlat4.w * u_xlat10_34;
    u_xlat5.w = u_xlat34 * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.w = min(max(u_xlat5.w, 0.0), 1.0);
#else
    u_xlat5.w = clamp(u_xlat5.w, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat7.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat8.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.y = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat6.z = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat6.w = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlatb6 = lessThan(u_xlat6, unity_ShadowSplitSqRadii);
    u_xlat6 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb6));
    u_xlat16_14.x = u_xlat6.y + u_xlat6.x;
    u_xlat16_14.y = u_xlat6.z + u_xlat16_14.x;
    u_xlat7.x = -0.0;
    u_xlat7.y = (-u_xlat6.x);
    u_xlat7.zw = (-u_xlat16_14.xy);
    u_xlat6 = u_xlat6 + u_xlat7;
    u_xlat6 = max(u_xlat6, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_14.x = dot(u_xlat6, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat16_14.x>=0.5);
#else
    u_xlatb34 = u_xlat16_14.x>=0.5;
#endif
    if(u_xlatb34){
        u_xlat34 = dot(u_xlat6.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat34 = min(u_xlat34, 3.0);
        u_xlatu34 = uint(u_xlat34);
        u_xlat6.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowPos[int(u_xlatu34)].xyz);
        u_xlati34 = int(u_xlatu34) << 2;
        u_xlat7.xyz = u_xlat6.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 1)].xyz;
        u_xlat6.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati34].xyz * u_xlat6.xxx + u_xlat7.xyz;
        u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 2)].xyz * u_xlat6.zzz + u_xlat6.xyw;
        u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
        u_xlat10_34 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_35 = (-_LightShadowData.x) + 1.0;
        u_xlat34 = u_xlat10_34 * u_xlat16_35 + _LightShadowData.x;
    } else {
        u_xlat34 = 1.0;
    //ENDIF
    }
    u_xlat34 = u_xlat34 + -1.0;
    u_xlat34 = _ShadowIntensity * u_xlat34 + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _LightColor0.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(u_xlat34) + vs_TEXCOORD1.xyz;
    u_xlat16_3.xyz = u_xlat2.xyz * vec3(u_xlat33) + u_xlat1.xyz;
    u_xlat16_36 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_36 = inversesqrt(u_xlat16_36);
    u_xlat16_3.xyz = vec3(u_xlat16_36) * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat11 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * -0.0394039154 + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = 0.960596085 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat16_3.x = u_xlat11 * u_xlat11;
    u_xlat16_3.x = u_xlat11 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat11 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat11 * u_xlat16_3.x;
    u_xlat16_11 = u_xlat16_3.x * 0.0756555125 + 0.0399999991;
    u_xlat22 = u_xlat16_11 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + 2.0;
    u_xlat0.x = u_xlat22 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat16_3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_3.xyz = vec3(u_xlat34) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat6.xyz * u_xlat4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + _EmissionColor.xyz;
    u_xlat0.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat22 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat1.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat1.x) + 2.0;
    u_xlat1.x = u_xlat12 * u_xlat1.x;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!((-u_xlat33)>=u_xlat12);
#else
    u_xlatb33 = (-u_xlat33)>=u_xlat12;
#endif
    u_xlat12 = u_xlat1.x * _HeigtFogColDelta.w;
    u_xlat33 = (u_xlatb33) ? u_xlat12 : u_xlat1.x;
    u_xlat33 = log2(u_xlat33);
    u_xlat33 = u_xlat33 * unity_FogColor.w;
    u_xlat33 = exp2(u_xlat33);
    u_xlat33 = min(u_xlat33, _HeigtFogColBase.w);
    u_xlat1.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_36 = (-u_xlat1.x) + 2.0;
    u_xlat16_36 = u_xlat1.x * u_xlat16_36;
    u_xlat1.xyz = vec3(u_xlat16_36) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat34 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat34 = u_xlat34 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat1.xyz = vec3(u_xlat34) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat34 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat34));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat34);
#endif
    u_xlat13 = u_xlat34 * -1.44269502;
    u_xlat13 = exp2(u_xlat13);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat34 = u_xlat13 / u_xlat34;
    u_xlat16_36 = (u_xlatb2) ? u_xlat34 : 1.0;
    u_xlat11 = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb34 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat2.x = u_xlat11 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat11 = u_xlat2.x / u_xlat11;
    u_xlat16_10 = (u_xlatb34) ? u_xlat11 : 1.0;
    u_xlat11 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_36 = u_xlat22 * u_xlat16_36;
    u_xlat16_10 = u_xlat11 * u_xlat16_10;
    u_xlat16_36 = exp2((-u_xlat16_36));
    u_xlat16_36 = (-u_xlat16_36) + 1.0;
    u_xlat16_36 = max(u_xlat16_36, 0.0);
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_10 = (-u_xlat16_10) + 1.0;
    u_xlat16_10 = max(u_xlat16_10, 0.0);
    u_xlat16_36 = u_xlat16_36 + u_xlat16_10;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat0.x) + 2.0;
    u_xlat16_10 = u_xlat0.x * u_xlat16_10;
    u_xlat0.x = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_36 = u_xlat0.x * u_xlat16_36;
    u_xlat0.x = min(u_xlat16_36, _HeigtFogColBase.w);
    u_xlat11 = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat11) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat11 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat11) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.x = (-u_xlat33) + 1.0;
    u_xlat0.x = u_xlat11 * u_xlat0.x;
    u_xlat5.xyz = u_xlat0.xxx * u_xlat16_3.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat5;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _VertexAniSpeed;
uniform 	mediump float _VertexAniScale;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform lowp sampler2D _MainTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat9;
mediump float u_xlat16_10;
vec3 u_xlat11;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
bool u_xlatb23;
float u_xlat26;
void main()
{
    u_xlat0.y = _Time.y * _VertexAniSpeed;
    u_xlat0.x = 0.0;
    u_xlat16_1.xy = u_xlat0.xy + in_TEXCOORD0.xy;
    u_xlat0.x = textureLod(_MainTex, u_xlat16_1.xy, 0.0).y;
    u_xlat0.x = u_xlat0.x * 0.800000012 + -0.400000006;
    u_xlat0.xyz = u_xlat0.xxx * abs(in_NORMAL0.xyz);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat21 = textureLod(_MainTex, u_xlat2.xy, 0.0).z;
    vs_TEXCOORD2.xy = u_xlat2.xy;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniScale, _VertexAniScale, _VertexAniScale)) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat23 = u_xlat21 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.00999999978<abs(u_xlat21));
#else
    u_xlatb21 = 0.00999999978<abs(u_xlat21);
#endif
    u_xlat16_3.x = (u_xlatb21) ? u_xlat23 : 1.0;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat23 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat4 = u_xlat23 * -1.44269502;
    u_xlat4 = exp2(u_xlat4);
    u_xlat4 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat23;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat16_10 = (u_xlatb23) ? u_xlat4 : 1.0;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat23 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat23 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat23) + 2.0;
    u_xlat16_10 = u_xlat23 * u_xlat16_10;
    u_xlat23 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat23 = u_xlat23 + 1.0;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat23 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat23) + 1.0;
    u_xlat11.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat11.x) + 2.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat11.x;
    u_xlat11.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat11.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat26 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat21 = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat26 = u_xlat26 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat11.xyz = vec3(u_xlat26) * u_xlat5.xyz + u_xlat11.xyz;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat9);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat9;
#endif
    u_xlat9 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat9;
    u_xlat9 = u_xlat21 * _HeigtFogColDelta.w;
    u_xlat21 = (u_xlatb2) ? u_xlat9 : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * unity_FogColor.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColBase.w);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat11.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    vs_TEXCOORD0.w = u_xlat4 * u_xlat21;
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat23) + u_xlat2.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec3 _EmissionColor;
uniform 	float _ShadowIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
bvec4 u_xlatb6;
vec4 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
float u_xlat12;
float u_xlat13;
mediump vec2 u_xlat16_14;
float u_xlat22;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
lowp float u_xlat10_34;
int u_xlati34;
uint u_xlatu34;
bool u_xlatb34;
mediump float u_xlat16_35;
mediump float u_xlat16_36;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat4 = vs_COLOR0 * _MainColor;
    u_xlat10_34 = texture(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat34 = u_xlat4.w * u_xlat10_34;
    u_xlat5.w = u_xlat34 * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.w = min(max(u_xlat5.w, 0.0), 1.0);
#else
    u_xlat5.w = clamp(u_xlat5.w, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat7.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat8.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.y = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat6.z = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat6.w = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlatb6 = lessThan(u_xlat6, unity_ShadowSplitSqRadii);
    u_xlat6 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb6));
    u_xlat16_14.x = u_xlat6.y + u_xlat6.x;
    u_xlat16_14.y = u_xlat6.z + u_xlat16_14.x;
    u_xlat7.x = -0.0;
    u_xlat7.y = (-u_xlat6.x);
    u_xlat7.zw = (-u_xlat16_14.xy);
    u_xlat6 = u_xlat6 + u_xlat7;
    u_xlat6 = max(u_xlat6, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_14.x = dot(u_xlat6, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat16_14.x>=0.5);
#else
    u_xlatb34 = u_xlat16_14.x>=0.5;
#endif
    if(u_xlatb34){
        u_xlat34 = dot(u_xlat6.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat34 = min(u_xlat34, 3.0);
        u_xlatu34 = uint(u_xlat34);
        u_xlat6.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowPos[int(u_xlatu34)].xyz);
        u_xlati34 = int(u_xlatu34) << 2;
        u_xlat7.xyz = u_xlat6.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 1)].xyz;
        u_xlat6.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati34].xyz * u_xlat6.xxx + u_xlat7.xyz;
        u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 2)].xyz * u_xlat6.zzz + u_xlat6.xyw;
        u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
        u_xlat10_34 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_35 = (-_LightShadowData.x) + 1.0;
        u_xlat34 = u_xlat10_34 * u_xlat16_35 + _LightShadowData.x;
    } else {
        u_xlat34 = 1.0;
    //ENDIF
    }
    u_xlat34 = u_xlat34 + -1.0;
    u_xlat34 = _ShadowIntensity * u_xlat34 + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _LightColor0.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(u_xlat34) + vs_TEXCOORD1.xyz;
    u_xlat16_3.xyz = u_xlat2.xyz * vec3(u_xlat33) + u_xlat1.xyz;
    u_xlat16_36 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_36 = inversesqrt(u_xlat16_36);
    u_xlat16_3.xyz = vec3(u_xlat16_36) * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat11 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * -0.0394039154 + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = 0.960596085 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat16_3.x = u_xlat11 * u_xlat11;
    u_xlat16_3.x = u_xlat11 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat11 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat11 * u_xlat16_3.x;
    u_xlat16_11 = u_xlat16_3.x * 0.0756555125 + 0.0399999991;
    u_xlat22 = u_xlat16_11 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + 2.0;
    u_xlat0.x = u_xlat22 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat16_3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_3.xyz = vec3(u_xlat34) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat6.xyz * u_xlat4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + _EmissionColor.xyz;
    u_xlat0.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat22 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat1.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat1.x) + 2.0;
    u_xlat1.x = u_xlat12 * u_xlat1.x;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!((-u_xlat33)>=u_xlat12);
#else
    u_xlatb33 = (-u_xlat33)>=u_xlat12;
#endif
    u_xlat12 = u_xlat1.x * _HeigtFogColDelta.w;
    u_xlat33 = (u_xlatb33) ? u_xlat12 : u_xlat1.x;
    u_xlat33 = log2(u_xlat33);
    u_xlat33 = u_xlat33 * unity_FogColor.w;
    u_xlat33 = exp2(u_xlat33);
    u_xlat33 = min(u_xlat33, _HeigtFogColBase.w);
    u_xlat1.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_36 = (-u_xlat1.x) + 2.0;
    u_xlat16_36 = u_xlat1.x * u_xlat16_36;
    u_xlat1.xyz = vec3(u_xlat16_36) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat34 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat34 = u_xlat34 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat1.xyz = vec3(u_xlat34) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat34 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat34));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat34);
#endif
    u_xlat13 = u_xlat34 * -1.44269502;
    u_xlat13 = exp2(u_xlat13);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat34 = u_xlat13 / u_xlat34;
    u_xlat16_36 = (u_xlatb2) ? u_xlat34 : 1.0;
    u_xlat11 = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb34 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat2.x = u_xlat11 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat11 = u_xlat2.x / u_xlat11;
    u_xlat16_10 = (u_xlatb34) ? u_xlat11 : 1.0;
    u_xlat11 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_36 = u_xlat22 * u_xlat16_36;
    u_xlat16_10 = u_xlat11 * u_xlat16_10;
    u_xlat16_36 = exp2((-u_xlat16_36));
    u_xlat16_36 = (-u_xlat16_36) + 1.0;
    u_xlat16_36 = max(u_xlat16_36, 0.0);
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_10 = (-u_xlat16_10) + 1.0;
    u_xlat16_10 = max(u_xlat16_10, 0.0);
    u_xlat16_36 = u_xlat16_36 + u_xlat16_10;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat0.x) + 2.0;
    u_xlat16_10 = u_xlat0.x * u_xlat16_10;
    u_xlat0.x = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_36 = u_xlat0.x * u_xlat16_36;
    u_xlat0.x = min(u_xlat16_36, _HeigtFogColBase.w);
    u_xlat11 = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat11) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat11 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat11) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.x = (-u_xlat33) + 1.0;
    u_xlat0.x = u_xlat11 * u_xlat0.x;
    u_xlat5.xyz = u_xlat0.xxx * u_xlat16_3.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat5;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_MIDDLE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _VertexAniSpeed;
uniform 	mediump float _VertexAniScale;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
float u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat10;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
float u_xlat24;
int u_xlati24;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.y = _Time.y * _VertexAniSpeed;
    u_xlat0.x = 0.0;
    u_xlat16_1.xy = u_xlat0.xy + in_TEXCOORD0.xy;
    u_xlat0.x = textureLod(_MainTex, u_xlat16_1.xy, 0.0).y;
    u_xlat0.x = u_xlat0.x * 0.800000012 + -0.400000006;
    u_xlat0.xyz = u_xlat0.xxx * abs(in_NORMAL0.xyz);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat24 = textureLod(_MainTex, u_xlat2.xy, 0.0).z;
    vs_TEXCOORD2.xy = u_xlat2.xy;
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniScale, _VertexAniScale, _VertexAniScale)) + in_POSITION0.xyz;
    u_xlati24 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati24 = u_xlati24 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat0.xyz = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat3 = u_xlat26 * -1.44269502;
    u_xlat3 = exp2(u_xlat3);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_4.x = (u_xlatb26) ? u_xlat3 : 1.0;
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat3 = u_xlat26 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat3 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat11 = u_xlat3 * -1.44269502;
    u_xlat11 = exp2(u_xlat11);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat11 = u_xlat11 / u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3);
#endif
    u_xlat16_12 = (u_xlatb3) ? u_xlat11 : 1.0;
    u_xlat3 = u_xlat26 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat3 = u_xlat26 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat3) + 2.0;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat3 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat3 = u_xlat3 + 1.0;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat3 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat11 = (-u_xlat3) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat10.x);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat10.x;
#endif
    u_xlat10.x = u_xlat26 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat26 + (-_HeigtFogRamp.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat10.x) + 2.0;
    u_xlat10.x = u_xlat26 * u_xlat10.x;
    u_xlat26 = u_xlat10.x * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat26 : u_xlat10.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat10.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat10.x) + 2.0;
    u_xlat16_4.x = u_xlat10.x * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat10.xyz = vec3(u_xlat18) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat10.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat11 * u_xlat2.x;
    u_xlat2.xyz = vec3(u_xlat11) * u_xlat10.xyz;
    u_xlat26 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat26) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat3) + u_xlat2.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_4.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_4.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec3 _EmissionColor;
uniform 	float _ShadowIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
bvec4 u_xlatb6;
vec4 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
float u_xlat12;
float u_xlat13;
mediump vec2 u_xlat16_14;
float u_xlat22;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
lowp float u_xlat10_34;
int u_xlati34;
uint u_xlatu34;
bool u_xlatb34;
mediump float u_xlat16_35;
mediump float u_xlat16_36;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat4 = vs_COLOR0 * _MainColor;
    u_xlat10_34 = texture(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat34 = u_xlat4.w * u_xlat10_34;
    u_xlat5.w = u_xlat34 * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.w = min(max(u_xlat5.w, 0.0), 1.0);
#else
    u_xlat5.w = clamp(u_xlat5.w, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat7.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat8.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.y = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat6.z = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat6.w = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlatb6 = lessThan(u_xlat6, unity_ShadowSplitSqRadii);
    u_xlat6 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb6));
    u_xlat16_14.x = u_xlat6.y + u_xlat6.x;
    u_xlat16_14.y = u_xlat6.z + u_xlat16_14.x;
    u_xlat7.x = -0.0;
    u_xlat7.y = (-u_xlat6.x);
    u_xlat7.zw = (-u_xlat16_14.xy);
    u_xlat6 = u_xlat6 + u_xlat7;
    u_xlat6 = max(u_xlat6, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_14.x = dot(u_xlat6, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat16_14.x>=0.5);
#else
    u_xlatb34 = u_xlat16_14.x>=0.5;
#endif
    if(u_xlatb34){
        u_xlat34 = dot(u_xlat6.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat34 = min(u_xlat34, 3.0);
        u_xlatu34 = uint(u_xlat34);
        u_xlat6.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowPos[int(u_xlatu34)].xyz);
        u_xlati34 = int(u_xlatu34) << 2;
        u_xlat7.xyz = u_xlat6.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 1)].xyz;
        u_xlat6.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati34].xyz * u_xlat6.xxx + u_xlat7.xyz;
        u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 2)].xyz * u_xlat6.zzz + u_xlat6.xyw;
        u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
        u_xlat10_34 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_35 = (-_LightShadowData.x) + 1.0;
        u_xlat34 = u_xlat10_34 * u_xlat16_35 + _LightShadowData.x;
    } else {
        u_xlat34 = 1.0;
    //ENDIF
    }
    u_xlat34 = u_xlat34 + -1.0;
    u_xlat34 = _ShadowIntensity * u_xlat34 + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _LightColor0.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(u_xlat34) + vs_TEXCOORD1.xyz;
    u_xlat16_3.xyz = u_xlat2.xyz * vec3(u_xlat33) + u_xlat1.xyz;
    u_xlat16_36 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_36 = inversesqrt(u_xlat16_36);
    u_xlat16_3.xyz = vec3(u_xlat16_36) * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat11 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * -0.0394039154 + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = 0.960596085 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat16_3.x = u_xlat11 * u_xlat11;
    u_xlat16_3.x = u_xlat11 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat11 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat11 * u_xlat16_3.x;
    u_xlat16_11 = u_xlat16_3.x * 0.0756555125 + 0.0399999991;
    u_xlat22 = u_xlat16_11 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + 2.0;
    u_xlat0.x = u_xlat22 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat16_3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_3.xyz = vec3(u_xlat34) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat6.xyz * u_xlat4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + _EmissionColor.xyz;
    u_xlat0.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat22 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat1.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat1.x) + 2.0;
    u_xlat1.x = u_xlat12 * u_xlat1.x;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!((-u_xlat33)>=u_xlat12);
#else
    u_xlatb33 = (-u_xlat33)>=u_xlat12;
#endif
    u_xlat12 = u_xlat1.x * _HeigtFogColDelta.w;
    u_xlat33 = (u_xlatb33) ? u_xlat12 : u_xlat1.x;
    u_xlat33 = log2(u_xlat33);
    u_xlat33 = u_xlat33 * unity_FogColor.w;
    u_xlat33 = exp2(u_xlat33);
    u_xlat33 = min(u_xlat33, _HeigtFogColBase.w);
    u_xlat1.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_36 = (-u_xlat1.x) + 2.0;
    u_xlat16_36 = u_xlat1.x * u_xlat16_36;
    u_xlat1.xyz = vec3(u_xlat16_36) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat34 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat34 = u_xlat34 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat1.xyz = vec3(u_xlat34) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat34 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat34));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat34);
#endif
    u_xlat13 = u_xlat34 * -1.44269502;
    u_xlat13 = exp2(u_xlat13);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat34 = u_xlat13 / u_xlat34;
    u_xlat16_36 = (u_xlatb2) ? u_xlat34 : 1.0;
    u_xlat11 = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb34 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat2.x = u_xlat11 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat11 = u_xlat2.x / u_xlat11;
    u_xlat16_10 = (u_xlatb34) ? u_xlat11 : 1.0;
    u_xlat11 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_36 = u_xlat22 * u_xlat16_36;
    u_xlat16_10 = u_xlat11 * u_xlat16_10;
    u_xlat16_36 = exp2((-u_xlat16_36));
    u_xlat16_36 = (-u_xlat16_36) + 1.0;
    u_xlat16_36 = max(u_xlat16_36, 0.0);
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_10 = (-u_xlat16_10) + 1.0;
    u_xlat16_10 = max(u_xlat16_10, 0.0);
    u_xlat16_36 = u_xlat16_36 + u_xlat16_10;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat0.x) + 2.0;
    u_xlat16_10 = u_xlat0.x * u_xlat16_10;
    u_xlat0.x = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_36 = u_xlat0.x * u_xlat16_36;
    u_xlat0.x = min(u_xlat16_36, _HeigtFogColBase.w);
    u_xlat11 = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat11) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat11 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat11) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.x = (-u_xlat33) + 1.0;
    u_xlat0.x = u_xlat11 * u_xlat0.x;
    u_xlat5.xyz = u_xlat0.xxx * u_xlat16_3.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat5;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _VertexAniSpeed;
uniform 	mediump float _VertexAniScale;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform lowp sampler2D _MainTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat9;
mediump float u_xlat16_10;
vec3 u_xlat11;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
bool u_xlatb23;
float u_xlat26;
void main()
{
    u_xlat0.y = _Time.y * _VertexAniSpeed;
    u_xlat0.x = 0.0;
    u_xlat16_1.xy = u_xlat0.xy + in_TEXCOORD0.xy;
    u_xlat0.x = textureLod(_MainTex, u_xlat16_1.xy, 0.0).y;
    u_xlat0.x = u_xlat0.x * 0.800000012 + -0.400000006;
    u_xlat0.xyz = u_xlat0.xxx * abs(in_NORMAL0.xyz);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat21 = textureLod(_MainTex, u_xlat2.xy, 0.0).z;
    vs_TEXCOORD2.xy = u_xlat2.xy;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniScale, _VertexAniScale, _VertexAniScale)) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat23 = u_xlat21 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.00999999978<abs(u_xlat21));
#else
    u_xlatb21 = 0.00999999978<abs(u_xlat21);
#endif
    u_xlat16_3.x = (u_xlatb21) ? u_xlat23 : 1.0;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat23 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat4 = u_xlat23 * -1.44269502;
    u_xlat4 = exp2(u_xlat4);
    u_xlat4 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat23;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat16_10 = (u_xlatb23) ? u_xlat4 : 1.0;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat23 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat23 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat23) + 2.0;
    u_xlat16_10 = u_xlat23 * u_xlat16_10;
    u_xlat23 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat23 = u_xlat23 + 1.0;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat23 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat23) + 1.0;
    u_xlat11.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat11.x) + 2.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat11.x;
    u_xlat11.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat11.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat26 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat21 = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat26 = u_xlat26 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat11.xyz = vec3(u_xlat26) * u_xlat5.xyz + u_xlat11.xyz;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat9);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat9;
#endif
    u_xlat9 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat9;
    u_xlat9 = u_xlat21 * _HeigtFogColDelta.w;
    u_xlat21 = (u_xlatb2) ? u_xlat9 : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * unity_FogColor.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColBase.w);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat11.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    vs_TEXCOORD0.w = u_xlat4 * u_xlat21;
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat23) + u_xlat2.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec3 _EmissionColor;
uniform 	float _ShadowIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
bvec4 u_xlatb6;
vec4 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
float u_xlat12;
float u_xlat13;
mediump vec2 u_xlat16_14;
float u_xlat22;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
lowp float u_xlat10_34;
int u_xlati34;
uint u_xlatu34;
bool u_xlatb34;
mediump float u_xlat16_35;
mediump float u_xlat16_36;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat4 = vs_COLOR0 * _MainColor;
    u_xlat10_34 = texture(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat34 = u_xlat4.w * u_xlat10_34;
    u_xlat5.w = u_xlat34 * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.w = min(max(u_xlat5.w, 0.0), 1.0);
#else
    u_xlat5.w = clamp(u_xlat5.w, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat7.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat8.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.y = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat6.z = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat6.w = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlatb6 = lessThan(u_xlat6, unity_ShadowSplitSqRadii);
    u_xlat6 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb6));
    u_xlat16_14.x = u_xlat6.y + u_xlat6.x;
    u_xlat16_14.y = u_xlat6.z + u_xlat16_14.x;
    u_xlat7.x = -0.0;
    u_xlat7.y = (-u_xlat6.x);
    u_xlat7.zw = (-u_xlat16_14.xy);
    u_xlat6 = u_xlat6 + u_xlat7;
    u_xlat6 = max(u_xlat6, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_14.x = dot(u_xlat6, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat16_14.x>=0.5);
#else
    u_xlatb34 = u_xlat16_14.x>=0.5;
#endif
    if(u_xlatb34){
        u_xlat34 = dot(u_xlat6.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat34 = min(u_xlat34, 3.0);
        u_xlatu34 = uint(u_xlat34);
        u_xlat6.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowPos[int(u_xlatu34)].xyz);
        u_xlati34 = int(u_xlatu34) << 2;
        u_xlat7.xyz = u_xlat6.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 1)].xyz;
        u_xlat6.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati34].xyz * u_xlat6.xxx + u_xlat7.xyz;
        u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 2)].xyz * u_xlat6.zzz + u_xlat6.xyw;
        u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
        u_xlat10_34 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_35 = (-_LightShadowData.x) + 1.0;
        u_xlat34 = u_xlat10_34 * u_xlat16_35 + _LightShadowData.x;
    } else {
        u_xlat34 = 1.0;
    //ENDIF
    }
    u_xlat34 = u_xlat34 + -1.0;
    u_xlat34 = _ShadowIntensity * u_xlat34 + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _LightColor0.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(u_xlat34) + vs_TEXCOORD1.xyz;
    u_xlat16_3.xyz = u_xlat2.xyz * vec3(u_xlat33) + u_xlat1.xyz;
    u_xlat16_36 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_36 = inversesqrt(u_xlat16_36);
    u_xlat16_3.xyz = vec3(u_xlat16_36) * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat11 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * -0.0394039154 + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = 0.960596085 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat16_3.x = u_xlat11 * u_xlat11;
    u_xlat16_3.x = u_xlat11 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat11 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat11 * u_xlat16_3.x;
    u_xlat16_11 = u_xlat16_3.x * 0.0756555125 + 0.0399999991;
    u_xlat22 = u_xlat16_11 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + 2.0;
    u_xlat0.x = u_xlat22 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat16_3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_3.xyz = vec3(u_xlat34) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat6.xyz * u_xlat4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + _EmissionColor.xyz;
    u_xlat0.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat22 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat1.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat1.x) + 2.0;
    u_xlat1.x = u_xlat12 * u_xlat1.x;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!((-u_xlat33)>=u_xlat12);
#else
    u_xlatb33 = (-u_xlat33)>=u_xlat12;
#endif
    u_xlat12 = u_xlat1.x * _HeigtFogColDelta.w;
    u_xlat33 = (u_xlatb33) ? u_xlat12 : u_xlat1.x;
    u_xlat33 = log2(u_xlat33);
    u_xlat33 = u_xlat33 * unity_FogColor.w;
    u_xlat33 = exp2(u_xlat33);
    u_xlat33 = min(u_xlat33, _HeigtFogColBase.w);
    u_xlat1.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_36 = (-u_xlat1.x) + 2.0;
    u_xlat16_36 = u_xlat1.x * u_xlat16_36;
    u_xlat1.xyz = vec3(u_xlat16_36) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat34 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat34 = u_xlat34 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat1.xyz = vec3(u_xlat34) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat34 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat34));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat34);
#endif
    u_xlat13 = u_xlat34 * -1.44269502;
    u_xlat13 = exp2(u_xlat13);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat34 = u_xlat13 / u_xlat34;
    u_xlat16_36 = (u_xlatb2) ? u_xlat34 : 1.0;
    u_xlat11 = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb34 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat2.x = u_xlat11 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat11 = u_xlat2.x / u_xlat11;
    u_xlat16_10 = (u_xlatb34) ? u_xlat11 : 1.0;
    u_xlat11 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_36 = u_xlat22 * u_xlat16_36;
    u_xlat16_10 = u_xlat11 * u_xlat16_10;
    u_xlat16_36 = exp2((-u_xlat16_36));
    u_xlat16_36 = (-u_xlat16_36) + 1.0;
    u_xlat16_36 = max(u_xlat16_36, 0.0);
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_10 = (-u_xlat16_10) + 1.0;
    u_xlat16_10 = max(u_xlat16_10, 0.0);
    u_xlat16_36 = u_xlat16_36 + u_xlat16_10;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat0.x) + 2.0;
    u_xlat16_10 = u_xlat0.x * u_xlat16_10;
    u_xlat0.x = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_36 = u_xlat0.x * u_xlat16_36;
    u_xlat0.x = min(u_xlat16_36, _HeigtFogColBase.w);
    u_xlat11 = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat11) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat11 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat11) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.x = (-u_xlat33) + 1.0;
    u_xlat0.x = u_xlat11 * u_xlat0.x;
    u_xlat5.xyz = u_xlat0.xxx * u_xlat16_3.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat5;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_LOW" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _VertexAniSpeed;
uniform 	mediump float _VertexAniScale;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
float u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat10;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
float u_xlat24;
int u_xlati24;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.y = _Time.y * _VertexAniSpeed;
    u_xlat0.x = 0.0;
    u_xlat16_1.xy = u_xlat0.xy + in_TEXCOORD0.xy;
    u_xlat0.x = textureLod(_MainTex, u_xlat16_1.xy, 0.0).y;
    u_xlat0.x = u_xlat0.x * 0.800000012 + -0.400000006;
    u_xlat0.xyz = u_xlat0.xxx * abs(in_NORMAL0.xyz);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat24 = textureLod(_MainTex, u_xlat2.xy, 0.0).z;
    vs_TEXCOORD2.xy = u_xlat2.xy;
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniScale, _VertexAniScale, _VertexAniScale)) + in_POSITION0.xyz;
    u_xlati24 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati24 = u_xlati24 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat0.xyz = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat3 = u_xlat26 * -1.44269502;
    u_xlat3 = exp2(u_xlat3);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_4.x = (u_xlatb26) ? u_xlat3 : 1.0;
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat3 = u_xlat26 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat3 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat11 = u_xlat3 * -1.44269502;
    u_xlat11 = exp2(u_xlat11);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat11 = u_xlat11 / u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3);
#endif
    u_xlat16_12 = (u_xlatb3) ? u_xlat11 : 1.0;
    u_xlat3 = u_xlat26 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat3 = u_xlat26 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat3) + 2.0;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat3 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat3 = u_xlat3 + 1.0;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat3 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat11 = (-u_xlat3) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat10.x);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat10.x;
#endif
    u_xlat10.x = u_xlat26 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat26 + (-_HeigtFogRamp.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat10.x) + 2.0;
    u_xlat10.x = u_xlat26 * u_xlat10.x;
    u_xlat26 = u_xlat10.x * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat26 : u_xlat10.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat10.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat10.x) + 2.0;
    u_xlat16_4.x = u_xlat10.x * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat10.xyz = vec3(u_xlat18) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat10.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat11 * u_xlat2.x;
    u_xlat2.xyz = vec3(u_xlat11) * u_xlat10.xyz;
    u_xlat26 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat26) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat3) + u_xlat2.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_4.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_4.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec3 _EmissionColor;
uniform 	float _ShadowIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
bvec4 u_xlatb6;
vec4 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
float u_xlat12;
float u_xlat13;
mediump vec2 u_xlat16_14;
float u_xlat22;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
lowp float u_xlat10_34;
int u_xlati34;
uint u_xlatu34;
bool u_xlatb34;
mediump float u_xlat16_35;
mediump float u_xlat16_36;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat4 = vs_COLOR0 * _MainColor;
    u_xlat10_34 = texture(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat34 = u_xlat4.w * u_xlat10_34;
    u_xlat5.w = u_xlat34 * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.w = min(max(u_xlat5.w, 0.0), 1.0);
#else
    u_xlat5.w = clamp(u_xlat5.w, 0.0, 1.0);
#endif
    u_xlat6.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat7.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat8.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat6.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.y = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat6.z = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat6.w = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlatb6 = lessThan(u_xlat6, unity_ShadowSplitSqRadii);
    u_xlat6 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb6));
    u_xlat16_14.x = u_xlat6.y + u_xlat6.x;
    u_xlat16_14.y = u_xlat6.z + u_xlat16_14.x;
    u_xlat7.x = -0.0;
    u_xlat7.y = (-u_xlat6.x);
    u_xlat7.zw = (-u_xlat16_14.xy);
    u_xlat6 = u_xlat6 + u_xlat7;
    u_xlat6 = max(u_xlat6, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_14.x = dot(u_xlat6, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat16_14.x>=0.5);
#else
    u_xlatb34 = u_xlat16_14.x>=0.5;
#endif
    if(u_xlatb34){
        u_xlat34 = dot(u_xlat6.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat34 = min(u_xlat34, 3.0);
        u_xlatu34 = uint(u_xlat34);
        u_xlat6.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowPos[int(u_xlatu34)].xyz);
        u_xlati34 = int(u_xlatu34) << 2;
        u_xlat7.xyz = u_xlat6.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 1)].xyz;
        u_xlat6.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati34].xyz * u_xlat6.xxx + u_xlat7.xyz;
        u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 2)].xyz * u_xlat6.zzz + u_xlat6.xyw;
        u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat6.xy,u_xlat6.z);
        u_xlat10_34 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_35 = (-_LightShadowData.x) + 1.0;
        u_xlat34 = u_xlat10_34 * u_xlat16_35 + _LightShadowData.x;
    } else {
        u_xlat34 = 1.0;
    //ENDIF
    }
    u_xlat34 = u_xlat34 + -1.0;
    u_xlat34 = _ShadowIntensity * u_xlat34 + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xxx * _LightColor0.xyz;
    u_xlat6.xyz = u_xlat16_3.xyz * vec3(u_xlat34) + vs_TEXCOORD1.xyz;
    u_xlat16_3.xyz = u_xlat2.xyz * vec3(u_xlat33) + u_xlat1.xyz;
    u_xlat16_36 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_36 = inversesqrt(u_xlat16_36);
    u_xlat16_3.xyz = vec3(u_xlat16_36) * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat11 = dot(u_xlat1.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * -0.0394039154 + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = 0.960596085 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat16_3.x = u_xlat11 * u_xlat11;
    u_xlat16_3.x = u_xlat11 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat11 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat11 * u_xlat16_3.x;
    u_xlat16_11 = u_xlat16_3.x * 0.0756555125 + 0.0399999991;
    u_xlat22 = u_xlat16_11 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + 2.0;
    u_xlat0.x = u_xlat22 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat16_3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_3.xyz = vec3(u_xlat34) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat6.xyz * u_xlat4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + _EmissionColor.xyz;
    u_xlat0.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat22 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat1.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat1.x) + 2.0;
    u_xlat1.x = u_xlat12 * u_xlat1.x;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!((-u_xlat33)>=u_xlat12);
#else
    u_xlatb33 = (-u_xlat33)>=u_xlat12;
#endif
    u_xlat12 = u_xlat1.x * _HeigtFogColDelta.w;
    u_xlat33 = (u_xlatb33) ? u_xlat12 : u_xlat1.x;
    u_xlat33 = log2(u_xlat33);
    u_xlat33 = u_xlat33 * unity_FogColor.w;
    u_xlat33 = exp2(u_xlat33);
    u_xlat33 = min(u_xlat33, _HeigtFogColBase.w);
    u_xlat1.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_36 = (-u_xlat1.x) + 2.0;
    u_xlat16_36 = u_xlat1.x * u_xlat16_36;
    u_xlat1.xyz = vec3(u_xlat16_36) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat34 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat34 = u_xlat34 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat1.xyz = vec3(u_xlat34) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat34 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat34));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat34);
#endif
    u_xlat13 = u_xlat34 * -1.44269502;
    u_xlat13 = exp2(u_xlat13);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat34 = u_xlat13 / u_xlat34;
    u_xlat16_36 = (u_xlatb2) ? u_xlat34 : 1.0;
    u_xlat11 = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb34 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat2.x = u_xlat11 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat11 = u_xlat2.x / u_xlat11;
    u_xlat16_10 = (u_xlatb34) ? u_xlat11 : 1.0;
    u_xlat11 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_36 = u_xlat22 * u_xlat16_36;
    u_xlat16_10 = u_xlat11 * u_xlat16_10;
    u_xlat16_36 = exp2((-u_xlat16_36));
    u_xlat16_36 = (-u_xlat16_36) + 1.0;
    u_xlat16_36 = max(u_xlat16_36, 0.0);
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_10 = (-u_xlat16_10) + 1.0;
    u_xlat16_10 = max(u_xlat16_10, 0.0);
    u_xlat16_36 = u_xlat16_36 + u_xlat16_10;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat0.x) + 2.0;
    u_xlat16_10 = u_xlat0.x * u_xlat16_10;
    u_xlat0.x = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_36 = u_xlat0.x * u_xlat16_36;
    u_xlat0.x = min(u_xlat16_36, _HeigtFogColBase.w);
    u_xlat11 = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat11) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat11 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat11) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.x = (-u_xlat33) + 1.0;
    u_xlat0.x = u_xlat11 * u_xlat0.x;
    u_xlat5.xyz = u_xlat0.xxx * u_xlat16_3.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat5;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_HIGH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _VertexAniSpeed;
uniform 	mediump float _VertexAniScale;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform lowp sampler2D _MainTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat9;
mediump float u_xlat16_10;
vec3 u_xlat11;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
bool u_xlatb23;
float u_xlat26;
void main()
{
    u_xlat0.y = _Time.y * _VertexAniSpeed;
    u_xlat0.x = 0.0;
    u_xlat16_1.xy = u_xlat0.xy + in_TEXCOORD0.xy;
    u_xlat0.x = textureLod(_MainTex, u_xlat16_1.xy, 0.0).y;
    u_xlat0.x = u_xlat0.x * 0.800000012 + -0.400000006;
    u_xlat0.xyz = u_xlat0.xxx * abs(in_NORMAL0.xyz);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat21 = textureLod(_MainTex, u_xlat2.xy, 0.0).z;
    vs_TEXCOORD2.xy = u_xlat2.xy;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniScale, _VertexAniScale, _VertexAniScale)) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat23 = u_xlat21 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.00999999978<abs(u_xlat21));
#else
    u_xlatb21 = 0.00999999978<abs(u_xlat21);
#endif
    u_xlat16_3.x = (u_xlatb21) ? u_xlat23 : 1.0;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat23 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat4 = u_xlat23 * -1.44269502;
    u_xlat4 = exp2(u_xlat4);
    u_xlat4 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat23;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat16_10 = (u_xlatb23) ? u_xlat4 : 1.0;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat23 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat23 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat23) + 2.0;
    u_xlat16_10 = u_xlat23 * u_xlat16_10;
    u_xlat23 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat23 = u_xlat23 + 1.0;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat23 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat23) + 1.0;
    u_xlat11.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat11.x) + 2.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat11.x;
    u_xlat11.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat11.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat26 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat21 = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat26 = u_xlat26 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat11.xyz = vec3(u_xlat26) * u_xlat5.xyz + u_xlat11.xyz;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat9);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat9;
#endif
    u_xlat9 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat9;
    u_xlat9 = u_xlat21 * _HeigtFogColDelta.w;
    u_xlat21 = (u_xlatb2) ? u_xlat9 : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * unity_FogColor.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColBase.w);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat11.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    vs_TEXCOORD0.w = u_xlat4 * u_xlat21;
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat23) + u_xlat2.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec3 _EmissionColor;
uniform 	float _ShadowIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat10;
float u_xlat11;
float u_xlat16;
float u_xlat24;
lowp float u_xlat10_24;
int u_xlati24;
uint u_xlatu24;
bool u_xlatb24;
float u_xlat26;
bool u_xlatb26;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat10_24 = texture(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat24 = u_xlat1.w * u_xlat10_24;
    u_xlat1.w = u_xlat24 * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat3.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat4.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat5.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_6.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_6.y = u_xlat2.z + u_xlat16_6.x;
    u_xlat3.x = -0.0;
    u_xlat3.y = (-u_xlat2.x);
    u_xlat3.zw = (-u_xlat16_6.xy);
    u_xlat2 = u_xlat2 + u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_6.x>=0.5);
#else
    u_xlatb24 = u_xlat16_6.x>=0.5;
#endif
    if(u_xlatb24){
        u_xlat24 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat24 = min(u_xlat24, 3.0);
        u_xlatu24 = uint(u_xlat24);
        u_xlat2.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowPos[int(u_xlatu24)].xyz);
        u_xlati24 = int(u_xlatu24) << 2;
        u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati24 + 1)].xyz;
        u_xlat2.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati24].xyz * u_xlat2.xxx + u_xlat3.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati24 + 2)].xyz * u_xlat2.zzz + u_xlat2.xyw;
        u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati24 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat2.xy,u_xlat2.z);
        u_xlat10_24 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_2 = (-_LightShadowData.x) + 1.0;
        u_xlat24 = u_xlat10_24 * u_xlat16_2 + _LightShadowData.x;
    } else {
        u_xlat24 = 1.0;
    //ENDIF
    }
    u_xlat24 = u_xlat24 + -1.0;
    u_xlat2.xyz = vec3(_ShadowIntensity) * vec3(u_xlat24) + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==1.0;
#endif
    if(u_xlatb24){
        SV_Target0 = u_xlat1;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==2.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==2.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = vec3(0.0399999991, 0.0399999991, 0.0399999991);
        SV_Target0.w = u_xlat1.w;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==3.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==3.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = vec3(0.00999999046, 0.00999999046, 0.00999999046);
        SV_Target0.w = u_xlat1.w;
        return;
    //ENDIF
    }
    u_xlat3.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==4.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==4.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==9.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==9.0;
#endif
    if(u_xlatb24){
        u_xlat2.w = u_xlat1.w;
        SV_Target0 = u_xlat2;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==10.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==10.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==11.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==11.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==12.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==12.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(1.0, 0.0, 0.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==13.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==13.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==100.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==100.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==101.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==101.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==102.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==102.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==103.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==103.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==151.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==151.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
    u_xlat2.xyw = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat2.xyw, u_xlat2.xyw);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyw = vec3(u_xlat24) * u_xlat2.xyw;
    u_xlat3.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_6.x = dot(u_xlat0.xyz, u_xlat2.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xxx * _LightColor0.xyz;
    u_xlat4.xyz = u_xlat16_6.xyz * u_xlat2.zzz + vs_TEXCOORD1.xyz;
    u_xlat16_6.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat2.xyw;
    u_xlat16_30 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8 = dot(u_xlat2.xyw, u_xlat16_6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * -0.0394039154 + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = 0.960596085 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat16_6.x = u_xlat8 * u_xlat8;
    u_xlat16_6.x = u_xlat8 * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat8 * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat8 * u_xlat16_6.x;
    u_xlat16_8 = u_xlat16_6.x * 0.0756555125 + 0.0399999991;
    u_xlat16 = u_xlat16_8 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_8 + 2.0;
    u_xlat0.x = u_xlat16 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat16_6.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat2.zzz * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + _EmissionColor.xyz;
    u_xlat0.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat2.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat10 * u_xlat2.x;
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!((-u_xlat24)>=u_xlat10);
#else
    u_xlatb24 = (-u_xlat24)>=u_xlat10;
#endif
    u_xlat10 = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat24 = (u_xlatb24) ? u_xlat10 : u_xlat2.x;
    u_xlat24 = log2(u_xlat24);
    u_xlat24 = u_xlat24 * unity_FogColor.w;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = min(u_xlat24, _HeigtFogColBase.w);
    u_xlat2.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_30 = (-u_xlat2.x) + 2.0;
    u_xlat16_30 = u_xlat2.x * u_xlat16_30;
    u_xlat2.xyz = vec3(u_xlat16_30) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat26 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat26 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat11 = u_xlat26 * -1.44269502;
    u_xlat11 = exp2(u_xlat11);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat26 = u_xlat11 / u_xlat26;
    u_xlat16_30 = (u_xlatb3) ? u_xlat26 : 1.0;
    u_xlat8 = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat3.x = u_xlat8 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat8 = u_xlat3.x / u_xlat8;
    u_xlat16_7 = (u_xlatb26) ? u_xlat8 : 1.0;
    u_xlat8 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_30 = u_xlat16 * u_xlat16_30;
    u_xlat16_7 = u_xlat8 * u_xlat16_7;
    u_xlat16_30 = exp2((-u_xlat16_30));
    u_xlat16_30 = (-u_xlat16_30) + 1.0;
    u_xlat16_30 = max(u_xlat16_30, 0.0);
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_7 = (-u_xlat16_7) + 1.0;
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat16_30 = u_xlat16_30 + u_xlat16_7;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_30 = u_xlat0.x * u_xlat16_30;
    u_xlat0.x = min(u_xlat16_30, _HeigtFogColBase.w);
    u_xlat8 = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat8) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat8 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.x = (-u_xlat24) + 1.0;
    u_xlat0.x = u_xlat8 * u_xlat0.x;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_HIGH" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _VertexAniSpeed;
uniform 	mediump float _VertexAniScale;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
float u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat10;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
float u_xlat24;
int u_xlati24;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.y = _Time.y * _VertexAniSpeed;
    u_xlat0.x = 0.0;
    u_xlat16_1.xy = u_xlat0.xy + in_TEXCOORD0.xy;
    u_xlat0.x = textureLod(_MainTex, u_xlat16_1.xy, 0.0).y;
    u_xlat0.x = u_xlat0.x * 0.800000012 + -0.400000006;
    u_xlat0.xyz = u_xlat0.xxx * abs(in_NORMAL0.xyz);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat24 = textureLod(_MainTex, u_xlat2.xy, 0.0).z;
    vs_TEXCOORD2.xy = u_xlat2.xy;
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniScale, _VertexAniScale, _VertexAniScale)) + in_POSITION0.xyz;
    u_xlati24 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati24 = u_xlati24 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat0.xyz = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat3 = u_xlat26 * -1.44269502;
    u_xlat3 = exp2(u_xlat3);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_4.x = (u_xlatb26) ? u_xlat3 : 1.0;
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat3 = u_xlat26 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat3 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat11 = u_xlat3 * -1.44269502;
    u_xlat11 = exp2(u_xlat11);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat11 = u_xlat11 / u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3);
#endif
    u_xlat16_12 = (u_xlatb3) ? u_xlat11 : 1.0;
    u_xlat3 = u_xlat26 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat3 = u_xlat26 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat3) + 2.0;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat3 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat3 = u_xlat3 + 1.0;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat3 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat11 = (-u_xlat3) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat10.x);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat10.x;
#endif
    u_xlat10.x = u_xlat26 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat26 + (-_HeigtFogRamp.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat10.x) + 2.0;
    u_xlat10.x = u_xlat26 * u_xlat10.x;
    u_xlat26 = u_xlat10.x * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat26 : u_xlat10.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat10.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat10.x) + 2.0;
    u_xlat16_4.x = u_xlat10.x * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat10.xyz = vec3(u_xlat18) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat10.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat11 * u_xlat2.x;
    u_xlat2.xyz = vec3(u_xlat11) * u_xlat10.xyz;
    u_xlat26 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat26) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat3) + u_xlat2.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_4.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_4.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec3 _EmissionColor;
uniform 	float _ShadowIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat10;
float u_xlat11;
float u_xlat16;
float u_xlat24;
lowp float u_xlat10_24;
int u_xlati24;
uint u_xlatu24;
bool u_xlatb24;
float u_xlat26;
bool u_xlatb26;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat10_24 = texture(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat24 = u_xlat1.w * u_xlat10_24;
    u_xlat1.w = u_xlat24 * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat3.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat4.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat5.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_6.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_6.y = u_xlat2.z + u_xlat16_6.x;
    u_xlat3.x = -0.0;
    u_xlat3.y = (-u_xlat2.x);
    u_xlat3.zw = (-u_xlat16_6.xy);
    u_xlat2 = u_xlat2 + u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_6.x>=0.5);
#else
    u_xlatb24 = u_xlat16_6.x>=0.5;
#endif
    if(u_xlatb24){
        u_xlat24 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat24 = min(u_xlat24, 3.0);
        u_xlatu24 = uint(u_xlat24);
        u_xlat2.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowPos[int(u_xlatu24)].xyz);
        u_xlati24 = int(u_xlatu24) << 2;
        u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati24 + 1)].xyz;
        u_xlat2.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati24].xyz * u_xlat2.xxx + u_xlat3.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati24 + 2)].xyz * u_xlat2.zzz + u_xlat2.xyw;
        u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati24 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat2.xy,u_xlat2.z);
        u_xlat10_24 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_2 = (-_LightShadowData.x) + 1.0;
        u_xlat24 = u_xlat10_24 * u_xlat16_2 + _LightShadowData.x;
    } else {
        u_xlat24 = 1.0;
    //ENDIF
    }
    u_xlat24 = u_xlat24 + -1.0;
    u_xlat2.xyz = vec3(_ShadowIntensity) * vec3(u_xlat24) + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==1.0;
#endif
    if(u_xlatb24){
        SV_Target0 = u_xlat1;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==2.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==2.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = vec3(0.0399999991, 0.0399999991, 0.0399999991);
        SV_Target0.w = u_xlat1.w;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==3.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==3.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = vec3(0.00999999046, 0.00999999046, 0.00999999046);
        SV_Target0.w = u_xlat1.w;
        return;
    //ENDIF
    }
    u_xlat3.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==4.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==4.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==9.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==9.0;
#endif
    if(u_xlatb24){
        u_xlat2.w = u_xlat1.w;
        SV_Target0 = u_xlat2;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==10.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==10.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==11.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==11.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==12.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==12.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(1.0, 0.0, 0.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==13.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==13.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==100.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==100.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==101.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==101.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==102.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==102.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==103.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==103.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==151.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==151.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
    u_xlat2.xyw = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat2.xyw, u_xlat2.xyw);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyw = vec3(u_xlat24) * u_xlat2.xyw;
    u_xlat3.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_6.x = dot(u_xlat0.xyz, u_xlat2.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xxx * _LightColor0.xyz;
    u_xlat4.xyz = u_xlat16_6.xyz * u_xlat2.zzz + vs_TEXCOORD1.xyz;
    u_xlat16_6.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat2.xyw;
    u_xlat16_30 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8 = dot(u_xlat2.xyw, u_xlat16_6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * -0.0394039154 + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = 0.960596085 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat16_6.x = u_xlat8 * u_xlat8;
    u_xlat16_6.x = u_xlat8 * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat8 * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat8 * u_xlat16_6.x;
    u_xlat16_8 = u_xlat16_6.x * 0.0756555125 + 0.0399999991;
    u_xlat16 = u_xlat16_8 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_8 + 2.0;
    u_xlat0.x = u_xlat16 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat16_6.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat2.zzz * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + _EmissionColor.xyz;
    u_xlat0.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat2.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat10 * u_xlat2.x;
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!((-u_xlat24)>=u_xlat10);
#else
    u_xlatb24 = (-u_xlat24)>=u_xlat10;
#endif
    u_xlat10 = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat24 = (u_xlatb24) ? u_xlat10 : u_xlat2.x;
    u_xlat24 = log2(u_xlat24);
    u_xlat24 = u_xlat24 * unity_FogColor.w;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = min(u_xlat24, _HeigtFogColBase.w);
    u_xlat2.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_30 = (-u_xlat2.x) + 2.0;
    u_xlat16_30 = u_xlat2.x * u_xlat16_30;
    u_xlat2.xyz = vec3(u_xlat16_30) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat26 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat26 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat11 = u_xlat26 * -1.44269502;
    u_xlat11 = exp2(u_xlat11);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat26 = u_xlat11 / u_xlat26;
    u_xlat16_30 = (u_xlatb3) ? u_xlat26 : 1.0;
    u_xlat8 = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat3.x = u_xlat8 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat8 = u_xlat3.x / u_xlat8;
    u_xlat16_7 = (u_xlatb26) ? u_xlat8 : 1.0;
    u_xlat8 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_30 = u_xlat16 * u_xlat16_30;
    u_xlat16_7 = u_xlat8 * u_xlat16_7;
    u_xlat16_30 = exp2((-u_xlat16_30));
    u_xlat16_30 = (-u_xlat16_30) + 1.0;
    u_xlat16_30 = max(u_xlat16_30, 0.0);
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_7 = (-u_xlat16_7) + 1.0;
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat16_30 = u_xlat16_30 + u_xlat16_7;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_30 = u_xlat0.x * u_xlat16_30;
    u_xlat0.x = min(u_xlat16_30, _HeigtFogColBase.w);
    u_xlat8 = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat8) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat8 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.x = (-u_xlat24) + 1.0;
    u_xlat0.x = u_xlat8 * u_xlat0.x;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_MIDDLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _VertexAniSpeed;
uniform 	mediump float _VertexAniScale;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform lowp sampler2D _MainTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat9;
mediump float u_xlat16_10;
vec3 u_xlat11;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
bool u_xlatb23;
float u_xlat26;
void main()
{
    u_xlat0.y = _Time.y * _VertexAniSpeed;
    u_xlat0.x = 0.0;
    u_xlat16_1.xy = u_xlat0.xy + in_TEXCOORD0.xy;
    u_xlat0.x = textureLod(_MainTex, u_xlat16_1.xy, 0.0).y;
    u_xlat0.x = u_xlat0.x * 0.800000012 + -0.400000006;
    u_xlat0.xyz = u_xlat0.xxx * abs(in_NORMAL0.xyz);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat21 = textureLod(_MainTex, u_xlat2.xy, 0.0).z;
    vs_TEXCOORD2.xy = u_xlat2.xy;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniScale, _VertexAniScale, _VertexAniScale)) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat23 = u_xlat21 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.00999999978<abs(u_xlat21));
#else
    u_xlatb21 = 0.00999999978<abs(u_xlat21);
#endif
    u_xlat16_3.x = (u_xlatb21) ? u_xlat23 : 1.0;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat23 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat4 = u_xlat23 * -1.44269502;
    u_xlat4 = exp2(u_xlat4);
    u_xlat4 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat23;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat16_10 = (u_xlatb23) ? u_xlat4 : 1.0;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat23 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat23 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat23) + 2.0;
    u_xlat16_10 = u_xlat23 * u_xlat16_10;
    u_xlat23 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat23 = u_xlat23 + 1.0;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat23 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat23) + 1.0;
    u_xlat11.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat11.x) + 2.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat11.x;
    u_xlat11.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat11.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat26 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat21 = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat26 = u_xlat26 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat11.xyz = vec3(u_xlat26) * u_xlat5.xyz + u_xlat11.xyz;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat9);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat9;
#endif
    u_xlat9 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat9;
    u_xlat9 = u_xlat21 * _HeigtFogColDelta.w;
    u_xlat21 = (u_xlatb2) ? u_xlat9 : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * unity_FogColor.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColBase.w);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat11.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    vs_TEXCOORD0.w = u_xlat4 * u_xlat21;
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat23) + u_xlat2.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec3 _EmissionColor;
uniform 	float _ShadowIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat10;
float u_xlat11;
float u_xlat16;
float u_xlat24;
lowp float u_xlat10_24;
int u_xlati24;
uint u_xlatu24;
bool u_xlatb24;
float u_xlat26;
bool u_xlatb26;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat10_24 = texture(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat24 = u_xlat1.w * u_xlat10_24;
    u_xlat1.w = u_xlat24 * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat3.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat4.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat5.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_6.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_6.y = u_xlat2.z + u_xlat16_6.x;
    u_xlat3.x = -0.0;
    u_xlat3.y = (-u_xlat2.x);
    u_xlat3.zw = (-u_xlat16_6.xy);
    u_xlat2 = u_xlat2 + u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_6.x>=0.5);
#else
    u_xlatb24 = u_xlat16_6.x>=0.5;
#endif
    if(u_xlatb24){
        u_xlat24 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat24 = min(u_xlat24, 3.0);
        u_xlatu24 = uint(u_xlat24);
        u_xlat2.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowPos[int(u_xlatu24)].xyz);
        u_xlati24 = int(u_xlatu24) << 2;
        u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati24 + 1)].xyz;
        u_xlat2.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati24].xyz * u_xlat2.xxx + u_xlat3.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati24 + 2)].xyz * u_xlat2.zzz + u_xlat2.xyw;
        u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati24 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat2.xy,u_xlat2.z);
        u_xlat10_24 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_2 = (-_LightShadowData.x) + 1.0;
        u_xlat24 = u_xlat10_24 * u_xlat16_2 + _LightShadowData.x;
    } else {
        u_xlat24 = 1.0;
    //ENDIF
    }
    u_xlat24 = u_xlat24 + -1.0;
    u_xlat2.xyz = vec3(_ShadowIntensity) * vec3(u_xlat24) + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==1.0;
#endif
    if(u_xlatb24){
        SV_Target0 = u_xlat1;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==2.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==2.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = vec3(0.0399999991, 0.0399999991, 0.0399999991);
        SV_Target0.w = u_xlat1.w;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==3.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==3.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = vec3(0.00999999046, 0.00999999046, 0.00999999046);
        SV_Target0.w = u_xlat1.w;
        return;
    //ENDIF
    }
    u_xlat3.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==4.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==4.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==9.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==9.0;
#endif
    if(u_xlatb24){
        u_xlat2.w = u_xlat1.w;
        SV_Target0 = u_xlat2;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==10.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==10.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==11.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==11.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==12.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==12.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(1.0, 0.0, 0.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==13.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==13.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==100.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==100.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==101.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==101.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==102.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==102.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==103.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==103.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==151.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==151.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
    u_xlat2.xyw = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat2.xyw, u_xlat2.xyw);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyw = vec3(u_xlat24) * u_xlat2.xyw;
    u_xlat3.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_6.x = dot(u_xlat0.xyz, u_xlat2.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xxx * _LightColor0.xyz;
    u_xlat4.xyz = u_xlat16_6.xyz * u_xlat2.zzz + vs_TEXCOORD1.xyz;
    u_xlat16_6.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat2.xyw;
    u_xlat16_30 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8 = dot(u_xlat2.xyw, u_xlat16_6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * -0.0394039154 + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = 0.960596085 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat16_6.x = u_xlat8 * u_xlat8;
    u_xlat16_6.x = u_xlat8 * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat8 * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat8 * u_xlat16_6.x;
    u_xlat16_8 = u_xlat16_6.x * 0.0756555125 + 0.0399999991;
    u_xlat16 = u_xlat16_8 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_8 + 2.0;
    u_xlat0.x = u_xlat16 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat16_6.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat2.zzz * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + _EmissionColor.xyz;
    u_xlat0.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat2.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat10 * u_xlat2.x;
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!((-u_xlat24)>=u_xlat10);
#else
    u_xlatb24 = (-u_xlat24)>=u_xlat10;
#endif
    u_xlat10 = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat24 = (u_xlatb24) ? u_xlat10 : u_xlat2.x;
    u_xlat24 = log2(u_xlat24);
    u_xlat24 = u_xlat24 * unity_FogColor.w;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = min(u_xlat24, _HeigtFogColBase.w);
    u_xlat2.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_30 = (-u_xlat2.x) + 2.0;
    u_xlat16_30 = u_xlat2.x * u_xlat16_30;
    u_xlat2.xyz = vec3(u_xlat16_30) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat26 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat26 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat11 = u_xlat26 * -1.44269502;
    u_xlat11 = exp2(u_xlat11);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat26 = u_xlat11 / u_xlat26;
    u_xlat16_30 = (u_xlatb3) ? u_xlat26 : 1.0;
    u_xlat8 = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat3.x = u_xlat8 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat8 = u_xlat3.x / u_xlat8;
    u_xlat16_7 = (u_xlatb26) ? u_xlat8 : 1.0;
    u_xlat8 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_30 = u_xlat16 * u_xlat16_30;
    u_xlat16_7 = u_xlat8 * u_xlat16_7;
    u_xlat16_30 = exp2((-u_xlat16_30));
    u_xlat16_30 = (-u_xlat16_30) + 1.0;
    u_xlat16_30 = max(u_xlat16_30, 0.0);
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_7 = (-u_xlat16_7) + 1.0;
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat16_30 = u_xlat16_30 + u_xlat16_7;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_30 = u_xlat0.x * u_xlat16_30;
    u_xlat0.x = min(u_xlat16_30, _HeigtFogColBase.w);
    u_xlat8 = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat8) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat8 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.x = (-u_xlat24) + 1.0;
    u_xlat0.x = u_xlat8 * u_xlat0.x;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_MIDDLE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _VertexAniSpeed;
uniform 	mediump float _VertexAniScale;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
float u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat10;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
float u_xlat24;
int u_xlati24;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.y = _Time.y * _VertexAniSpeed;
    u_xlat0.x = 0.0;
    u_xlat16_1.xy = u_xlat0.xy + in_TEXCOORD0.xy;
    u_xlat0.x = textureLod(_MainTex, u_xlat16_1.xy, 0.0).y;
    u_xlat0.x = u_xlat0.x * 0.800000012 + -0.400000006;
    u_xlat0.xyz = u_xlat0.xxx * abs(in_NORMAL0.xyz);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat24 = textureLod(_MainTex, u_xlat2.xy, 0.0).z;
    vs_TEXCOORD2.xy = u_xlat2.xy;
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniScale, _VertexAniScale, _VertexAniScale)) + in_POSITION0.xyz;
    u_xlati24 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati24 = u_xlati24 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat0.xyz = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat3 = u_xlat26 * -1.44269502;
    u_xlat3 = exp2(u_xlat3);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_4.x = (u_xlatb26) ? u_xlat3 : 1.0;
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat3 = u_xlat26 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat3 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat11 = u_xlat3 * -1.44269502;
    u_xlat11 = exp2(u_xlat11);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat11 = u_xlat11 / u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3);
#endif
    u_xlat16_12 = (u_xlatb3) ? u_xlat11 : 1.0;
    u_xlat3 = u_xlat26 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat3 = u_xlat26 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat3) + 2.0;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat3 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat3 = u_xlat3 + 1.0;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat3 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat11 = (-u_xlat3) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat10.x);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat10.x;
#endif
    u_xlat10.x = u_xlat26 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat26 + (-_HeigtFogRamp.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat10.x) + 2.0;
    u_xlat10.x = u_xlat26 * u_xlat10.x;
    u_xlat26 = u_xlat10.x * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat26 : u_xlat10.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat10.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat10.x) + 2.0;
    u_xlat16_4.x = u_xlat10.x * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat10.xyz = vec3(u_xlat18) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat10.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat11 * u_xlat2.x;
    u_xlat2.xyz = vec3(u_xlat11) * u_xlat10.xyz;
    u_xlat26 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat26) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat3) + u_xlat2.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_4.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_4.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec3 _EmissionColor;
uniform 	float _ShadowIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat10;
float u_xlat11;
float u_xlat16;
float u_xlat24;
lowp float u_xlat10_24;
int u_xlati24;
uint u_xlatu24;
bool u_xlatb24;
float u_xlat26;
bool u_xlatb26;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat10_24 = texture(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat24 = u_xlat1.w * u_xlat10_24;
    u_xlat1.w = u_xlat24 * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat3.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat4.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat5.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_6.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_6.y = u_xlat2.z + u_xlat16_6.x;
    u_xlat3.x = -0.0;
    u_xlat3.y = (-u_xlat2.x);
    u_xlat3.zw = (-u_xlat16_6.xy);
    u_xlat2 = u_xlat2 + u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_6.x>=0.5);
#else
    u_xlatb24 = u_xlat16_6.x>=0.5;
#endif
    if(u_xlatb24){
        u_xlat24 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat24 = min(u_xlat24, 3.0);
        u_xlatu24 = uint(u_xlat24);
        u_xlat2.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowPos[int(u_xlatu24)].xyz);
        u_xlati24 = int(u_xlatu24) << 2;
        u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati24 + 1)].xyz;
        u_xlat2.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati24].xyz * u_xlat2.xxx + u_xlat3.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati24 + 2)].xyz * u_xlat2.zzz + u_xlat2.xyw;
        u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati24 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat2.xy,u_xlat2.z);
        u_xlat10_24 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_2 = (-_LightShadowData.x) + 1.0;
        u_xlat24 = u_xlat10_24 * u_xlat16_2 + _LightShadowData.x;
    } else {
        u_xlat24 = 1.0;
    //ENDIF
    }
    u_xlat24 = u_xlat24 + -1.0;
    u_xlat2.xyz = vec3(_ShadowIntensity) * vec3(u_xlat24) + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==1.0;
#endif
    if(u_xlatb24){
        SV_Target0 = u_xlat1;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==2.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==2.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = vec3(0.0399999991, 0.0399999991, 0.0399999991);
        SV_Target0.w = u_xlat1.w;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==3.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==3.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = vec3(0.00999999046, 0.00999999046, 0.00999999046);
        SV_Target0.w = u_xlat1.w;
        return;
    //ENDIF
    }
    u_xlat3.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==4.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==4.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==9.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==9.0;
#endif
    if(u_xlatb24){
        u_xlat2.w = u_xlat1.w;
        SV_Target0 = u_xlat2;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==10.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==10.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==11.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==11.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==12.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==12.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(1.0, 0.0, 0.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==13.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==13.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==100.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==100.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==101.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==101.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==102.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==102.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==103.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==103.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==151.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==151.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
    u_xlat2.xyw = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat2.xyw, u_xlat2.xyw);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyw = vec3(u_xlat24) * u_xlat2.xyw;
    u_xlat3.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_6.x = dot(u_xlat0.xyz, u_xlat2.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xxx * _LightColor0.xyz;
    u_xlat4.xyz = u_xlat16_6.xyz * u_xlat2.zzz + vs_TEXCOORD1.xyz;
    u_xlat16_6.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat2.xyw;
    u_xlat16_30 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8 = dot(u_xlat2.xyw, u_xlat16_6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * -0.0394039154 + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = 0.960596085 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat16_6.x = u_xlat8 * u_xlat8;
    u_xlat16_6.x = u_xlat8 * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat8 * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat8 * u_xlat16_6.x;
    u_xlat16_8 = u_xlat16_6.x * 0.0756555125 + 0.0399999991;
    u_xlat16 = u_xlat16_8 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_8 + 2.0;
    u_xlat0.x = u_xlat16 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat16_6.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat2.zzz * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + _EmissionColor.xyz;
    u_xlat0.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat2.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat10 * u_xlat2.x;
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!((-u_xlat24)>=u_xlat10);
#else
    u_xlatb24 = (-u_xlat24)>=u_xlat10;
#endif
    u_xlat10 = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat24 = (u_xlatb24) ? u_xlat10 : u_xlat2.x;
    u_xlat24 = log2(u_xlat24);
    u_xlat24 = u_xlat24 * unity_FogColor.w;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = min(u_xlat24, _HeigtFogColBase.w);
    u_xlat2.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_30 = (-u_xlat2.x) + 2.0;
    u_xlat16_30 = u_xlat2.x * u_xlat16_30;
    u_xlat2.xyz = vec3(u_xlat16_30) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat26 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat26 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat11 = u_xlat26 * -1.44269502;
    u_xlat11 = exp2(u_xlat11);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat26 = u_xlat11 / u_xlat26;
    u_xlat16_30 = (u_xlatb3) ? u_xlat26 : 1.0;
    u_xlat8 = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat3.x = u_xlat8 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat8 = u_xlat3.x / u_xlat8;
    u_xlat16_7 = (u_xlatb26) ? u_xlat8 : 1.0;
    u_xlat8 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_30 = u_xlat16 * u_xlat16_30;
    u_xlat16_7 = u_xlat8 * u_xlat16_7;
    u_xlat16_30 = exp2((-u_xlat16_30));
    u_xlat16_30 = (-u_xlat16_30) + 1.0;
    u_xlat16_30 = max(u_xlat16_30, 0.0);
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_7 = (-u_xlat16_7) + 1.0;
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat16_30 = u_xlat16_30 + u_xlat16_7;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_30 = u_xlat0.x * u_xlat16_30;
    u_xlat0.x = min(u_xlat16_30, _HeigtFogColBase.w);
    u_xlat8 = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat8) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat8 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.x = (-u_xlat24) + 1.0;
    u_xlat0.x = u_xlat8 * u_xlat0.x;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_LOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _VertexAniSpeed;
uniform 	mediump float _VertexAniScale;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform lowp sampler2D _MainTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat9;
mediump float u_xlat16_10;
vec3 u_xlat11;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
bool u_xlatb23;
float u_xlat26;
void main()
{
    u_xlat0.y = _Time.y * _VertexAniSpeed;
    u_xlat0.x = 0.0;
    u_xlat16_1.xy = u_xlat0.xy + in_TEXCOORD0.xy;
    u_xlat0.x = textureLod(_MainTex, u_xlat16_1.xy, 0.0).y;
    u_xlat0.x = u_xlat0.x * 0.800000012 + -0.400000006;
    u_xlat0.xyz = u_xlat0.xxx * abs(in_NORMAL0.xyz);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat21 = textureLod(_MainTex, u_xlat2.xy, 0.0).z;
    vs_TEXCOORD2.xy = u_xlat2.xy;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniScale, _VertexAniScale, _VertexAniScale)) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat23 = u_xlat21 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.00999999978<abs(u_xlat21));
#else
    u_xlatb21 = 0.00999999978<abs(u_xlat21);
#endif
    u_xlat16_3.x = (u_xlatb21) ? u_xlat23 : 1.0;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat23 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat4 = u_xlat23 * -1.44269502;
    u_xlat4 = exp2(u_xlat4);
    u_xlat4 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat4 / u_xlat23;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat16_10 = (u_xlatb23) ? u_xlat4 : 1.0;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat23 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat23 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat23) + 2.0;
    u_xlat16_10 = u_xlat23 * u_xlat16_10;
    u_xlat23 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat23 = u_xlat23 + 1.0;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat23 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat23) + 1.0;
    u_xlat11.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat11.x) + 2.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat11.x;
    u_xlat11.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat11.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat26 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat21 = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat26 = u_xlat26 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat11.xyz = vec3(u_xlat26) * u_xlat5.xyz + u_xlat11.xyz;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat9);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat9;
#endif
    u_xlat9 = (-u_xlat21) + 2.0;
    u_xlat21 = u_xlat21 * u_xlat9;
    u_xlat9 = u_xlat21 * _HeigtFogColDelta.w;
    u_xlat21 = (u_xlatb2) ? u_xlat9 : u_xlat21;
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * unity_FogColor.w;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = min(u_xlat21, _HeigtFogColBase.w);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat11.xyz;
    u_xlat21 = (-u_xlat21) + 1.0;
    vs_TEXCOORD0.w = u_xlat4 * u_xlat21;
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat23) + u_xlat2.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_3.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_3.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_3.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec3 _EmissionColor;
uniform 	float _ShadowIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat10;
float u_xlat11;
float u_xlat16;
float u_xlat24;
lowp float u_xlat10_24;
int u_xlati24;
uint u_xlatu24;
bool u_xlatb24;
float u_xlat26;
bool u_xlatb26;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat10_24 = texture(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat24 = u_xlat1.w * u_xlat10_24;
    u_xlat1.w = u_xlat24 * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat3.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat4.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat5.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_6.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_6.y = u_xlat2.z + u_xlat16_6.x;
    u_xlat3.x = -0.0;
    u_xlat3.y = (-u_xlat2.x);
    u_xlat3.zw = (-u_xlat16_6.xy);
    u_xlat2 = u_xlat2 + u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_6.x>=0.5);
#else
    u_xlatb24 = u_xlat16_6.x>=0.5;
#endif
    if(u_xlatb24){
        u_xlat24 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat24 = min(u_xlat24, 3.0);
        u_xlatu24 = uint(u_xlat24);
        u_xlat2.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowPos[int(u_xlatu24)].xyz);
        u_xlati24 = int(u_xlatu24) << 2;
        u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati24 + 1)].xyz;
        u_xlat2.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati24].xyz * u_xlat2.xxx + u_xlat3.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati24 + 2)].xyz * u_xlat2.zzz + u_xlat2.xyw;
        u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati24 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat2.xy,u_xlat2.z);
        u_xlat10_24 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_2 = (-_LightShadowData.x) + 1.0;
        u_xlat24 = u_xlat10_24 * u_xlat16_2 + _LightShadowData.x;
    } else {
        u_xlat24 = 1.0;
    //ENDIF
    }
    u_xlat24 = u_xlat24 + -1.0;
    u_xlat2.xyz = vec3(_ShadowIntensity) * vec3(u_xlat24) + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==1.0;
#endif
    if(u_xlatb24){
        SV_Target0 = u_xlat1;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==2.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==2.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = vec3(0.0399999991, 0.0399999991, 0.0399999991);
        SV_Target0.w = u_xlat1.w;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==3.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==3.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = vec3(0.00999999046, 0.00999999046, 0.00999999046);
        SV_Target0.w = u_xlat1.w;
        return;
    //ENDIF
    }
    u_xlat3.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==4.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==4.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==9.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==9.0;
#endif
    if(u_xlatb24){
        u_xlat2.w = u_xlat1.w;
        SV_Target0 = u_xlat2;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==10.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==10.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==11.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==11.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==12.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==12.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(1.0, 0.0, 0.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==13.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==13.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==100.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==100.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==101.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==101.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==102.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==102.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==103.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==103.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==151.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==151.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
    u_xlat2.xyw = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat2.xyw, u_xlat2.xyw);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyw = vec3(u_xlat24) * u_xlat2.xyw;
    u_xlat3.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_6.x = dot(u_xlat0.xyz, u_xlat2.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xxx * _LightColor0.xyz;
    u_xlat4.xyz = u_xlat16_6.xyz * u_xlat2.zzz + vs_TEXCOORD1.xyz;
    u_xlat16_6.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat2.xyw;
    u_xlat16_30 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8 = dot(u_xlat2.xyw, u_xlat16_6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * -0.0394039154 + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = 0.960596085 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat16_6.x = u_xlat8 * u_xlat8;
    u_xlat16_6.x = u_xlat8 * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat8 * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat8 * u_xlat16_6.x;
    u_xlat16_8 = u_xlat16_6.x * 0.0756555125 + 0.0399999991;
    u_xlat16 = u_xlat16_8 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_8 + 2.0;
    u_xlat0.x = u_xlat16 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat16_6.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat2.zzz * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + _EmissionColor.xyz;
    u_xlat0.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat2.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat10 * u_xlat2.x;
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!((-u_xlat24)>=u_xlat10);
#else
    u_xlatb24 = (-u_xlat24)>=u_xlat10;
#endif
    u_xlat10 = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat24 = (u_xlatb24) ? u_xlat10 : u_xlat2.x;
    u_xlat24 = log2(u_xlat24);
    u_xlat24 = u_xlat24 * unity_FogColor.w;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = min(u_xlat24, _HeigtFogColBase.w);
    u_xlat2.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_30 = (-u_xlat2.x) + 2.0;
    u_xlat16_30 = u_xlat2.x * u_xlat16_30;
    u_xlat2.xyz = vec3(u_xlat16_30) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat26 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat26 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat11 = u_xlat26 * -1.44269502;
    u_xlat11 = exp2(u_xlat11);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat26 = u_xlat11 / u_xlat26;
    u_xlat16_30 = (u_xlatb3) ? u_xlat26 : 1.0;
    u_xlat8 = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat3.x = u_xlat8 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat8 = u_xlat3.x / u_xlat8;
    u_xlat16_7 = (u_xlatb26) ? u_xlat8 : 1.0;
    u_xlat8 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_30 = u_xlat16 * u_xlat16_30;
    u_xlat16_7 = u_xlat8 * u_xlat16_7;
    u_xlat16_30 = exp2((-u_xlat16_30));
    u_xlat16_30 = (-u_xlat16_30) + 1.0;
    u_xlat16_30 = max(u_xlat16_30, 0.0);
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_7 = (-u_xlat16_7) + 1.0;
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat16_30 = u_xlat16_30 + u_xlat16_7;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_30 = u_xlat0.x * u_xlat16_30;
    u_xlat0.x = min(u_xlat16_30, _HeigtFogColBase.w);
    u_xlat8 = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat8) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat8 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.x = (-u_xlat24) + 1.0;
    u_xlat0.x = u_xlat8 * u_xlat0.x;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_LOW" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _VertexAniSpeed;
uniform 	mediump float _VertexAniScale;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
float u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat10;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
float u_xlat24;
int u_xlati24;
float u_xlat26;
bool u_xlatb26;
void main()
{
    u_xlat0.y = _Time.y * _VertexAniSpeed;
    u_xlat0.x = 0.0;
    u_xlat16_1.xy = u_xlat0.xy + in_TEXCOORD0.xy;
    u_xlat0.x = textureLod(_MainTex, u_xlat16_1.xy, 0.0).y;
    u_xlat0.x = u_xlat0.x * 0.800000012 + -0.400000006;
    u_xlat0.xyz = u_xlat0.xxx * abs(in_NORMAL0.xyz);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat24 = textureLod(_MainTex, u_xlat2.xy, 0.0).z;
    vs_TEXCOORD2.xy = u_xlat2.xy;
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniScale, _VertexAniScale, _VertexAniScale)) + in_POSITION0.xyz;
    u_xlati24 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati24 = u_xlati24 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat0.xyz = unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat3 = u_xlat26 * -1.44269502;
    u_xlat3 = exp2(u_xlat3);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = u_xlat3 / u_xlat26;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat16_4.x = (u_xlatb26) ? u_xlat3 : 1.0;
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat3 = u_xlat26 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat3 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat11 = u_xlat3 * -1.44269502;
    u_xlat11 = exp2(u_xlat11);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat11 = u_xlat11 / u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3);
#endif
    u_xlat16_12 = (u_xlatb3) ? u_xlat11 : 1.0;
    u_xlat3 = u_xlat26 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat3 = u_xlat26 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat3) + 2.0;
    u_xlat16_12 = u_xlat3 * u_xlat16_12;
    u_xlat3 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat3 = u_xlat3 + 1.0;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat3 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat11 = (-u_xlat3) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat10.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat10.x);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat10.x;
#endif
    u_xlat10.x = u_xlat26 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat26 + (-_HeigtFogRamp.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat26 = (-u_xlat10.x) + 2.0;
    u_xlat10.x = u_xlat26 * u_xlat10.x;
    u_xlat26 = u_xlat10.x * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat26 : u_xlat10.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat10.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat10.x) + 2.0;
    u_xlat16_4.x = u_xlat10.x * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat10.xyz = vec3(u_xlat18) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat10.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat11 * u_xlat2.x;
    u_xlat2.xyz = vec3(u_xlat11) * u_xlat10.xyz;
    u_xlat26 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat26) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat3) + u_xlat2.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati24 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_4.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_4.x);
    u_xlat16_2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec3 _EmissionColor;
uniform 	float _ShadowIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2DShadow hlslcc_zcmp_CascadeShadowMapTexture;
uniform lowp sampler2D _CascadeShadowMapTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat10;
float u_xlat11;
float u_xlat16;
float u_xlat24;
lowp float u_xlat10_24;
int u_xlati24;
uint u_xlatu24;
bool u_xlatb24;
float u_xlat26;
bool u_xlatb26;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat10_24 = texture(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat24 = u_xlat1.w * u_xlat10_24;
    u_xlat1.w = u_xlat24 * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat3.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat4.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat5.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_6.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_6.y = u_xlat2.z + u_xlat16_6.x;
    u_xlat3.x = -0.0;
    u_xlat3.y = (-u_xlat2.x);
    u_xlat3.zw = (-u_xlat16_6.xy);
    u_xlat2 = u_xlat2 + u_xlat3;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat16_6.x>=0.5);
#else
    u_xlatb24 = u_xlat16_6.x>=0.5;
#endif
    if(u_xlatb24){
        u_xlat24 = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
        u_xlat24 = min(u_xlat24, 3.0);
        u_xlatu24 = uint(u_xlat24);
        u_xlat2.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowPos[int(u_xlatu24)].xyz);
        u_xlati24 = int(u_xlatu24) << 2;
        u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati24 + 1)].xyz;
        u_xlat2.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati24].xyz * u_xlat2.xxx + u_xlat3.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati24 + 2)].xyz * u_xlat2.zzz + u_xlat2.xyw;
        u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati24 + 3)].xyz;
        vec3 txVec0 = vec3(u_xlat2.xy,u_xlat2.z);
        u_xlat10_24 = textureLod(hlslcc_zcmp_CascadeShadowMapTexture, txVec0, 0.0);
        u_xlat16_2 = (-_LightShadowData.x) + 1.0;
        u_xlat24 = u_xlat10_24 * u_xlat16_2 + _LightShadowData.x;
    } else {
        u_xlat24 = 1.0;
    //ENDIF
    }
    u_xlat24 = u_xlat24 + -1.0;
    u_xlat2.xyz = vec3(_ShadowIntensity) * vec3(u_xlat24) + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==1.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==1.0;
#endif
    if(u_xlatb24){
        SV_Target0 = u_xlat1;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==2.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==2.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = vec3(0.0399999991, 0.0399999991, 0.0399999991);
        SV_Target0.w = u_xlat1.w;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==3.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==3.0;
#endif
    if(u_xlatb24){
        SV_Target0.xyz = vec3(0.00999999046, 0.00999999046, 0.00999999046);
        SV_Target0.w = u_xlat1.w;
        return;
    //ENDIF
    }
    u_xlat3.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==4.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==4.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==9.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==9.0;
#endif
    if(u_xlatb24){
        u_xlat2.w = u_xlat1.w;
        SV_Target0 = u_xlat2;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==10.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==10.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==11.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==11.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==12.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==12.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(1.0, 0.0, 0.0, 1.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==13.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==13.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==51.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==51.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==100.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==100.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==101.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==101.0;
#endif
    if(u_xlatb24){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==102.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==102.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==103.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==103.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(unity_DebugViewInfo.x==151.0);
#else
    u_xlatb24 = unity_DebugViewInfo.x==151.0;
#endif
    if(u_xlatb24){
        u_xlat3.w = u_xlat1.w;
        SV_Target0 = u_xlat3;
        return;
    //ENDIF
    }
    u_xlat2.xyw = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat2.xyw, u_xlat2.xyw);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyw = vec3(u_xlat24) * u_xlat2.xyw;
    u_xlat3.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat16_6.x = dot(u_xlat0.xyz, u_xlat2.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xxx * _LightColor0.xyz;
    u_xlat4.xyz = u_xlat16_6.xyz * u_xlat2.zzz + vs_TEXCOORD1.xyz;
    u_xlat16_6.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat2.xyw;
    u_xlat16_30 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8 = dot(u_xlat2.xyw, u_xlat16_6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * -0.0394039154 + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = 0.960596085 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat16_6.x = u_xlat8 * u_xlat8;
    u_xlat16_6.x = u_xlat8 * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat8 * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat8 * u_xlat16_6.x;
    u_xlat16_8 = u_xlat16_6.x * 0.0756555125 + 0.0399999991;
    u_xlat16 = u_xlat16_8 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_8 + 2.0;
    u_xlat0.x = u_xlat16 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat16_6.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat16_6.xyz = u_xlat2.zzz * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + _EmissionColor.xyz;
    u_xlat0.xyz = vs_TEXCOORD4.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat2.x = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat10 * u_xlat2.x;
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!((-u_xlat24)>=u_xlat10);
#else
    u_xlatb24 = (-u_xlat24)>=u_xlat10;
#endif
    u_xlat10 = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat24 = (u_xlatb24) ? u_xlat10 : u_xlat2.x;
    u_xlat24 = log2(u_xlat24);
    u_xlat24 = u_xlat24 * unity_FogColor.w;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = min(u_xlat24, _HeigtFogColBase.w);
    u_xlat2.x = vs_TEXCOORD4.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_30 = (-u_xlat2.x) + 2.0;
    u_xlat16_30 = u_xlat2.x * u_xlat16_30;
    u_xlat2.xyz = vec3(u_xlat16_30) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat26 = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat26 = u_xlat0.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat26));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat26);
#endif
    u_xlat11 = u_xlat26 * -1.44269502;
    u_xlat11 = exp2(u_xlat11);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat26 = u_xlat11 / u_xlat26;
    u_xlat16_30 = (u_xlatb3) ? u_xlat26 : 1.0;
    u_xlat8 = u_xlat0.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb26 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat3.x = u_xlat8 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat8 = u_xlat3.x / u_xlat8;
    u_xlat16_7 = (u_xlatb26) ? u_xlat8 : 1.0;
    u_xlat8 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_30 = u_xlat16 * u_xlat16_30;
    u_xlat16_7 = u_xlat8 * u_xlat16_7;
    u_xlat16_30 = exp2((-u_xlat16_30));
    u_xlat16_30 = (-u_xlat16_30) + 1.0;
    u_xlat16_30 = max(u_xlat16_30, 0.0);
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_7 = (-u_xlat16_7) + 1.0;
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat16_30 = u_xlat16_30 + u_xlat16_7;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_30 = u_xlat0.x * u_xlat16_30;
    u_xlat0.x = min(u_xlat16_30, _HeigtFogColBase.w);
    u_xlat8 = vs_TEXCOORD4.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat8) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat8 = (-u_xlat0.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.x = (-u_xlat24) + 1.0;
    u_xlat0.x = u_xlat8 * u_xlat0.x;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_HIGH" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_MIDDLE" }
""
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MHY_SHADER_LOW" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_HIGH" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_HIGH" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_MIDDLE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_MIDDLE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MHY_SHADER_LOW" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MHY_SHADER_LOW" }
""
}
}
}
 Pass {
  Name "SHADOW"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "SHADOWCASTER" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
  GpuProgramID 69633
Program "vp" {
SubProgram "gles3 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _VertexAniSpeed;
uniform 	mediump float _VertexAniScale;
uniform lowp sampler2D _MainTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat8;
float u_xlat12;
float u_xlat14;
bool u_xlatb14;
void main()
{
    u_xlat0.y = _Time.y * _VertexAniSpeed;
    u_xlat0.x = 0.0;
    u_xlat16_1.xy = u_xlat0.xy + in_TEXCOORD0.xy;
    u_xlat0.x = textureLod(_MainTex, u_xlat16_1.xy, 0.0).y;
    u_xlat0.x = u_xlat0.x * 0.800000012 + -0.400000006;
    u_xlat0.xyz = u_xlat0.xxx * abs(in_NORMAL0.xyz);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat12 = textureLod(_MainTex, u_xlat2.xy, 0.0).z;
    vs_TEXCOORD1.xy = u_xlat2.xy;
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniScale, _VertexAniScale, _VertexAniScale)) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat3.xyz = vec3(u_xlat14) * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = (-u_xlat2.x) * u_xlat2.x + 1.0;
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_LightShadowBias.z;
    u_xlat2.xyz = (-u_xlat3.xyz) * u_xlat2.xxx + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb14 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat2.xyz : u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat8 = u_xlat0.z + u_xlat2.x;
    u_xlat2.x = max((-u_xlat0.w), u_xlat8);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat8) + u_xlat2.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat8;
    vs_TEXCOORD2 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat0 = u_xlat10_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _VertexAniSpeed;
uniform 	mediump float _VertexAniScale;
uniform lowp sampler2D _MainTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.y = _Time.y * _VertexAniSpeed;
    u_xlat0.x = 0.0;
    u_xlat16_1.xy = u_xlat0.xy + in_TEXCOORD0.xy;
    u_xlat0.x = textureLod(_MainTex, u_xlat16_1.xy, 0.0).y;
    u_xlat0.x = u_xlat0.x * 0.800000012 + -0.400000006;
    u_xlat0.xyz = u_xlat0.xxx * abs(in_NORMAL0.xyz);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat9 = textureLod(_MainTex, u_xlat2.xy, 0.0).z;
    vs_TEXCOORD1.xy = u_xlat2.xy;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniScale, _VertexAniScale, _VertexAniScale)) + in_POSITION0.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat2.xyz + (-_LightPositionRange.xyz);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat0.x = u_xlat10_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
    u_xlat0.x = min(u_xlat0.x, 0.999000013);
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
    u_xlat0 = fract(u_xlat0);
    SV_Target0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_DEPTH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _VertexAniSpeed;
uniform 	mediump float _VertexAniScale;
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
vec3 u_xlat6;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat5.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.y = _Time.y * _VertexAniSpeed;
    u_xlat1.x = 0.0;
    u_xlat16_2.xy = u_xlat1.xy + in_TEXCOORD0.xy;
    u_xlat15 = textureLod(_MainTex, u_xlat16_2.xy, 0.0).y;
    u_xlat15 = u_xlat15 * 0.800000012 + -0.400000006;
    u_xlat1.x = textureLod(_MainTex, u_xlat5.xy, 0.0).z;
    u_xlat6.xyz = vec3(u_xlat15) * abs(in_NORMAL0.xyz);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_VertexAniScale, _VertexAniScale, _VertexAniScale)) + in_POSITION0.xyz;
    u_xlati0 = u_xlati0 << 3;
    u_xlat2 = u_xlat1.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb15 = unity_LightShadowBias.z!=0.0;
#endif
    if(u_xlatb15){
        u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
        u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
        u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
        u_xlat0 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat0 = inversesqrt(u_xlat0);
        u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
        u_xlat4.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
        u_xlat0 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat0 = inversesqrt(u_xlat0);
        u_xlat4.xyz = vec3(u_xlat0) * u_xlat4.xyz;
        u_xlat0 = dot(u_xlat3.xyz, u_xlat4.xyz);
        u_xlat0 = (-u_xlat0) * u_xlat0 + 1.0;
        u_xlat0 = sqrt(u_xlat0);
        u_xlat0 = u_xlat0 * unity_LightShadowBias.z;
        u_xlat1.xyz = (-u_xlat3.xyz) * vec3(u_xlat0) + u_xlat1.xyz;
    //ENDIF
    }
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0 = unity_LightShadowBias.x / u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 + u_xlat1.z;
    u_xlat15 = max((-u_xlat1.w), u_xlat0);
    u_xlat15 = (-u_xlat0) + u_xlat15;
    gl_Position.z = unity_LightShadowBias.y * u_xlat15 + u_xlat0;
    gl_Position.xyw = u_xlat1.xyw;
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD1.xy = u_xlat5.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat0 = u_xlat10_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_CUBE" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _VertexAniSpeed;
uniform 	mediump float _VertexAniScale;
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
float u_xlat9;
int u_xlati9;
void main()
{
    u_xlat0.y = _Time.y * _VertexAniSpeed;
    u_xlat0.x = 0.0;
    u_xlat16_1.xy = u_xlat0.xy + in_TEXCOORD0.xy;
    u_xlat0.x = textureLod(_MainTex, u_xlat16_1.xy, 0.0).y;
    u_xlat0.x = u_xlat0.x * 0.800000012 + -0.400000006;
    u_xlat0.xyz = u_xlat0.xxx * abs(in_NORMAL0.xyz);
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat9 = textureLod(_MainTex, u_xlat2.xy, 0.0).z;
    vs_TEXCOORD1.xy = u_xlat2.xy;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_VertexAniScale, _VertexAniScale, _VertexAniScale)) + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat2.xyz = u_xlat0.yyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat2.xyz + (-_LightPositionRange.xyz);
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat0.x = u_xlat10_0 + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
    u_xlat0.x = min(u_xlat0.x, 0.999000013);
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
    u_xlat0 = fract(u_xlat0);
    SV_Target0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_DEPTH" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_CUBE" "INSTANCING_ON" }
""
}
}
}
}
}