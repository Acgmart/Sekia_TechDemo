//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Internal-ScreenSpaceShadows-PCF-Specify" {
Properties {
}
SubShader {
 Tags { "ShadowmapFilter" = "HardShadow" }
 Pass {
  Tags { "ShadowmapFilter" = "HardShadow" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 25603
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat12;
int u_xlati12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlati12 = int(u_xlatu12) << 2;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 1)].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati12].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 2)].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 3)].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat12;
int u_xlati12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlati12 = int(u_xlatu12) << 2;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 1)].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati12].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 2)].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 3)].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlat12 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlat12 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat12;
int u_xlati12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlati12 = int(u_xlatu12) << 2;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 1)].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati12].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 2)].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 3)].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat12;
int u_xlati12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlati12 = int(u_xlatu12) << 2;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 1)].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati12].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 2)].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 3)].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlat12 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlat12 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
float u_xlat12;
int u_xlati12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat4 = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat4;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlati12 = int(u_xlatu12) << 2;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 1)].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati12].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 2)].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 3)].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
float u_xlat12;
int u_xlati12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat4 = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat4;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlati12 = int(u_xlatu12) << 2;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 1)].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati12].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 2)].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 3)].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat4 = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat4;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlat12 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat4 = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat4;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlat12 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
float u_xlat12;
int u_xlati12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat4 = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat4, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlati12 = int(u_xlatu12) << 2;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 1)].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati12].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 2)].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 3)].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
float u_xlat12;
int u_xlati12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat4 = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat4, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlati12 = int(u_xlatu12) << 2;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 1)].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati12].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 2)].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 3)].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat4 = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat4, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlat12 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat4 = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat4, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlat12 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
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
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
""
}
}
}
}
SubShader {
 Tags { "ShadowmapFilter" = "HardShadow_FORCE_INV_PROJECTION_IN_PS" }
 Pass {
  Tags { "ShadowmapFilter" = "HardShadow_FORCE_INV_PROJECTION_IN_PS" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 92763
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat12;
int u_xlati12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlati12 = int(u_xlatu12) << 2;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 1)].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati12].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 2)].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 3)].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat12;
int u_xlati12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlati12 = int(u_xlatu12) << 2;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 1)].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati12].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 2)].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 3)].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlat12 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlat12 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat12;
int u_xlati12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlati12 = int(u_xlatu12) << 2;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 1)].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati12].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 2)].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 3)].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat12;
int u_xlati12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlati12 = int(u_xlatu12) << 2;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 1)].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati12].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 2)].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 3)].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlat12 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlat12 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
float u_xlat12;
int u_xlati12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat4 = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat4;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlati12 = int(u_xlatu12) << 2;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 1)].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati12].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 2)].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 3)].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
float u_xlat12;
int u_xlati12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat4 = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat4;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlati12 = int(u_xlatu12) << 2;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 1)].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati12].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 2)].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 3)].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat4 = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat4;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlat12 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat4 = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat4;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlat12 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
float u_xlat12;
int u_xlati12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat4 = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat4, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlati12 = int(u_xlatu12) << 2;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 1)].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati12].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 2)].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 3)].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
float u_xlat12;
int u_xlati12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat4 = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat4, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb1.x = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlati12 = int(u_xlatu12) << 2;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 1)].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati12].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 2)].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati12 + 3)].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat4 = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat4, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlat12 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
float u_xlat12;
uint u_xlatu12;
bool u_xlatb12;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat4 = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat4, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat12 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
    u_xlat16_3.x = u_xlat1.y + u_xlat1.x;
    u_xlat16_3.y = u_xlat1.z + u_xlat16_3.x;
    u_xlat2.zw = (-u_xlat16_3.xy);
    u_xlat2.y = (-u_xlat1.x);
    u_xlat2.x = -0.0;
    u_xlat1 = u_xlat1 + u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat1, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat12 = dot(u_xlat1.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlatu12 = uint(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowPos[int(u_xlatu12)].xyz);
    u_xlat12 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<0.0);
#else
    u_xlatb12 = u_xlat12<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat16_3.x = (-_LightShadowData.x) + 1.0;
    SV_Target0.x = u_xlat10_0 * u_xlat16_3.x + _LightShadowData.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
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
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
""
}
}
}
}
SubShader {
 Tags { "ShadowmapFilter" = "SHADOW_SOFT" }
 Pass {
  Tags { "ShadowmapFilter" = "SHADOW_SOFT" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 177037
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
int u_xlati5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat10 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10<0.0);
#else
    u_xlatb10 = u_xlat10<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlati5 = int(u_xlatu5) << 2;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati5].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat5.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
int u_xlati5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat10 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10<0.0);
#else
    u_xlatb10 = u_xlat10<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlati5 = int(u_xlatu5) << 2;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati5].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat5.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
vec2 u_xlat8;
vec4 u_xlat9;
mediump vec3 u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
vec2 u_xlat13;
int u_xlati13;
uint u_xlatu13;
bool u_xlatb13;
lowp float u_xlat10_23;
bool u_xlatb24;
vec2 u_xlat25;
vec2 u_xlat29;
vec2 u_xlat30;
float u_xlat33;
int u_xlati33;
uint u_xlatu33;
bool u_xlatb33;
float u_xlat34;
mediump float u_xlat16_34;
lowp float u_xlat10_34;
float u_xlat35;
lowp float u_xlat10_35;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat33 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<0.0);
#else
    u_xlatb33 = u_xlat33<0.0;
#endif
    if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat4.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb3 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat3 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb3));
    u_xlat16_6.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_6.y = u_xlat3.z + u_xlat16_6.x;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat3.x);
    u_xlat4.zw = (-u_xlat16_6.xy);
    u_xlat4 = u_xlat3 + u_xlat4;
    u_xlat4 = max(u_xlat4, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat33 = u_xlat16_6.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<0.0);
#else
    u_xlatb33 = u_xlat33<0.0;
#endif
    if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
    u_xlat33 = dot(u_xlat4.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat33 = min(u_xlat33, 3.0);
    u_xlatu33 = uint(u_xlat33);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu33)].xyz);
    u_xlati33 = int(u_xlatu33) << 2;
    u_xlat7.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 1)].xyz;
    u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati33].xyz * u_xlat5.xxx + u_xlat7.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat5.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat29.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat8.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat30.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat30.xy = u_xlat30.xy / u_xlat29.yx;
    u_xlat6.xy = u_xlat30.xy + vec2(-1.0, -1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat8.xy;
    u_xlat6.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat6 = u_xlat6.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat33 = u_xlat29.x * u_xlat29.y;
    u_xlat9 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xzyz;
    vec3 txVec0 = vec3(u_xlat9.xy,u_xlat5.z);
    u_xlat10_34 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat5.xy = u_xlat29.xy * u_xlat8.xy;
    vec3 txVec1 = vec3(u_xlat9.zw,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat3.x = u_xlat10_3 * u_xlat5.x;
    u_xlat33 = u_xlat33 * u_xlat10_34 + u_xlat3.x;
    u_xlat6 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xwyw;
    vec3 txVec2 = vec3(u_xlat6.xy,u_xlat5.z);
    u_xlat10_34 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat33 = u_xlat5.y * u_xlat10_34 + u_xlat33;
    u_xlat34 = u_xlat8.y * u_xlat8.x;
    vec3 txVec3 = vec3(u_xlat6.zw,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat33 = u_xlat34 * u_xlat10_3 + u_xlat33;
    u_xlat33 = u_xlat33 * 0.0625;
    u_xlat16_34 = (-_LightShadowData.x) + 1.0;
    u_xlat33 = u_xlat33 * u_xlat16_34 + _LightShadowData.x;
    u_xlat2 = u_xlat2 / unity_ShadowSplitSqRadii;
    u_xlat2.x = dot(u_xlat2, u_xlat4);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.639999986<u_xlat2.x);
#else
    u_xlatb13 = 0.639999986<u_xlat2.x;
#endif
    if(u_xlatb13){
        u_xlat16_10.xyz = vec3(u_xlat3.y * u_xlat4.x, u_xlat3.z * u_xlat4.y, u_xlat3.w * u_xlat4.z);
        u_xlat13.x = dot(u_xlat16_10.xyz, vec3(1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(0.5<u_xlat13.x);
#else
        u_xlatb24 = 0.5<u_xlat13.x;
#endif
        if(u_xlatb24){
            u_xlatu13 = uint(u_xlat13.x);
            u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu13)].xyz);
            u_xlati13 = int(u_xlatu13) << 2;
            u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 1)].xyz;
            u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati13].xyz * u_xlat1.xxx + u_xlat3.xyz;
            u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 2)].xyz * u_xlat1.zzz + u_xlat3.xyz;
            u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 3)].xyz;
            u_xlat1.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
            u_xlat13.xy = floor(u_xlat1.xy);
            u_xlat13.xy = u_xlat13.xy + vec2(-0.5, -0.5);
            u_xlat1.xy = fract(u_xlat1.xy);
            u_xlat3.xy = (-u_xlat1.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
            u_xlat25.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
            u_xlat4.xy = (-u_xlat1.xy) + vec2(2.0, 2.0);
            u_xlat4.xy = u_xlat4.xy / u_xlat3.yx;
            u_xlat4.xy = u_xlat4.xy + vec2(-1.0, -1.0);
            u_xlat1.xy = u_xlat1.xy / u_xlat25.xy;
            u_xlat4.zw = u_xlat1.xy + vec2(1.0, 1.0);
            u_xlat4 = u_xlat4.xzyw * _ShadowMapTexture_TexelSize.xxyy;
            u_xlat1.x = u_xlat3.x * u_xlat3.y;
            u_xlat5 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xzyz;
            vec3 txVec4 = vec3(u_xlat5.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
            u_xlat3.xy = u_xlat3.xy * u_xlat25.xy;
            vec3 txVec5 = vec3(u_xlat5.zw,u_xlat1.z);
            u_xlat10_35 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
            u_xlat35 = u_xlat10_35 * u_xlat3.x;
            u_xlat1.x = u_xlat1.x * u_xlat10_12 + u_xlat35;
            u_xlat4 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xwyw;
            vec3 txVec6 = vec3(u_xlat4.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
            u_xlat1.x = u_xlat3.y * u_xlat10_12 + u_xlat1.x;
            u_xlat12 = u_xlat25.y * u_xlat25.x;
            vec3 txVec7 = vec3(u_xlat4.zw,u_xlat1.z);
            u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
            u_xlat1.x = u_xlat12 * u_xlat10_23 + u_xlat1.x;
            u_xlat1.x = u_xlat16_34 * u_xlat1.x;
            u_xlat1.x = u_xlat1.x * 0.0625 + _LightShadowData.x;
            u_xlat16_1 = u_xlat1.x;
        } else {
            u_xlat16_1 = 1.0;
        //ENDIF
        }
        u_xlat2.x = u_xlat2.x + -0.639999986;
        u_xlat2.x = u_xlat2.x * 2.77777767;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat13.x = (-u_xlat33) + u_xlat16_1;
        u_xlat2.x = u_xlat2.x * u_xlat13.x + u_xlat33;
        u_xlat16_2 = u_xlat2.x;
    } else {
        u_xlat16_2 = u_xlat33;
    //ENDIF
    }
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat11 = u_xlat11 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat11;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat16_2) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + u_xlat16_2;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
vec2 u_xlat8;
vec4 u_xlat9;
mediump vec3 u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
vec2 u_xlat13;
int u_xlati13;
uint u_xlatu13;
bool u_xlatb13;
lowp float u_xlat10_23;
bool u_xlatb24;
vec2 u_xlat25;
vec2 u_xlat29;
vec2 u_xlat30;
float u_xlat33;
int u_xlati33;
uint u_xlatu33;
bool u_xlatb33;
float u_xlat34;
mediump float u_xlat16_34;
lowp float u_xlat10_34;
float u_xlat35;
lowp float u_xlat10_35;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat33 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<0.0);
#else
    u_xlatb33 = u_xlat33<0.0;
#endif
    if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat4.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb3 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat3 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb3));
    u_xlat16_6.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_6.y = u_xlat3.z + u_xlat16_6.x;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat3.x);
    u_xlat4.zw = (-u_xlat16_6.xy);
    u_xlat4 = u_xlat3 + u_xlat4;
    u_xlat4 = max(u_xlat4, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat33 = u_xlat16_6.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<0.0);
#else
    u_xlatb33 = u_xlat33<0.0;
#endif
    if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
    u_xlat33 = dot(u_xlat4.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat33 = min(u_xlat33, 3.0);
    u_xlatu33 = uint(u_xlat33);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu33)].xyz);
    u_xlati33 = int(u_xlatu33) << 2;
    u_xlat7.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 1)].xyz;
    u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati33].xyz * u_xlat5.xxx + u_xlat7.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat5.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat29.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat8.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat30.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat30.xy = u_xlat30.xy / u_xlat29.yx;
    u_xlat6.xy = u_xlat30.xy + vec2(-1.0, -1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat8.xy;
    u_xlat6.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat6 = u_xlat6.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat33 = u_xlat29.x * u_xlat29.y;
    u_xlat9 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xzyz;
    vec3 txVec0 = vec3(u_xlat9.xy,u_xlat5.z);
    u_xlat10_34 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat5.xy = u_xlat29.xy * u_xlat8.xy;
    vec3 txVec1 = vec3(u_xlat9.zw,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat3.x = u_xlat10_3 * u_xlat5.x;
    u_xlat33 = u_xlat33 * u_xlat10_34 + u_xlat3.x;
    u_xlat6 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xwyw;
    vec3 txVec2 = vec3(u_xlat6.xy,u_xlat5.z);
    u_xlat10_34 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat33 = u_xlat5.y * u_xlat10_34 + u_xlat33;
    u_xlat34 = u_xlat8.y * u_xlat8.x;
    vec3 txVec3 = vec3(u_xlat6.zw,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat33 = u_xlat34 * u_xlat10_3 + u_xlat33;
    u_xlat33 = u_xlat33 * 0.0625;
    u_xlat16_34 = (-_LightShadowData.x) + 1.0;
    u_xlat33 = u_xlat33 * u_xlat16_34 + _LightShadowData.x;
    u_xlat2 = u_xlat2 / unity_ShadowSplitSqRadii;
    u_xlat2.x = dot(u_xlat2, u_xlat4);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.639999986<u_xlat2.x);
#else
    u_xlatb13 = 0.639999986<u_xlat2.x;
#endif
    if(u_xlatb13){
        u_xlat16_10.xyz = vec3(u_xlat3.y * u_xlat4.x, u_xlat3.z * u_xlat4.y, u_xlat3.w * u_xlat4.z);
        u_xlat13.x = dot(u_xlat16_10.xyz, vec3(1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(0.5<u_xlat13.x);
#else
        u_xlatb24 = 0.5<u_xlat13.x;
#endif
        if(u_xlatb24){
            u_xlatu13 = uint(u_xlat13.x);
            u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu13)].xyz);
            u_xlati13 = int(u_xlatu13) << 2;
            u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 1)].xyz;
            u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati13].xyz * u_xlat1.xxx + u_xlat3.xyz;
            u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 2)].xyz * u_xlat1.zzz + u_xlat3.xyz;
            u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 3)].xyz;
            u_xlat1.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
            u_xlat13.xy = floor(u_xlat1.xy);
            u_xlat13.xy = u_xlat13.xy + vec2(-0.5, -0.5);
            u_xlat1.xy = fract(u_xlat1.xy);
            u_xlat3.xy = (-u_xlat1.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
            u_xlat25.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
            u_xlat4.xy = (-u_xlat1.xy) + vec2(2.0, 2.0);
            u_xlat4.xy = u_xlat4.xy / u_xlat3.yx;
            u_xlat4.xy = u_xlat4.xy + vec2(-1.0, -1.0);
            u_xlat1.xy = u_xlat1.xy / u_xlat25.xy;
            u_xlat4.zw = u_xlat1.xy + vec2(1.0, 1.0);
            u_xlat4 = u_xlat4.xzyw * _ShadowMapTexture_TexelSize.xxyy;
            u_xlat1.x = u_xlat3.x * u_xlat3.y;
            u_xlat5 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xzyz;
            vec3 txVec4 = vec3(u_xlat5.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
            u_xlat3.xy = u_xlat3.xy * u_xlat25.xy;
            vec3 txVec5 = vec3(u_xlat5.zw,u_xlat1.z);
            u_xlat10_35 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
            u_xlat35 = u_xlat10_35 * u_xlat3.x;
            u_xlat1.x = u_xlat1.x * u_xlat10_12 + u_xlat35;
            u_xlat4 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xwyw;
            vec3 txVec6 = vec3(u_xlat4.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
            u_xlat1.x = u_xlat3.y * u_xlat10_12 + u_xlat1.x;
            u_xlat12 = u_xlat25.y * u_xlat25.x;
            vec3 txVec7 = vec3(u_xlat4.zw,u_xlat1.z);
            u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
            u_xlat1.x = u_xlat12 * u_xlat10_23 + u_xlat1.x;
            u_xlat1.x = u_xlat16_34 * u_xlat1.x;
            u_xlat1.x = u_xlat1.x * 0.0625 + _LightShadowData.x;
            u_xlat16_1 = u_xlat1.x;
        } else {
            u_xlat16_1 = 1.0;
        //ENDIF
        }
        u_xlat2.x = u_xlat2.x + -0.639999986;
        u_xlat2.x = u_xlat2.x * 2.77777767;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat13.x = (-u_xlat33) + u_xlat16_1;
        u_xlat2.x = u_xlat2.x * u_xlat13.x + u_xlat33;
        u_xlat16_2 = u_xlat2.x;
    } else {
        u_xlat16_2 = u_xlat33;
    //ENDIF
    }
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat11 = u_xlat11 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat11;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat16_2) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + u_xlat16_2;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "ENABLE_CLOUD_SHADOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
int u_xlati6;
uint u_xlatu6;
vec2 u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat12.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12.x<0.0);
#else
    u_xlatb12 = u_xlat12.x<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlati6 = int(u_xlatu6) << 2;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat12.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat12.xy = u_xlat12.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_12 = texture(_cloudLayerShadowTexture, u_xlat12.xy).x;
    u_xlat12.x = u_xlat10_12 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati6].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 3)].xyz;
    u_xlat6.xz = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat6.xz);
    u_xlat6.xz = fract(u_xlat6.xz);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xz) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.zx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xz * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xz = u_xlat6.xz / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xz + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat1.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat1.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xyw = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat1.x;
    u_xlat6.x = u_xlat1.w * u_xlat10_18 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat1.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat1.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat1.y * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_1 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_18 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_18 + _LightShadowData.x;
    u_xlat16_5 = u_xlat12.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat12.x + 1.0;
    u_xlat12.x = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12.x = u_xlat12.x * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12.x;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "ENABLE_CLOUD_SHADOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
int u_xlati6;
uint u_xlatu6;
vec2 u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat12.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12.x<0.0);
#else
    u_xlatb12 = u_xlat12.x<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlati6 = int(u_xlatu6) << 2;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat12.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat12.xy = u_xlat12.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_12 = texture(_cloudLayerShadowTexture, u_xlat12.xy).x;
    u_xlat12.x = u_xlat10_12 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati6].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 3)].xyz;
    u_xlat6.xz = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat6.xz);
    u_xlat6.xz = fract(u_xlat6.xz);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xz) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.zx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xz * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xz = u_xlat6.xz / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xz + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat1.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat1.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xyw = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat1.x;
    u_xlat6.x = u_xlat1.w * u_xlat10_18 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat1.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat1.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat1.y * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_1 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_18 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_18 + _LightShadowData.x;
    u_xlat16_5 = u_xlat12.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat12.x + 1.0;
    u_xlat12.x = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12.x = u_xlat12.x * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12.x;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "ENABLE_CLOUD_SHADOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
uint u_xlatu6;
vec3 u_xlat7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlat19 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<0.0);
#else
    u_xlatb19 = u_xlat19<0.0;
#endif
    if((int(u_xlatb19) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_1 = texture(_cloudLayerShadowTexture, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat6.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat6.xxx + u_xlat7.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat6.zzz + u_xlat7.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat6.xy = u_xlat6.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat6.xy);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xy) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xy = u_xlat6.xy / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat7.xyz = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat7.x;
    u_xlat6.x = u_xlat7.z * u_xlat10_12 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat6.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat7.y * u_xlat10_12 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_12 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_12 + _LightShadowData.x;
    u_xlat16_5 = u_xlat1.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat1.x + 1.0;
    u_xlat12 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12 = u_xlat12 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "ENABLE_CLOUD_SHADOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
uint u_xlatu6;
vec3 u_xlat7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlat19 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<0.0);
#else
    u_xlatb19 = u_xlat19<0.0;
