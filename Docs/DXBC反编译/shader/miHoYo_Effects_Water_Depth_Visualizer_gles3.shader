//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/Water_Depth_Visualizer" {
Properties {
[Header(Main Settings)] _Color1 ("Depth Layer Color 1", Color) = (1,1,1,1)
_Width1 ("Depth Layer width 1", Float) = 0
[Space] _Color2 ("Depth Layer Color 2", Color) = (1,1,1,1)
_Width2 ("Depth Layer width 2", Float) = 0
[Space] _Color3 ("Depth Layer Color 3", Color) = (1,1,1,1)
_Width3 ("Depth Layer width 3", Float) = 0
[Space] _Color4 ("Depth Layer Color 4", Color) = (1,1,1,1)
_Width4 ("Depth Layer width 4", Float) = 0
[Space] [Space] _Color5 ("Depth Layer Color 5", Color) = (1,1,1,1)
_Width5 ("Depth Layer width 5", Float) = 0
[Space] _Color0 ("Default Layer Color", Color) = (1,1,1,1)
_Alpha ("Alpha", Range(0, 1)) = 0.5
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "DebugView" = "On" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 56919
Program "vp" {
SubProgram "gles3 " {
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
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp float vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
mediump float u_xlat16_9;
vec3 u_xlat10;
float u_xlat14;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
bool u_xlatb20;
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
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat20 = u_xlat18 * -1.44269502;
    u_xlat20 = exp2(u_xlat20);
    u_xlat20 = (-u_xlat20) + 1.0;
    u_xlat20 = u_xlat20 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_3.x = (u_xlatb18) ? u_xlat20 : 1.0;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = sqrt(u_xlat18);
    u_xlat20 = u_xlat18 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat20 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat20 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat4.x = u_xlat20 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_9 = (u_xlatb20) ? u_xlat4.x : 1.0;
    u_xlat20 = u_xlat18 * _HeigtFogParams2.y;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat16_9 = exp2((-u_xlat16_9));
    u_xlat16_3.y = (-u_xlat16_9) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat20 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3.x = u_xlat20 * u_xlat16_3.x;
    u_xlat20 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4.x = (-u_xlat20) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat8 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat8);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat8;
#endif
    u_xlat8 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat8) + 2.0;
    u_xlat8 = u_xlat14 * u_xlat8;
    u_xlat14 = u_xlat8 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat14 : u_xlat8;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat8 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat8) + 2.0;
    u_xlat16_3.x = u_xlat8 * u_xlat16_3.x;
    u_xlat10.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat10.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat10.xyz = vec3(u_xlat18) * u_xlat5.xyz + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat18 = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat4.x * u_xlat18;
    u_xlat2.xyz = u_xlat4.xxx * u_xlat10.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat18) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat4.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.w = 0.0;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat18 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat18;
    vs_TEXCOORD5 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat18;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
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
uniform 	float _Alpha;
uniform 	vec3 _Color0;
uniform 	vec3 _Color1;
uniform 	float _Width1;
uniform 	vec3 _Color2;
uniform 	float _Width2;
uniform 	vec3 _Color3;
uniform 	float _Width3;
uniform 	vec3 _Color4;
uniform 	float _Width4;
uniform 	vec3 _Color5;
uniform 	float _Width5;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp float vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
float u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
bool u_xlatb6;
vec3 u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) / vs_TEXCOORD5;
    u_xlat0.x = vs_TEXCOORD4.y * u_xlat0.x + _WorldSpaceCameraPos.y;
    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.x<_Width2);
#else
    u_xlatb6 = u_xlat0.x<_Width2;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Width1<u_xlat0.x);
#else
    u_xlatb12 = _Width1<u_xlat0.x;
#endif
    u_xlatb6 = u_xlatb12 && u_xlatb6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x<_Width1);
#else
    u_xlatb12 = u_xlat0.x<_Width1;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb12)) ? _Color1.xyz : vec3(_Color0.x, _Color0.y, _Color0.z);
    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _Color2.xyz : u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.x<_Width3);
#else
    u_xlatb6 = u_xlat0.x<_Width3;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Width2<u_xlat0.x);
#else
    u_xlatb12 = _Width2<u_xlat0.x;
#endif
    u_xlatb6 = u_xlatb12 && u_xlatb6;
    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _Color3.xyz : u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.x<_Width4);
#else
    u_xlatb6 = u_xlat0.x<_Width4;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Width3<u_xlat0.x);
#else
    u_xlatb12 = _Width3<u_xlat0.x;
#endif
    u_xlatb6 = u_xlatb12 && u_xlatb6;
    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _Color4.xyz : u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.x<_Width5);
