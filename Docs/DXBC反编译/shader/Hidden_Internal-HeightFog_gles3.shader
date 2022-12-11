//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Internal-HeightFog" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 5744
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
vec4 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump float u_xlat16_7;
float u_xlat10;
bool u_xlatb10;
float u_xlat11;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = vs_TEXCOORD1.y * u_xlat0.x + _WorldSpaceCameraPos.y;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat15 = u_xlat5.x + (-_HeigtFogColParams.z);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat15 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat10 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat1 = u_xlat15 * -1.44269502;
    u_xlat1 = exp2(u_xlat1);
    u_xlat1 = (-u_xlat1) + 1.0;
    u_xlat1 = u_xlat1 / u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.00999999978<abs(u_xlat15));
#else
    u_xlatb15 = 0.00999999978<abs(u_xlat15);
#endif
    u_xlat16_2.x = (u_xlatb15) ? u_xlat1 : 1.0;
    u_xlat15 = u_xlat5.x * _HeigtFogParams.y;
    u_xlat16_2.x = u_xlat15 * u_xlat16_2.x;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_7 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat5.x * _HeigtFogParams2.y;
    u_xlat16_7 = u_xlat10 * u_xlat16_7;
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_2.y = (-u_xlat16_7) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat10 = u_xlat5.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat10) + 2.0;
    u_xlat16_7 = u_xlat10 * u_xlat16_7;
    u_xlat10 = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat10 = u_xlat10 + 1.0;
    u_xlat16_2.x = u_xlat10 * u_xlat16_2.x;
    u_xlat10 = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat15 = (-u_xlat10) + 1.0;
    u_xlat1 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat5.x>=u_xlat1);
#else
    u_xlatb1 = u_xlat5.x>=u_xlat1;
#endif
    u_xlat6.x = u_xlat5.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x + (-_HeigtFogRamp.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat11 * u_xlat6.x;
    u_xlat11 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat1 = (u_xlatb1) ? u_xlat11 : u_xlat6.x;
    u_xlat1 = log2(u_xlat1);
    u_xlat1 = u_xlat1 * unity_FogColor.w;
    u_xlat1 = exp2(u_xlat1);
    u_xlat1 = min(u_xlat1, _HeigtFogColBase.w);
    u_xlat6.x = u_xlat0.x * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat0.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_2.x = (-u_xlat6.x) + 2.0;
    u_xlat16_2.x = u_xlat6.x * u_xlat16_2.x;
    u_xlat6.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat6.xyz = u_xlat5.xxx * u_xlat4.xyz + u_xlat6.xyz;
    u_xlat6.xyz = vec3(u_xlat1) * u_xlat6.xyz;
    u_xlat0.x = (-u_xlat1) + 1.0;
    u_xlat2.w = u_xlat15 * u_xlat0.x;
    u_xlat0.xyw = vec3(u_xlat15) * u_xlat6.xyz;
    u_xlat2.xyz = u_xlat3.xyz * vec3(u_xlat10) + u_xlat0.xyw;
    SV_Target0 = u_xlat2;
    SV_Target1 = u_xlat2;
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
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 72469
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
vec4 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump float u_xlat16_7;
float u_xlat10;
bool u_xlatb10;
float u_xlat11;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = vs_TEXCOORD1.y * u_xlat0.x + _WorldSpaceCameraPos.y;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat15 = u_xlat5.x + (-_HeigtFogColParams.z);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat15 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat10 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat1 = u_xlat15 * -1.44269502;
    u_xlat1 = exp2(u_xlat1);
    u_xlat1 = (-u_xlat1) + 1.0;
    u_xlat1 = u_xlat1 / u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.00999999978<abs(u_xlat15));
#else
    u_xlatb15 = 0.00999999978<abs(u_xlat15);
#endif
    u_xlat16_2.x = (u_xlatb15) ? u_xlat1 : 1.0;
    u_xlat15 = u_xlat5.x * _HeigtFogParams.y;
    u_xlat16_2.x = u_xlat15 * u_xlat16_2.x;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_7 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat5.x * _HeigtFogParams2.y;
    u_xlat16_7 = u_xlat10 * u_xlat16_7;
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_2.y = (-u_xlat16_7) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat10 = u_xlat5.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat10) + 2.0;
    u_xlat16_7 = u_xlat10 * u_xlat16_7;
    u_xlat10 = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat10 = u_xlat10 + 1.0;
    u_xlat16_2.x = u_xlat10 * u_xlat16_2.x;
    u_xlat10 = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat15 = (-u_xlat10) + 1.0;
    u_xlat1 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat5.x>=u_xlat1);
#else
    u_xlatb1 = u_xlat5.x>=u_xlat1;