#endif
    if((int(u_xlatb19) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_1 = texture(_cloudLayerShadowTexture, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat6.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat6.xxx + u_xlat7.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat6.zzz + u_xlat7.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat6.xy = u_xlat6.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat6.xy);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xy) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xy = u_xlat6.xy / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat7.xyz = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat7.x;
    u_xlat6.x = u_xlat7.z * u_xlat10_12 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat6.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat7.y * u_xlat10_12 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_12 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_12 + _LightShadowData.x;
    u_xlat16_5 = u_xlat1.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat1.x + 1.0;
    u_xlat12 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12 = u_xlat12 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
lowp float u_xlat10_5;
vec4 u_xlat6;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
vec2 u_xlat8;
vec4 u_xlat9;
float u_xlat10;
mediump float u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
vec2 u_xlat13;
int u_xlati13;
uint u_xlatu13;
bool u_xlatb13;
vec3 u_xlat14;
mediump vec3 u_xlat16_21;
lowp float u_xlat10_23;
bool u_xlatb24;
vec2 u_xlat26;
vec2 u_xlat29;
vec2 u_xlat30;
float u_xlat33;
lowp float u_xlat10_33;
bool u_xlatb33;
float u_xlat34;
int u_xlati34;
uint u_xlatu34;
bool u_xlatb34;
float u_xlat35;
lowp float u_xlat10_35;
lowp float u_xlat10_38;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat33 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<0.0);
#else
    u_xlatb33 = u_xlat33<0.0;
#endif
    if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat2.xy = u_xlat2.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_33 = texture(_cloudLayerShadowTexture, u_xlat2.xy).x;
    u_xlat33 = u_xlat10_33 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat4.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb3 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat3 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb3));
    u_xlat16_6.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_6.y = u_xlat3.z + u_xlat16_6.x;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat3.x);
    u_xlat4.zw = (-u_xlat16_6.xy);
    u_xlat4 = u_xlat3 + u_xlat4;
    u_xlat4 = max(u_xlat4, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat34 = u_xlat16_6.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat34<0.0);
#else
    u_xlatb34 = u_xlat34<0.0;
#endif
    if((int(u_xlatb34) * int(0xffffffffu))!=0){discard;}
    u_xlat34 = dot(u_xlat4.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat34 = min(u_xlat34, 3.0);
    u_xlatu34 = uint(u_xlat34);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu34)].xyz);
    u_xlati34 = int(u_xlatu34) << 2;
    u_xlat7.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 1)].xyz;
    u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati34].xyz * u_xlat5.xxx + u_xlat7.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat5.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat29.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat8.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat30.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat30.xy = u_xlat30.xy / u_xlat29.yx;
    u_xlat6.xy = u_xlat30.xy + vec2(-1.0, -1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat8.xy;
    u_xlat6.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat6 = u_xlat6.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat34 = u_xlat29.x * u_xlat29.y;
    u_xlat9 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xzyz;
    vec3 txVec0 = vec3(u_xlat9.xy,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat5.xy = u_xlat29.xy * u_xlat8.xy;
    vec3 txVec1 = vec3(u_xlat9.zw,u_xlat5.z);
    u_xlat10_38 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat5.x = u_xlat10_38 * u_xlat5.x;
    u_xlat34 = u_xlat34 * u_xlat10_3 + u_xlat5.x;
    u_xlat6 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xwyw;
    vec3 txVec2 = vec3(u_xlat6.xy,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat34 = u_xlat5.y * u_xlat10_3 + u_xlat34;
    u_xlat3.x = u_xlat8.y * u_xlat8.x;
    vec3 txVec3 = vec3(u_xlat6.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat34 = u_xlat3.x * u_xlat10_5 + u_xlat34;
    u_xlat34 = u_xlat34 * 0.0625;
    u_xlat16_3 = (-_LightShadowData.x) + 1.0;
    u_xlat34 = u_xlat34 * u_xlat16_3 + _LightShadowData.x;
    u_xlat16_10 = u_xlat33 * u_xlat34;
    u_xlat2 = u_xlat2 / unity_ShadowSplitSqRadii;
    u_xlat2.x = dot(u_xlat2, u_xlat4);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.639999986<u_xlat2.x);
#else
    u_xlatb13 = 0.639999986<u_xlat2.x;
#endif
    if(u_xlatb13){
        u_xlat16_21.xyz = vec3(u_xlat3.y * u_xlat4.x, u_xlat3.z * u_xlat4.y, u_xlat3.w * u_xlat4.z);
        u_xlat13.x = dot(u_xlat16_21.xyz, vec3(1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(0.5<u_xlat13.x);
#else
        u_xlatb24 = 0.5<u_xlat13.x;
#endif
        if(u_xlatb24){
            u_xlatu13 = uint(u_xlat13.x);
            u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu13)].xyz);
            u_xlati13 = int(u_xlatu13) << 2;
            u_xlat14.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 1)].xyz;
            u_xlat14.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati13].xyz * u_xlat1.xxx + u_xlat14.xyz;
            u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 2)].xyz * u_xlat1.zzz + u_xlat14.xyz;
            u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 3)].xyz;
            u_xlat1.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
            u_xlat13.xy = floor(u_xlat1.xy);
            u_xlat13.xy = u_xlat13.xy + vec2(-0.5, -0.5);
            u_xlat1.xy = fract(u_xlat1.xy);
            u_xlat14.xy = (-u_xlat1.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
            u_xlat4.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
            u_xlat26.xy = (-u_xlat1.xy) + vec2(2.0, 2.0);
            u_xlat26.xy = u_xlat26.xy / u_xlat14.yx;
            u_xlat5.xy = u_xlat26.xy + vec2(-1.0, -1.0);
            u_xlat1.xy = u_xlat1.xy / u_xlat4.xy;
            u_xlat5.zw = u_xlat1.xy + vec2(1.0, 1.0);
            u_xlat5 = u_xlat5.xzyw * _ShadowMapTexture_TexelSize.xxyy;
            u_xlat1.x = u_xlat14.x * u_xlat14.y;
            u_xlat6 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xzyz;
            vec3 txVec4 = vec3(u_xlat6.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
            u_xlat14.xy = u_xlat14.xy * u_xlat4.xy;
            vec3 txVec5 = vec3(u_xlat6.zw,u_xlat1.z);
            u_xlat10_35 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
            u_xlat35 = u_xlat10_35 * u_xlat14.x;
            u_xlat1.x = u_xlat1.x * u_xlat10_12 + u_xlat35;
            u_xlat5 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwyw;
            vec3 txVec6 = vec3(u_xlat5.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
            u_xlat1.x = u_xlat14.y * u_xlat10_12 + u_xlat1.x;
            u_xlat12 = u_xlat4.y * u_xlat4.x;
            vec3 txVec7 = vec3(u_xlat5.zw,u_xlat1.z);
            u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
            u_xlat1.x = u_xlat12 * u_xlat10_23 + u_xlat1.x;
            u_xlat1.x = u_xlat16_3 * u_xlat1.x;
            u_xlat1.x = u_xlat1.x * 0.0625 + _LightShadowData.x;
            u_xlat16_21.x = u_xlat33 * u_xlat1.x;
        } else {
            u_xlat16_21.x = 1.0;
        //ENDIF
        }
        u_xlat1.x = u_xlat2.x + -0.639999986;
        u_xlat1.x = u_xlat1.x * 2.77777767;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat33 = (-u_xlat34) * u_xlat33 + u_xlat16_21.x;
        u_xlat10 = u_xlat1.x * u_xlat33 + u_xlat16_10;
        u_xlat16_10 = u_xlat10;
    //ENDIF
    }
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat11 = u_xlat11 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat11;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat16_10) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + u_xlat16_10;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
lowp float u_xlat10_5;
vec4 u_xlat6;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
vec2 u_xlat8;
vec4 u_xlat9;
float u_xlat10;
mediump float u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
vec2 u_xlat13;
int u_xlati13;
uint u_xlatu13;
bool u_xlatb13;
vec3 u_xlat14;
mediump vec3 u_xlat16_21;
lowp float u_xlat10_23;
bool u_xlatb24;
vec2 u_xlat26;
vec2 u_xlat29;
vec2 u_xlat30;
float u_xlat33;
lowp float u_xlat10_33;
bool u_xlatb33;
float u_xlat34;
int u_xlati34;
uint u_xlatu34;
bool u_xlatb34;
float u_xlat35;
lowp float u_xlat10_35;
lowp float u_xlat10_38;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat33 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<0.0);
#else
    u_xlatb33 = u_xlat33<0.0;
#endif
    if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat2.xy = u_xlat2.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_33 = texture(_cloudLayerShadowTexture, u_xlat2.xy).x;
    u_xlat33 = u_xlat10_33 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat4.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb3 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat3 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb3));
    u_xlat16_6.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_6.y = u_xlat3.z + u_xlat16_6.x;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat3.x);
    u_xlat4.zw = (-u_xlat16_6.xy);
    u_xlat4 = u_xlat3 + u_xlat4;
    u_xlat4 = max(u_xlat4, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat34 = u_xlat16_6.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat34<0.0);
#else
    u_xlatb34 = u_xlat34<0.0;
#endif
    if((int(u_xlatb34) * int(0xffffffffu))!=0){discard;}
    u_xlat34 = dot(u_xlat4.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat34 = min(u_xlat34, 3.0);
    u_xlatu34 = uint(u_xlat34);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu34)].xyz);
    u_xlati34 = int(u_xlatu34) << 2;
    u_xlat7.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 1)].xyz;
    u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati34].xyz * u_xlat5.xxx + u_xlat7.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat5.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat29.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat8.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat30.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat30.xy = u_xlat30.xy / u_xlat29.yx;
    u_xlat6.xy = u_xlat30.xy + vec2(-1.0, -1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat8.xy;
    u_xlat6.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat6 = u_xlat6.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat34 = u_xlat29.x * u_xlat29.y;
    u_xlat9 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xzyz;
    vec3 txVec0 = vec3(u_xlat9.xy,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat5.xy = u_xlat29.xy * u_xlat8.xy;
    vec3 txVec1 = vec3(u_xlat9.zw,u_xlat5.z);
    u_xlat10_38 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat5.x = u_xlat10_38 * u_xlat5.x;
    u_xlat34 = u_xlat34 * u_xlat10_3 + u_xlat5.x;
    u_xlat6 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xwyw;
    vec3 txVec2 = vec3(u_xlat6.xy,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat34 = u_xlat5.y * u_xlat10_3 + u_xlat34;
    u_xlat3.x = u_xlat8.y * u_xlat8.x;
    vec3 txVec3 = vec3(u_xlat6.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat34 = u_xlat3.x * u_xlat10_5 + u_xlat34;
    u_xlat34 = u_xlat34 * 0.0625;
    u_xlat16_3 = (-_LightShadowData.x) + 1.0;
    u_xlat34 = u_xlat34 * u_xlat16_3 + _LightShadowData.x;
    u_xlat16_10 = u_xlat33 * u_xlat34;
    u_xlat2 = u_xlat2 / unity_ShadowSplitSqRadii;
    u_xlat2.x = dot(u_xlat2, u_xlat4);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.639999986<u_xlat2.x);
#else
    u_xlatb13 = 0.639999986<u_xlat2.x;
#endif
    if(u_xlatb13){
        u_xlat16_21.xyz = vec3(u_xlat3.y * u_xlat4.x, u_xlat3.z * u_xlat4.y, u_xlat3.w * u_xlat4.z);
        u_xlat13.x = dot(u_xlat16_21.xyz, vec3(1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(0.5<u_xlat13.x);
#else
        u_xlatb24 = 0.5<u_xlat13.x;
#endif
        if(u_xlatb24){
            u_xlatu13 = uint(u_xlat13.x);
            u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu13)].xyz);
            u_xlati13 = int(u_xlatu13) << 2;
            u_xlat14.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 1)].xyz;
            u_xlat14.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati13].xyz * u_xlat1.xxx + u_xlat14.xyz;
            u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 2)].xyz * u_xlat1.zzz + u_xlat14.xyz;
            u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 3)].xyz;
            u_xlat1.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
            u_xlat13.xy = floor(u_xlat1.xy);
            u_xlat13.xy = u_xlat13.xy + vec2(-0.5, -0.5);
            u_xlat1.xy = fract(u_xlat1.xy);
            u_xlat14.xy = (-u_xlat1.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
            u_xlat4.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
            u_xlat26.xy = (-u_xlat1.xy) + vec2(2.0, 2.0);
            u_xlat26.xy = u_xlat26.xy / u_xlat14.yx;
            u_xlat5.xy = u_xlat26.xy + vec2(-1.0, -1.0);
            u_xlat1.xy = u_xlat1.xy / u_xlat4.xy;
            u_xlat5.zw = u_xlat1.xy + vec2(1.0, 1.0);
            u_xlat5 = u_xlat5.xzyw * _ShadowMapTexture_TexelSize.xxyy;
            u_xlat1.x = u_xlat14.x * u_xlat14.y;
            u_xlat6 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xzyz;
            vec3 txVec4 = vec3(u_xlat6.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
            u_xlat14.xy = u_xlat14.xy * u_xlat4.xy;
            vec3 txVec5 = vec3(u_xlat6.zw,u_xlat1.z);
            u_xlat10_35 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
            u_xlat35 = u_xlat10_35 * u_xlat14.x;
            u_xlat1.x = u_xlat1.x * u_xlat10_12 + u_xlat35;
            u_xlat5 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwyw;
            vec3 txVec6 = vec3(u_xlat5.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
            u_xlat1.x = u_xlat14.y * u_xlat10_12 + u_xlat1.x;
            u_xlat12 = u_xlat4.y * u_xlat4.x;
            vec3 txVec7 = vec3(u_xlat5.zw,u_xlat1.z);
            u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
            u_xlat1.x = u_xlat12 * u_xlat10_23 + u_xlat1.x;
            u_xlat1.x = u_xlat16_3 * u_xlat1.x;
            u_xlat1.x = u_xlat1.x * 0.0625 + _LightShadowData.x;
            u_xlat16_21.x = u_xlat33 * u_xlat1.x;
        } else {
            u_xlat16_21.x = 1.0;
        //ENDIF
        }
        u_xlat1.x = u_xlat2.x + -0.639999986;
        u_xlat1.x = u_xlat1.x * 2.77777767;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat33 = (-u_xlat34) * u_xlat33 + u_xlat16_21.x;
        u_xlat10 = u_xlat1.x * u_xlat33 + u_xlat16_10;
        u_xlat16_10 = u_xlat10;
    //ENDIF
    }
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat11 = u_xlat11 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat11;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat16_10) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + u_xlat16_10;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
uint u_xlatu6;
vec3 u_xlat7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlat19 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<0.0);
#else
    u_xlatb19 = u_xlat19<0.0;
#endif
    if((int(u_xlatb19) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_1 = texture(_cloudLayerShadowTexture, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat6.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat6.xxx + u_xlat7.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat6.zzz + u_xlat7.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat6.xy = u_xlat6.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat6.xy);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xy) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xy = u_xlat6.xy / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat7.xyz = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat7.x;
    u_xlat6.x = u_xlat7.z * u_xlat10_12 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat6.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat7.y * u_xlat10_12 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_12 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_12 + _LightShadowData.x;
    u_xlat16_5 = u_xlat1.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat1.x + 1.0;
    u_xlat12 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12 = u_xlat12 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
uint u_xlatu6;
vec3 u_xlat7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlat19 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<0.0);
#else
    u_xlatb19 = u_xlat19<0.0;
#endif
    if((int(u_xlatb19) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_1 = texture(_cloudLayerShadowTexture, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat6.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat6.xxx + u_xlat7.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat6.zzz + u_xlat7.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat6.xy = u_xlat6.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat6.xy);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xy) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xy = u_xlat6.xy / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat7.xyz = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat7.x;
    u_xlat6.x = u_xlat7.z * u_xlat10_12 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat6.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat7.y * u_xlat10_12 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_12 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_12 + _LightShadowData.x;
    u_xlat16_5 = u_xlat1.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat1.x + 1.0;
    u_xlat12 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12 = u_xlat12 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
int u_xlati5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat10 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10<0.0);
#else
    u_xlatb10 = u_xlat10<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlati5 = int(u_xlatu5) << 2;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati5].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat5.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
int u_xlati5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat10 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10<0.0);
#else
    u_xlatb10 = u_xlat10<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlati5 = int(u_xlatu5) << 2;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati5].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat5.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
vec2 u_xlat8;
vec4 u_xlat9;
mediump vec3 u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
vec2 u_xlat13;
int u_xlati13;
uint u_xlatu13;
bool u_xlatb13;
lowp float u_xlat10_23;
bool u_xlatb24;
vec2 u_xlat25;
vec2 u_xlat29;
vec2 u_xlat30;
float u_xlat33;
int u_xlati33;
uint u_xlatu33;
bool u_xlatb33;
float u_xlat34;
mediump float u_xlat16_34;
lowp float u_xlat10_34;
float u_xlat35;
lowp float u_xlat10_35;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat33 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<0.0);
#else
    u_xlatb33 = u_xlat33<0.0;
#endif
    if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat4.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb3 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat3 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb3));
    u_xlat16_6.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_6.y = u_xlat3.z + u_xlat16_6.x;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat3.x);
    u_xlat4.zw = (-u_xlat16_6.xy);
    u_xlat4 = u_xlat3 + u_xlat4;
    u_xlat4 = max(u_xlat4, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat33 = u_xlat16_6.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<0.0);
#else
    u_xlatb33 = u_xlat33<0.0;
#endif
    if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
    u_xlat33 = dot(u_xlat4.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat33 = min(u_xlat33, 3.0);
    u_xlatu33 = uint(u_xlat33);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu33)].xyz);
    u_xlati33 = int(u_xlatu33) << 2;
    u_xlat7.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 1)].xyz;
    u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati33].xyz * u_xlat5.xxx + u_xlat7.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat5.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat29.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat8.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat30.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat30.xy = u_xlat30.xy / u_xlat29.yx;
    u_xlat6.xy = u_xlat30.xy + vec2(-1.0, -1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat8.xy;
    u_xlat6.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat6 = u_xlat6.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat33 = u_xlat29.x * u_xlat29.y;
    u_xlat9 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xzyz;
    vec3 txVec0 = vec3(u_xlat9.xy,u_xlat5.z);
    u_xlat10_34 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat5.xy = u_xlat29.xy * u_xlat8.xy;
    vec3 txVec1 = vec3(u_xlat9.zw,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat3.x = u_xlat10_3 * u_xlat5.x;
    u_xlat33 = u_xlat33 * u_xlat10_34 + u_xlat3.x;
    u_xlat6 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xwyw;
    vec3 txVec2 = vec3(u_xlat6.xy,u_xlat5.z);
    u_xlat10_34 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat33 = u_xlat5.y * u_xlat10_34 + u_xlat33;
    u_xlat34 = u_xlat8.y * u_xlat8.x;
    vec3 txVec3 = vec3(u_xlat6.zw,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat33 = u_xlat34 * u_xlat10_3 + u_xlat33;
    u_xlat33 = u_xlat33 * 0.0625;
    u_xlat16_34 = (-_LightShadowData.x) + 1.0;
    u_xlat33 = u_xlat33 * u_xlat16_34 + _LightShadowData.x;
    u_xlat2 = u_xlat2 / unity_ShadowSplitSqRadii;
    u_xlat2.x = dot(u_xlat2, u_xlat4);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.639999986<u_xlat2.x);
#else
    u_xlatb13 = 0.639999986<u_xlat2.x;
#endif
    if(u_xlatb13){
        u_xlat16_10.xyz = vec3(u_xlat3.y * u_xlat4.x, u_xlat3.z * u_xlat4.y, u_xlat3.w * u_xlat4.z);
        u_xlat13.x = dot(u_xlat16_10.xyz, vec3(1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(0.5<u_xlat13.x);
#else
        u_xlatb24 = 0.5<u_xlat13.x;
#endif
        if(u_xlatb24){
            u_xlatu13 = uint(u_xlat13.x);
            u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu13)].xyz);
            u_xlati13 = int(u_xlatu13) << 2;
            u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 1)].xyz;
            u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati13].xyz * u_xlat1.xxx + u_xlat3.xyz;
            u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 2)].xyz * u_xlat1.zzz + u_xlat3.xyz;
            u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 3)].xyz;
            u_xlat1.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
            u_xlat13.xy = floor(u_xlat1.xy);
            u_xlat13.xy = u_xlat13.xy + vec2(-0.5, -0.5);
            u_xlat1.xy = fract(u_xlat1.xy);
            u_xlat3.xy = (-u_xlat1.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
            u_xlat25.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
            u_xlat4.xy = (-u_xlat1.xy) + vec2(2.0, 2.0);
            u_xlat4.xy = u_xlat4.xy / u_xlat3.yx;
            u_xlat4.xy = u_xlat4.xy + vec2(-1.0, -1.0);
            u_xlat1.xy = u_xlat1.xy / u_xlat25.xy;
            u_xlat4.zw = u_xlat1.xy + vec2(1.0, 1.0);
            u_xlat4 = u_xlat4.xzyw * _ShadowMapTexture_TexelSize.xxyy;
            u_xlat1.x = u_xlat3.x * u_xlat3.y;
            u_xlat5 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xzyz;
            vec3 txVec4 = vec3(u_xlat5.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
            u_xlat3.xy = u_xlat3.xy * u_xlat25.xy;
            vec3 txVec5 = vec3(u_xlat5.zw,u_xlat1.z);
            u_xlat10_35 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
            u_xlat35 = u_xlat10_35 * u_xlat3.x;
            u_xlat1.x = u_xlat1.x * u_xlat10_12 + u_xlat35;
            u_xlat4 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xwyw;
            vec3 txVec6 = vec3(u_xlat4.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
            u_xlat1.x = u_xlat3.y * u_xlat10_12 + u_xlat1.x;
            u_xlat12 = u_xlat25.y * u_xlat25.x;
            vec3 txVec7 = vec3(u_xlat4.zw,u_xlat1.z);
            u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
            u_xlat1.x = u_xlat12 * u_xlat10_23 + u_xlat1.x;
            u_xlat1.x = u_xlat16_34 * u_xlat1.x;
            u_xlat1.x = u_xlat1.x * 0.0625 + _LightShadowData.x;
            u_xlat16_1 = u_xlat1.x;
        } else {
            u_xlat16_1 = 1.0;
        //ENDIF
        }
        u_xlat2.x = u_xlat2.x + -0.639999986;
        u_xlat2.x = u_xlat2.x * 2.77777767;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat13.x = (-u_xlat33) + u_xlat16_1;
        u_xlat2.x = u_xlat2.x * u_xlat13.x + u_xlat33;
        u_xlat16_2 = u_xlat2.x;
    } else {
        u_xlat16_2 = u_xlat33;
    //ENDIF
    }
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat11 = u_xlat11 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat11;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat16_2) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + u_xlat16_2;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "LINE_INTERPOLATION" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
vec2 u_xlat8;
vec4 u_xlat9;
mediump vec3 u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
vec2 u_xlat13;
int u_xlati13;
uint u_xlatu13;
bool u_xlatb13;
lowp float u_xlat10_23;
bool u_xlatb24;
vec2 u_xlat25;
vec2 u_xlat29;
vec2 u_xlat30;
float u_xlat33;
int u_xlati33;
uint u_xlatu33;
bool u_xlatb33;
float u_xlat34;
mediump float u_xlat16_34;
lowp float u_xlat10_34;
float u_xlat35;
lowp float u_xlat10_35;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat33 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<0.0);
#else
    u_xlatb33 = u_xlat33<0.0;