#else
    u_xlatb6 = u_xlat0.x<_Width5;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Width4<u_xlat0.x);
#else
    u_xlatb0 = _Width4<u_xlat0.x;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb6;
    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _Color5.xyz : u_xlat16_1.xyz;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat2 = u_xlat18 * -1.44269502;
    u_xlat2 = exp2(u_xlat2);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat2 = u_xlat2 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_19 = (u_xlatb18) ? u_xlat2 : 1.0;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = sqrt(u_xlat18);
    u_xlat2 = u_xlat18 * _HeigtFogParams.y;
    u_xlat16_19 = u_xlat16_19 * u_xlat2;
    u_xlat16_19 = exp2((-u_xlat16_19));
    u_xlat16_19 = (-u_xlat16_19) + 1.0;
    u_xlat16_19 = max(u_xlat16_19, 0.0);
    u_xlat2 = u_xlat0.y * _HeigtFogParams2.x;
    u_xlat8.x = u_xlat2 * -1.44269502;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat8.x / u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2);
#endif
    u_xlat16_3 = (u_xlatb2) ? u_xlat8.x : 1.0;
    u_xlat2 = u_xlat18 * _HeigtFogParams2.y;
    u_xlat16_3 = u_xlat2 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_19 = u_xlat16_19 + u_xlat16_3;
    u_xlat2 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2) + 2.0;
    u_xlat16_3 = u_xlat2 * u_xlat16_3;
    u_xlat2 = u_xlat16_3 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat2 = u_xlat2 + 1.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat2;
    u_xlat2 = min(u_xlat16_19, _HeigtFogColBase.w);
    u_xlat8.x = (-u_xlat2) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat6.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat6.x;
#endif
    u_xlat6.x = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat12 = u_xlat12 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat18 : u_xlat6.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat6.x = vs_TEXCOORD2.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_19 = (-u_xlat6.x) + 2.0;
    u_xlat16_19 = u_xlat6.x * u_xlat16_19;
    u_xlat4.xyz = vec3(u_xlat16_19) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat0.yzw = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0 = u_xlat8.xxxx * u_xlat0;
    u_xlat8.x = vs_TEXCOORD2.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat8.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat6.xyz = u_xlat8.xyz * vec3(u_xlat2) + u_xlat0.yzw;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz + u_xlat6.xyz;
    u_xlat0.w = _Alpha;
    SV_Target0 = u_xlat0;
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
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp float vs_TEXCOORD5;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
mediump float u_xlat16_9;
vec3 u_xlat10;
float u_xlat14;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
bool u_xlatb20;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat20 = u_xlat18 * -1.44269502;
    u_xlat20 = exp2(u_xlat20);
    u_xlat20 = (-u_xlat20) + 1.0;
    u_xlat20 = u_xlat20 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_3.x = (u_xlatb18) ? u_xlat20 : 1.0;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = sqrt(u_xlat18);
    u_xlat20 = u_xlat18 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat20 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat20 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat4.x = u_xlat20 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat4.x / u_xlat20;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(0.00999999978<abs(u_xlat20));
#else
    u_xlatb20 = 0.00999999978<abs(u_xlat20);
#endif
    u_xlat16_9 = (u_xlatb20) ? u_xlat4.x : 1.0;
    u_xlat20 = u_xlat18 * _HeigtFogParams2.y;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat16_9 = exp2((-u_xlat16_9));
    u_xlat16_3.y = (-u_xlat16_9) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat20 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat20) + 2.0;
    u_xlat16_9 = u_xlat20 * u_xlat16_9;
    u_xlat20 = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat20 = u_xlat20 + 1.0;
    u_xlat16_3.x = u_xlat20 * u_xlat16_3.x;
    u_xlat20 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4.x = (-u_xlat20) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
    u_xlat8 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat8);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat8;
#endif
    u_xlat8 = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat14 = (-u_xlat8) + 2.0;
    u_xlat8 = u_xlat14 * u_xlat8;
    u_xlat14 = u_xlat8 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat14 : u_xlat8;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat8 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat8) + 2.0;
    u_xlat16_3.x = u_xlat8 * u_xlat16_3.x;
    u_xlat10.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat10.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat10.xyz = vec3(u_xlat18) * u_xlat5.xyz + u_xlat10.xyz;
    u_xlat10.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat18 = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat4.x * u_xlat18;
    u_xlat2.xyz = u_xlat4.xxx * u_xlat10.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat18) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat4.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.w = 0.0;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat18 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat18;
    vs_TEXCOORD5 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat18;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
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
uniform 	float _Alpha;
uniform 	vec3 _Color0;
uniform 	vec3 _Color1;
uniform 	float _Width1;
uniform 	vec3 _Color2;
uniform 	float _Width2;
uniform 	vec3 _Color3;
uniform 	float _Width3;
uniform 	vec3 _Color4;
uniform 	float _Width4;
uniform 	vec3 _Color5;
uniform 	float _Width5;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp float vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
float u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
bool u_xlatb6;
vec3 u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) / vs_TEXCOORD5;
    u_xlat0.x = vs_TEXCOORD4.y * u_xlat0.x + _WorldSpaceCameraPos.y;
    u_xlat0.x = (-u_xlat0.x) + vs_TEXCOORD2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.x<_Width2);