#endif
    u_xlat6.x = u_xlat5.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x + (-_HeigtFogRamp.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat11 * u_xlat6.x;
    u_xlat11 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat1 = (u_xlatb1) ? u_xlat11 : u_xlat6.x;
    u_xlat1 = log2(u_xlat1);
    u_xlat1 = u_xlat1 * unity_FogColor.w;
    u_xlat1 = exp2(u_xlat1);
    u_xlat1 = min(u_xlat1, _HeigtFogColBase.w);
    u_xlat6.x = u_xlat0.x * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat0.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_2.x = (-u_xlat6.x) + 2.0;
    u_xlat16_2.x = u_xlat6.x * u_xlat16_2.x;
    u_xlat6.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat6.xyz = u_xlat5.xxx * u_xlat4.xyz + u_xlat6.xyz;
    u_xlat6.xyz = vec3(u_xlat1) * u_xlat6.xyz;
    u_xlat0.x = (-u_xlat1) + 1.0;
    u_xlat2.w = u_xlat15 * u_xlat0.x;
    u_xlat0.xyw = vec3(u_xlat15) * u_xlat6.xyz;
    u_xlat2.xyz = u_xlat3.xyz * vec3(u_xlat10) + u_xlat0.xyw;
    SV_Target0 = u_xlat2;
    SV_Target1 = u_xlat2;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform lowp sampler2DMS _CameraDepthTextureMS;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
vec4 u_xlat0;
uvec4 u_xlatu0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump float u_xlat16_7;
float u_xlat10;
bool u_xlatb10;
float u_xlat11;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _ScreenParams.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlatu0.xy = uvec2(ivec2(u_xlat0.xy));
    u_xlatu0.z = uint(uint(0u));
    u_xlatu0.w = uint(uint(0u));
    u_xlat0.x = texelFetch(_CameraDepthTextureMS, ivec2(u_xlatu0.xy), gl_SampleID).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat5.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = vs_TEXCOORD1.y * u_xlat0.x + _WorldSpaceCameraPos.y;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat15 = u_xlat5.x + (-_HeigtFogColParams.z);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<0.0);
#else
    u_xlatb15 = u_xlat15<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat15 = u_xlat5.y * _HeigtFogParams.x;
    u_xlat10 = u_xlat5.y * _HeigtFogParams2.x;
    u_xlat1 = u_xlat15 * -1.44269502;
    u_xlat1 = exp2(u_xlat1);
    u_xlat1 = (-u_xlat1) + 1.0;
    u_xlat1 = u_xlat1 / u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.00999999978<abs(u_xlat15));
#else
    u_xlatb15 = 0.00999999978<abs(u_xlat15);
#endif
    u_xlat16_2.x = (u_xlatb15) ? u_xlat1 : 1.0;
    u_xlat15 = u_xlat5.x * _HeigtFogParams.y;
    u_xlat16_2.x = u_xlat15 * u_xlat16_2.x;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat15 = u_xlat10 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10);
#endif
    u_xlat16_7 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat5.x * _HeigtFogParams2.y;
    u_xlat16_7 = u_xlat10 * u_xlat16_7;
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_2.y = (-u_xlat16_7) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat10 = u_xlat5.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat10) + 2.0;
    u_xlat16_7 = u_xlat10 * u_xlat16_7;
    u_xlat10 = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat10 = u_xlat10 + 1.0;
    u_xlat16_2.x = u_xlat10 * u_xlat16_2.x;
    u_xlat10 = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat15 = (-u_xlat10) + 1.0;
    u_xlat1 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat5.x>=u_xlat1);
#else
    u_xlatb1 = u_xlat5.x>=u_xlat1;
#endif
    u_xlat6.x = u_xlat5.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x + (-_HeigtFogRamp.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat11 * u_xlat6.x;
    u_xlat11 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat1 = (u_xlatb1) ? u_xlat11 : u_xlat6.x;
    u_xlat1 = log2(u_xlat1);
    u_xlat1 = u_xlat1 * unity_FogColor.w;
    u_xlat1 = exp2(u_xlat1);
    u_xlat1 = min(u_xlat1, _HeigtFogColBase.w);
    u_xlat6.x = u_xlat0.x * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat0.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_2.x = (-u_xlat6.x) + 2.0;
    u_xlat16_2.x = u_xlat6.x * u_xlat16_2.x;
    u_xlat6.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat6.xyz = u_xlat5.xxx * u_xlat4.xyz + u_xlat6.xyz;
    u_xlat6.xyz = vec3(u_xlat1) * u_xlat6.xyz;
    u_xlat0.x = (-u_xlat1) + 1.0;
    u_xlat2.w = u_xlat15 * u_xlat0.x;
    u_xlat0.xyw = vec3(u_xlat15) * u_xlat6.xyz;
    u_xlat2.xyz = u_xlat3.xyz * vec3(u_xlat10) + u_xlat0.xyw;
    SV_Target0 = u_xlat2;
    SV_Target1 = u_xlat2;
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
Keywords { "MSAA_INTERPOLATION" }
""
}
}
}
}
}