#endif
    if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat4.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb3 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat3 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb3));
    u_xlat16_6.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_6.y = u_xlat3.z + u_xlat16_6.x;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat3.x);
    u_xlat4.zw = (-u_xlat16_6.xy);
    u_xlat4 = u_xlat3 + u_xlat4;
    u_xlat4 = max(u_xlat4, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat33 = u_xlat16_6.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<0.0);
#else
    u_xlatb33 = u_xlat33<0.0;
#endif
    if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
    u_xlat33 = dot(u_xlat4.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat33 = min(u_xlat33, 3.0);
    u_xlatu33 = uint(u_xlat33);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu33)].xyz);
    u_xlati33 = int(u_xlatu33) << 2;
    u_xlat7.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 1)].xyz;
    u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati33].xyz * u_xlat5.xxx + u_xlat7.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat5.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat29.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat8.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat30.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat30.xy = u_xlat30.xy / u_xlat29.yx;
    u_xlat6.xy = u_xlat30.xy + vec2(-1.0, -1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat8.xy;
    u_xlat6.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat6 = u_xlat6.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat33 = u_xlat29.x * u_xlat29.y;
    u_xlat9 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xzyz;
    vec3 txVec0 = vec3(u_xlat9.xy,u_xlat5.z);
    u_xlat10_34 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat5.xy = u_xlat29.xy * u_xlat8.xy;
    vec3 txVec1 = vec3(u_xlat9.zw,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat3.x = u_xlat10_3 * u_xlat5.x;
    u_xlat33 = u_xlat33 * u_xlat10_34 + u_xlat3.x;
    u_xlat6 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xwyw;
    vec3 txVec2 = vec3(u_xlat6.xy,u_xlat5.z);
    u_xlat10_34 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat33 = u_xlat5.y * u_xlat10_34 + u_xlat33;
    u_xlat34 = u_xlat8.y * u_xlat8.x;
    vec3 txVec3 = vec3(u_xlat6.zw,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat33 = u_xlat34 * u_xlat10_3 + u_xlat33;
    u_xlat33 = u_xlat33 * 0.0625;
    u_xlat16_34 = (-_LightShadowData.x) + 1.0;
    u_xlat33 = u_xlat33 * u_xlat16_34 + _LightShadowData.x;
    u_xlat2 = u_xlat2 / unity_ShadowSplitSqRadii;
    u_xlat2.x = dot(u_xlat2, u_xlat4);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.639999986<u_xlat2.x);
#else
    u_xlatb13 = 0.639999986<u_xlat2.x;
#endif
    if(u_xlatb13){
        u_xlat16_10.xyz = vec3(u_xlat3.y * u_xlat4.x, u_xlat3.z * u_xlat4.y, u_xlat3.w * u_xlat4.z);
        u_xlat13.x = dot(u_xlat16_10.xyz, vec3(1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(0.5<u_xlat13.x);
#else
        u_xlatb24 = 0.5<u_xlat13.x;
#endif
        if(u_xlatb24){
            u_xlatu13 = uint(u_xlat13.x);
            u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu13)].xyz);
            u_xlati13 = int(u_xlatu13) << 2;
            u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 1)].xyz;
            u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati13].xyz * u_xlat1.xxx + u_xlat3.xyz;
            u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 2)].xyz * u_xlat1.zzz + u_xlat3.xyz;
            u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 3)].xyz;
            u_xlat1.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
            u_xlat13.xy = floor(u_xlat1.xy);
            u_xlat13.xy = u_xlat13.xy + vec2(-0.5, -0.5);
            u_xlat1.xy = fract(u_xlat1.xy);
            u_xlat3.xy = (-u_xlat1.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
            u_xlat25.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
            u_xlat4.xy = (-u_xlat1.xy) + vec2(2.0, 2.0);
            u_xlat4.xy = u_xlat4.xy / u_xlat3.yx;
            u_xlat4.xy = u_xlat4.xy + vec2(-1.0, -1.0);
            u_xlat1.xy = u_xlat1.xy / u_xlat25.xy;
            u_xlat4.zw = u_xlat1.xy + vec2(1.0, 1.0);
            u_xlat4 = u_xlat4.xzyw * _ShadowMapTexture_TexelSize.xxyy;
            u_xlat1.x = u_xlat3.x * u_xlat3.y;
            u_xlat5 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xzyz;
            vec3 txVec4 = vec3(u_xlat5.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
            u_xlat3.xy = u_xlat3.xy * u_xlat25.xy;
            vec3 txVec5 = vec3(u_xlat5.zw,u_xlat1.z);
            u_xlat10_35 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
            u_xlat35 = u_xlat10_35 * u_xlat3.x;
            u_xlat1.x = u_xlat1.x * u_xlat10_12 + u_xlat35;
            u_xlat4 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xwyw;
            vec3 txVec6 = vec3(u_xlat4.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
            u_xlat1.x = u_xlat3.y * u_xlat10_12 + u_xlat1.x;
            u_xlat12 = u_xlat25.y * u_xlat25.x;
            vec3 txVec7 = vec3(u_xlat4.zw,u_xlat1.z);
            u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
            u_xlat1.x = u_xlat12 * u_xlat10_23 + u_xlat1.x;
            u_xlat1.x = u_xlat16_34 * u_xlat1.x;
            u_xlat1.x = u_xlat1.x * 0.0625 + _LightShadowData.x;
            u_xlat16_1 = u_xlat1.x;
        } else {
            u_xlat16_1 = 1.0;
        //ENDIF
        }
        u_xlat2.x = u_xlat2.x + -0.639999986;
        u_xlat2.x = u_xlat2.x * 2.77777767;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat13.x = (-u_xlat33) + u_xlat16_1;
        u_xlat2.x = u_xlat2.x * u_xlat13.x + u_xlat33;
        u_xlat16_2 = u_xlat2.x;
    } else {
        u_xlat16_2 = u_xlat33;
    //ENDIF
    }
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat11 = u_xlat11 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat11;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat16_2) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + u_xlat16_2;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
int u_xlati6;
uint u_xlatu6;
vec2 u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat12.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12.x<0.0);
#else
    u_xlatb12 = u_xlat12.x<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlati6 = int(u_xlatu6) << 2;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat12.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat12.xy = u_xlat12.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_12 = texture(_cloudLayerShadowTexture, u_xlat12.xy).x;
    u_xlat12.x = u_xlat10_12 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati6].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 3)].xyz;
    u_xlat6.xz = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat6.xz);
    u_xlat6.xz = fract(u_xlat6.xz);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xz) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.zx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xz * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xz = u_xlat6.xz / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xz + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat1.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat1.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xyw = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat1.x;
    u_xlat6.x = u_xlat1.w * u_xlat10_18 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat1.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat1.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat1.y * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_1 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_18 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_18 + _LightShadowData.x;
    u_xlat16_5 = u_xlat12.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat12.x + 1.0;
    u_xlat12.x = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12.x = u_xlat12.x * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12.x;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
int u_xlati6;
uint u_xlatu6;
vec2 u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat12.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12.x<0.0);
#else
    u_xlatb12 = u_xlat12.x<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlati6 = int(u_xlatu6) << 2;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat12.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat12.xy = u_xlat12.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_12 = texture(_cloudLayerShadowTexture, u_xlat12.xy).x;
    u_xlat12.x = u_xlat10_12 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati6].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 3)].xyz;
    u_xlat6.xz = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat6.xz);
    u_xlat6.xz = fract(u_xlat6.xz);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xz) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.zx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xz * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xz = u_xlat6.xz / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xz + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat1.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat1.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xyw = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat1.x;
    u_xlat6.x = u_xlat1.w * u_xlat10_18 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat1.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat1.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat1.y * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_1 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_18 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_18 + _LightShadowData.x;
    u_xlat16_5 = u_xlat12.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat12.x + 1.0;
    u_xlat12.x = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12.x = u_xlat12.x * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12.x;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
uint u_xlatu6;
vec3 u_xlat7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlat19 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<0.0);
#else
    u_xlatb19 = u_xlat19<0.0;
#endif
    if((int(u_xlatb19) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_1 = texture(_cloudLayerShadowTexture, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat6.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat6.xxx + u_xlat7.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat6.zzz + u_xlat7.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat6.xy = u_xlat6.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat6.xy);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xy) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xy = u_xlat6.xy / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat7.xyz = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat7.x;
    u_xlat6.x = u_xlat7.z * u_xlat10_12 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat6.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat7.y * u_xlat10_12 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_12 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_12 + _LightShadowData.x;
    u_xlat16_5 = u_xlat1.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat1.x + 1.0;
    u_xlat12 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12 = u_xlat12 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
uint u_xlatu6;
vec3 u_xlat7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlat19 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<0.0);
#else
    u_xlatb19 = u_xlat19<0.0;
#endif
    if((int(u_xlatb19) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_1 = texture(_cloudLayerShadowTexture, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat6.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat6.xxx + u_xlat7.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat6.zzz + u_xlat7.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat6.xy = u_xlat6.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat6.xy);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xy) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xy = u_xlat6.xy / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat7.xyz = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat7.x;
    u_xlat6.x = u_xlat7.z * u_xlat10_12 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat6.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat7.y * u_xlat10_12 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_12 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_12 + _LightShadowData.x;
    u_xlat16_5 = u_xlat1.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat1.x + 1.0;
    u_xlat12 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12 = u_xlat12 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
lowp float u_xlat10_5;
vec4 u_xlat6;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
vec2 u_xlat8;
vec4 u_xlat9;
float u_xlat10;
mediump float u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
vec2 u_xlat13;
int u_xlati13;
uint u_xlatu13;
bool u_xlatb13;
vec3 u_xlat14;
mediump vec3 u_xlat16_21;
lowp float u_xlat10_23;
bool u_xlatb24;
vec2 u_xlat26;
vec2 u_xlat29;
vec2 u_xlat30;
float u_xlat33;
lowp float u_xlat10_33;
bool u_xlatb33;
float u_xlat34;
int u_xlati34;
uint u_xlatu34;
bool u_xlatb34;
float u_xlat35;
lowp float u_xlat10_35;
lowp float u_xlat10_38;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat33 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<0.0);
#else
    u_xlatb33 = u_xlat33<0.0;
#endif
    if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat2.xy = u_xlat2.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_33 = texture(_cloudLayerShadowTexture, u_xlat2.xy).x;
    u_xlat33 = u_xlat10_33 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat4.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb3 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat3 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb3));
    u_xlat16_6.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_6.y = u_xlat3.z + u_xlat16_6.x;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat3.x);
    u_xlat4.zw = (-u_xlat16_6.xy);
    u_xlat4 = u_xlat3 + u_xlat4;
    u_xlat4 = max(u_xlat4, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat34 = u_xlat16_6.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat34<0.0);
#else
    u_xlatb34 = u_xlat34<0.0;
#endif
    if((int(u_xlatb34) * int(0xffffffffu))!=0){discard;}
    u_xlat34 = dot(u_xlat4.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat34 = min(u_xlat34, 3.0);
    u_xlatu34 = uint(u_xlat34);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu34)].xyz);
    u_xlati34 = int(u_xlatu34) << 2;
    u_xlat7.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 1)].xyz;
    u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati34].xyz * u_xlat5.xxx + u_xlat7.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat5.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat29.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat8.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat30.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat30.xy = u_xlat30.xy / u_xlat29.yx;
    u_xlat6.xy = u_xlat30.xy + vec2(-1.0, -1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat8.xy;
    u_xlat6.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat6 = u_xlat6.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat34 = u_xlat29.x * u_xlat29.y;
    u_xlat9 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xzyz;
    vec3 txVec0 = vec3(u_xlat9.xy,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat5.xy = u_xlat29.xy * u_xlat8.xy;
    vec3 txVec1 = vec3(u_xlat9.zw,u_xlat5.z);
    u_xlat10_38 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat5.x = u_xlat10_38 * u_xlat5.x;
    u_xlat34 = u_xlat34 * u_xlat10_3 + u_xlat5.x;
    u_xlat6 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xwyw;
    vec3 txVec2 = vec3(u_xlat6.xy,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat34 = u_xlat5.y * u_xlat10_3 + u_xlat34;
    u_xlat3.x = u_xlat8.y * u_xlat8.x;
    vec3 txVec3 = vec3(u_xlat6.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat34 = u_xlat3.x * u_xlat10_5 + u_xlat34;
    u_xlat34 = u_xlat34 * 0.0625;
    u_xlat16_3 = (-_LightShadowData.x) + 1.0;
    u_xlat34 = u_xlat34 * u_xlat16_3 + _LightShadowData.x;
    u_xlat16_10 = u_xlat33 * u_xlat34;
    u_xlat2 = u_xlat2 / unity_ShadowSplitSqRadii;
    u_xlat2.x = dot(u_xlat2, u_xlat4);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.639999986<u_xlat2.x);
#else
    u_xlatb13 = 0.639999986<u_xlat2.x;
#endif
    if(u_xlatb13){
        u_xlat16_21.xyz = vec3(u_xlat3.y * u_xlat4.x, u_xlat3.z * u_xlat4.y, u_xlat3.w * u_xlat4.z);
        u_xlat13.x = dot(u_xlat16_21.xyz, vec3(1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(0.5<u_xlat13.x);
#else
        u_xlatb24 = 0.5<u_xlat13.x;
#endif
        if(u_xlatb24){
            u_xlatu13 = uint(u_xlat13.x);
            u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu13)].xyz);
            u_xlati13 = int(u_xlatu13) << 2;
            u_xlat14.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 1)].xyz;
            u_xlat14.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati13].xyz * u_xlat1.xxx + u_xlat14.xyz;
            u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 2)].xyz * u_xlat1.zzz + u_xlat14.xyz;
            u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 3)].xyz;
            u_xlat1.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
            u_xlat13.xy = floor(u_xlat1.xy);
            u_xlat13.xy = u_xlat13.xy + vec2(-0.5, -0.5);
            u_xlat1.xy = fract(u_xlat1.xy);
            u_xlat14.xy = (-u_xlat1.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
            u_xlat4.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
            u_xlat26.xy = (-u_xlat1.xy) + vec2(2.0, 2.0);
            u_xlat26.xy = u_xlat26.xy / u_xlat14.yx;
            u_xlat5.xy = u_xlat26.xy + vec2(-1.0, -1.0);
            u_xlat1.xy = u_xlat1.xy / u_xlat4.xy;
            u_xlat5.zw = u_xlat1.xy + vec2(1.0, 1.0);
            u_xlat5 = u_xlat5.xzyw * _ShadowMapTexture_TexelSize.xxyy;
            u_xlat1.x = u_xlat14.x * u_xlat14.y;
            u_xlat6 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xzyz;
            vec3 txVec4 = vec3(u_xlat6.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
            u_xlat14.xy = u_xlat14.xy * u_xlat4.xy;
            vec3 txVec5 = vec3(u_xlat6.zw,u_xlat1.z);
            u_xlat10_35 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
            u_xlat35 = u_xlat10_35 * u_xlat14.x;
            u_xlat1.x = u_xlat1.x * u_xlat10_12 + u_xlat35;
            u_xlat5 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwyw;
            vec3 txVec6 = vec3(u_xlat5.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
            u_xlat1.x = u_xlat14.y * u_xlat10_12 + u_xlat1.x;
            u_xlat12 = u_xlat4.y * u_xlat4.x;
            vec3 txVec7 = vec3(u_xlat5.zw,u_xlat1.z);
            u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
            u_xlat1.x = u_xlat12 * u_xlat10_23 + u_xlat1.x;
            u_xlat1.x = u_xlat16_3 * u_xlat1.x;
            u_xlat1.x = u_xlat1.x * 0.0625 + _LightShadowData.x;
            u_xlat16_21.x = u_xlat33 * u_xlat1.x;
        } else {
            u_xlat16_21.x = 1.0;
        //ENDIF
        }
        u_xlat1.x = u_xlat2.x + -0.639999986;
        u_xlat1.x = u_xlat1.x * 2.77777767;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat33 = (-u_xlat34) * u_xlat33 + u_xlat16_21.x;
        u_xlat10 = u_xlat1.x * u_xlat33 + u_xlat16_10;
        u_xlat16_10 = u_xlat10;
    //ENDIF
    }
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat11 = u_xlat11 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat11;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat16_10) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + u_xlat16_10;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
lowp float u_xlat10_5;
vec4 u_xlat6;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
vec2 u_xlat8;
vec4 u_xlat9;
float u_xlat10;
mediump float u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
vec2 u_xlat13;
int u_xlati13;
uint u_xlatu13;
bool u_xlatb13;
vec3 u_xlat14;
mediump vec3 u_xlat16_21;
lowp float u_xlat10_23;
bool u_xlatb24;
vec2 u_xlat26;
vec2 u_xlat29;
vec2 u_xlat30;
float u_xlat33;
lowp float u_xlat10_33;
bool u_xlatb33;
float u_xlat34;
int u_xlati34;
uint u_xlatu34;
bool u_xlatb34;
float u_xlat35;
lowp float u_xlat10_35;
lowp float u_xlat10_38;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat33 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<0.0);
#else
    u_xlatb33 = u_xlat33<0.0;
#endif
    if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat2.xy = u_xlat2.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_33 = texture(_cloudLayerShadowTexture, u_xlat2.xy).x;
    u_xlat33 = u_xlat10_33 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat4.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb3 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat3 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb3));
    u_xlat16_6.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_6.y = u_xlat3.z + u_xlat16_6.x;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat3.x);
    u_xlat4.zw = (-u_xlat16_6.xy);
    u_xlat4 = u_xlat3 + u_xlat4;
    u_xlat4 = max(u_xlat4, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat34 = u_xlat16_6.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat34<0.0);
#else
    u_xlatb34 = u_xlat34<0.0;