#else
    u_xlatb6 = u_xlat0.x<_Width2;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Width1<u_xlat0.x);
#else
    u_xlatb12 = _Width1<u_xlat0.x;
#endif
    u_xlatb6 = u_xlatb12 && u_xlatb6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x<_Width1);
#else
    u_xlatb12 = u_xlat0.x<_Width1;
#endif
    u_xlat16_1.xyz = (bool(u_xlatb12)) ? _Color1.xyz : vec3(_Color0.x, _Color0.y, _Color0.z);
    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _Color2.xyz : u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.x<_Width3);
#else
    u_xlatb6 = u_xlat0.x<_Width3;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Width2<u_xlat0.x);
#else
    u_xlatb12 = _Width2<u_xlat0.x;
#endif
    u_xlatb6 = u_xlatb12 && u_xlatb6;
    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _Color3.xyz : u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.x<_Width4);
#else
    u_xlatb6 = u_xlat0.x<_Width4;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Width3<u_xlat0.x);
#else
    u_xlatb12 = _Width3<u_xlat0.x;
#endif
    u_xlatb6 = u_xlatb12 && u_xlatb6;
    u_xlat16_1.xyz = (bool(u_xlatb6)) ? _Color4.xyz : u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.x<_Width5);
#else
    u_xlatb6 = u_xlat0.x<_Width5;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Width4<u_xlat0.x);
#else
    u_xlatb0 = _Width4<u_xlat0.x;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb6;
    u_xlat16_1.xyz = (bool(u_xlatb0)) ? _Color5.xyz : u_xlat16_1.xyz;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat18 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat2 = u_xlat18 * -1.44269502;
    u_xlat2 = exp2(u_xlat2);
    u_xlat2 = (-u_xlat2) + 1.0;
    u_xlat2 = u_xlat2 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_19 = (u_xlatb18) ? u_xlat2 : 1.0;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = sqrt(u_xlat18);
    u_xlat2 = u_xlat18 * _HeigtFogParams.y;
    u_xlat16_19 = u_xlat16_19 * u_xlat2;
    u_xlat16_19 = exp2((-u_xlat16_19));
    u_xlat16_19 = (-u_xlat16_19) + 1.0;
    u_xlat16_19 = max(u_xlat16_19, 0.0);
    u_xlat2 = u_xlat0.y * _HeigtFogParams2.x;
    u_xlat8.x = u_xlat2 * -1.44269502;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat8.x / u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2);
#endif
    u_xlat16_3 = (u_xlatb2) ? u_xlat8.x : 1.0;
    u_xlat2 = u_xlat18 * _HeigtFogParams2.y;
    u_xlat16_3 = u_xlat2 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_3 = max(u_xlat16_3, 0.0);
    u_xlat16_19 = u_xlat16_19 + u_xlat16_3;
    u_xlat2 = u_xlat18 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat2) + 2.0;
    u_xlat16_3 = u_xlat2 * u_xlat16_3;
    u_xlat2 = u_xlat16_3 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat2 = u_xlat2 + 1.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat2;
    u_xlat2 = min(u_xlat16_19, _HeigtFogColBase.w);
    u_xlat8.x = (-u_xlat2) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat6.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat6.x;
#endif
    u_xlat6.x = u_xlat18 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat18 + (-_HeigtFogRamp.w);
    u_xlat12 = u_xlat12 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat18 : u_xlat6.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat6.x = vs_TEXCOORD2.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_19 = (-u_xlat6.x) + 2.0;
    u_xlat16_19 = u_xlat6.x * u_xlat16_19;
    u_xlat4.xyz = vec3(u_xlat16_19) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat0.yzw = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0 = u_xlat8.xxxx * u_xlat0;
    u_xlat8.x = vs_TEXCOORD2.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat8.xyz = u_xlat8.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat6.xyz = u_xlat8.xyz * vec3(u_xlat2) + u_xlat0.yzw;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz + u_xlat6.xyz;
    u_xlat0.w = _Alpha;
    SV_Target0 = u_xlat0;
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
}