#endif
    if((int(u_xlatb34) * int(0xffffffffu))!=0){discard;}
    u_xlat34 = dot(u_xlat4.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat34 = min(u_xlat34, 3.0);
    u_xlatu34 = uint(u_xlat34);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu34)].xyz);
    u_xlati34 = int(u_xlatu34) << 2;
    u_xlat7.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 1)].xyz;
    u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati34].xyz * u_xlat5.xxx + u_xlat7.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat5.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat29.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat8.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat30.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat30.xy = u_xlat30.xy / u_xlat29.yx;
    u_xlat6.xy = u_xlat30.xy + vec2(-1.0, -1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat8.xy;
    u_xlat6.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat6 = u_xlat6.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat34 = u_xlat29.x * u_xlat29.y;
    u_xlat9 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xzyz;
    vec3 txVec0 = vec3(u_xlat9.xy,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat5.xy = u_xlat29.xy * u_xlat8.xy;
    vec3 txVec1 = vec3(u_xlat9.zw,u_xlat5.z);
    u_xlat10_38 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat5.x = u_xlat10_38 * u_xlat5.x;
    u_xlat34 = u_xlat34 * u_xlat10_3 + u_xlat5.x;
    u_xlat6 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xwyw;
    vec3 txVec2 = vec3(u_xlat6.xy,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat34 = u_xlat5.y * u_xlat10_3 + u_xlat34;
    u_xlat3.x = u_xlat8.y * u_xlat8.x;
    vec3 txVec3 = vec3(u_xlat6.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat34 = u_xlat3.x * u_xlat10_5 + u_xlat34;
    u_xlat34 = u_xlat34 * 0.0625;
    u_xlat16_3 = (-_LightShadowData.x) + 1.0;
    u_xlat34 = u_xlat34 * u_xlat16_3 + _LightShadowData.x;
    u_xlat16_10 = u_xlat33 * u_xlat34;
    u_xlat2 = u_xlat2 / unity_ShadowSplitSqRadii;
    u_xlat2.x = dot(u_xlat2, u_xlat4);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.639999986<u_xlat2.x);
#else
    u_xlatb13 = 0.639999986<u_xlat2.x;
#endif
    if(u_xlatb13){
        u_xlat16_21.xyz = vec3(u_xlat3.y * u_xlat4.x, u_xlat3.z * u_xlat4.y, u_xlat3.w * u_xlat4.z);
        u_xlat13.x = dot(u_xlat16_21.xyz, vec3(1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(0.5<u_xlat13.x);
#else
        u_xlatb24 = 0.5<u_xlat13.x;
#endif
        if(u_xlatb24){
            u_xlatu13 = uint(u_xlat13.x);
            u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu13)].xyz);
            u_xlati13 = int(u_xlatu13) << 2;
            u_xlat14.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 1)].xyz;
            u_xlat14.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati13].xyz * u_xlat1.xxx + u_xlat14.xyz;
            u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 2)].xyz * u_xlat1.zzz + u_xlat14.xyz;
            u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 3)].xyz;
            u_xlat1.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
            u_xlat13.xy = floor(u_xlat1.xy);
            u_xlat13.xy = u_xlat13.xy + vec2(-0.5, -0.5);
            u_xlat1.xy = fract(u_xlat1.xy);
            u_xlat14.xy = (-u_xlat1.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
            u_xlat4.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
            u_xlat26.xy = (-u_xlat1.xy) + vec2(2.0, 2.0);
            u_xlat26.xy = u_xlat26.xy / u_xlat14.yx;
            u_xlat5.xy = u_xlat26.xy + vec2(-1.0, -1.0);
            u_xlat1.xy = u_xlat1.xy / u_xlat4.xy;
            u_xlat5.zw = u_xlat1.xy + vec2(1.0, 1.0);
            u_xlat5 = u_xlat5.xzyw * _ShadowMapTexture_TexelSize.xxyy;
            u_xlat1.x = u_xlat14.x * u_xlat14.y;
            u_xlat6 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xzyz;
            vec3 txVec4 = vec3(u_xlat6.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
            u_xlat14.xy = u_xlat14.xy * u_xlat4.xy;
            vec3 txVec5 = vec3(u_xlat6.zw,u_xlat1.z);
            u_xlat10_35 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
            u_xlat35 = u_xlat10_35 * u_xlat14.x;
            u_xlat1.x = u_xlat1.x * u_xlat10_12 + u_xlat35;
            u_xlat5 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwyw;
            vec3 txVec6 = vec3(u_xlat5.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
            u_xlat1.x = u_xlat14.y * u_xlat10_12 + u_xlat1.x;
            u_xlat12 = u_xlat4.y * u_xlat4.x;
            vec3 txVec7 = vec3(u_xlat5.zw,u_xlat1.z);
            u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
            u_xlat1.x = u_xlat12 * u_xlat10_23 + u_xlat1.x;
            u_xlat1.x = u_xlat16_3 * u_xlat1.x;
            u_xlat1.x = u_xlat1.x * 0.0625 + _LightShadowData.x;
            u_xlat16_21.x = u_xlat33 * u_xlat1.x;
        } else {
            u_xlat16_21.x = 1.0;
        //ENDIF
        }
        u_xlat1.x = u_xlat2.x + -0.639999986;
        u_xlat1.x = u_xlat1.x * 2.77777767;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat33 = (-u_xlat34) * u_xlat33 + u_xlat16_21.x;
        u_xlat10 = u_xlat1.x * u_xlat33 + u_xlat16_10;
        u_xlat16_10 = u_xlat10;
    //ENDIF
    }
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat11 = u_xlat11 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat11;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat16_10) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + u_xlat16_10;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
uint u_xlatu6;
vec3 u_xlat7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlat19 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<0.0);
#else
    u_xlatb19 = u_xlat19<0.0;
#endif
    if((int(u_xlatb19) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_1 = texture(_cloudLayerShadowTexture, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat6.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat6.xxx + u_xlat7.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat6.zzz + u_xlat7.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat6.xy = u_xlat6.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat6.xy);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xy) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xy = u_xlat6.xy / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat7.xyz = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat7.x;
    u_xlat6.x = u_xlat7.z * u_xlat10_12 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat6.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat7.y * u_xlat10_12 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_12 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_12 + _LightShadowData.x;
    u_xlat16_5 = u_xlat1.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat1.x + 1.0;
    u_xlat12 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12 = u_xlat12 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
uint u_xlatu6;
vec3 u_xlat7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlat19 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<0.0);
#else
    u_xlatb19 = u_xlat19<0.0;
#endif
    if((int(u_xlatb19) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_1 = texture(_cloudLayerShadowTexture, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat6.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat6.xxx + u_xlat7.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat6.zzz + u_xlat7.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat6.xy = u_xlat6.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat6.xy);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xy) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xy = u_xlat6.xy / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat7.xyz = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat7.x;
    u_xlat6.x = u_xlat7.z * u_xlat10_12 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat6.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat7.y * u_xlat10_12 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_12 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_12 + _LightShadowData.x;
    u_xlat16_5 = u_xlat1.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat1.x + 1.0;
    u_xlat12 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12 = u_xlat12 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
int u_xlati5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat5.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat5.x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat10 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10<0.0);
#else
    u_xlatb10 = u_xlat10<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlati5 = int(u_xlatu5) << 2;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati5].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat5.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
int u_xlati5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat5.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat5.x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat10 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10<0.0);
#else
    u_xlatb10 = u_xlat10<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlati5 = int(u_xlatu5) << 2;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati5].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat5.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat5.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat5.x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat5.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat5.x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
lowp float u_xlat10_5;
vec4 u_xlat6;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
vec2 u_xlat8;
vec4 u_xlat9;
mediump vec3 u_xlat16_10;
float u_xlat11;
float u_xlat12;
lowp float u_xlat10_12;
vec2 u_xlat13;
int u_xlati13;
uint u_xlatu13;
bool u_xlatb13;
vec3 u_xlat14;
mediump float u_xlat16_14;
lowp float u_xlat10_23;
bool u_xlatb24;
vec2 u_xlat26;
vec2 u_xlat29;
vec2 u_xlat30;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
int u_xlati34;
uint u_xlatu34;
bool u_xlatb34;
float u_xlat35;
lowp float u_xlat10_35;
lowp float u_xlat10_38;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat11 = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat11;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat33 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<0.0);
#else
    u_xlatb33 = u_xlat33<0.0;
#endif
    if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat4.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb3 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat3 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb3));
    u_xlat16_6.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_6.y = u_xlat3.z + u_xlat16_6.x;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat3.x);
    u_xlat4.zw = (-u_xlat16_6.xy);
    u_xlat4 = u_xlat3 + u_xlat4;
    u_xlat4 = max(u_xlat4, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat33 = u_xlat16_6.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat33<0.0);
#else
    u_xlatb34 = u_xlat33<0.0;
#endif
    if((int(u_xlatb34) * int(0xffffffffu))!=0){discard;}
    u_xlat34 = dot(u_xlat4.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat34 = min(u_xlat34, 3.0);
    u_xlatu34 = uint(u_xlat34);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu34)].xyz);
    u_xlati34 = int(u_xlatu34) << 2;
    u_xlat7.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 1)].xyz;
    u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati34].xyz * u_xlat5.xxx + u_xlat7.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat5.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat29.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat8.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat30.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat30.xy = u_xlat30.xy / u_xlat29.yx;
    u_xlat6.xy = u_xlat30.xy + vec2(-1.0, -1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat8.xy;
    u_xlat6.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat6 = u_xlat6.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat34 = u_xlat29.x * u_xlat29.y;
    u_xlat9 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xzyz;
    vec3 txVec0 = vec3(u_xlat9.xy,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat5.xy = u_xlat29.xy * u_xlat8.xy;
    vec3 txVec1 = vec3(u_xlat9.zw,u_xlat5.z);
    u_xlat10_38 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat5.x = u_xlat10_38 * u_xlat5.x;
    u_xlat34 = u_xlat34 * u_xlat10_3 + u_xlat5.x;
    u_xlat6 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xwyw;
    vec3 txVec2 = vec3(u_xlat6.xy,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat34 = u_xlat5.y * u_xlat10_3 + u_xlat34;
    u_xlat3.x = u_xlat8.y * u_xlat8.x;
    vec3 txVec3 = vec3(u_xlat6.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat34 = u_xlat3.x * u_xlat10_5 + u_xlat34;
    u_xlat34 = u_xlat34 * 0.0625;
    u_xlat16_3 = (-_LightShadowData.x) + 1.0;
    u_xlat34 = u_xlat34 * u_xlat16_3 + _LightShadowData.x;
    u_xlat2 = u_xlat2 / unity_ShadowSplitSqRadii;
    u_xlat2.x = dot(u_xlat2, u_xlat4);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.639999986<u_xlat2.x);
#else
    u_xlatb13 = 0.639999986<u_xlat2.x;
#endif
    if(u_xlatb13){
        u_xlat16_10.xyz = vec3(u_xlat3.y * u_xlat4.x, u_xlat3.z * u_xlat4.y, u_xlat3.w * u_xlat4.z);
        u_xlat13.x = dot(u_xlat16_10.xyz, vec3(1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(0.5<u_xlat13.x);
#else
        u_xlatb24 = 0.5<u_xlat13.x;
#endif
        if(u_xlatb24){
            u_xlatu13 = uint(u_xlat13.x);
            u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu13)].xyz);
            u_xlati13 = int(u_xlatu13) << 2;
            u_xlat14.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 1)].xyz;
            u_xlat14.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati13].xyz * u_xlat1.xxx + u_xlat14.xyz;
            u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 2)].xyz * u_xlat1.zzz + u_xlat14.xyz;
            u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 3)].xyz;
            u_xlat1.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
            u_xlat13.xy = floor(u_xlat1.xy);
            u_xlat13.xy = u_xlat13.xy + vec2(-0.5, -0.5);
            u_xlat1.xy = fract(u_xlat1.xy);
            u_xlat14.xy = (-u_xlat1.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
            u_xlat4.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
            u_xlat26.xy = (-u_xlat1.xy) + vec2(2.0, 2.0);
            u_xlat26.xy = u_xlat26.xy / u_xlat14.yx;
            u_xlat5.xy = u_xlat26.xy + vec2(-1.0, -1.0);
            u_xlat1.xy = u_xlat1.xy / u_xlat4.xy;
            u_xlat5.zw = u_xlat1.xy + vec2(1.0, 1.0);
            u_xlat5 = u_xlat5.xzyw * _ShadowMapTexture_TexelSize.xxyy;
            u_xlat1.x = u_xlat14.x * u_xlat14.y;
            u_xlat6 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xzyz;
            vec3 txVec4 = vec3(u_xlat6.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
            u_xlat14.xy = u_xlat14.xy * u_xlat4.xy;
            vec3 txVec5 = vec3(u_xlat6.zw,u_xlat1.z);
            u_xlat10_35 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
            u_xlat35 = u_xlat10_35 * u_xlat14.x;
            u_xlat1.x = u_xlat1.x * u_xlat10_12 + u_xlat35;
            u_xlat5 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwyw;
            vec3 txVec6 = vec3(u_xlat5.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
            u_xlat1.x = u_xlat14.y * u_xlat10_12 + u_xlat1.x;
            u_xlat12 = u_xlat4.y * u_xlat4.x;
            vec3 txVec7 = vec3(u_xlat5.zw,u_xlat1.z);
            u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
            u_xlat1.x = u_xlat12 * u_xlat10_23 + u_xlat1.x;
            u_xlat1.x = u_xlat16_3 * u_xlat1.x;
            u_xlat1.x = u_xlat1.x * 0.0625 + _LightShadowData.x;
            u_xlat16_1 = u_xlat1.x;
        } else {
            u_xlat16_1 = 1.0;
        //ENDIF
        }
        u_xlat2.x = u_xlat2.x + -0.639999986;
        u_xlat2.x = u_xlat2.x * 2.77777767;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat13.x = (-u_xlat34) + u_xlat16_1;
        u_xlat2.x = u_xlat2.x * u_xlat13.x + u_xlat34;
        u_xlat16_2 = u_xlat2.x;
    } else {
        u_xlat16_2 = u_xlat34;
    //ENDIF
    }
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat14.x = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat14.x = u_xlat14.x * 0.639999986;
    u_xlat3.x = u_xlat3.x / u_xlat14.x;
    u_xlat3.x = u_xlat3.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_14 = (-u_xlat16_2) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat16_14 + u_xlat16_2;
    SV_Target0.x = u_xlat3.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
lowp float u_xlat10_5;
vec4 u_xlat6;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
vec2 u_xlat8;
vec4 u_xlat9;
mediump vec3 u_xlat16_10;
float u_xlat11;
float u_xlat12;
lowp float u_xlat10_12;
vec2 u_xlat13;
int u_xlati13;
uint u_xlatu13;
bool u_xlatb13;
vec3 u_xlat14;
mediump float u_xlat16_14;
lowp float u_xlat10_23;
bool u_xlatb24;
vec2 u_xlat26;
vec2 u_xlat29;
vec2 u_xlat30;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
int u_xlati34;
uint u_xlatu34;
bool u_xlatb34;
float u_xlat35;
lowp float u_xlat10_35;
lowp float u_xlat10_38;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat11 = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat11;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat33 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<0.0);
#else
    u_xlatb33 = u_xlat33<0.0;
#endif
    if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat4.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb3 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat3 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb3));
    u_xlat16_6.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_6.y = u_xlat3.z + u_xlat16_6.x;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat3.x);
    u_xlat4.zw = (-u_xlat16_6.xy);
    u_xlat4 = u_xlat3 + u_xlat4;
    u_xlat4 = max(u_xlat4, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat33 = u_xlat16_6.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat33<0.0);
#else
    u_xlatb34 = u_xlat33<0.0;
#endif
    if((int(u_xlatb34) * int(0xffffffffu))!=0){discard;}
    u_xlat34 = dot(u_xlat4.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat34 = min(u_xlat34, 3.0);
    u_xlatu34 = uint(u_xlat34);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu34)].xyz);
    u_xlati34 = int(u_xlatu34) << 2;
    u_xlat7.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 1)].xyz;
    u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati34].xyz * u_xlat5.xxx + u_xlat7.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat5.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat29.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat8.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat30.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat30.xy = u_xlat30.xy / u_xlat29.yx;
    u_xlat6.xy = u_xlat30.xy + vec2(-1.0, -1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat8.xy;
    u_xlat6.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat6 = u_xlat6.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat34 = u_xlat29.x * u_xlat29.y;
    u_xlat9 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xzyz;
    vec3 txVec0 = vec3(u_xlat9.xy,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat5.xy = u_xlat29.xy * u_xlat8.xy;
    vec3 txVec1 = vec3(u_xlat9.zw,u_xlat5.z);
    u_xlat10_38 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat5.x = u_xlat10_38 * u_xlat5.x;
    u_xlat34 = u_xlat34 * u_xlat10_3 + u_xlat5.x;
    u_xlat6 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xwyw;
    vec3 txVec2 = vec3(u_xlat6.xy,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat34 = u_xlat5.y * u_xlat10_3 + u_xlat34;
    u_xlat3.x = u_xlat8.y * u_xlat8.x;
    vec3 txVec3 = vec3(u_xlat6.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat34 = u_xlat3.x * u_xlat10_5 + u_xlat34;
    u_xlat34 = u_xlat34 * 0.0625;
    u_xlat16_3 = (-_LightShadowData.x) + 1.0;
    u_xlat34 = u_xlat34 * u_xlat16_3 + _LightShadowData.x;
    u_xlat2 = u_xlat2 / unity_ShadowSplitSqRadii;
    u_xlat2.x = dot(u_xlat2, u_xlat4);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.639999986<u_xlat2.x);
#else
    u_xlatb13 = 0.639999986<u_xlat2.x;
#endif
    if(u_xlatb13){
        u_xlat16_10.xyz = vec3(u_xlat3.y * u_xlat4.x, u_xlat3.z * u_xlat4.y, u_xlat3.w * u_xlat4.z);
        u_xlat13.x = dot(u_xlat16_10.xyz, vec3(1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(0.5<u_xlat13.x);
#else
        u_xlatb24 = 0.5<u_xlat13.x;
#endif
        if(u_xlatb24){
            u_xlatu13 = uint(u_xlat13.x);
            u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu13)].xyz);
            u_xlati13 = int(u_xlatu13) << 2;
            u_xlat14.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 1)].xyz;
            u_xlat14.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati13].xyz * u_xlat1.xxx + u_xlat14.xyz;
            u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 2)].xyz * u_xlat1.zzz + u_xlat14.xyz;
            u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 3)].xyz;
            u_xlat1.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
            u_xlat13.xy = floor(u_xlat1.xy);
            u_xlat13.xy = u_xlat13.xy + vec2(-0.5, -0.5);
            u_xlat1.xy = fract(u_xlat1.xy);
            u_xlat14.xy = (-u_xlat1.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
            u_xlat4.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
            u_xlat26.xy = (-u_xlat1.xy) + vec2(2.0, 2.0);
            u_xlat26.xy = u_xlat26.xy / u_xlat14.yx;
            u_xlat5.xy = u_xlat26.xy + vec2(-1.0, -1.0);
            u_xlat1.xy = u_xlat1.xy / u_xlat4.xy;
            u_xlat5.zw = u_xlat1.xy + vec2(1.0, 1.0);
            u_xlat5 = u_xlat5.xzyw * _ShadowMapTexture_TexelSize.xxyy;
            u_xlat1.x = u_xlat14.x * u_xlat14.y;
            u_xlat6 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xzyz;
            vec3 txVec4 = vec3(u_xlat6.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
            u_xlat14.xy = u_xlat14.xy * u_xlat4.xy;
            vec3 txVec5 = vec3(u_xlat6.zw,u_xlat1.z);
            u_xlat10_35 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
            u_xlat35 = u_xlat10_35 * u_xlat14.x;
            u_xlat1.x = u_xlat1.x * u_xlat10_12 + u_xlat35;
            u_xlat5 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwyw;
            vec3 txVec6 = vec3(u_xlat5.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
            u_xlat1.x = u_xlat14.y * u_xlat10_12 + u_xlat1.x;
            u_xlat12 = u_xlat4.y * u_xlat4.x;
            vec3 txVec7 = vec3(u_xlat5.zw,u_xlat1.z);
            u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
            u_xlat1.x = u_xlat12 * u_xlat10_23 + u_xlat1.x;
            u_xlat1.x = u_xlat16_3 * u_xlat1.x;
            u_xlat1.x = u_xlat1.x * 0.0625 + _LightShadowData.x;
            u_xlat16_1 = u_xlat1.x;
        } else {
            u_xlat16_1 = 1.0;
        //ENDIF
        }
        u_xlat2.x = u_xlat2.x + -0.639999986;
        u_xlat2.x = u_xlat2.x * 2.77777767;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat13.x = (-u_xlat34) + u_xlat16_1;
        u_xlat2.x = u_xlat2.x * u_xlat13.x + u_xlat34;
        u_xlat16_2 = u_xlat2.x;
    } else {
        u_xlat16_2 = u_xlat34;
    //ENDIF
    }
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat14.x = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat14.x = u_xlat14.x * 0.639999986;
    u_xlat3.x = u_xlat3.x / u_xlat14.x;
    u_xlat3.x = u_xlat3.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_14 = (-u_xlat16_2) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat16_14 + u_xlat16_2;
    SV_Target0.x = u_xlat3.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat5.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat5.x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat5.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat5.x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" "ENABLE_CLOUD_SHADOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
int u_xlati6;
uint u_xlatu6;
vec2 u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat6.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat6.x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat12.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12.x<0.0);
#else
    u_xlatb12 = u_xlat12.x<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlati6 = int(u_xlatu6) << 2;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat12.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat12.xy = u_xlat12.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_12 = texture(_cloudLayerShadowTexture, u_xlat12.xy).x;
    u_xlat12.x = u_xlat10_12 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati6].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 3)].xyz;
    u_xlat6.xz = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat6.xz);
    u_xlat6.xz = fract(u_xlat6.xz);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xz) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.zx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xz * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xz = u_xlat6.xz / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xz + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat1.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat1.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xyw = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat1.x;
    u_xlat6.x = u_xlat1.w * u_xlat10_18 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat1.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat1.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat1.y * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_1 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_18 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_18 + _LightShadowData.x;
    u_xlat16_5 = u_xlat12.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat12.x + 1.0;
    u_xlat12.x = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12.x = u_xlat12.x * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12.x;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" "ENABLE_CLOUD_SHADOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
int u_xlati6;
uint u_xlatu6;
vec2 u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat6.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat6.x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat12.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12.x<0.0);
#else
    u_xlatb12 = u_xlat12.x<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlati6 = int(u_xlatu6) << 2;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat12.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat12.xy = u_xlat12.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_12 = texture(_cloudLayerShadowTexture, u_xlat12.xy).x;
    u_xlat12.x = u_xlat10_12 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati6].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 3)].xyz;
    u_xlat6.xz = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat6.xz);
    u_xlat6.xz = fract(u_xlat6.xz);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xz) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.zx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xz * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xz = u_xlat6.xz / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xz + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat1.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat1.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xyw = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat1.x;
    u_xlat6.x = u_xlat1.w * u_xlat10_18 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat1.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat1.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat1.y * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_1 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_18 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_18 + _LightShadowData.x;
    u_xlat16_5 = u_xlat12.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat12.x + 1.0;
    u_xlat12.x = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12.x = u_xlat12.x * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12.x;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "ENABLE_CLOUD_SHADOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
uint u_xlatu6;
vec3 u_xlat7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat6.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat6.x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlat19 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<0.0);
#else
    u_xlatb19 = u_xlat19<0.0;
#endif
    if((int(u_xlatb19) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_1 = texture(_cloudLayerShadowTexture, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat6.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat6.xxx + u_xlat7.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat6.zzz + u_xlat7.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat6.xy = u_xlat6.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat6.xy);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xy) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xy = u_xlat6.xy / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat7.xyz = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat7.x;
    u_xlat6.x = u_xlat7.z * u_xlat10_12 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat6.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat7.y * u_xlat10_12 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_12 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_12 + _LightShadowData.x;
    u_xlat16_5 = u_xlat1.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat1.x + 1.0;
    u_xlat12 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12 = u_xlat12 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "ENABLE_CLOUD_SHADOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
uint u_xlatu6;
vec3 u_xlat7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat6.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat6.x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlat19 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<0.0);
#else
    u_xlatb19 = u_xlat19<0.0;
#endif
    if((int(u_xlatb19) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_1 = texture(_cloudLayerShadowTexture, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat6.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat6.xxx + u_xlat7.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat6.zzz + u_xlat7.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat6.xy = u_xlat6.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat6.xy);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xy) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xy = u_xlat6.xy / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat7.xyz = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat7.x;
    u_xlat6.x = u_xlat7.z * u_xlat10_12 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat6.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat7.y * u_xlat10_12 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_12 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_12 + _LightShadowData.x;
    u_xlat16_5 = u_xlat1.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat1.x + 1.0;
    u_xlat12 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12 = u_xlat12 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
lowp float u_xlat10_5;
vec4 u_xlat6;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
vec2 u_xlat8;
vec4 u_xlat9;
float u_xlat10;
mediump float u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
vec2 u_xlat13;
int u_xlati13;
uint u_xlatu13;
bool u_xlatb13;
vec3 u_xlat14;
mediump vec3 u_xlat16_21;
lowp float u_xlat10_23;
bool u_xlatb24;
vec2 u_xlat26;
vec2 u_xlat29;
vec2 u_xlat30;
float u_xlat33;
lowp float u_xlat10_33;
bool u_xlatb33;
float u_xlat34;
int u_xlati34;
uint u_xlatu34;
bool u_xlatb34;
float u_xlat35;
lowp float u_xlat10_35;
lowp float u_xlat10_38;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat11 = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat11;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat33 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<0.0);
#else
    u_xlatb33 = u_xlat33<0.0;
#endif
    if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat2.xy = u_xlat2.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_33 = texture(_cloudLayerShadowTexture, u_xlat2.xy).x;
    u_xlat33 = u_xlat10_33 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat4.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb3 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat3 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb3));
    u_xlat16_6.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_6.y = u_xlat3.z + u_xlat16_6.x;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat3.x);
    u_xlat4.zw = (-u_xlat16_6.xy);
    u_xlat4 = u_xlat3 + u_xlat4;
    u_xlat4 = max(u_xlat4, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat34 = u_xlat16_6.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat34<0.0);
#else
    u_xlatb34 = u_xlat34<0.0;
#endif
    if((int(u_xlatb34) * int(0xffffffffu))!=0){discard;}
    u_xlat34 = dot(u_xlat4.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat34 = min(u_xlat34, 3.0);
    u_xlatu34 = uint(u_xlat34);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu34)].xyz);
    u_xlati34 = int(u_xlatu34) << 2;
    u_xlat7.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 1)].xyz;
    u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati34].xyz * u_xlat5.xxx + u_xlat7.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat5.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat29.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat8.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat30.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat30.xy = u_xlat30.xy / u_xlat29.yx;
    u_xlat6.xy = u_xlat30.xy + vec2(-1.0, -1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat8.xy;
    u_xlat6.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat6 = u_xlat6.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat34 = u_xlat29.x * u_xlat29.y;
    u_xlat9 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xzyz;
    vec3 txVec0 = vec3(u_xlat9.xy,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat5.xy = u_xlat29.xy * u_xlat8.xy;
    vec3 txVec1 = vec3(u_xlat9.zw,u_xlat5.z);
    u_xlat10_38 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat5.x = u_xlat10_38 * u_xlat5.x;
    u_xlat34 = u_xlat34 * u_xlat10_3 + u_xlat5.x;
    u_xlat6 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xwyw;
    vec3 txVec2 = vec3(u_xlat6.xy,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat34 = u_xlat5.y * u_xlat10_3 + u_xlat34;
    u_xlat3.x = u_xlat8.y * u_xlat8.x;
    vec3 txVec3 = vec3(u_xlat6.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat34 = u_xlat3.x * u_xlat10_5 + u_xlat34;
    u_xlat34 = u_xlat34 * 0.0625;
    u_xlat16_3 = (-_LightShadowData.x) + 1.0;
    u_xlat34 = u_xlat34 * u_xlat16_3 + _LightShadowData.x;
    u_xlat16_10 = u_xlat33 * u_xlat34;
    u_xlat2 = u_xlat2 / unity_ShadowSplitSqRadii;
    u_xlat2.x = dot(u_xlat2, u_xlat4);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.639999986<u_xlat2.x);
#else
    u_xlatb13 = 0.639999986<u_xlat2.x;
#endif
    if(u_xlatb13){
        u_xlat16_21.xyz = vec3(u_xlat3.y * u_xlat4.x, u_xlat3.z * u_xlat4.y, u_xlat3.w * u_xlat4.z);
        u_xlat13.x = dot(u_xlat16_21.xyz, vec3(1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(0.5<u_xlat13.x);
#else
        u_xlatb24 = 0.5<u_xlat13.x;
#endif
        if(u_xlatb24){
            u_xlatu13 = uint(u_xlat13.x);
            u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu13)].xyz);
            u_xlati13 = int(u_xlatu13) << 2;
            u_xlat14.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 1)].xyz;
            u_xlat14.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati13].xyz * u_xlat1.xxx + u_xlat14.xyz;
            u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 2)].xyz * u_xlat1.zzz + u_xlat14.xyz;
            u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 3)].xyz;
            u_xlat1.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
            u_xlat13.xy = floor(u_xlat1.xy);
            u_xlat13.xy = u_xlat13.xy + vec2(-0.5, -0.5);
            u_xlat1.xy = fract(u_xlat1.xy);
            u_xlat14.xy = (-u_xlat1.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
            u_xlat4.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
            u_xlat26.xy = (-u_xlat1.xy) + vec2(2.0, 2.0);
            u_xlat26.xy = u_xlat26.xy / u_xlat14.yx;
            u_xlat5.xy = u_xlat26.xy + vec2(-1.0, -1.0);
            u_xlat1.xy = u_xlat1.xy / u_xlat4.xy;
            u_xlat5.zw = u_xlat1.xy + vec2(1.0, 1.0);
            u_xlat5 = u_xlat5.xzyw * _ShadowMapTexture_TexelSize.xxyy;
            u_xlat1.x = u_xlat14.x * u_xlat14.y;
            u_xlat6 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xzyz;
            vec3 txVec4 = vec3(u_xlat6.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
            u_xlat14.xy = u_xlat14.xy * u_xlat4.xy;
            vec3 txVec5 = vec3(u_xlat6.zw,u_xlat1.z);
            u_xlat10_35 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
            u_xlat35 = u_xlat10_35 * u_xlat14.x;
            u_xlat1.x = u_xlat1.x * u_xlat10_12 + u_xlat35;
            u_xlat5 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwyw;
            vec3 txVec6 = vec3(u_xlat5.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
            u_xlat1.x = u_xlat14.y * u_xlat10_12 + u_xlat1.x;
            u_xlat12 = u_xlat4.y * u_xlat4.x;
            vec3 txVec7 = vec3(u_xlat5.zw,u_xlat1.z);
            u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
            u_xlat1.x = u_xlat12 * u_xlat10_23 + u_xlat1.x;
            u_xlat1.x = u_xlat16_3 * u_xlat1.x;
            u_xlat1.x = u_xlat1.x * 0.0625 + _LightShadowData.x;
            u_xlat16_21.x = u_xlat33 * u_xlat1.x;
        } else {
            u_xlat16_21.x = 1.0;
        //ENDIF
        }
        u_xlat1.x = u_xlat2.x + -0.639999986;
        u_xlat1.x = u_xlat1.x * 2.77777767;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat33 = (-u_xlat34) * u_xlat33 + u_xlat16_21.x;
        u_xlat10 = u_xlat1.x * u_xlat33 + u_xlat16_10;
        u_xlat16_10 = u_xlat10;
    //ENDIF
    }
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat11 = u_xlat11 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat11;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat16_10) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + u_xlat16_10;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
lowp float u_xlat10_5;
vec4 u_xlat6;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
vec2 u_xlat8;
vec4 u_xlat9;
float u_xlat10;
mediump float u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
vec2 u_xlat13;
int u_xlati13;
uint u_xlatu13;
bool u_xlatb13;
vec3 u_xlat14;
mediump vec3 u_xlat16_21;
lowp float u_xlat10_23;
bool u_xlatb24;
vec2 u_xlat26;
vec2 u_xlat29;
vec2 u_xlat30;
float u_xlat33;
lowp float u_xlat10_33;
bool u_xlatb33;
float u_xlat34;
int u_xlati34;
uint u_xlatu34;
bool u_xlatb34;
float u_xlat35;
lowp float u_xlat10_35;
lowp float u_xlat10_38;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat11 = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat11;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat33 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<0.0);
#else
    u_xlatb33 = u_xlat33<0.0;
#endif
    if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat2.xy = u_xlat2.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_33 = texture(_cloudLayerShadowTexture, u_xlat2.xy).x;
    u_xlat33 = u_xlat10_33 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat4.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb3 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat3 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb3));
    u_xlat16_6.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_6.y = u_xlat3.z + u_xlat16_6.x;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat3.x);
    u_xlat4.zw = (-u_xlat16_6.xy);
    u_xlat4 = u_xlat3 + u_xlat4;
    u_xlat4 = max(u_xlat4, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat34 = u_xlat16_6.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat34<0.0);
#else
    u_xlatb34 = u_xlat34<0.0;
#endif
    if((int(u_xlatb34) * int(0xffffffffu))!=0){discard;}
    u_xlat34 = dot(u_xlat4.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat34 = min(u_xlat34, 3.0);
    u_xlatu34 = uint(u_xlat34);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu34)].xyz);
    u_xlati34 = int(u_xlatu34) << 2;
    u_xlat7.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 1)].xyz;
    u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati34].xyz * u_xlat5.xxx + u_xlat7.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat5.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat29.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat8.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat30.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat30.xy = u_xlat30.xy / u_xlat29.yx;
    u_xlat6.xy = u_xlat30.xy + vec2(-1.0, -1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat8.xy;
    u_xlat6.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat6 = u_xlat6.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat34 = u_xlat29.x * u_xlat29.y;
    u_xlat9 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xzyz;
    vec3 txVec0 = vec3(u_xlat9.xy,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat5.xy = u_xlat29.xy * u_xlat8.xy;
    vec3 txVec1 = vec3(u_xlat9.zw,u_xlat5.z);
    u_xlat10_38 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat5.x = u_xlat10_38 * u_xlat5.x;
    u_xlat34 = u_xlat34 * u_xlat10_3 + u_xlat5.x;
    u_xlat6 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xwyw;
    vec3 txVec2 = vec3(u_xlat6.xy,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat34 = u_xlat5.y * u_xlat10_3 + u_xlat34;
    u_xlat3.x = u_xlat8.y * u_xlat8.x;
    vec3 txVec3 = vec3(u_xlat6.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat34 = u_xlat3.x * u_xlat10_5 + u_xlat34;
    u_xlat34 = u_xlat34 * 0.0625;
    u_xlat16_3 = (-_LightShadowData.x) + 1.0;
    u_xlat34 = u_xlat34 * u_xlat16_3 + _LightShadowData.x;
    u_xlat16_10 = u_xlat33 * u_xlat34;
    u_xlat2 = u_xlat2 / unity_ShadowSplitSqRadii;
    u_xlat2.x = dot(u_xlat2, u_xlat4);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.639999986<u_xlat2.x);
#else
    u_xlatb13 = 0.639999986<u_xlat2.x;
#endif
    if(u_xlatb13){
        u_xlat16_21.xyz = vec3(u_xlat3.y * u_xlat4.x, u_xlat3.z * u_xlat4.y, u_xlat3.w * u_xlat4.z);
        u_xlat13.x = dot(u_xlat16_21.xyz, vec3(1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(0.5<u_xlat13.x);
#else
        u_xlatb24 = 0.5<u_xlat13.x;
#endif
        if(u_xlatb24){
            u_xlatu13 = uint(u_xlat13.x);
            u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu13)].xyz);
            u_xlati13 = int(u_xlatu13) << 2;
            u_xlat14.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 1)].xyz;
            u_xlat14.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati13].xyz * u_xlat1.xxx + u_xlat14.xyz;
            u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 2)].xyz * u_xlat1.zzz + u_xlat14.xyz;
            u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 3)].xyz;
            u_xlat1.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
            u_xlat13.xy = floor(u_xlat1.xy);
            u_xlat13.xy = u_xlat13.xy + vec2(-0.5, -0.5);
            u_xlat1.xy = fract(u_xlat1.xy);
            u_xlat14.xy = (-u_xlat1.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
            u_xlat4.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
            u_xlat26.xy = (-u_xlat1.xy) + vec2(2.0, 2.0);
            u_xlat26.xy = u_xlat26.xy / u_xlat14.yx;
            u_xlat5.xy = u_xlat26.xy + vec2(-1.0, -1.0);
            u_xlat1.xy = u_xlat1.xy / u_xlat4.xy;
            u_xlat5.zw = u_xlat1.xy + vec2(1.0, 1.0);
            u_xlat5 = u_xlat5.xzyw * _ShadowMapTexture_TexelSize.xxyy;
            u_xlat1.x = u_xlat14.x * u_xlat14.y;
            u_xlat6 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xzyz;
            vec3 txVec4 = vec3(u_xlat6.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
            u_xlat14.xy = u_xlat14.xy * u_xlat4.xy;
            vec3 txVec5 = vec3(u_xlat6.zw,u_xlat1.z);
            u_xlat10_35 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
            u_xlat35 = u_xlat10_35 * u_xlat14.x;
            u_xlat1.x = u_xlat1.x * u_xlat10_12 + u_xlat35;
            u_xlat5 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwyw;
            vec3 txVec6 = vec3(u_xlat5.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
            u_xlat1.x = u_xlat14.y * u_xlat10_12 + u_xlat1.x;
            u_xlat12 = u_xlat4.y * u_xlat4.x;
            vec3 txVec7 = vec3(u_xlat5.zw,u_xlat1.z);
            u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
            u_xlat1.x = u_xlat12 * u_xlat10_23 + u_xlat1.x;
            u_xlat1.x = u_xlat16_3 * u_xlat1.x;
            u_xlat1.x = u_xlat1.x * 0.0625 + _LightShadowData.x;
            u_xlat16_21.x = u_xlat33 * u_xlat1.x;
        } else {
            u_xlat16_21.x = 1.0;
        //ENDIF
        }
        u_xlat1.x = u_xlat2.x + -0.639999986;
        u_xlat1.x = u_xlat1.x * 2.77777767;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat33 = (-u_xlat34) * u_xlat33 + u_xlat16_21.x;
        u_xlat10 = u_xlat1.x * u_xlat33 + u_xlat16_10;
        u_xlat16_10 = u_xlat10;
    //ENDIF
    }
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat11 = u_xlat11 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat11;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat16_10) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + u_xlat16_10;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
uint u_xlatu6;
vec3 u_xlat7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat6.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat6.x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlat19 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<0.0);
#else
    u_xlatb19 = u_xlat19<0.0;
#endif
    if((int(u_xlatb19) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_1 = texture(_cloudLayerShadowTexture, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat6.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat6.xxx + u_xlat7.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat6.zzz + u_xlat7.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat6.xy = u_xlat6.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat6.xy);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xy) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xy = u_xlat6.xy / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat7.xyz = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat7.x;
    u_xlat6.x = u_xlat7.z * u_xlat10_12 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat6.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat7.y * u_xlat10_12 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_12 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_12 + _LightShadowData.x;
    u_xlat16_5 = u_xlat1.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat1.x + 1.0;
    u_xlat12 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12 = u_xlat12 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
uint u_xlatu6;
vec3 u_xlat7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat6.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat6.x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlat19 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<0.0);
#else
    u_xlatb19 = u_xlat19<0.0;
#endif
    if((int(u_xlatb19) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_1 = texture(_cloudLayerShadowTexture, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat6.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat6.xxx + u_xlat7.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat6.zzz + u_xlat7.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat6.xy = u_xlat6.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat6.xy);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xy) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xy = u_xlat6.xy / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat7.xyz = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat7.x;
    u_xlat6.x = u_xlat7.z * u_xlat10_12 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat6.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat7.y * u_xlat10_12 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_12 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_12 + _LightShadowData.x;
    u_xlat16_5 = u_xlat1.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat1.x + 1.0;
    u_xlat12 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12 = u_xlat12 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
int u_xlati5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat5.x, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat10 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10<0.0);
#else
    u_xlatb10 = u_xlat10<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlati5 = int(u_xlatu5) << 2;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati5].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat5.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
int u_xlati5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat5.x, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat10 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10<0.0);
#else
    u_xlatb10 = u_xlat10<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlati5 = int(u_xlatu5) << 2;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati5].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat5.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat5.x, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat5.x, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" "LINE_INTERPOLATION" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
vec2 u_xlat8;
vec4 u_xlat9;
mediump vec3 u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
vec2 u_xlat13;
int u_xlati13;
uint u_xlatu13;
bool u_xlatb13;
lowp float u_xlat10_23;
bool u_xlatb24;
vec2 u_xlat25;
vec2 u_xlat29;
vec2 u_xlat30;
float u_xlat33;
int u_xlati33;
uint u_xlatu33;
bool u_xlatb33;
float u_xlat34;
mediump float u_xlat16_34;
lowp float u_xlat10_34;
float u_xlat35;
lowp float u_xlat10_35;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat11 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat0.x, u_xlat11);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat33 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<0.0);
#else
    u_xlatb33 = u_xlat33<0.0;
#endif
    if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat4.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb3 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat3 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb3));
    u_xlat16_6.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_6.y = u_xlat3.z + u_xlat16_6.x;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat3.x);
    u_xlat4.zw = (-u_xlat16_6.xy);
    u_xlat4 = u_xlat3 + u_xlat4;
    u_xlat4 = max(u_xlat4, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat33 = u_xlat16_6.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<0.0);
#else
    u_xlatb33 = u_xlat33<0.0;
#endif
    if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
    u_xlat33 = dot(u_xlat4.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat33 = min(u_xlat33, 3.0);
    u_xlatu33 = uint(u_xlat33);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu33)].xyz);
    u_xlati33 = int(u_xlatu33) << 2;
    u_xlat7.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 1)].xyz;
    u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati33].xyz * u_xlat5.xxx + u_xlat7.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat5.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat29.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat8.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat30.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat30.xy = u_xlat30.xy / u_xlat29.yx;
    u_xlat6.xy = u_xlat30.xy + vec2(-1.0, -1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat8.xy;
    u_xlat6.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat6 = u_xlat6.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat33 = u_xlat29.x * u_xlat29.y;
    u_xlat9 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xzyz;
    vec3 txVec0 = vec3(u_xlat9.xy,u_xlat5.z);
    u_xlat10_34 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat5.xy = u_xlat29.xy * u_xlat8.xy;
    vec3 txVec1 = vec3(u_xlat9.zw,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat3.x = u_xlat10_3 * u_xlat5.x;
    u_xlat33 = u_xlat33 * u_xlat10_34 + u_xlat3.x;
    u_xlat6 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xwyw;
    vec3 txVec2 = vec3(u_xlat6.xy,u_xlat5.z);
    u_xlat10_34 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat33 = u_xlat5.y * u_xlat10_34 + u_xlat33;
    u_xlat34 = u_xlat8.y * u_xlat8.x;
    vec3 txVec3 = vec3(u_xlat6.zw,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat33 = u_xlat34 * u_xlat10_3 + u_xlat33;
    u_xlat33 = u_xlat33 * 0.0625;
    u_xlat16_34 = (-_LightShadowData.x) + 1.0;
    u_xlat33 = u_xlat33 * u_xlat16_34 + _LightShadowData.x;
    u_xlat2 = u_xlat2 / unity_ShadowSplitSqRadii;
    u_xlat2.x = dot(u_xlat2, u_xlat4);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.639999986<u_xlat2.x);
#else
    u_xlatb13 = 0.639999986<u_xlat2.x;
#endif
    if(u_xlatb13){
        u_xlat16_10.xyz = vec3(u_xlat3.y * u_xlat4.x, u_xlat3.z * u_xlat4.y, u_xlat3.w * u_xlat4.z);
        u_xlat13.x = dot(u_xlat16_10.xyz, vec3(1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(0.5<u_xlat13.x);
#else
        u_xlatb24 = 0.5<u_xlat13.x;
#endif
        if(u_xlatb24){
            u_xlatu13 = uint(u_xlat13.x);
            u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu13)].xyz);
            u_xlati13 = int(u_xlatu13) << 2;
            u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 1)].xyz;
            u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati13].xyz * u_xlat1.xxx + u_xlat3.xyz;
            u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 2)].xyz * u_xlat1.zzz + u_xlat3.xyz;
            u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 3)].xyz;
            u_xlat1.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
            u_xlat13.xy = floor(u_xlat1.xy);
            u_xlat13.xy = u_xlat13.xy + vec2(-0.5, -0.5);
            u_xlat1.xy = fract(u_xlat1.xy);
            u_xlat3.xy = (-u_xlat1.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
            u_xlat25.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
            u_xlat4.xy = (-u_xlat1.xy) + vec2(2.0, 2.0);
            u_xlat4.xy = u_xlat4.xy / u_xlat3.yx;
            u_xlat4.xy = u_xlat4.xy + vec2(-1.0, -1.0);
            u_xlat1.xy = u_xlat1.xy / u_xlat25.xy;
            u_xlat4.zw = u_xlat1.xy + vec2(1.0, 1.0);
            u_xlat4 = u_xlat4.xzyw * _ShadowMapTexture_TexelSize.xxyy;
            u_xlat1.x = u_xlat3.x * u_xlat3.y;
            u_xlat5 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xzyz;
            vec3 txVec4 = vec3(u_xlat5.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
            u_xlat3.xy = u_xlat3.xy * u_xlat25.xy;
            vec3 txVec5 = vec3(u_xlat5.zw,u_xlat1.z);
            u_xlat10_35 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
            u_xlat35 = u_xlat10_35 * u_xlat3.x;
            u_xlat1.x = u_xlat1.x * u_xlat10_12 + u_xlat35;
            u_xlat4 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xwyw;
            vec3 txVec6 = vec3(u_xlat4.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
            u_xlat1.x = u_xlat3.y * u_xlat10_12 + u_xlat1.x;
            u_xlat12 = u_xlat25.y * u_xlat25.x;
            vec3 txVec7 = vec3(u_xlat4.zw,u_xlat1.z);
            u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
            u_xlat1.x = u_xlat12 * u_xlat10_23 + u_xlat1.x;
            u_xlat1.x = u_xlat16_34 * u_xlat1.x;
            u_xlat1.x = u_xlat1.x * 0.0625 + _LightShadowData.x;
            u_xlat16_1 = u_xlat1.x;
        } else {
            u_xlat16_1 = 1.0;
        //ENDIF
        }
        u_xlat2.x = u_xlat2.x + -0.639999986;
        u_xlat2.x = u_xlat2.x * 2.77777767;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat13.x = (-u_xlat33) + u_xlat16_1;
        u_xlat2.x = u_xlat2.x * u_xlat13.x + u_xlat33;
        u_xlat16_2 = u_xlat2.x;
    } else {
        u_xlat16_2 = u_xlat33;
    //ENDIF
    }
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat11 = u_xlat11 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat11;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat16_2) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + u_xlat16_2;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" "LINE_INTERPOLATION" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
lowp float u_xlat10_3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
vec2 u_xlat8;
vec4 u_xlat9;
mediump vec3 u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
vec2 u_xlat13;
int u_xlati13;
uint u_xlatu13;
bool u_xlatb13;
lowp float u_xlat10_23;
bool u_xlatb24;
vec2 u_xlat25;
vec2 u_xlat29;
vec2 u_xlat30;
float u_xlat33;
int u_xlati33;
uint u_xlatu33;
bool u_xlatb33;
float u_xlat34;
mediump float u_xlat16_34;
lowp float u_xlat10_34;
float u_xlat35;
lowp float u_xlat10_35;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat11 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat0.x, u_xlat11);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat33 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<0.0);
#else
    u_xlatb33 = u_xlat33<0.0;
#endif
    if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat4.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb3 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat3 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb3));
    u_xlat16_6.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_6.y = u_xlat3.z + u_xlat16_6.x;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat3.x);
    u_xlat4.zw = (-u_xlat16_6.xy);
    u_xlat4 = u_xlat3 + u_xlat4;
    u_xlat4 = max(u_xlat4, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat33 = u_xlat16_6.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<0.0);
#else
    u_xlatb33 = u_xlat33<0.0;
#endif
    if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
    u_xlat33 = dot(u_xlat4.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat33 = min(u_xlat33, 3.0);
    u_xlatu33 = uint(u_xlat33);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu33)].xyz);
    u_xlati33 = int(u_xlatu33) << 2;
    u_xlat7.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 1)].xyz;
    u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati33].xyz * u_xlat5.xxx + u_xlat7.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati33 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat5.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat29.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat8.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat30.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat30.xy = u_xlat30.xy / u_xlat29.yx;
    u_xlat6.xy = u_xlat30.xy + vec2(-1.0, -1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat8.xy;
    u_xlat6.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat6 = u_xlat6.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat33 = u_xlat29.x * u_xlat29.y;
    u_xlat9 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xzyz;
    vec3 txVec0 = vec3(u_xlat9.xy,u_xlat5.z);
    u_xlat10_34 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat5.xy = u_xlat29.xy * u_xlat8.xy;
    vec3 txVec1 = vec3(u_xlat9.zw,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat3.x = u_xlat10_3 * u_xlat5.x;
    u_xlat33 = u_xlat33 * u_xlat10_34 + u_xlat3.x;
    u_xlat6 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xwyw;
    vec3 txVec2 = vec3(u_xlat6.xy,u_xlat5.z);
    u_xlat10_34 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat33 = u_xlat5.y * u_xlat10_34 + u_xlat33;
    u_xlat34 = u_xlat8.y * u_xlat8.x;
    vec3 txVec3 = vec3(u_xlat6.zw,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat33 = u_xlat34 * u_xlat10_3 + u_xlat33;
    u_xlat33 = u_xlat33 * 0.0625;
    u_xlat16_34 = (-_LightShadowData.x) + 1.0;
    u_xlat33 = u_xlat33 * u_xlat16_34 + _LightShadowData.x;
    u_xlat2 = u_xlat2 / unity_ShadowSplitSqRadii;
    u_xlat2.x = dot(u_xlat2, u_xlat4);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.639999986<u_xlat2.x);
#else
    u_xlatb13 = 0.639999986<u_xlat2.x;
#endif
    if(u_xlatb13){
        u_xlat16_10.xyz = vec3(u_xlat3.y * u_xlat4.x, u_xlat3.z * u_xlat4.y, u_xlat3.w * u_xlat4.z);
        u_xlat13.x = dot(u_xlat16_10.xyz, vec3(1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(0.5<u_xlat13.x);
#else
        u_xlatb24 = 0.5<u_xlat13.x;
#endif
        if(u_xlatb24){
            u_xlatu13 = uint(u_xlat13.x);
            u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu13)].xyz);
            u_xlati13 = int(u_xlatu13) << 2;
            u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 1)].xyz;
            u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati13].xyz * u_xlat1.xxx + u_xlat3.xyz;
            u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 2)].xyz * u_xlat1.zzz + u_xlat3.xyz;
            u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 3)].xyz;
            u_xlat1.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
            u_xlat13.xy = floor(u_xlat1.xy);
            u_xlat13.xy = u_xlat13.xy + vec2(-0.5, -0.5);
            u_xlat1.xy = fract(u_xlat1.xy);
            u_xlat3.xy = (-u_xlat1.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
            u_xlat25.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
            u_xlat4.xy = (-u_xlat1.xy) + vec2(2.0, 2.0);
            u_xlat4.xy = u_xlat4.xy / u_xlat3.yx;
            u_xlat4.xy = u_xlat4.xy + vec2(-1.0, -1.0);
            u_xlat1.xy = u_xlat1.xy / u_xlat25.xy;
            u_xlat4.zw = u_xlat1.xy + vec2(1.0, 1.0);
            u_xlat4 = u_xlat4.xzyw * _ShadowMapTexture_TexelSize.xxyy;
            u_xlat1.x = u_xlat3.x * u_xlat3.y;
            u_xlat5 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xzyz;
            vec3 txVec4 = vec3(u_xlat5.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
            u_xlat3.xy = u_xlat3.xy * u_xlat25.xy;
            vec3 txVec5 = vec3(u_xlat5.zw,u_xlat1.z);
            u_xlat10_35 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
            u_xlat35 = u_xlat10_35 * u_xlat3.x;
            u_xlat1.x = u_xlat1.x * u_xlat10_12 + u_xlat35;
            u_xlat4 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xwyw;
            vec3 txVec6 = vec3(u_xlat4.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
            u_xlat1.x = u_xlat3.y * u_xlat10_12 + u_xlat1.x;
            u_xlat12 = u_xlat25.y * u_xlat25.x;
            vec3 txVec7 = vec3(u_xlat4.zw,u_xlat1.z);
            u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
            u_xlat1.x = u_xlat12 * u_xlat10_23 + u_xlat1.x;
            u_xlat1.x = u_xlat16_34 * u_xlat1.x;
            u_xlat1.x = u_xlat1.x * 0.0625 + _LightShadowData.x;
            u_xlat16_1 = u_xlat1.x;
        } else {
            u_xlat16_1 = 1.0;
        //ENDIF
        }
        u_xlat2.x = u_xlat2.x + -0.639999986;
        u_xlat2.x = u_xlat2.x * 2.77777767;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat13.x = (-u_xlat33) + u_xlat16_1;
        u_xlat2.x = u_xlat2.x * u_xlat13.x + u_xlat33;
        u_xlat16_2 = u_xlat2.x;
    } else {
        u_xlat16_2 = u_xlat33;
    //ENDIF
    }
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat11 = u_xlat11 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat11;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat16_2) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + u_xlat16_2;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat5.x, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat5.x, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
int u_xlati6;
uint u_xlatu6;
vec2 u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat6.x = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat6.x, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat12.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12.x<0.0);
#else
    u_xlatb12 = u_xlat12.x<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlati6 = int(u_xlatu6) << 2;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat12.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat12.xy = u_xlat12.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_12 = texture(_cloudLayerShadowTexture, u_xlat12.xy).x;
    u_xlat12.x = u_xlat10_12 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati6].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 3)].xyz;
    u_xlat6.xz = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat6.xz);
    u_xlat6.xz = fract(u_xlat6.xz);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xz) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.zx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xz * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xz = u_xlat6.xz / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xz + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat1.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat1.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xyw = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat1.x;
    u_xlat6.x = u_xlat1.w * u_xlat10_18 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat1.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat1.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat1.y * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_1 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_18 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_18 + _LightShadowData.x;
    u_xlat16_5 = u_xlat12.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat12.x + 1.0;
    u_xlat12.x = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12.x = u_xlat12.x * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12.x;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
int u_xlati6;
uint u_xlatu6;
vec2 u_xlat12;
lowp float u_xlat10_12;
bool u_xlatb12;
float u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat6.x = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat6.x, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat12.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12.x<0.0);
#else
    u_xlatb12 = u_xlat12.x<0.0;
#endif
    if((int(u_xlatb12) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlati6 = int(u_xlatu6) << 2;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat12.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat12.xy = u_xlat12.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_12 = texture(_cloudLayerShadowTexture, u_xlat12.xy).x;
    u_xlat12.x = u_xlat10_12 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati6].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati6 + 3)].xyz;
    u_xlat6.xz = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat6.xz);
    u_xlat6.xz = fract(u_xlat6.xz);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xz) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.zx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xz * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xz = u_xlat6.xz / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xz + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat1.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat1.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xyw = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat1.x;
    u_xlat6.x = u_xlat1.w * u_xlat10_18 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat1.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat1.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat1.y * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_1 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_18 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_18 + _LightShadowData.x;
    u_xlat16_5 = u_xlat12.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat12.x + 1.0;
    u_xlat12.x = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12.x = u_xlat12.x * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12.x;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
uint u_xlatu6;
vec3 u_xlat7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat6.x = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat6.x, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlat19 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<0.0);
#else
    u_xlatb19 = u_xlat19<0.0;
#endif
    if((int(u_xlatb19) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_1 = texture(_cloudLayerShadowTexture, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat6.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat6.xxx + u_xlat7.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat6.zzz + u_xlat7.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat6.xy = u_xlat6.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat6.xy);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xy) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xy = u_xlat6.xy / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat7.xyz = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat7.x;
    u_xlat6.x = u_xlat7.z * u_xlat10_12 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat6.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat7.y * u_xlat10_12 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_12 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_12 + _LightShadowData.x;
    u_xlat16_5 = u_xlat1.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat1.x + 1.0;
    u_xlat12 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12 = u_xlat12 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
uint u_xlatu6;
vec3 u_xlat7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat6.x = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat6.x, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlat19 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<0.0);
#else
    u_xlatb19 = u_xlat19<0.0;
#endif
    if((int(u_xlatb19) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_1 = texture(_cloudLayerShadowTexture, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat6.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat6.xxx + u_xlat7.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat6.zzz + u_xlat7.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat6.xy = u_xlat6.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat6.xy);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xy) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xy = u_xlat6.xy / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat7.xyz = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat7.x;
    u_xlat6.x = u_xlat7.z * u_xlat10_12 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat6.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat7.y * u_xlat10_12 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_12 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_12 + _LightShadowData.x;
    u_xlat16_5 = u_xlat1.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat1.x + 1.0;
    u_xlat12 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12 = u_xlat12 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
lowp float u_xlat10_5;
vec4 u_xlat6;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
vec2 u_xlat8;
vec4 u_xlat9;
float u_xlat10;
mediump float u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
vec2 u_xlat13;
int u_xlati13;
uint u_xlatu13;
bool u_xlatb13;
vec3 u_xlat14;
mediump vec3 u_xlat16_21;
lowp float u_xlat10_23;
bool u_xlatb24;
vec2 u_xlat26;
vec2 u_xlat29;
vec2 u_xlat30;
float u_xlat33;
lowp float u_xlat10_33;
bool u_xlatb33;
float u_xlat34;
int u_xlati34;
uint u_xlatu34;
bool u_xlatb34;
float u_xlat35;
lowp float u_xlat10_35;
lowp float u_xlat10_38;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat11 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat0.x, u_xlat11);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat33 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<0.0);
#else
    u_xlatb33 = u_xlat33<0.0;
#endif
    if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat2.xy = u_xlat2.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_33 = texture(_cloudLayerShadowTexture, u_xlat2.xy).x;
    u_xlat33 = u_xlat10_33 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat4.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb3 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat3 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb3));
    u_xlat16_6.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_6.y = u_xlat3.z + u_xlat16_6.x;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat3.x);
    u_xlat4.zw = (-u_xlat16_6.xy);
    u_xlat4 = u_xlat3 + u_xlat4;
    u_xlat4 = max(u_xlat4, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat34 = u_xlat16_6.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat34<0.0);
#else
    u_xlatb34 = u_xlat34<0.0;
#endif
    if((int(u_xlatb34) * int(0xffffffffu))!=0){discard;}
    u_xlat34 = dot(u_xlat4.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat34 = min(u_xlat34, 3.0);
    u_xlatu34 = uint(u_xlat34);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu34)].xyz);
    u_xlati34 = int(u_xlatu34) << 2;
    u_xlat7.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 1)].xyz;
    u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati34].xyz * u_xlat5.xxx + u_xlat7.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat5.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat29.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat8.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat30.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat30.xy = u_xlat30.xy / u_xlat29.yx;
    u_xlat6.xy = u_xlat30.xy + vec2(-1.0, -1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat8.xy;
    u_xlat6.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat6 = u_xlat6.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat34 = u_xlat29.x * u_xlat29.y;
    u_xlat9 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xzyz;
    vec3 txVec0 = vec3(u_xlat9.xy,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat5.xy = u_xlat29.xy * u_xlat8.xy;
    vec3 txVec1 = vec3(u_xlat9.zw,u_xlat5.z);
    u_xlat10_38 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat5.x = u_xlat10_38 * u_xlat5.x;
    u_xlat34 = u_xlat34 * u_xlat10_3 + u_xlat5.x;
    u_xlat6 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xwyw;
    vec3 txVec2 = vec3(u_xlat6.xy,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat34 = u_xlat5.y * u_xlat10_3 + u_xlat34;
    u_xlat3.x = u_xlat8.y * u_xlat8.x;
    vec3 txVec3 = vec3(u_xlat6.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat34 = u_xlat3.x * u_xlat10_5 + u_xlat34;
    u_xlat34 = u_xlat34 * 0.0625;
    u_xlat16_3 = (-_LightShadowData.x) + 1.0;
    u_xlat34 = u_xlat34 * u_xlat16_3 + _LightShadowData.x;
    u_xlat16_10 = u_xlat33 * u_xlat34;
    u_xlat2 = u_xlat2 / unity_ShadowSplitSqRadii;
    u_xlat2.x = dot(u_xlat2, u_xlat4);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.639999986<u_xlat2.x);
#else
    u_xlatb13 = 0.639999986<u_xlat2.x;
#endif
    if(u_xlatb13){
        u_xlat16_21.xyz = vec3(u_xlat3.y * u_xlat4.x, u_xlat3.z * u_xlat4.y, u_xlat3.w * u_xlat4.z);
        u_xlat13.x = dot(u_xlat16_21.xyz, vec3(1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(0.5<u_xlat13.x);
#else
        u_xlatb24 = 0.5<u_xlat13.x;
#endif
        if(u_xlatb24){
            u_xlatu13 = uint(u_xlat13.x);
            u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu13)].xyz);
            u_xlati13 = int(u_xlatu13) << 2;
            u_xlat14.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 1)].xyz;
            u_xlat14.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati13].xyz * u_xlat1.xxx + u_xlat14.xyz;
            u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 2)].xyz * u_xlat1.zzz + u_xlat14.xyz;
            u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 3)].xyz;
            u_xlat1.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
            u_xlat13.xy = floor(u_xlat1.xy);
            u_xlat13.xy = u_xlat13.xy + vec2(-0.5, -0.5);
            u_xlat1.xy = fract(u_xlat1.xy);
            u_xlat14.xy = (-u_xlat1.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
            u_xlat4.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
            u_xlat26.xy = (-u_xlat1.xy) + vec2(2.0, 2.0);
            u_xlat26.xy = u_xlat26.xy / u_xlat14.yx;
            u_xlat5.xy = u_xlat26.xy + vec2(-1.0, -1.0);
            u_xlat1.xy = u_xlat1.xy / u_xlat4.xy;
            u_xlat5.zw = u_xlat1.xy + vec2(1.0, 1.0);
            u_xlat5 = u_xlat5.xzyw * _ShadowMapTexture_TexelSize.xxyy;
            u_xlat1.x = u_xlat14.x * u_xlat14.y;
            u_xlat6 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xzyz;
            vec3 txVec4 = vec3(u_xlat6.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
            u_xlat14.xy = u_xlat14.xy * u_xlat4.xy;
            vec3 txVec5 = vec3(u_xlat6.zw,u_xlat1.z);
            u_xlat10_35 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
            u_xlat35 = u_xlat10_35 * u_xlat14.x;
            u_xlat1.x = u_xlat1.x * u_xlat10_12 + u_xlat35;
            u_xlat5 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwyw;
            vec3 txVec6 = vec3(u_xlat5.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
            u_xlat1.x = u_xlat14.y * u_xlat10_12 + u_xlat1.x;
            u_xlat12 = u_xlat4.y * u_xlat4.x;
            vec3 txVec7 = vec3(u_xlat5.zw,u_xlat1.z);
            u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
            u_xlat1.x = u_xlat12 * u_xlat10_23 + u_xlat1.x;
            u_xlat1.x = u_xlat16_3 * u_xlat1.x;
            u_xlat1.x = u_xlat1.x * 0.0625 + _LightShadowData.x;
            u_xlat16_21.x = u_xlat33 * u_xlat1.x;
        } else {
            u_xlat16_21.x = 1.0;
        //ENDIF
        }
        u_xlat1.x = u_xlat2.x + -0.639999986;
        u_xlat1.x = u_xlat1.x * 2.77777767;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat33 = (-u_xlat34) * u_xlat33 + u_xlat16_21.x;
        u_xlat10 = u_xlat1.x * u_xlat33 + u_xlat16_10;
        u_xlat16_10 = u_xlat10;
    //ENDIF
    }
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat11 = u_xlat11 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat11;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat16_10) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + u_xlat16_10;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec4 u_xlat5;
lowp float u_xlat10_5;
vec4 u_xlat6;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
vec2 u_xlat8;
vec4 u_xlat9;
float u_xlat10;
mediump float u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
float u_xlat12;
lowp float u_xlat10_12;
vec2 u_xlat13;
int u_xlati13;
uint u_xlatu13;
bool u_xlatb13;
vec3 u_xlat14;
mediump vec3 u_xlat16_21;
lowp float u_xlat10_23;
bool u_xlatb24;
vec2 u_xlat26;
vec2 u_xlat29;
vec2 u_xlat30;
float u_xlat33;
lowp float u_xlat10_33;
bool u_xlatb33;
float u_xlat34;
int u_xlati34;
uint u_xlatu34;
bool u_xlatb34;
float u_xlat35;
lowp float u_xlat10_35;
lowp float u_xlat10_38;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat11 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat0.x, u_xlat11);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat33 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<0.0);
#else
    u_xlatb33 = u_xlat33<0.0;
#endif
    if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat2.xy = u_xlat2.xy / u_xlat2.zz;
    u_xlat2.xy = u_xlat2.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_33 = texture(_cloudLayerShadowTexture, u_xlat2.xy).x;
    u_xlat33 = u_xlat10_33 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat3.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat4.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.z = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb3 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat3 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb3));
    u_xlat16_6.x = u_xlat3.y + u_xlat3.x;
    u_xlat16_6.y = u_xlat3.z + u_xlat16_6.x;
    u_xlat4.x = -0.0;
    u_xlat4.y = (-u_xlat3.x);
    u_xlat4.zw = (-u_xlat16_6.xy);
    u_xlat4 = u_xlat3 + u_xlat4;
    u_xlat4 = max(u_xlat4, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_6.x = dot(u_xlat4, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat34 = u_xlat16_6.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat34<0.0);
#else
    u_xlatb34 = u_xlat34<0.0;
#endif
    if((int(u_xlatb34) * int(0xffffffffu))!=0){discard;}
    u_xlat34 = dot(u_xlat4.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat34 = min(u_xlat34, 3.0);
    u_xlatu34 = uint(u_xlat34);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu34)].xyz);
    u_xlati34 = int(u_xlatu34) << 2;
    u_xlat7.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 1)].xyz;
    u_xlat5.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati34].xyz * u_xlat5.xxx + u_xlat7.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 2)].xyz * u_xlat5.zzz + u_xlat5.xyw;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati34 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat5.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat29.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat8.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat30.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat30.xy = u_xlat30.xy / u_xlat29.yx;
    u_xlat6.xy = u_xlat30.xy + vec2(-1.0, -1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat8.xy;
    u_xlat6.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat6 = u_xlat6.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat34 = u_xlat29.x * u_xlat29.y;
    u_xlat9 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xzyz;
    vec3 txVec0 = vec3(u_xlat9.xy,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat5.xy = u_xlat29.xy * u_xlat8.xy;
    vec3 txVec1 = vec3(u_xlat9.zw,u_xlat5.z);
    u_xlat10_38 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat5.x = u_xlat10_38 * u_xlat5.x;
    u_xlat34 = u_xlat34 * u_xlat10_3 + u_xlat5.x;
    u_xlat6 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.xwyw;
    vec3 txVec2 = vec3(u_xlat6.xy,u_xlat5.z);
    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    u_xlat34 = u_xlat5.y * u_xlat10_3 + u_xlat34;
    u_xlat3.x = u_xlat8.y * u_xlat8.x;
    vec3 txVec3 = vec3(u_xlat6.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat34 = u_xlat3.x * u_xlat10_5 + u_xlat34;
    u_xlat34 = u_xlat34 * 0.0625;
    u_xlat16_3 = (-_LightShadowData.x) + 1.0;
    u_xlat34 = u_xlat34 * u_xlat16_3 + _LightShadowData.x;
    u_xlat16_10 = u_xlat33 * u_xlat34;
    u_xlat2 = u_xlat2 / unity_ShadowSplitSqRadii;
    u_xlat2.x = dot(u_xlat2, u_xlat4);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.639999986<u_xlat2.x);
#else
    u_xlatb13 = 0.639999986<u_xlat2.x;
#endif
    if(u_xlatb13){
        u_xlat16_21.xyz = vec3(u_xlat3.y * u_xlat4.x, u_xlat3.z * u_xlat4.y, u_xlat3.w * u_xlat4.z);
        u_xlat13.x = dot(u_xlat16_21.xyz, vec3(1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
        u_xlatb24 = !!(0.5<u_xlat13.x);
#else
        u_xlatb24 = 0.5<u_xlat13.x;
#endif
        if(u_xlatb24){
            u_xlatu13 = uint(u_xlat13.x);
            u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu13)].xyz);
            u_xlati13 = int(u_xlatu13) << 2;
            u_xlat14.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 1)].xyz;
            u_xlat14.xyz = hlslcc_mtx4x4unity_WorldToShadow[u_xlati13].xyz * u_xlat1.xxx + u_xlat14.xyz;
            u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 2)].xyz * u_xlat1.zzz + u_xlat14.xyz;
            u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati13 + 3)].xyz;
            u_xlat1.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
            u_xlat13.xy = floor(u_xlat1.xy);
            u_xlat13.xy = u_xlat13.xy + vec2(-0.5, -0.5);
            u_xlat1.xy = fract(u_xlat1.xy);
            u_xlat14.xy = (-u_xlat1.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
            u_xlat4.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
            u_xlat26.xy = (-u_xlat1.xy) + vec2(2.0, 2.0);
            u_xlat26.xy = u_xlat26.xy / u_xlat14.yx;
            u_xlat5.xy = u_xlat26.xy + vec2(-1.0, -1.0);
            u_xlat1.xy = u_xlat1.xy / u_xlat4.xy;
            u_xlat5.zw = u_xlat1.xy + vec2(1.0, 1.0);
            u_xlat5 = u_xlat5.xzyw * _ShadowMapTexture_TexelSize.xxyy;
            u_xlat1.x = u_xlat14.x * u_xlat14.y;
            u_xlat6 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xzyz;
            vec3 txVec4 = vec3(u_xlat6.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec4, 0.0);
            u_xlat14.xy = u_xlat14.xy * u_xlat4.xy;
            vec3 txVec5 = vec3(u_xlat6.zw,u_xlat1.z);
            u_xlat10_35 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec5, 0.0);
            u_xlat35 = u_xlat10_35 * u_xlat14.x;
            u_xlat1.x = u_xlat1.x * u_xlat10_12 + u_xlat35;
            u_xlat5 = u_xlat13.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwyw;
            vec3 txVec6 = vec3(u_xlat5.xy,u_xlat1.z);
            u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec6, 0.0);
            u_xlat1.x = u_xlat14.y * u_xlat10_12 + u_xlat1.x;
            u_xlat12 = u_xlat4.y * u_xlat4.x;
            vec3 txVec7 = vec3(u_xlat5.zw,u_xlat1.z);
            u_xlat10_23 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec7, 0.0);
            u_xlat1.x = u_xlat12 * u_xlat10_23 + u_xlat1.x;
            u_xlat1.x = u_xlat16_3 * u_xlat1.x;
            u_xlat1.x = u_xlat1.x * 0.0625 + _LightShadowData.x;
            u_xlat16_21.x = u_xlat33 * u_xlat1.x;
        } else {
            u_xlat16_21.x = 1.0;
        //ENDIF
        }
        u_xlat1.x = u_xlat2.x + -0.639999986;
        u_xlat1.x = u_xlat1.x * 2.77777767;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat33 = (-u_xlat34) * u_xlat33 + u_xlat16_21.x;
        u_xlat10 = u_xlat1.x * u_xlat33 + u_xlat16_10;
        u_xlat16_10 = u_xlat10;
    //ENDIF
    }
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat11 = u_xlat11 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat11;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat16_10) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_11 + u_xlat16_10;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
uint u_xlatu6;
vec3 u_xlat7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat6.x = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat6.x, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlat19 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<0.0);
#else
    u_xlatb19 = u_xlat19<0.0;
#endif
    if((int(u_xlatb19) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_1 = texture(_cloudLayerShadowTexture, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat6.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat6.xxx + u_xlat7.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat6.zzz + u_xlat7.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat6.xy = u_xlat6.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat6.xy);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xy) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xy = u_xlat6.xy / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat7.xyz = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat7.x;
    u_xlat6.x = u_xlat7.z * u_xlat10_12 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat6.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat7.y * u_xlat10_12 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_12 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_12 + _LightShadowData.x;
    u_xlat16_5 = u_xlat1.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat1.x + 1.0;
    u_xlat12 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12 = u_xlat12 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform 	vec4 hlslcc_mtx4x4_worldToCloudShadowLayer[4];
uniform 	vec4 _cloudLayerShadowParams;
uniform 	float _cloudLayerShadowIntensity;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _cloudLayerShadowTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
lowp float u_xlat10_6;
uint u_xlatu6;
vec3 u_xlat7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
float u_xlat18;
lowp float u_xlat10_18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat6.x = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat6.x, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat18 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18<0.0);
#else
    u_xlatb18 = u_xlat18<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat6.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat6.x = min(u_xlat6.x, 3.0);
    u_xlatu6 = uint(u_xlat6.x);
    u_xlat6.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu6)].xyz);
    u_xlat19 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<0.0);
#else
    u_xlatb19 = u_xlat19<0.0;
#endif
    if((int(u_xlatb19) * int(0xffffffffu))!=0){discard;}
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4_worldToCloudShadowLayer[1].xzw;
    u_xlat1.xyw = hlslcc_mtx4x4_worldToCloudShadowLayer[0].xzw * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_worldToCloudShadowLayer[2].xzw * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_worldToCloudShadowLayer[3].xzw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.xy = u_xlat1.xy * _cloudLayerShadowParams.zw + (-_cloudLayerShadowParams.xy);
    u_xlat10_1 = texture(_cloudLayerShadowTexture, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 + _cloudLayerShadowIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat6.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat6.xxx + u_xlat7.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat6.zzz + u_xlat7.xyz;
    u_xlat6.xyz = u_xlat6.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat6.xy = u_xlat6.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat7.xy = floor(u_xlat6.xy);
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat7.xy = u_xlat7.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = (-u_xlat6.xy) + vec2(2.0, 2.0);
    u_xlat2.zw = (-u_xlat6.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat2.xy = vec2(u_xlat2.x / u_xlat2.w, u_xlat2.y / u_xlat2.z);
    u_xlat3.xy = u_xlat2.xy + vec2(-1.0, -1.0);
    u_xlat2.xy = u_xlat6.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat6.xy = u_xlat6.xy / u_xlat2.xy;
    u_xlat3.zw = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat7.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat6.z);
    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat7.xyz = vec3(u_xlat2.z * u_xlat2.x, u_xlat2.w * u_xlat2.y, u_xlat2.z * u_xlat2.w);
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat6.x = u_xlat10_6 * u_xlat7.x;
    u_xlat6.x = u_xlat7.z * u_xlat10_12 + u_xlat6.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat6.z);
    u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat6.z);
    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat7.y * u_xlat10_12 + u_xlat6.x;
    u_xlat6.x = u_xlat2.x * u_xlat10_18 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * 0.0625;
    u_xlat16_12 = (-_LightShadowData.x) + 1.0;
    u_xlat6.x = u_xlat6.x * u_xlat16_12 + _LightShadowData.x;
    u_xlat16_5 = u_xlat1.x * u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) * u_xlat1.x + 1.0;
    u_xlat12 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat12 = u_xlat12 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat12;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_5;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
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
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "ENABLE_CLOUD_SHADOW" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "ENABLE_CLOUD_SHADOW" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "ENABLE_CLOUD_SHADOW" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "ENABLE_CLOUD_SHADOW" }
""
}
SubProgram "gles3 " {
Keywords { "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "LINE_INTERPOLATION" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" }
""
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" "ENABLE_CLOUD_SHADOW" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" "ENABLE_CLOUD_SHADOW" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "ENABLE_CLOUD_SHADOW" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "ENABLE_CLOUD_SHADOW" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" "LINE_INTERPOLATION" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" "LINE_INTERPOLATION" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" "ENABLE_CLOUD_SHADOW" "UNITY_USE_CASCADE_BLENDING" }
""
}
}
}
}
SubShader {
 Tags { "ShadowmapFilter" = "PCF_SOFT_FORCE_INV_PROJECTION_IN_PS" }
 Pass {
  Tags { "ShadowmapFilter" = "PCF_SOFT_FORCE_INV_PROJECTION_IN_PS" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 215541
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
int u_xlati5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat10 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10<0.0);
#else
    u_xlatb10 = u_xlat10<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlati5 = int(u_xlatu5) << 2;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati5].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat5.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
int u_xlati5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat10 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10<0.0);
#else
    u_xlatb10 = u_xlat10<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlati5 = int(u_xlatu5) << 2;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati5].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat5.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
int u_xlati5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat10 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10<0.0);
#else
    u_xlatb10 = u_xlat10<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlati5 = int(u_xlatu5) << 2;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati5].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat5.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
int u_xlati5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat10 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10<0.0);
#else
    u_xlatb10 = u_xlat10<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlati5 = int(u_xlatu5) << 2;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati5].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat5.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.z = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
int u_xlati5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat5.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat5.x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat10 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10<0.0);
#else
    u_xlatb10 = u_xlat10<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlati5 = int(u_xlatu5) << 2;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati5].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat5.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
int u_xlati5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat5.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat5.x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat10 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10<0.0);
#else
    u_xlatb10 = u_xlat10<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlati5 = int(u_xlatu5) << 2;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati5].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat5.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat5.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat5.x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = texture(_CameraDepthTextureScaled, vs_TEXCOORD0.xy).x;
    u_xlat5.x = u_xlat0.x * _ZBufferParams.x;
    u_xlat0.x = (-u_xlat0.x) * _ZBufferParams.y + 1.0;
    u_xlat0.z = u_xlat0.x / u_xlat5.x;
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
int u_xlati5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat5.x, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat10 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10<0.0);
#else
    u_xlatb10 = u_xlat10<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlati5 = int(u_xlatu5) << 2;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati5].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat5.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
int u_xlati5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat5.x, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat10 = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10<0.0);
#else
    u_xlatb10 = u_xlat10<0.0;
#endif
    if((int(u_xlatb10) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlati5 = int(u_xlatu5) << 2;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 1)].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToShadow[u_xlati5].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 2)].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat5.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_WorldToShadow[(u_xlati5 + 3)].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat5.x, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xyz = in_TEXCOORD1.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowPos[4];
uniform 	vec4 _ShadowMapTexture_TexelSize;
uniform 	vec4 _mhyShadowDistParams;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp float u_xlat10_5;
uint u_xlatu5;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = _ScreenParams.z + -1.0;
    u_xlat1.x = (-u_xlat0.x) * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.z = u_xlat0.x * 0.5 + vs_TEXCOORD0.x;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat1.zw).x;
    u_xlat0.z = max(u_xlat5.x, u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_CameraInvProjection[1];
    u_xlat1 = hlslcc_mtx4x4unity_CameraInvProjection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_CameraInvProjection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_CameraInvProjection[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat15 = u_xlat0.z + _mhyShadowDistParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * (-u_xlat0.zzz) + u_xlat0.xyw;
    u_xlat1.xyz = u_xlat0.xyz + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[0].xyz);
    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[1].xyz);
    u_xlat2.y = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[2].xyz);
    u_xlat2.z = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowSplitSpheres[3].xyz);
    u_xlat2.w = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlatb2 = lessThan(u_xlat2, unity_ShadowSplitSqRadii);
    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
    u_xlat16_3.x = u_xlat2.y + u_xlat2.x;
    u_xlat16_3.y = u_xlat2.z + u_xlat16_3.x;
    u_xlat4.zw = (-u_xlat16_3.xy);
    u_xlat4.y = (-u_xlat2.x);
    u_xlat4.x = -0.0;
    u_xlat2 = u_xlat2 + u_xlat4;
    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat16_3.x = dot(u_xlat2, vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat5.x = dot(u_xlat2.yzw, vec3(1.0, 2.0, 3.0));
    u_xlat5.x = min(u_xlat5.x, 3.0);
    u_xlatu5 = uint(u_xlat5.x);
    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowPos[int(u_xlatu5)].xyz);
    u_xlat1.x = u_xlat16_3.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat5.yyy * hlslcc_mtx4x4unity_WorldToShadow[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToShadow[0].xyz * u_xlat5.xxx + u_xlat1.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToShadow[2].xyz * u_xlat5.zzz + u_xlat1.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToShadow[3].xyz;
    u_xlat5.xy = u_xlat5.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat1.xy = floor(u_xlat5.xy);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat11.xy = (-u_xlat5.xy) + vec2(2.0, 2.0);
    u_xlat2.xy = (-u_xlat5.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat11.xy = u_xlat11.xy / u_xlat2.yx;
    u_xlat3.xy = u_xlat11.xy + vec2(-1.0, -1.0);
    u_xlat11.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat5.xy = u_xlat5.xy / u_xlat11.xy;
    u_xlat3.zw = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat3 = u_xlat3.xzyw * _ShadowMapTexture_TexelSize.xxyy;
    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xzyz;
    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat3.xwyw;
    vec3 txVec0 = vec3(u_xlat4.zw,u_xlat5.z);
    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
    u_xlat1.xy = u_xlat2.xy * u_xlat11.xy;
    u_xlat2.x = u_xlat2.x * u_xlat2.y;
    u_xlat11.x = u_xlat11.y * u_xlat11.x;
    u_xlat5.x = u_xlat10_5 * u_xlat1.x;
    u_xlat5.x = u_xlat2.x * u_xlat10_10 + u_xlat5.x;
    vec3 txVec2 = vec3(u_xlat3.xy,u_xlat5.z);
    u_xlat10_10 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat3.zw,u_xlat5.z);
    u_xlat10_15 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
    u_xlat5.x = u_xlat1.y * u_xlat10_10 + u_xlat5.x;
    u_xlat5.x = u_xlat11.x * u_xlat10_15 + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.0625;
    u_xlat16_10 = (-_LightShadowData.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat16_10 + _LightShadowData.x;
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat15 = _mhyShadowDistParams.x * _mhyShadowDistParams.x;
    u_xlat15 = u_xlat15 * 0.639999986;
    u_xlat0.x = u_xlat0.x / u_xlat15;
    u_xlat0.x = u_xlat0.x * 3.0 + -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
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
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles3 " {
Keywords { "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" "SHADOW_HALF_RES" "LINE_INTERPOLATION" }
""
}
}
}
}
SubShader {
 Tags { "ShadowmapFilter" = "SHADOW_MASK_TAA" }
 Pass {
  Tags { "ShadowmapFilter" = "SHADOW_MASK_TAA" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 284019
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
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
    u_xlat2 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat2 * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ShadowMaskTexture_TexelSize;
uniform lowp sampler2D _ShadowMaskTexture;
uniform lowp sampler2D _CameraMotionVectorsTexture;
uniform lowp sampler2D _ShadowMapHistoryTexture;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
ivec2 u_xlati1;
vec4 u_xlat2;
float u_xlat3;
bool u_xlatb3;
lowp float u_xlat10_4;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec2 u_xlat7;
ivec2 u_xlati7;
float u_xlat9;
mediump float u_xlat16_9;
lowp float u_xlat10_9;
void main()
{
    u_xlat10_0.xyz = texture(_CameraMotionVectorsTexture, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xy = u_xlat10_0.xy + vec2(-0.498039216, -0.498039216);
    u_xlati1.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxx).xy) * 0xFFFFFFFFu);
    u_xlati7.xy = ivec2(uvec2(lessThan(u_xlat0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
    u_xlati1.xy = (-u_xlati1.xy) + u_xlati7.xy;
    u_xlat1.xy = vec2(u_xlati1.xy);
    u_xlat7.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = (-u_xlat0.xy) * u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat9 = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * 6000.0;
    u_xlat9 = min(u_xlat9, 1.0);
    u_xlat9 = u_xlat9 * -0.25 + 0.949999988;
    u_xlat1.x = texture(_CameraMotionVectorsTexture, u_xlat0.xy).z;
    u_xlat10_0.x = texture(_ShadowMapHistoryTexture, u_xlat0.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat10_0.z==u_xlat1.x);
#else
    u_xlatb3 = u_xlat10_0.z==u_xlat1.x;
#endif
    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat3 = u_xlat3 * u_xlat9;
    u_xlat1.x = float(0.0);
    u_xlat1.w = float(0.0);
    u_xlat1.yz = (-_ShadowMaskTexture_TexelSize.yx);
    u_xlat1 = u_xlat1 + vs_TEXCOORD0.xyxy;
    u_xlat10_6 = texture(_ShadowMaskTexture, u_xlat1.xy).x;
    u_xlat10_9 = texture(_ShadowMaskTexture, u_xlat1.zw).x;
    u_xlat16_1 = min(u_xlat10_9, u_xlat10_6);
    u_xlat16_6 = max(u_xlat10_9, u_xlat10_6);
    u_xlat2.xw = _ShadowMaskTexture_TexelSize.xy;
    u_xlat2.y = float(0.0);
    u_xlat2.z = float(0.0);
    u_xlat2 = u_xlat2 + vs_TEXCOORD0.xyxy;
    u_xlat10_9 = texture(_ShadowMaskTexture, u_xlat2.xy).x;
    u_xlat10_4 = texture(_ShadowMaskTexture, u_xlat2.zw).x;
    u_xlat16_1 = min(u_xlat10_9, u_xlat16_1);
    u_xlat16_6 = max(u_xlat10_9, u_xlat16_6);
    u_xlat16_6 = max(u_xlat10_4, u_xlat16_6);
    u_xlat16_9 = min(u_xlat10_4, u_xlat16_1);
    u_xlat10_1 = texture(_ShadowMaskTexture, vs_TEXCOORD0.xy).x;
    u_xlat16_9 = min(u_xlat16_9, u_xlat10_1);
    u_xlat16_0 = max(u_xlat16_9, u_xlat10_0.x);
    u_xlat16_6 = max(u_xlat16_6, u_xlat10_1);
    u_xlat16_0 = min(u_xlat16_6, u_xlat16_0);
    u_xlat16_0 = (-u_xlat10_1) + u_xlat16_0;
    u_xlat0.x = u_xlat3 * u_xlat16_0 + u_xlat10_1;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
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
}
}
}
SubShader {
 Tags { "ShadowmapFilter" = "MERGE_PER_OBJECT_SHADOWMAP" }
 Pass {
  Tags { "ShadowmapFilter" = "MERGE_PER_OBJECT_SHADOWMAP" }
  ZTest GEqual
  ZWrite Off
  Cull Front
  GpuProgramID 391336
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 _UVScaleAndOffsetArray;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_PerObjectShadowMapTexture;
uniform lowp sampler2D _PerObjectShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
bvec3 u_xlatb1;
vec3 u_xlat2;
mediump float u_xlat16_2;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat0.xyz = u_xlat0.xyz + vec3(0.5, 0.5, 0.5);
    u_xlatb1.xyz = lessThan(u_xlat1.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb6 = u_xlatb1.y || u_xlatb1.x;
    u_xlatb6 = u_xlatb1.z || u_xlatb6;
    if((int(u_xlatb6) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = u_xlat0.xy * _UVScaleAndOffsetArray.xy + _UVScaleAndOffsetArray.zw;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_PerObjectShadowMapTexture, txVec0, 0.0);
    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_2 + _LightShadowData.x;
    SV_Target0.x = u_xlat16_0;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct PerObjectShadowPropsArray_Type {
	vec4 _UVScaleAndOffsetArray;
};
layout(std140) uniform UnityInstancing_PerObjectShadowProps {
	PerObjectShadowPropsArray_Type PerObjectShadowPropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_PerObjectShadowMapTexture;
uniform lowp sampler2D _PerObjectShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
int u_xlati1;
bvec3 u_xlatb1;
vec3 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
int u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlati6 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati1 = u_xlati6 << 3;
    u_xlat3.xyz = u_xlat0.yyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat0.xyz = u_xlat0.xyz + vec3(0.5, 0.5, 0.5);
    u_xlatb1.xyz = lessThan(u_xlat1.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = u_xlat0.xy * PerObjectShadowPropsArray[u_xlati6]._UVScaleAndOffsetArray.xy + PerObjectShadowPropsArray[u_xlati6]._UVScaleAndOffsetArray.zw;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_PerObjectShadowMapTexture, txVec0, 0.0);
    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_2 + _LightShadowData.x;
    SV_Target0.x = u_xlat16_0;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 _UVScaleAndOffsetArray;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_PerObjectShadowMapTexture;
uniform lowp sampler2D _PerObjectShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
bvec3 u_xlatb1;
mediump float u_xlat16_2;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat6 = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat0.xyz = u_xlat0.xyz + vec3(0.5, 0.5, 0.5);
    u_xlatb1.xyz = lessThan(u_xlat1.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb6 = u_xlatb1.y || u_xlatb1.x;
    u_xlatb6 = u_xlatb1.z || u_xlatb6;
    if((int(u_xlatb6) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = u_xlat0.xy * _UVScaleAndOffsetArray.xy + _UVScaleAndOffsetArray.zw;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_PerObjectShadowMapTexture, txVec0, 0.0);
    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_2 + _LightShadowData.x;
    SV_Target0.x = u_xlat16_0;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "SHADOW_HALF_RES" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct PerObjectShadowPropsArray_Type {
	vec4 _UVScaleAndOffsetArray;
};
layout(std140) uniform UnityInstancing_PerObjectShadowProps {
	PerObjectShadowPropsArray_Type PerObjectShadowPropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_PerObjectShadowMapTexture;
uniform lowp sampler2D _PerObjectShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
int u_xlati1;
bvec3 u_xlatb1;
mediump float u_xlat16_2;
vec3 u_xlat3;
float u_xlat6;
int u_xlati6;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat6 = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlati6 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati1 = u_xlati6 << 3;
    u_xlat3.xyz = u_xlat0.yyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat0.xyz = u_xlat0.xyz + vec3(0.5, 0.5, 0.5);
    u_xlatb1.xyz = lessThan(u_xlat1.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = u_xlat0.xy * PerObjectShadowPropsArray[u_xlati6]._UVScaleAndOffsetArray.xy + PerObjectShadowPropsArray[u_xlati6]._UVScaleAndOffsetArray.zw;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_PerObjectShadowMapTexture, txVec0, 0.0);
    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_2 + _LightShadowData.x;
    SV_Target0.x = u_xlat16_0;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PER_OBJECT_PCF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 _UVScaleAndOffsetArray;
uniform 	vec4 _PerObjectShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_PerObjectShadowMapTexture;
uniform lowp sampler2D _PerObjectShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec3 u_xlatb1;
vec2 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
float u_xlat8;
lowp float u_xlat10_8;
vec2 u_xlat13;
vec2 u_xlat14;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat6.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat6.xyz = u_xlat6.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlatb1.xyz = lessThan(u_xlat1.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb18 = u_xlatb1.y || u_xlatb1.x;
    u_xlatb18 = u_xlatb1.z || u_xlatb18;
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.xy * _UVScaleAndOffsetArray.xy + _UVScaleAndOffsetArray.zw;
    u_xlat1.xy = u_xlat1.xy * _PerObjectShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat13.xy = fract(u_xlat1.xy);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat1.xy * _PerObjectShadowMapTexture_TexelSize.xy;
    u_xlat1.xy = (-u_xlat13.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat18 = u_xlat1.x * u_xlat1.y;
    u_xlat2.xy = u_xlat13.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat14.xy = u_xlat1.xy * u_xlat2.xy;
    u_xlat3.xy = (-u_xlat13.xy) + vec2(2.0, 2.0);
    u_xlat1.zw = u_xlat13.xy / u_xlat2.xy;
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat1.xy = u_xlat3.xy / u_xlat1.yx;
    u_xlat4 = u_xlat1 + vec4(-1.0, -1.0, 1.0, 1.0);
    u_xlat1.xy = vec2(u_xlat4.y * _PerObjectShadowMapTexture_TexelSize.y, u_xlat4.w * _PerObjectShadowMapTexture_TexelSize.y);
    u_xlat3.xy = u_xlat4.zx * _PerObjectShadowMapTexture_TexelSize.xx;
    u_xlat3.w = u_xlat1.x;
    u_xlat3.z = 0.5;
    u_xlat4.xyz = u_xlat0.xyz + u_xlat3.xwz;
    u_xlat5.xyz = vec3(u_xlat0.x + u_xlat3.y, u_xlat0.y + u_xlat3.w, u_xlat0.z + u_xlat3.z);
    vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_PerObjectShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat4.z);
    u_xlat10_8 = textureLod(hlslcc_zcmp_PerObjectShadowMapTexture, txVec1, 0.0);
    u_xlat8 = u_xlat10_8 * u_xlat14.x;
    u_xlat18 = u_xlat18 * u_xlat10_1 + u_xlat8;
    u_xlat1.zw = u_xlat3.yz;
    u_xlat1.xzw = vec3(u_xlat0.x + u_xlat1.z, u_xlat0.y + u_xlat1.y, u_xlat0.z + u_xlat1.w);
    u_xlat3.y = u_xlat1.y;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    vec3 txVec2 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_PerObjectShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat1.xz,u_xlat1.w);
    u_xlat10_6 = textureLod(hlslcc_zcmp_PerObjectShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat14.y * u_xlat10_6 + u_xlat18;
    u_xlat0.x = u_xlat2.x * u_xlat10_0 + u_xlat6.x;
    u_xlat0.x = u_xlat0.x * 0.0625;
    u_xlat16_6 = (-_LightShadowData.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_6 + _LightShadowData.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "PER_OBJECT_PCF" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _PerObjectShadowMapTexture_TexelSize;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct PerObjectShadowPropsArray_Type {
	vec4 _UVScaleAndOffsetArray;
};
layout(std140) uniform UnityInstancing_PerObjectShadowProps {
	PerObjectShadowPropsArray_Type PerObjectShadowPropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2DShadow hlslcc_zcmp_PerObjectShadowMapTexture;
uniform lowp sampler2D _PerObjectShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp float u_xlat10_1;
int u_xlati1;
bvec3 u_xlatb1;
vec2 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec3 u_xlat7;
float u_xlat8;
lowp float u_xlat10_8;
vec2 u_xlat13;
vec2 u_xlat14;
float u_xlat18;
int u_xlati18;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat6.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat6.xyz = u_xlat6.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlati18 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati1 = u_xlati18 << 3;
    u_xlat7.xyz = u_xlat0.yyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat7.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.zzz + u_xlat7.xyz;
    u_xlat0.xyz = u_xlat0.xyz + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlatb1.xyz = lessThan(u_xlat1.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.xy * PerObjectShadowPropsArray[u_xlati18]._UVScaleAndOffsetArray.xy + PerObjectShadowPropsArray[u_xlati18]._UVScaleAndOffsetArray.zw;
    u_xlat1.xy = u_xlat1.xy * _PerObjectShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat13.xy = fract(u_xlat1.xy);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat1.xy * _PerObjectShadowMapTexture_TexelSize.xy;
    u_xlat1.xy = (-u_xlat13.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat18 = u_xlat1.x * u_xlat1.y;
    u_xlat2.xy = u_xlat13.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat14.xy = u_xlat1.xy * u_xlat2.xy;
    u_xlat3.xy = (-u_xlat13.xy) + vec2(2.0, 2.0);
    u_xlat1.zw = u_xlat13.xy / u_xlat2.xy;
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat1.xy = u_xlat3.xy / u_xlat1.yx;
    u_xlat4 = u_xlat1 + vec4(-1.0, -1.0, 1.0, 1.0);
    u_xlat1.xy = vec2(u_xlat4.y * _PerObjectShadowMapTexture_TexelSize.y, u_xlat4.w * _PerObjectShadowMapTexture_TexelSize.y);
    u_xlat3.xy = u_xlat4.zx * _PerObjectShadowMapTexture_TexelSize.xx;
    u_xlat3.w = u_xlat1.x;
    u_xlat3.z = 0.5;
    u_xlat4.xyz = u_xlat0.xyz + u_xlat3.xwz;
    u_xlat5.xyz = vec3(u_xlat0.x + u_xlat3.y, u_xlat0.y + u_xlat3.w, u_xlat0.z + u_xlat3.z);
    vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_PerObjectShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat4.z);
    u_xlat10_8 = textureLod(hlslcc_zcmp_PerObjectShadowMapTexture, txVec1, 0.0);
    u_xlat8 = u_xlat10_8 * u_xlat14.x;
    u_xlat18 = u_xlat18 * u_xlat10_1 + u_xlat8;
    u_xlat1.zw = u_xlat3.yz;
    u_xlat1.xzw = vec3(u_xlat0.x + u_xlat1.z, u_xlat0.y + u_xlat1.y, u_xlat0.z + u_xlat1.w);
    u_xlat3.y = u_xlat1.y;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    vec3 txVec2 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_PerObjectShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat1.xz,u_xlat1.w);
    u_xlat10_6 = textureLod(hlslcc_zcmp_PerObjectShadowMapTexture, txVec3, 0.0);
    u_xlat6.x = u_xlat14.y * u_xlat10_6 + u_xlat18;
    u_xlat0.x = u_xlat2.x * u_xlat10_0 + u_xlat6.x;
    u_xlat0.x = u_xlat0.x * 0.0625;
    u_xlat16_6 = (-_LightShadowData.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_6 + _LightShadowData.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" "PER_OBJECT_PCF" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 _UVScaleAndOffsetArray;
uniform 	vec4 _PerObjectShadowMapTexture_TexelSize;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_PerObjectShadowMapTexture;
uniform lowp sampler2D _PerObjectShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec3 u_xlatb1;
vec2 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
float u_xlat8;
lowp float u_xlat10_8;
vec2 u_xlat13;
vec2 u_xlat14;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat18 = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlatb1.xyz = lessThan(u_xlat1.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb18 = u_xlatb1.y || u_xlatb1.x;
    u_xlatb18 = u_xlatb1.z || u_xlatb18;
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.xy * _UVScaleAndOffsetArray.xy + _UVScaleAndOffsetArray.zw;
    u_xlat1.xy = u_xlat1.xy * _PerObjectShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat13.xy = fract(u_xlat1.xy);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat1.xy * _PerObjectShadowMapTexture_TexelSize.xy;
    u_xlat1.xy = (-u_xlat13.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat18 = u_xlat1.x * u_xlat1.y;
    u_xlat2.xy = u_xlat13.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat14.xy = u_xlat1.xy * u_xlat2.xy;
    u_xlat3.xy = (-u_xlat13.xy) + vec2(2.0, 2.0);
    u_xlat1.zw = u_xlat13.xy / u_xlat2.xy;
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat1.xy = u_xlat3.xy / u_xlat1.yx;
    u_xlat4 = u_xlat1 + vec4(-1.0, -1.0, 1.0, 1.0);
    u_xlat1.xy = vec2(u_xlat4.y * _PerObjectShadowMapTexture_TexelSize.y, u_xlat4.w * _PerObjectShadowMapTexture_TexelSize.y);
    u_xlat3.xy = u_xlat4.zx * _PerObjectShadowMapTexture_TexelSize.xx;
    u_xlat3.w = u_xlat1.x;
    u_xlat3.z = 0.5;
    u_xlat4.xyz = u_xlat0.xyz + u_xlat3.xwz;
    u_xlat5.xyz = vec3(u_xlat0.x + u_xlat3.y, u_xlat0.y + u_xlat3.w, u_xlat0.z + u_xlat3.z);
    vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_PerObjectShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat4.z);
    u_xlat10_8 = textureLod(hlslcc_zcmp_PerObjectShadowMapTexture, txVec1, 0.0);
    u_xlat8 = u_xlat10_8 * u_xlat14.x;
    u_xlat18 = u_xlat18 * u_xlat10_1 + u_xlat8;
    u_xlat1.zw = u_xlat3.yz;
    u_xlat1.xzw = vec3(u_xlat0.x + u_xlat1.z, u_xlat0.y + u_xlat1.y, u_xlat0.z + u_xlat1.w);
    u_xlat3.y = u_xlat1.y;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    vec3 txVec2 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_PerObjectShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat1.xz,u_xlat1.w);
    u_xlat10_6 = textureLod(hlslcc_zcmp_PerObjectShadowMapTexture, txVec3, 0.0);
    u_xlat6 = u_xlat14.y * u_xlat10_6 + u_xlat18;
    u_xlat0.x = u_xlat2.x * u_xlat10_0 + u_xlat6;
    u_xlat0.x = u_xlat0.x * 0.0625;
    u_xlat16_6 = (-_LightShadowData.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_6 + _LightShadowData.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "SHADOW_HALF_RES" "PER_OBJECT_PCF" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _PerObjectShadowMapTexture_TexelSize;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct PerObjectShadowPropsArray_Type {
	vec4 _UVScaleAndOffsetArray;
};
layout(std140) uniform UnityInstancing_PerObjectShadowProps {
	PerObjectShadowPropsArray_Type PerObjectShadowPropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2DShadow hlslcc_zcmp_PerObjectShadowMapTexture;
uniform lowp sampler2D _PerObjectShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp float u_xlat10_1;
int u_xlati1;
bvec3 u_xlatb1;
vec2 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec3 u_xlat7;
float u_xlat8;
lowp float u_xlat10_8;
vec2 u_xlat13;
vec2 u_xlat14;
float u_xlat18;
int u_xlati18;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat18 = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlati18 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati1 = u_xlati18 << 3;
    u_xlat7.xyz = u_xlat0.yyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat7.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.zzz + u_xlat7.xyz;
    u_xlat0.xyz = u_xlat0.xyz + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz;
    u_xlat1.xyz = -abs(u_xlat0.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlatb1.xyz = lessThan(u_xlat1.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat1.xy = u_xlat1.xy * PerObjectShadowPropsArray[u_xlati18]._UVScaleAndOffsetArray.xy + PerObjectShadowPropsArray[u_xlati18]._UVScaleAndOffsetArray.zw;
    u_xlat1.xy = u_xlat1.xy * _PerObjectShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
    u_xlat13.xy = fract(u_xlat1.xy);
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat1.xy * _PerObjectShadowMapTexture_TexelSize.xy;
    u_xlat1.xy = (-u_xlat13.yx) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat18 = u_xlat1.x * u_xlat1.y;
    u_xlat2.xy = u_xlat13.xy * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat14.xy = u_xlat1.xy * u_xlat2.xy;
    u_xlat3.xy = (-u_xlat13.xy) + vec2(2.0, 2.0);
    u_xlat1.zw = u_xlat13.xy / u_xlat2.xy;
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat1.xy = u_xlat3.xy / u_xlat1.yx;
    u_xlat4 = u_xlat1 + vec4(-1.0, -1.0, 1.0, 1.0);
    u_xlat1.xy = vec2(u_xlat4.y * _PerObjectShadowMapTexture_TexelSize.y, u_xlat4.w * _PerObjectShadowMapTexture_TexelSize.y);
    u_xlat3.xy = u_xlat4.zx * _PerObjectShadowMapTexture_TexelSize.xx;
    u_xlat3.w = u_xlat1.x;
    u_xlat3.z = 0.5;
    u_xlat4.xyz = u_xlat0.xyz + u_xlat3.xwz;
    u_xlat5.xyz = vec3(u_xlat0.x + u_xlat3.y, u_xlat0.y + u_xlat3.w, u_xlat0.z + u_xlat3.z);
    vec3 txVec0 = vec3(u_xlat5.xy,u_xlat5.z);
    u_xlat10_1 = textureLod(hlslcc_zcmp_PerObjectShadowMapTexture, txVec0, 0.0);
    vec3 txVec1 = vec3(u_xlat4.xy,u_xlat4.z);
    u_xlat10_8 = textureLod(hlslcc_zcmp_PerObjectShadowMapTexture, txVec1, 0.0);
    u_xlat8 = u_xlat10_8 * u_xlat14.x;
    u_xlat18 = u_xlat18 * u_xlat10_1 + u_xlat8;
    u_xlat1.zw = u_xlat3.yz;
    u_xlat1.xzw = vec3(u_xlat0.x + u_xlat1.z, u_xlat0.y + u_xlat1.y, u_xlat0.z + u_xlat1.w);
    u_xlat3.y = u_xlat1.y;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat3.xyz;
    vec3 txVec2 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat10_0 = textureLod(hlslcc_zcmp_PerObjectShadowMapTexture, txVec2, 0.0);
    vec3 txVec3 = vec3(u_xlat1.xz,u_xlat1.w);
    u_xlat10_6 = textureLod(hlslcc_zcmp_PerObjectShadowMapTexture, txVec3, 0.0);
    u_xlat6 = u_xlat14.y * u_xlat10_6 + u_xlat18;
    u_xlat0.x = u_xlat2.x * u_xlat10_0 + u_xlat6;
    u_xlat0.x = u_xlat0.x * 0.0625;
    u_xlat16_6 = (-_LightShadowData.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_6 + _LightShadowData.x;
    SV_Target0.x = u_xlat0.x;
    SV_Target0.yzw = vec3(1.0, 0.0, 0.0);
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
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "SHADOW_HALF_RES" }
""
}
SubProgram "gles3 " {
Keywords { "PER_OBJECT_PCF" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "PER_OBJECT_PCF" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOW_HALF_RES" "PER_OBJECT_PCF" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "SHADOW_HALF_RES" "PER_OBJECT_PCF" }
""
}
}
}
}
}