//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Grass/LowLOD_Billboard_Simple" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
[Header(Element View)] _ElementViewEleID ("Element ID", Float) = 0
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "AlphaTest-1" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "AlphaTest-1" "RenderType" = "Opaque" }
  ZTest Equal
  Cull Off
  GpuProgramID 43192
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _MiHoYoTimeScale;
uniform 	mediump vec4 _WindParams0;
uniform 	mediump vec4 _WindParams1;
uniform 	mediump vec4 _WindParams2;
uniform 	mediump vec4 _BaseSpeculars;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _LowLODColor2;
uniform 	mediump vec4 _Height;
uniform 	mediump vec4 _SpecularExtra;
uniform 	mediump vec4 _DistanceCoeff;
uniform 	mediump vec4 _DistanceConst;
uniform 	vec4 _Pos;
in highp vec4 in_POSITION0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
float u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_11;
mediump float u_xlat16_18;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.xz = in_POSITION0.xz;
    u_xlat0.w = 0.0;
    u_xlat1 = _Pos + vec4(-0.0, -0.0, -0.0, -1.0);
    u_xlat1.x = dot(u_xlat1, u_xlat1);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * _DistanceCoeff.xyz + _DistanceConst.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xyz = min(max(u_xlat1.xyz, 0.0), 1.0);
#else
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
#endif
    u_xlat2.z = min(u_xlat1.y, u_xlat1.x);
    u_xlat0.y = u_xlat2.z * in_POSITION0.y;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat1.xyw = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixInvV[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_MatrixInvV[0].xyz * u_xlat0.xxx + u_xlat1.xyw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixInvV[2].xyz * u_xlat0.zzz + u_xlat1.xyw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixInvV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xz, _MiHoYoWind.xz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = (-u_xlat21) * _WindParams0.y;
    u_xlat21 = _Time.y * _WindParams2.x + u_xlat21;
    u_xlat1.x = u_xlat21 + _WindParams2.y;
    u_xlat1.y = _Time.y * _MiHoYoTimeScale.x + _MiHoYoTimeScale.y;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat3.xy = abs(u_xlat1.xy) * abs(u_xlat1.xy);
    u_xlat1.xy = -abs(u_xlat1.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat1.xy = u_xlat1.xy * u_xlat3.xy;
    u_xlat21 = in_POSITION0.y * _Height.x;
    u_xlat22 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * 8.0 + -5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat21 * _SpecularExtra.x;
    u_xlat21 = u_xlat22 * 1.10000002;
    u_xlat21 = exp2(u_xlat21);
    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat21);
    u_xlat21 = u_xlat21 * _MiHoYoWind.w;
    u_xlat21 = u_xlat21 * _WindParams1.x + 1.0;
    u_xlat21 = u_xlat21 * u_xlat21 + (-u_xlat21);
    u_xlat1.xy = vec2(u_xlat21) * _MiHoYoWind.xz;
    u_xlat2.xw = u_xlat2.zz * u_xlat2.xz;
    u_xlat21 = u_xlat2.y * u_xlat2.w;
    u_xlat21 = u_xlat21 * 0.0848399997;
    u_xlat9.xz = _MiHoYoWind.xz;
    u_xlat9.xz = u_xlat9.xz * u_xlat2.xx;
    u_xlat3.x = 0.0;
    u_xlat3.yz = _MiHoYoWind.zx * vec2(0.0, 1.0);
    u_xlat5.xy = _MiHoYoWind.zx * vec2(1.0, 0.0);
    u_xlat5.z = 0.0;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat5.xyz;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat22 = _MiHoYoWind.w * _WindParams0.x;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _WindParams2.zzz;
    u_xlat5.xy = u_xlat9.xz * vec2(u_xlat22) + u_xlat3.xz;
    u_xlat6.xz = vec2(u_xlat22) * u_xlat9.xz;
    u_xlat2.xy = vec2(u_xlat21) * _WindParams2.ww + u_xlat5.xy;
    u_xlat1.xy = u_xlat1.xy * u_xlat2.zz + u_xlat2.xy;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_MatrixV[2].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyw = u_xlat1.xyw * vec3(100.0, 100.0, 100.0);
    u_xlat1.xyw = floor(u_xlat1.xyw);
    u_xlat1.xyw = u_xlat1.xyw * vec3(0.00999999978, 0.00999999978, 0.00999999978) + hlslcc_mtx4x4unity_MatrixV[3].xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat21 = u_xlat1.w + 0.649999976;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * vec4(u_xlat21) + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[3] * hlslcc_mtx4x4unity_MatrixV[3].wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat6.y = 0.0;
    u_xlat1.xyw = u_xlat3.xyz * _WindParams0.www + u_xlat6.xyz;
    u_xlat1.xyw = u_xlat1.xyw * _WindParams0.zzz;
    u_xlat21 = dot(u_xlat1.xw, u_xlat1.xw);
    u_xlat21 = max(u_xlat21, 0.00100000005);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyw = vec3(u_xlat21) * u_xlat1.xyw;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xz, u_xlat1.xw);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat21<0.0);
#else
    u_xlatb3 = u_xlat21<0.0;
#endif
    u_xlat16_11 = u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat16_11) + 1.00010002;
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_11 = u_xlat16_11 * _BaseSpeculars.w;
    u_xlat16_11 = exp2(u_xlat16_11);
    u_xlat21 = _BaseSpeculars.z * u_xlat16_11 + -0.5;
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat3.xyz = (bool(u_xlatb3)) ? u_xlat0.xyz : u_xlat1.xyw;
    u_xlat1.x = dot(u_xlat1.xw, _WorldSpaceLightPos0.xz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat8 = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat8 = u_xlat8 + u_xlat8;
    u_xlat8 = u_xlat3.y * (-u_xlat8) + (-u_xlat0.y);
    u_xlat8 = u_xlat8 + (-_WorldSpaceLightPos0.y);
    u_xlat5.y = u_xlat16_4.x * u_xlat8 + _WorldSpaceLightPos0.y;
    u_xlat5.xz = _WorldSpaceLightPos0.xz;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat5.xyz * u_xlat16_4.xxx + u_xlat0.xyz;
    u_xlat16_25 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_25 = inversesqrt(u_xlat16_25);
    u_xlat16_4.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz;
    u_xlat8 = dot(u_xlat16_4.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_4.x = dot(u_xlat16_4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_11 = u_xlat8 * u_xlat8;
    u_xlat0.x = (-_BaseSpeculars.y) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_18 = u_xlat0.x * u_xlat0.x;
    u_xlat16_25 = u_xlat16_18 * u_xlat16_18 + -1.0;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_18 = u_xlat16_18 * 0.5;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_25 + 1.0;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11 + 9.99999975e-05;
    u_xlat16_11 = float(1.0) / float(u_xlat16_11);
    u_xlat16_11 = u_xlat16_11 * u_xlat16_18;
    u_xlat16_11 = u_xlat1.x * u_xlat16_11;
    u_xlat16_11 = min(u_xlat16_11, 16.0);
    u_xlat16_18 = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
    u_xlat16_25 = u_xlat16_18 * u_xlat16_4.x;
    u_xlat16_4.x = (-u_xlat16_4.x) * u_xlat16_18 + 1.0;
    u_xlat16_3 = _Color2 + (-_LowLODColor2);
    u_xlat16_1 = u_xlat1.zzzz * u_xlat16_3 + _LowLODColor2;
    u_xlat16_3 = u_xlat16_1 * _BaseSpeculars.xxxx;
    u_xlat16_3 = u_xlat16_4.xxxx * u_xlat16_3 + vec4(u_xlat16_25);
    u_xlat0.x = in_POSITION0.y * _Height.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<u_xlat0.x);
#else
    u_xlatb0 = 0.0<u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 1.0 : 0.5;
    u_xlat16_4.x = u_xlat0.x * u_xlat21;
    u_xlat16_0 = u_xlat16_1 * u_xlat16_4.xxxx;
    u_xlat16_0 = u_xlat16_0 * _LightColor0;
    u_xlat16_0 = vec4(u_xlat16_11) * u_xlat16_3 + u_xlat16_0;
    vs_TEXCOORD0 = u_xlat16_0 * _LightColor0;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat2.y = u_xlat2.y * _ProjectionParams.x;
    u_xlat5.xzw = u_xlat2.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = u_xlat5.zz + u_xlat5.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy).x;
    SV_Target0 = vs_TEXCOORD0 * vec4(u_xlat10_0) + vs_TEXCOORD1;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _MiHoYoTimeScale;
uniform 	mediump vec4 _WindParams0;
uniform 	mediump vec4 _WindParams1;
uniform 	mediump vec4 _WindParams2;
uniform 	mediump vec4 _BaseSpeculars;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _LowLODColor;
uniform 	mediump vec4 _LowLODColor2;
uniform 	mediump vec4 _Height;
uniform 	mediump vec4 _SpecularExtra;
uniform 	mediump vec4 _DistanceCoeff;
uniform 	mediump vec4 _DistanceConst;
uniform 	vec4 _Pos;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD4;
float u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
vec4 u_xlat6;
mediump vec4 u_xlat16_6;
vec4 u_xlat7;
vec4 u_xlat8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
float u_xlat11;
bool u_xlatb11;
vec3 u_xlat14;
bool u_xlatb14;
mediump float u_xlat16_19;
vec2 u_xlat20;
float u_xlat21;
bvec2 u_xlatb24;
mediump float u_xlat16_29;
float u_xlat30;
float u_xlat31;
int u_xlati31;
float u_xlat32;
bool u_xlatb32;
mediump float u_xlat16_39;
void main()
{
    u_xlat0 = in_POSITION0.y * _Height.x;
    u_xlat10.x = log2(u_xlat0);
    u_xlat0 = u_xlat0 * 8.0 + -5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x * 1.10000002;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat20.x = u_xlat10.x * _MiHoYoWind.w;
    u_xlat20.x = u_xlat20.x * _WindParams1.x + 1.0;
    u_xlat20.x = u_xlat20.x * u_xlat20.x + (-u_xlat20.x);
    u_xlat1.xy = _MiHoYoWind.xz;
    u_xlat20.xy = u_xlat20.xx * u_xlat1.xy;
    u_xlat2.x = 0.0;
    u_xlat2.yz = _MiHoYoWind.zx * vec2(0.0, 1.0);
    u_xlat3.xy = _MiHoYoWind.zx * vec2(1.0, 0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(0.0);
    u_xlat2.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat21 = _WindParams1.y * 0.100000001;
    u_xlat3.xz = in_POSITION0.xz;
    u_xlat4.w = 1.0;
    u_xlati31 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati31 = u_xlati31 << 3;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati31 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat5 = (-u_xlat4) + _Pos;
    u_xlat32 = dot(u_xlat5, u_xlat5);
    u_xlat32 = sqrt(u_xlat32);
    u_xlat5.xyz = vec3(u_xlat32) * _DistanceCoeff.xyz + _DistanceConst.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xyz = min(max(u_xlat5.xyz, 0.0), 1.0);
#else
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
#endif
    u_xlat6.z = min(u_xlat5.y, u_xlat5.x);
    u_xlat32 = u_xlat6.z * in_POSITION0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(unity_Builtins0Array[u_xlati31 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x>=0.0);
#else
    u_xlatb14 = unity_Builtins0Array[u_xlati31 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x>=0.0;
#endif
    u_xlat14.x = u_xlatb14 ? 1.0 : float(0.0);
    u_xlat3.y = u_xlat32 * u_xlat14.x;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[1] * unity_Builtins0Array[u_xlati31 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[0] * unity_Builtins0Array[u_xlati31 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat7;
    u_xlat7 = hlslcc_mtx4x4unity_MatrixV[2] * unity_Builtins0Array[u_xlati31 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat7;
    u_xlat7 = u_xlat7 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat8 = u_xlat3 + u_xlat7;
    u_xlat5.xyw = u_xlat8.yyy * hlslcc_mtx4x4unity_MatrixInvV[1].xyz;
    u_xlat5.xyw = hlslcc_mtx4x4unity_MatrixInvV[0].xyz * u_xlat8.xxx + u_xlat5.xyw;
    u_xlat5.xyw = hlslcc_mtx4x4unity_MatrixInvV[2].xyz * u_xlat8.zzz + u_xlat5.xyw;
    u_xlat5.xyw = hlslcc_mtx4x4unity_MatrixInvV[3].xyz * u_xlat8.www + u_xlat5.xyw;
    u_xlat32 = dot(u_xlat5.xw, _MiHoYoWind.xz);
    u_xlat32 = (-u_xlat32) * _WindParams0.y;
    u_xlat32 = _Time.y * _WindParams2.x + u_xlat32;
    u_xlat14.x = 6.28299999 * unity_Builtins0Array[u_xlati31 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
    u_xlat21 = u_xlat14.x * u_xlat21 + u_xlat32;
    u_xlat32 = _Time.y * _MiHoYoTimeScale.x + u_xlat14.x;
    u_xlat8.y = u_xlat32 + _MiHoYoTimeScale.y;
    u_xlat8.x = u_xlat21 + _WindParams2.y;
    u_xlat14.xz = u_xlat8.xy + vec2(0.5, 0.5);
    u_xlat14.xz = fract(u_xlat14.xz);
    u_xlat14.xz = u_xlat14.xz * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat8.xy = abs(u_xlat14.xz) * abs(u_xlat14.xz);
    u_xlat14.xz = -abs(u_xlat14.xz) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat14.xz = u_xlat14.xz * u_xlat8.xy;
    u_xlat6.xy = u_xlat10.xx * u_xlat14.xz;
    u_xlat14.xz = u_xlat6.zz * u_xlat6.xz;
    u_xlat10.x = u_xlat6.y * u_xlat14.z;
    u_xlat6.xy = u_xlat10.xx * vec2(0.0848399997, 0.0848399997);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat14.xxx;
    u_xlat1.xy = u_xlat1.xy * u_xlat14.xx;
    u_xlat10.x = _MiHoYoWind.w * _WindParams0.x;
    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _WindParams2.zzz;
    u_xlat14.xz = u_xlat1.xy * u_xlat10.xx + u_xlat2.xz;
    u_xlat1.xz = u_xlat10.xx * u_xlat1.xy;
    u_xlat14.xz = u_xlat6.xy * _WindParams2.ww + u_xlat14.xz;
    u_xlat10.xy = u_xlat20.xy * u_xlat6.zz + u_xlat14.xz;
    u_xlat30 = -0.200000003 * unity_Builtins0Array[u_xlati31 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat6.xyz = vec3(u_xlat30) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat10.xxx + u_xlat6.xyz;
    u_xlat10.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat10.yyy + u_xlat6.xyz;
    u_xlat10.xyz = u_xlat10.xyz * vec3(100.0, 100.0, 100.0);
    u_xlat10.xyz = floor(u_xlat10.xyz);
    u_xlat4.xy = (-u_xlat4.xz) + u_xlat5.xw;
    u_xlat5.xyw = (-u_xlat5.xyw) + _WorldSpaceCameraPos.xyz;
    u_xlat6.x = u_xlat4.x * _Height.y + unity_Builtins0Array[u_xlati31 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat6.y = u_xlat4.y * _Height.y + unity_Builtins0Array[u_xlati31 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat4.xy = -abs(u_xlat6.xy) * _Height.zz + vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat6.x = unity_Builtins0Array[u_xlati31 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat6.y = unity_Builtins0Array[u_xlati31 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat4.xy = u_xlat4.xy * u_xlat6.xy;
    u_xlatb24.xy = greaterThanEqual(u_xlat6.xyxy, vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat4.x = (u_xlatb24.x) ? float(1.0) : u_xlat4.x;
    u_xlat4.y = (u_xlatb24.y) ? float(1.0) : u_xlat4.y;
    u_xlat4.w = u_xlat4.y + u_xlat4.x;
    u_xlat4.xyz = u_xlat4.www * vec3(0.5, 0.5, 0.5);
    u_xlat3 = u_xlat3 * u_xlat4 + u_xlat7;
    u_xlat10.xyz = u_xlat10.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat3.xyz;
    u_xlat4 = u_xlat10.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat4 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat10.xxxx + u_xlat4;
    u_xlat10.x = u_xlat10.z + 0.649999976;
    u_xlat4 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat10.xxxx + u_xlat4;
    u_xlat3 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat3.wwww + u_xlat4;
    gl_Position = u_xlat3;
    u_xlat16_4 = _Color + (-_Color2);
    u_xlat16_4 = unity_Builtins0Array[u_xlati31 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].wwww * u_xlat16_4 + _Color2;
    u_xlat16_6 = _LowLODColor + (-_LowLODColor2);
    u_xlat16_6 = unity_Builtins0Array[u_xlati31 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].wwww * u_xlat16_6 + _LowLODColor2;
    u_xlat16_4 = u_xlat16_4 + (-u_xlat16_6);
    u_xlat16_4 = u_xlat5.zzzz * u_xlat16_4 + u_xlat16_6;
    u_xlat10.x = -0.600000024 + unity_Builtins0Array[u_xlati31 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_9.x = u_xlat10.x * 1.875 + 1.0;
    u_xlat10.x = u_xlat10.x * 0.0249999985;
    u_xlat6 = u_xlat16_4 * u_xlat16_9.xxxx + u_xlat10.xxxx;
    u_xlat16_6 = (-u_xlat16_4) + u_xlat6;
    u_xlat16_4 = vec4(u_xlat0) * u_xlat16_6 + u_xlat16_4;
    u_xlat16_9.x = u_xlat0 * _SpecularExtra.x;
    u_xlat16_0 = u_xlat16_4 * _BaseSpeculars.xxxx;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat2.xyz * _WindParams0.www + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _WindParams0.zzz + unity_Builtins0Array[u_xlati31 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = max(u_xlat31, 0.00100000005);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat1.xyz = vec3(u_xlat31) * u_xlat1.xyz;
    u_xlat31 = dot(u_xlat5.xyw, u_xlat5.xyw);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat2.xyz = vec3(u_xlat31) * u_xlat5.xyw;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(u_xlat31<0.0);
#else
    u_xlatb32 = u_xlat31<0.0;
#endif
    u_xlat16_19 = u_xlat31;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_19 = (-u_xlat16_19) + 1.00010002;
    u_xlat16_19 = log2(u_xlat16_19);
    u_xlat16_19 = u_xlat16_19 * _BaseSpeculars.w;
    u_xlat16_19 = exp2(u_xlat16_19);
    u_xlat31 = _BaseSpeculars.z * u_xlat16_19 + -0.5;
    u_xlat31 = max(u_xlat31, 0.0);
    u_xlat5.xyz = (bool(u_xlatb32)) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat11 = dot((-u_xlat2.xyz), u_xlat5.xyz);
    u_xlat11 = u_xlat11 + u_xlat11;
    u_xlat11 = u_xlat5.y * (-u_xlat11) + (-u_xlat2.y);
    u_xlat11 = u_xlat11 + (-_WorldSpaceLightPos0.y);
    u_xlat7.y = u_xlat16_9.x * u_xlat11 + _WorldSpaceLightPos0.y;
    u_xlat7.xz = _WorldSpaceLightPos0.xz;
    u_xlat16_9.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
    u_xlat16_9.xyz = u_xlat7.xyz * u_xlat16_9.xxx + u_xlat2.xyz;
    u_xlat16_39 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_39 = inversesqrt(u_xlat16_39);
    u_xlat16_9.xyz = vec3(u_xlat16_39) * u_xlat16_9.xyz;
    u_xlat16_39 = dot(u_xlat16_9.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_39 = min(max(u_xlat16_39, 0.0), 1.0);
#else
    u_xlat16_39 = clamp(u_xlat16_39, 0.0, 1.0);
#endif
    u_xlat11 = dot(u_xlat16_9.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_9.x = u_xlat11 * u_xlat11;
    u_xlat16_19 = (-u_xlat16_39) + 1.0;
    u_xlat16_29 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_39 = u_xlat16_29 * u_xlat16_19;
    u_xlat16_19 = (-u_xlat16_19) * u_xlat16_29 + 1.0;
    u_xlat16_0 = vec4(u_xlat16_19) * u_xlat16_0 + vec4(u_xlat16_39);
    u_xlat11 = in_POSITION0.y * _Height.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.0<u_xlat11);
#else
    u_xlatb11 = 0.0<u_xlat11;
#endif
    u_xlat11 = (u_xlatb11) ? 1.0 : 0.5;
    u_xlat16_19 = u_xlat11 * u_xlat31;
    u_xlat16_2 = u_xlat16_4 * vec4(u_xlat16_19);
    u_xlat16_2 = u_xlat16_2 * _LightColor0;
    u_xlat11 = (-_BaseSpeculars.y) + 1.0;
    u_xlat11 = u_xlat11 * u_xlat11;
    u_xlat16_19 = u_xlat11 * u_xlat11;
    u_xlat16_29 = u_xlat16_19 * u_xlat16_19 + -1.0;
    u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
    u_xlat16_19 = u_xlat16_19 * 0.5;
    u_xlat16_9.x = u_xlat16_9.x * u_xlat16_29 + 1.0;
    u_xlat16_9.x = u_xlat16_9.x * u_xlat16_9.x + 9.99999975e-05;
    u_xlat16_9.x = float(1.0) / float(u_xlat16_9.x);
    u_xlat16_9.x = u_xlat16_9.x * u_xlat16_19;
    u_xlat16_9.x = u_xlat1.x * u_xlat16_9.x;
    u_xlat16_9.x = min(u_xlat16_9.x, 16.0);
    u_xlat16_0 = u_xlat16_9.xxxx * u_xlat16_0 + u_xlat16_2;
    vs_TEXCOORD0 = u_xlat16_0 * _LightColor0;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat1.x = u_xlat3.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat3.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat3.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy).x;
    SV_Target0 = vs_TEXCOORD0 * vec4(u_xlat10_0) + vs_TEXCOORD1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MIHOYO_GRASS_ELEMENT_VIEW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _MiHoYoTimeScale;
uniform 	mediump vec4 _WindParams0;
uniform 	mediump vec4 _WindParams1;
uniform 	mediump vec4 _WindParams2;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _Height;
uniform 	mediump vec4 _DistanceCoeff;
uniform 	mediump vec4 _DistanceConst;
uniform 	vec4 _Pos;
in highp vec4 in_POSITION0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat7;
float u_xlat9;
void main()
{
    u_xlat0 = _Pos + vec4(-0.0, -0.0, -0.0, -1.0);
    u_xlat0.x = dot(u_xlat0, u_xlat0);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * _DistanceCoeff.xy + _DistanceConst.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.z = min(u_xlat0.y, u_xlat0.x);
    u_xlat1.y = u_xlat0.z * in_POSITION0.y;
    u_xlat1.xz = in_POSITION0.xz;
    u_xlat1.w = 0.0;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat2.xy = u_xlat1.yy * hlslcc_mtx4x4unity_MatrixInvV[1].xz;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixInvV[0].xz * u_xlat1.xx + u_xlat2.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixInvV[2].xz * u_xlat1.zz + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixInvV[3].xz * u_xlat1.ww + u_xlat1.xy;
    u_xlat9 = dot(u_xlat1.xy, _MiHoYoWind.xz);
    u_xlat9 = (-u_xlat9) * _WindParams0.y;
    u_xlat9 = _Time.y * _WindParams2.x + u_xlat9;
    u_xlat1.x = u_xlat9 + _WindParams2.y;
    u_xlat1.y = _Time.y * _MiHoYoTimeScale.x + _MiHoYoTimeScale.y;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat7.xy = abs(u_xlat1.xy) * abs(u_xlat1.xy);
    u_xlat1.xy = -abs(u_xlat1.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat1.xy = u_xlat1.xy * u_xlat7.xy;
    u_xlat9 = in_POSITION0.y * _Height.x;
    u_xlat9 = log2(u_xlat9);
    u_xlat9 = u_xlat9 * 1.10000002;
    u_xlat9 = exp2(u_xlat9);
    u_xlat0.xy = u_xlat1.xy * vec2(u_xlat9);
    u_xlat9 = u_xlat9 * _MiHoYoWind.w;
    u_xlat9 = u_xlat9 * _WindParams1.x + 1.0;
    u_xlat9 = u_xlat9 * u_xlat9 + (-u_xlat9);
    u_xlat1.xy = vec2(u_xlat9) * _MiHoYoWind.xz;
    u_xlat0.xw = u_xlat0.zz * u_xlat0.xz;
    u_xlat3.x = u_xlat0.y * u_xlat0.w;
    u_xlat3.x = u_xlat3.x * 0.0848399997;
    u_xlat2.x = float(0.0);
    u_xlat2.w = float(0.0);
    u_xlat2.yz = _MiHoYoWind.xz;
    u_xlat7.xy = vec2((-u_xlat2.x) + u_xlat2.z, (-u_xlat2.y) + u_xlat2.w);
    u_xlat7.xy = u_xlat0.xx * u_xlat7.xy;
    u_xlat0.xw = u_xlat0.xx * _MiHoYoWind.xz;
    u_xlat2.x = _MiHoYoWind.w * _WindParams0.x;
    u_xlat7.xy = u_xlat7.xy * u_xlat2.xx;
    u_xlat7.xy = u_xlat7.xy * _WindParams2.zz;
    u_xlat0.xw = u_xlat0.xw * u_xlat2.xx + u_xlat7.xy;
    u_xlat0.xy = u_xlat3.xx * _WindParams2.ww + u_xlat0.xw;
    u_xlat0.xy = u_xlat1.xy * u_xlat0.zz + u_xlat0.xy;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[2].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(100.0, 100.0, 100.0);
    u_xlat0.xyz = floor(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + hlslcc_mtx4x4unity_MatrixV[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0.x = u_xlat0.z + 0.649999976;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * hlslcc_mtx4x4unity_MatrixV[3].wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = _Color2;
    vs_TEXCOORD1 = _Color2 * vec4(1.0, 1.0, 1.0, 5.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy).x;
    SV_Target0 = vs_TEXCOORD0 * vec4(u_xlat10_0) + vs_TEXCOORD1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MIHOYO_GRASS_ELEMENT_VIEW" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _MiHoYoTimeScale;
uniform 	mediump vec4 _WindParams0;
uniform 	mediump vec4 _WindParams1;
uniform 	mediump vec4 _WindParams2;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _BurnedColor;
uniform 	mediump vec4 _Height;
uniform 	mediump vec4 _DistanceCoeff;
uniform 	mediump vec4 _DistanceConst;
uniform 	vec4 _Pos;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
bvec2 u_xlatb2;
mediump vec4 u_xlat16_3;
int u_xlati3;
vec4 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
vec3 u_xlat9;
vec3 u_xlat10;
float u_xlat14;
vec2 u_xlat16;
bvec2 u_xlatb16;
float u_xlat21;
float u_xlat23;
bool u_xlatb23;
void main()
{
    u_xlat0.x = 0.0;
    u_xlat0.z = _MiHoYoWind.x;
    u_xlat1.x = _MiHoYoWind.z;
    u_xlat1.z = float(0.0);
    u_xlat1.w = float(0.0);
    u_xlat0.xy = (-u_xlat0.xz) + u_xlat1.xz;
    u_xlat14 = in_POSITION0.y * _Height.x;
    u_xlat14 = log2(u_xlat14);
    u_xlat14 = u_xlat14 * 1.10000002;
    u_xlat14 = exp2(u_xlat14);
    u_xlat21 = _WindParams1.y * 0.100000001;
    u_xlat1.xz = in_POSITION0.xz;
    u_xlat2.w = 1.0;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 3;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat4 = (-u_xlat2) + _Pos;
    u_xlat9.x = dot(u_xlat4, u_xlat4);
    u_xlat9.x = sqrt(u_xlat9.x);
    u_xlat9.xz = u_xlat9.xx * _DistanceCoeff.xy + _DistanceConst.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.xz = min(max(u_xlat9.xz, 0.0), 1.0);
#else
    u_xlat9.xz = clamp(u_xlat9.xz, 0.0, 1.0);
#endif
    u_xlat4.z = min(u_xlat9.z, u_xlat9.x);
    u_xlat9.x = u_xlat4.z * in_POSITION0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x>=0.0);
#else
    u_xlatb23 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x>=0.0;
#endif
    u_xlat23 = u_xlatb23 ? 1.0 : float(0.0);
    u_xlat1.y = u_xlat23 * u_xlat9.x;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[1] * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0] * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2] * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat5;
    u_xlat5 = u_xlat5 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat6 = u_xlat1 + u_xlat5;
    u_xlat9.xz = u_xlat6.yy * hlslcc_mtx4x4unity_MatrixInvV[1].xz;
    u_xlat9.xz = hlslcc_mtx4x4unity_MatrixInvV[0].xz * u_xlat6.xx + u_xlat9.xz;
    u_xlat9.xz = hlslcc_mtx4x4unity_MatrixInvV[2].xz * u_xlat6.zz + u_xlat9.xz;
    u_xlat9.xz = hlslcc_mtx4x4unity_MatrixInvV[3].xz * u_xlat6.ww + u_xlat9.xz;
    u_xlat10.x = dot(u_xlat9.xz, _MiHoYoWind.xz);
    u_xlat2.xy = (-u_xlat2.xz) + u_xlat9.xz;
    u_xlat16.x = (-u_xlat10.x) * _WindParams0.y;
    u_xlat16.x = _Time.y * _WindParams2.x + u_xlat16.x;
    u_xlat23 = 6.28299999 * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
    u_xlat21 = u_xlat23 * u_xlat21 + u_xlat16.x;
    u_xlat16.x = _Time.y * _MiHoYoTimeScale.x + u_xlat23;
    u_xlat6.y = u_xlat16.x + _MiHoYoTimeScale.y;
    u_xlat6.x = u_xlat21 + _WindParams2.y;
    u_xlat16.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16.xy = fract(u_xlat16.xy);
    u_xlat16.xy = u_xlat16.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat10.xy = abs(u_xlat16.xy) * abs(u_xlat16.xy);
    u_xlat16.xy = -abs(u_xlat16.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat16.xy = u_xlat16.xy * u_xlat10.xy;
    u_xlat4.xy = vec2(u_xlat14) * u_xlat16.xy;
    u_xlat14 = u_xlat14 * _MiHoYoWind.w;
    u_xlat14 = u_xlat14 * _WindParams1.x + 1.0;
    u_xlat14 = u_xlat14 * u_xlat14 + (-u_xlat14);
    u_xlat16.xy = u_xlat4.zz * u_xlat4.xz;
    u_xlat21 = u_xlat4.y * u_xlat16.y;
    u_xlat10.xy = vec2(u_xlat21) * vec2(0.0848399997, 0.0848399997);
    u_xlat0.xy = u_xlat0.xy * u_xlat16.xx;
    u_xlat21 = _MiHoYoWind.w * _WindParams0.x;
    u_xlat0.xy = vec2(u_xlat21) * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * _WindParams2.zz;
    u_xlat4.xy = _MiHoYoWind.xz;
    u_xlat16.xy = u_xlat16.xx * u_xlat4.xy;
    u_xlat4.xy = vec2(u_xlat14) * u_xlat4.xy;
    u_xlat0.xy = u_xlat16.xy * vec2(u_xlat21) + u_xlat0.xy;
    u_xlat0.xy = u_xlat10.xy * _WindParams2.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat4.xy * u_xlat4.zz + u_xlat0.xy;
    u_xlat14 = -0.200000003 * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat10.xyz = vec3(u_xlat14) * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xzw = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat10.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(100.0, 100.0, 100.0);
    u_xlat0.xyz = floor(u_xlat0.xyz);
    u_xlat4.x = u_xlat2.x * _Height.y + unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat4.y = u_xlat2.y * _Height.y + unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat2.xy = -abs(u_xlat4.xy) * _Height.zz + vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
#else
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
#endif
    u_xlat4.x = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat4.y = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat2.xy = u_xlat2.xy * u_xlat4.xy;
    u_xlatb16.xy = greaterThanEqual(u_xlat4.xyxy, vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat2.x = (u_xlatb16.x) ? float(1.0) : u_xlat2.x;
    u_xlat2.y = (u_xlatb16.y) ? float(1.0) : u_xlat2.y;
    u_xlat2.w = u_xlat2.y + u_xlat2.x;
    u_xlat2.xyz = u_xlat2.www * vec3(0.5, 0.5, 0.5);
    u_xlat1 = u_xlat1 * u_xlat2 + u_xlat5;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0.x = u_xlat0.z + 0.649999976;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat16_1 = _Color + (-_Color2);
    u_xlat16_1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].wwww * u_xlat16_1 + _Color2;
    u_xlat2.x = floor(abs(unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x));
    u_xlatb2.xy = equal(u_xlat2.xxxx, vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat16_3 = (u_xlatb2.y) ? _BurnedColor : vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_1 = (u_xlatb2.x) ? u_xlat16_1 : u_xlat16_3;
    vs_TEXCOORD0 = u_xlat16_1;
    vs_TEXCOORD1 = u_xlat16_1 * vec4(1.0, 1.0, 1.0, 5.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform lowp sampler2D _ShadowMapTexture;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy).x;
    SV_Target0 = vs_TEXCOORD0 * vec4(u_xlat10_0) + vs_TEXCOORD1;
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
Keywords { "MIHOYO_GRASS_ELEMENT_VIEW" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MIHOYO_GRASS_ELEMENT_VIEW" }
""
}
}
}
 Pass {
  LOD 100
  Tags { "LIGHTMODE" = "DepthOnly" "QUEUE" = "AlphaTest-1" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 92335
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
vec4 u_xlat0;
float u_xlat1;
void main()
{
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[1] * hlslcc_mtx4x4unity_MatrixV[3].yyyy;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * hlslcc_mtx4x4unity_MatrixV[3].xxxx + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3].z + 0.649999976;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * vec4(u_xlat1) + u_xlat0;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * hlslcc_mtx4x4unity_MatrixV[3].wwww + u_xlat0;
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
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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

uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _Height;
uniform 	mediump vec4 _DistanceCoeff;
uniform 	mediump vec4 _DistanceConst;
uniform 	vec4 _Pos;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
float u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 3;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2 = (-u_xlat0) + _Pos;
    u_xlat5.x = dot(u_xlat2, u_xlat2);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat5.xz = u_xlat5.xx * _DistanceCoeff.xy + _DistanceConst.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xz = min(max(u_xlat5.xz, 0.0), 1.0);
#else
    u_xlat5.xz = clamp(u_xlat5.xz, 0.0, 1.0);
#endif
    u_xlat5.x = min(u_xlat5.z, u_xlat5.x);
    u_xlat5.x = u_xlat5.x * in_POSITION0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x>=0.0);
#else
    u_xlatb15 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x>=0.0;
#endif
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
    u_xlat2.y = u_xlat15 * u_xlat5.x;
    u_xlat2.xz = in_POSITION0.xz;
    u_xlat2.w = 0.0;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[1] * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat3;
    u_xlat3 = u_xlat3 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat4 = u_xlat2 + u_xlat3;
    u_xlat5.xz = u_xlat4.yy * hlslcc_mtx4x4unity_MatrixInvV[1].xz;
    u_xlat5.xz = hlslcc_mtx4x4unity_MatrixInvV[0].xz * u_xlat4.xx + u_xlat5.xz;
    u_xlat5.xz = hlslcc_mtx4x4unity_MatrixInvV[2].xz * u_xlat4.zz + u_xlat5.xz;
    u_xlat5.xz = hlslcc_mtx4x4unity_MatrixInvV[3].xz * u_xlat4.ww + u_xlat5.xz;
    u_xlat0.xy = (-u_xlat0.xz) + u_xlat5.xz;
    u_xlat4.x = u_xlat0.x * _Height.y + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat4.y = u_xlat0.y * _Height.y + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat0.xy = -abs(u_xlat4.xy) * _Height.zz + vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat4.x = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat4.y = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat10 = -0.200000003 * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat0.xy = u_xlat0.xy * u_xlat4.xy;
    u_xlatb1.xy = greaterThanEqual(u_xlat4.xyxx, vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = (u_xlatb1.x) ? float(1.0) : u_xlat0.x;
    u_xlat0.y = (u_xlatb1.y) ? float(1.0) : u_xlat0.y;
    u_xlat1.w = u_xlat0.y + u_xlat0.x;
    u_xlat1.xyz = u_xlat1.www * vec3(0.5, 0.5, 0.5);
    u_xlat1 = u_xlat2 * u_xlat1 + u_xlat3;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0.x = u_xlat0.z + 0.649999976;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.xxxx + u_xlat2;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat1.wwww + u_xlat0;
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
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
  LOD 100
  Tags { "DebugView" = "On" "LIGHTMODE" = "HYBRIDDEFERRED" "QUEUE" = "AlphaTest-1" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 148201
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _BaseSpeculars;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _LowLODColor2;
uniform 	mediump vec4 _Height;
uniform 	mediump vec4 _DistanceCoeff;
uniform 	mediump vec4 _DistanceConst;
uniform 	vec4 _Pos;
in highp vec4 in_POSITION0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_7;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[1] * hlslcc_mtx4x4unity_MatrixV[3].yyyy;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * hlslcc_mtx4x4unity_MatrixV[3].xxxx + u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z + 0.649999976;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * hlslcc_mtx4x4unity_MatrixV[3].wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1 = _Pos + vec4(-0.0, -0.0, -0.0, -1.0);
    u_xlat1.x = dot(u_xlat1, u_xlat1);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _DistanceCoeff.z + _DistanceConst.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_2 = _Color2 + (-_LowLODColor2);
    u_xlat16_1 = u_xlat1.xxxx * u_xlat16_2 + _LowLODColor2;
    vs_TEXCOORD0 = u_xlat16_1;
    u_xlat16_2.x = _BaseSpeculars.w * 0.000144286227;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat3.x = _BaseSpeculars.z * u_xlat16_2.x + -0.5;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat8 = in_POSITION0.y * _Height.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.0<u_xlat8);
#else
    u_xlatb8 = 0.0<u_xlat8;
#endif
    u_xlat8 = (u_xlatb8) ? 1.0 : 0.5;
    u_xlat16_2.x = u_xlat8 * u_xlat3.x;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
    vs_TEXCOORD1.w = u_xlat16_2.x;
    u_xlat16_4.xyz = _LightColor0.xyz * _LightColor0.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_7.xyz * u_xlat16_4.xyz;
    vs_TEXCOORD3.xyz = vec3(0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat3.zz + u_xlat3.xw;
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
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0117647061;
    SV_Target1.xyz = vs_TEXCOORD0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : vs_TEXCOORD1.z;
    SV_Target2.xyw = vs_TEXCOORD1.xyw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _BaseSpeculars;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _LowLODColor;
uniform 	mediump vec4 _LowLODColor2;
uniform 	mediump vec4 _Height;
uniform 	mediump vec4 _SpecularExtra;
uniform 	mediump vec4 _DistanceCoeff;
uniform 	mediump vec4 _DistanceConst;
uniform 	vec4 _Pos;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat9;
vec3 u_xlat10;
vec3 u_xlat12;
bool u_xlatb12;
mediump float u_xlat16_14;
mediump vec3 u_xlat16_15;
bvec2 u_xlatb17;
mediump float u_xlat16_22;
float u_xlat25;
bool u_xlatb25;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.xz = in_POSITION0.xz;
    u_xlat0.w = 0.0;
    u_xlat1.w = 1.0;
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat3 = (-u_xlat1) + _Pos;
    u_xlat9 = dot(u_xlat3, u_xlat3);
    u_xlat9 = sqrt(u_xlat9);
    u_xlat10.xyz = vec3(u_xlat9) * _DistanceCoeff.xyz + _DistanceConst.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.xyz = min(max(u_xlat10.xyz, 0.0), 1.0);
#else
    u_xlat10.xyz = clamp(u_xlat10.xyz, 0.0, 1.0);
#endif
    u_xlat9 = min(u_xlat10.y, u_xlat10.x);
    u_xlat9 = u_xlat9 * in_POSITION0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x>=0.0);
#else
    u_xlatb25 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x>=0.0;
#endif
    u_xlat25 = u_xlatb25 ? 1.0 : float(0.0);
    u_xlat0.y = u_xlat25 * u_xlat9;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[1] * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat3;
    u_xlat3 = u_xlat3 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat4 = u_xlat0 + u_xlat3;
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_MatrixInvV[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_MatrixInvV[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixInvV[2].xyz * u_xlat4.zzz + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixInvV[3].xyz * u_xlat4.www + u_xlat4.xyz;
    u_xlat1.xy = (-u_xlat1.xz) + u_xlat4.xz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5.x = u_xlat1.x * _Height.y + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat5.y = u_xlat1.y * _Height.y + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat1.xy = -abs(u_xlat5.xy) * _Height.zz + vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat5.x = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat5.y = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat1.xy = u_xlat1.xy * u_xlat5.xy;
    u_xlatb17.xy = greaterThanEqual(u_xlat5.xyxy, vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat1.x = (u_xlatb17.x) ? float(1.0) : u_xlat1.x;
    u_xlat1.y = (u_xlatb17.y) ? float(1.0) : u_xlat1.y;
    u_xlat1.w = u_xlat1.y + u_xlat1.x;
    u_xlat1.xyz = u_xlat1.www * vec3(0.5, 0.5, 0.5);
    u_xlat0 = u_xlat0 * u_xlat1 + u_xlat3;
    u_xlat1.x = -0.200000003 * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0.x = u_xlat0.z + 0.649999976;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat16_1 = _Color + (-_Color2);
    u_xlat16_1 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].wwww * u_xlat16_1 + _Color2;
    u_xlat16_3 = _LowLODColor + (-_LowLODColor2);
    u_xlat16_3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].wwww * u_xlat16_3 + _LowLODColor2;
    u_xlat16_1 = u_xlat16_1 + (-u_xlat16_3);
    u_xlat16_1 = u_xlat10.zzzz * u_xlat16_1 + u_xlat16_3;
    u_xlat10.x = -0.600000024 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat10.x * 1.875 + 1.0;
    u_xlat10.x = u_xlat10.x * 0.0249999985;
    u_xlat3 = u_xlat16_1 * u_xlat16_6.xxxx + u_xlat10.xxxx;
    u_xlat16_3 = (-u_xlat16_1) + u_xlat3;
    u_xlat10.x = in_POSITION0.y * _Height.x;
    u_xlat10.x = u_xlat10.x * 8.0 + -5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat10.xxxx * u_xlat16_3 + u_xlat16_1;
    u_xlat16_6.x = u_xlat10.x * _SpecularExtra.x;
    vs_TEXCOORD0 = u_xlat16_1;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat4.x = dot(u_xlat10.xyz, unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat4.x<0.0);
#else
    u_xlatb12 = u_xlat4.x<0.0;
#endif
    u_xlat16_14 = u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_14 = (-u_xlat16_14) + 1.00010002;
    u_xlat16_14 = log2(u_xlat16_14);
    u_xlat16_14 = u_xlat16_14 * _BaseSpeculars.w;
    u_xlat16_14 = exp2(u_xlat16_14);
    u_xlat4.x = _BaseSpeculars.z * u_xlat16_14 + -0.5;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat12.xyz = (bool(u_xlatb12)) ? u_xlat10.xyz : unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat5.x = dot((-u_xlat10.xyz), u_xlat12.xyz);
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
    u_xlat5.x = u_xlat12.y * (-u_xlat5.x) + (-u_xlat10.y);
    u_xlat5.x = u_xlat5.x + (-_WorldSpaceLightPos0.y);
    u_xlat5.y = u_xlat16_6.x * u_xlat5.x + _WorldSpaceLightPos0.y;
    u_xlat5.xz = _WorldSpaceLightPos0.xz;
    u_xlat16_6.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat16_6.x = inversesqrt(u_xlat16_6.x);
    u_xlat16_6.xyz = u_xlat5.xyz * u_xlat16_6.xxx + u_xlat10.xyz;
    u_xlat16_30 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat12.x = dot(u_xlat16_6.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = dot(u_xlat16_6.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_14 = u_xlat12.x * u_xlat12.x;
    u_xlat10.x = (-_BaseSpeculars.y) + 1.0;
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat16_22 = u_xlat10.x * u_xlat10.x;
    u_xlat16_30 = u_xlat16_22 * u_xlat16_22 + -1.0;
    u_xlat16_22 = u_xlat16_22 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_22 * 0.5;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_30 + 1.0;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_14 + 9.99999975e-05;
    u_xlat16_14 = float(1.0) / float(u_xlat16_14);
    u_xlat16_14 = u_xlat16_14 * u_xlat16_22;
    u_xlat10.x = dot(unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3.xyz = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat16_14 = u_xlat10.x * u_xlat16_14;
    u_xlat16_14 = min(u_xlat16_14, 16.0);
    u_xlat16_22 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_22 = u_xlat16_22 * u_xlat16_22;
    u_xlat16_30 = u_xlat16_22 * u_xlat16_6.x;
    u_xlat16_6.x = (-u_xlat16_6.x) * u_xlat16_22 + 1.0;
    u_xlat16_7.xyz = u_xlat16_1.xyz * _BaseSpeculars.xxx;
    u_xlat16_6.xzw = u_xlat16_6.xxx * u_xlat16_7.xyz + vec3(u_xlat16_30);
    u_xlat2.x = in_POSITION0.y * _Height.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<u_xlat2.x);
#else
    u_xlatb2 = 0.0<u_xlat2.x;
#endif
    u_xlat2.x = (u_xlatb2) ? 1.0 : 0.5;
    u_xlat16_7.x = u_xlat2.x * u_xlat4.x;
    u_xlat16_15.xyz = u_xlat16_1.xyz * u_xlat16_7.xxx;
    vs_TEXCOORD1.w = u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_15.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_14) * u_xlat16_6.xzw + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_6.xyz * _LightColor0.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
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
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0117647061;
    SV_Target1.xyz = vs_TEXCOORD0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : vs_TEXCOORD1.z;
    SV_Target2.xyw = vs_TEXCOORD1.xyw;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MIHOYO_GRASS_ELEMENT_VIEW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color2;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[1] * hlslcc_mtx4x4unity_MatrixV[3].yyyy;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * hlslcc_mtx4x4unity_MatrixV[3].xxxx + u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z + 0.649999976;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * hlslcc_mtx4x4unity_MatrixV[3].wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = _Color2;
    vs_TEXCOORD1 = _Color2 * vec4(1.0, 1.0, 1.0, 5.0);
    vs_TEXCOORD3.xyz = vec3(0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0274509806;
    SV_Target1.xyz = vs_TEXCOORD0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : vs_TEXCOORD1.z;
    u_xlat16_0 = vs_TEXCOORD1.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_0 = sqrt(u_xlat16_0);
    SV_Target2.w = u_xlat16_0;
    SV_Target2.xy = vs_TEXCOORD1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MIHOYO_GRASS_ELEMENT_VIEW" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _BurnedColor;
uniform 	mediump vec4 _Height;
uniform 	mediump vec4 _DistanceCoeff;
uniform 	mediump vec4 _DistanceConst;
uniform 	vec4 _Pos;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
int u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
bvec2 u_xlatb10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 3;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2 = (-u_xlat0) + _Pos;
    u_xlat5.x = dot(u_xlat2, u_xlat2);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat5.xz = u_xlat5.xx * _DistanceCoeff.xy + _DistanceConst.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xz = min(max(u_xlat5.xz, 0.0), 1.0);
#else
    u_xlat5.xz = clamp(u_xlat5.xz, 0.0, 1.0);
#endif
    u_xlat5.x = min(u_xlat5.z, u_xlat5.x);
    u_xlat5.x = u_xlat5.x * in_POSITION0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x>=0.0);
#else
    u_xlatb15 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x>=0.0;
#endif
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
    u_xlat2.y = u_xlat15 * u_xlat5.x;
    u_xlat2.xz = in_POSITION0.xz;
    u_xlat2.w = 0.0;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[1] * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat3;
    u_xlat3 = u_xlat3 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat4 = u_xlat2 + u_xlat3;
    u_xlat5.xz = u_xlat4.yy * hlslcc_mtx4x4unity_MatrixInvV[1].xz;
    u_xlat5.xz = hlslcc_mtx4x4unity_MatrixInvV[0].xz * u_xlat4.xx + u_xlat5.xz;
    u_xlat5.xz = hlslcc_mtx4x4unity_MatrixInvV[2].xz * u_xlat4.zz + u_xlat5.xz;
    u_xlat5.xz = hlslcc_mtx4x4unity_MatrixInvV[3].xz * u_xlat4.ww + u_xlat5.xz;
    u_xlat0.xy = (-u_xlat0.xz) + u_xlat5.xz;
    u_xlat4.x = u_xlat0.x * _Height.y + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat4.y = u_xlat0.y * _Height.y + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat0.xy = -abs(u_xlat4.xy) * _Height.zz + vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat4.x = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat4.y = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat0.xy = u_xlat0.xy * u_xlat4.xy;
    u_xlatb10.xy = greaterThanEqual(u_xlat4.xyxy, vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb10.x) ? float(1.0) : u_xlat0.x;
    u_xlat0.y = (u_xlatb10.y) ? float(1.0) : u_xlat0.y;
    u_xlat0.w = u_xlat0.y + u_xlat0.x;
    u_xlat0.xyz = u_xlat0.www * vec3(0.5, 0.5, 0.5);
    u_xlat0 = u_xlat2 * u_xlat0 + u_xlat3;
    u_xlat6 = -0.200000003 * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * vec3(u_xlat6) + u_xlat0.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0.x = u_xlat0.z + 0.649999976;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat2;
    gl_Position = u_xlat0;
    u_xlat16_2 = _Color + (-_Color2);
    u_xlat16_2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].wwww * u_xlat16_2 + _Color2;
    u_xlat6 = floor(abs(unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x));
    vs_TEXCOORD3.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlatb1.xy = equal(vec4(u_xlat6), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat16_3 = (u_xlatb1.y) ? _BurnedColor : vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_1 = (u_xlatb1.x) ? u_xlat16_2 : u_xlat16_3;
    vs_TEXCOORD0 = u_xlat16_1;
    vs_TEXCOORD1 = u_xlat16_1 * vec4(1.0, 1.0, 1.0, 5.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat4.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat4.zz + u_xlat4.xw;
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
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0274509806;
    SV_Target1.xyz = vs_TEXCOORD0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : vs_TEXCOORD1.z;
    u_xlat16_0 = vs_TEXCOORD1.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_0 = sqrt(u_xlat16_0);
    SV_Target2.w = u_xlat16_0;
    SV_Target2.xy = vs_TEXCOORD1.xy;
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
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _BaseSpeculars;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _LowLODColor2;
uniform 	mediump vec4 _Height;
uniform 	mediump vec4 _DistanceCoeff;
uniform 	mediump vec4 _DistanceConst;
uniform 	vec4 _Pos;
in highp vec4 in_POSITION0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_7;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[1] * hlslcc_mtx4x4unity_MatrixV[3].yyyy;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * hlslcc_mtx4x4unity_MatrixV[3].xxxx + u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z + 0.649999976;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * hlslcc_mtx4x4unity_MatrixV[3].wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1 = _Pos + vec4(-0.0, -0.0, -0.0, -1.0);
    u_xlat1.x = dot(u_xlat1, u_xlat1);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _DistanceCoeff.z + _DistanceConst.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_2 = _Color2 + (-_LowLODColor2);
    u_xlat16_1 = u_xlat1.xxxx * u_xlat16_2 + _LowLODColor2;
    vs_TEXCOORD0 = u_xlat16_1;
    u_xlat16_2.x = _BaseSpeculars.w * 0.000144286227;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat3.x = _BaseSpeculars.z * u_xlat16_2.x + -0.5;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat8 = in_POSITION0.y * _Height.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.0<u_xlat8);
#else
    u_xlatb8 = 0.0<u_xlat8;
#endif
    u_xlat8 = (u_xlatb8) ? 1.0 : 0.5;
    u_xlat16_2.x = u_xlat8 * u_xlat3.x;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
    vs_TEXCOORD1.w = u_xlat16_2.x;
    u_xlat16_4.xyz = _LightColor0.xyz * _LightColor0.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_7.xyz * u_xlat16_4.xyz;
    vs_TEXCOORD3.xyz = vec3(0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat3.zz + u_xlat3.xw;
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
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0117647061;
    SV_Target1.xyz = vs_TEXCOORD0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : vs_TEXCOORD1.z;
    SV_Target2.xyw = vs_TEXCOORD1.xyw;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _BaseSpeculars;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _LowLODColor;
uniform 	mediump vec4 _LowLODColor2;
uniform 	mediump vec4 _Height;
uniform 	mediump vec4 _SpecularExtra;
uniform 	mediump vec4 _DistanceCoeff;
uniform 	mediump vec4 _DistanceConst;
uniform 	vec4 _Pos;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat9;
vec3 u_xlat10;
vec3 u_xlat12;
bool u_xlatb12;
mediump float u_xlat16_14;
mediump vec3 u_xlat16_15;
bvec2 u_xlatb17;
mediump float u_xlat16_22;
float u_xlat25;
bool u_xlatb25;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.xz = in_POSITION0.xz;
    u_xlat0.w = 0.0;
    u_xlat1.w = 1.0;
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat3 = (-u_xlat1) + _Pos;
    u_xlat9 = dot(u_xlat3, u_xlat3);
    u_xlat9 = sqrt(u_xlat9);
    u_xlat10.xyz = vec3(u_xlat9) * _DistanceCoeff.xyz + _DistanceConst.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.xyz = min(max(u_xlat10.xyz, 0.0), 1.0);
#else
    u_xlat10.xyz = clamp(u_xlat10.xyz, 0.0, 1.0);
#endif
    u_xlat9 = min(u_xlat10.y, u_xlat10.x);
    u_xlat9 = u_xlat9 * in_POSITION0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x>=0.0);
#else
    u_xlatb25 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x>=0.0;
#endif
    u_xlat25 = u_xlatb25 ? 1.0 : float(0.0);
    u_xlat0.y = u_xlat25 * u_xlat9;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[1] * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat3;
    u_xlat3 = u_xlat3 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat4 = u_xlat0 + u_xlat3;
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_MatrixInvV[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_MatrixInvV[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixInvV[2].xyz * u_xlat4.zzz + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixInvV[3].xyz * u_xlat4.www + u_xlat4.xyz;
    u_xlat1.xy = (-u_xlat1.xz) + u_xlat4.xz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5.x = u_xlat1.x * _Height.y + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat5.y = u_xlat1.y * _Height.y + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat1.xy = -abs(u_xlat5.xy) * _Height.zz + vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat5.x = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat5.y = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat1.xy = u_xlat1.xy * u_xlat5.xy;
    u_xlatb17.xy = greaterThanEqual(u_xlat5.xyxy, vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat1.x = (u_xlatb17.x) ? float(1.0) : u_xlat1.x;
    u_xlat1.y = (u_xlatb17.y) ? float(1.0) : u_xlat1.y;
    u_xlat1.w = u_xlat1.y + u_xlat1.x;
    u_xlat1.xyz = u_xlat1.www * vec3(0.5, 0.5, 0.5);
    u_xlat0 = u_xlat0 * u_xlat1 + u_xlat3;
    u_xlat1.x = -0.200000003 * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0.x = u_xlat0.z + 0.649999976;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat16_1 = _Color + (-_Color2);
    u_xlat16_1 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].wwww * u_xlat16_1 + _Color2;
    u_xlat16_3 = _LowLODColor + (-_LowLODColor2);
    u_xlat16_3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].wwww * u_xlat16_3 + _LowLODColor2;
    u_xlat16_1 = u_xlat16_1 + (-u_xlat16_3);
    u_xlat16_1 = u_xlat10.zzzz * u_xlat16_1 + u_xlat16_3;
    u_xlat10.x = -0.600000024 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat10.x * 1.875 + 1.0;
    u_xlat10.x = u_xlat10.x * 0.0249999985;
    u_xlat3 = u_xlat16_1 * u_xlat16_6.xxxx + u_xlat10.xxxx;
    u_xlat16_3 = (-u_xlat16_1) + u_xlat3;
    u_xlat10.x = in_POSITION0.y * _Height.x;
    u_xlat10.x = u_xlat10.x * 8.0 + -5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat10.xxxx * u_xlat16_3 + u_xlat16_1;
    u_xlat16_6.x = u_xlat10.x * _SpecularExtra.x;
    vs_TEXCOORD0 = u_xlat16_1;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat4.x = dot(u_xlat10.xyz, unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat4.x<0.0);
#else
    u_xlatb12 = u_xlat4.x<0.0;
#endif
    u_xlat16_14 = u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_14 = (-u_xlat16_14) + 1.00010002;
    u_xlat16_14 = log2(u_xlat16_14);
    u_xlat16_14 = u_xlat16_14 * _BaseSpeculars.w;
    u_xlat16_14 = exp2(u_xlat16_14);
    u_xlat4.x = _BaseSpeculars.z * u_xlat16_14 + -0.5;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat12.xyz = (bool(u_xlatb12)) ? u_xlat10.xyz : unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat5.x = dot((-u_xlat10.xyz), u_xlat12.xyz);
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
    u_xlat5.x = u_xlat12.y * (-u_xlat5.x) + (-u_xlat10.y);
    u_xlat5.x = u_xlat5.x + (-_WorldSpaceLightPos0.y);
    u_xlat5.y = u_xlat16_6.x * u_xlat5.x + _WorldSpaceLightPos0.y;
    u_xlat5.xz = _WorldSpaceLightPos0.xz;
    u_xlat16_6.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat16_6.x = inversesqrt(u_xlat16_6.x);
    u_xlat16_6.xyz = u_xlat5.xyz * u_xlat16_6.xxx + u_xlat10.xyz;
    u_xlat16_30 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat12.x = dot(u_xlat16_6.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = dot(u_xlat16_6.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_14 = u_xlat12.x * u_xlat12.x;
    u_xlat10.x = (-_BaseSpeculars.y) + 1.0;
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat16_22 = u_xlat10.x * u_xlat10.x;
    u_xlat16_30 = u_xlat16_22 * u_xlat16_22 + -1.0;
    u_xlat16_22 = u_xlat16_22 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_22 * 0.5;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_30 + 1.0;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_14 + 9.99999975e-05;
    u_xlat16_14 = float(1.0) / float(u_xlat16_14);
    u_xlat16_14 = u_xlat16_14 * u_xlat16_22;
    u_xlat10.x = dot(unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3.xyz = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat16_14 = u_xlat10.x * u_xlat16_14;
    u_xlat16_14 = min(u_xlat16_14, 16.0);
    u_xlat16_22 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_22 = u_xlat16_22 * u_xlat16_22;
    u_xlat16_30 = u_xlat16_22 * u_xlat16_6.x;
    u_xlat16_6.x = (-u_xlat16_6.x) * u_xlat16_22 + 1.0;
    u_xlat16_7.xyz = u_xlat16_1.xyz * _BaseSpeculars.xxx;
    u_xlat16_6.xzw = u_xlat16_6.xxx * u_xlat16_7.xyz + vec3(u_xlat16_30);
    u_xlat2.x = in_POSITION0.y * _Height.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<u_xlat2.x);
#else
    u_xlatb2 = 0.0<u_xlat2.x;
#endif
    u_xlat2.x = (u_xlatb2) ? 1.0 : 0.5;
    u_xlat16_7.x = u_xlat2.x * u_xlat4.x;
    u_xlat16_15.xyz = u_xlat16_1.xyz * u_xlat16_7.xxx;
    vs_TEXCOORD1.w = u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_15.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_14) * u_xlat16_6.xzw + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_6.xyz * _LightColor0.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
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
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0117647061;
    SV_Target1.xyz = vs_TEXCOORD0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : vs_TEXCOORD1.z;
    SV_Target2.xyw = vs_TEXCOORD1.xyw;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_ELEMENT_VIEW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color2;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[1] * hlslcc_mtx4x4unity_MatrixV[3].yyyy;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * hlslcc_mtx4x4unity_MatrixV[3].xxxx + u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z + 0.649999976;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * hlslcc_mtx4x4unity_MatrixV[3].wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = _Color2;
    vs_TEXCOORD1 = _Color2 * vec4(1.0, 1.0, 1.0, 5.0);
    vs_TEXCOORD3.xyz = vec3(0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0274509806;
    SV_Target1.xyz = vs_TEXCOORD0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : vs_TEXCOORD1.z;
    u_xlat16_0 = vs_TEXCOORD1.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_0 = sqrt(u_xlat16_0);
    SV_Target2.w = u_xlat16_0;
    SV_Target2.xy = vs_TEXCOORD1.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_ELEMENT_VIEW" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _BurnedColor;
uniform 	mediump vec4 _Height;
uniform 	mediump vec4 _DistanceCoeff;
uniform 	mediump vec4 _DistanceConst;
uniform 	vec4 _Pos;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
int u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
bvec2 u_xlatb10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 3;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2 = (-u_xlat0) + _Pos;
    u_xlat5.x = dot(u_xlat2, u_xlat2);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat5.xz = u_xlat5.xx * _DistanceCoeff.xy + _DistanceConst.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xz = min(max(u_xlat5.xz, 0.0), 1.0);
#else
    u_xlat5.xz = clamp(u_xlat5.xz, 0.0, 1.0);
#endif
    u_xlat5.x = min(u_xlat5.z, u_xlat5.x);
    u_xlat5.x = u_xlat5.x * in_POSITION0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x>=0.0);
#else
    u_xlatb15 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x>=0.0;
#endif
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
    u_xlat2.y = u_xlat15 * u_xlat5.x;
    u_xlat2.xz = in_POSITION0.xz;
    u_xlat2.w = 0.0;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[1] * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat3;
    u_xlat3 = u_xlat3 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat4 = u_xlat2 + u_xlat3;
    u_xlat5.xz = u_xlat4.yy * hlslcc_mtx4x4unity_MatrixInvV[1].xz;
    u_xlat5.xz = hlslcc_mtx4x4unity_MatrixInvV[0].xz * u_xlat4.xx + u_xlat5.xz;
    u_xlat5.xz = hlslcc_mtx4x4unity_MatrixInvV[2].xz * u_xlat4.zz + u_xlat5.xz;
    u_xlat5.xz = hlslcc_mtx4x4unity_MatrixInvV[3].xz * u_xlat4.ww + u_xlat5.xz;
    u_xlat0.xy = (-u_xlat0.xz) + u_xlat5.xz;
    u_xlat4.x = u_xlat0.x * _Height.y + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat4.y = u_xlat0.y * _Height.y + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat0.xy = -abs(u_xlat4.xy) * _Height.zz + vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat4.x = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat4.y = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat0.xy = u_xlat0.xy * u_xlat4.xy;
    u_xlatb10.xy = greaterThanEqual(u_xlat4.xyxy, vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb10.x) ? float(1.0) : u_xlat0.x;
    u_xlat0.y = (u_xlatb10.y) ? float(1.0) : u_xlat0.y;
    u_xlat0.w = u_xlat0.y + u_xlat0.x;
    u_xlat0.xyz = u_xlat0.www * vec3(0.5, 0.5, 0.5);
    u_xlat0 = u_xlat2 * u_xlat0 + u_xlat3;
    u_xlat6 = -0.200000003 * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * vec3(u_xlat6) + u_xlat0.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0.x = u_xlat0.z + 0.649999976;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat2;
    gl_Position = u_xlat0;
    u_xlat16_2 = _Color + (-_Color2);
    u_xlat16_2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].wwww * u_xlat16_2 + _Color2;
    u_xlat6 = floor(abs(unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x));
    vs_TEXCOORD3.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlatb1.xy = equal(vec4(u_xlat6), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat16_3 = (u_xlatb1.y) ? _BurnedColor : vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_1 = (u_xlatb1.x) ? u_xlat16_2 : u_xlat16_3;
    vs_TEXCOORD0 = u_xlat16_1;
    vs_TEXCOORD1 = u_xlat16_1 * vec4(1.0, 1.0, 1.0, 5.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat4.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat4.zz + u_xlat4.xw;
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
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0274509806;
    SV_Target1.xyz = vs_TEXCOORD0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_1 : vs_TEXCOORD1.z;
    u_xlat16_0 = vs_TEXCOORD1.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_0 = sqrt(u_xlat16_0);
    SV_Target2.w = u_xlat16_0;
    SV_Target2.xy = vs_TEXCOORD1.xy;
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
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _BaseSpeculars;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _LowLODColor2;
uniform 	mediump vec4 _Height;
uniform 	mediump vec4 _DistanceCoeff;
uniform 	mediump vec4 _DistanceConst;
uniform 	vec4 _Pos;
in highp vec4 in_POSITION0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_7;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[1] * hlslcc_mtx4x4unity_MatrixV[3].yyyy;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * hlslcc_mtx4x4unity_MatrixV[3].xxxx + u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z + 0.649999976;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * hlslcc_mtx4x4unity_MatrixV[3].wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1 = _Pos + vec4(-0.0, -0.0, -0.0, -1.0);
    u_xlat1.x = dot(u_xlat1, u_xlat1);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _DistanceCoeff.z + _DistanceConst.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_2 = _Color2 + (-_LowLODColor2);
    u_xlat16_1 = u_xlat1.xxxx * u_xlat16_2 + _LowLODColor2;
    vs_TEXCOORD0 = u_xlat16_1;
    u_xlat16_2.x = _BaseSpeculars.w * 0.000144286227;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat3.x = _BaseSpeculars.z * u_xlat16_2.x + -0.5;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat8 = in_POSITION0.y * _Height.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.0<u_xlat8);
#else
    u_xlatb8 = 0.0<u_xlat8;
#endif
    u_xlat8 = (u_xlatb8) ? 1.0 : 0.5;
    u_xlat16_2.x = u_xlat8 * u_xlat3.x;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
    vs_TEXCOORD1.w = u_xlat16_2.x;
    u_xlat16_4.xyz = _LightColor0.xyz * _LightColor0.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_7.xyz * u_xlat16_4.xyz;
    vs_TEXCOORD3.xyz = vec3(0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat3.zz + u_xlat3.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = _Color;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = _Color;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = _Color;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = _Color;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0.x) ? u_xlat16_1 : vs_TEXCOORD1.z;
    SV_Target0.xyz = vs_TEXCOORD3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0117647061;
    SV_Target1.xyz = vs_TEXCOORD0.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xyw = vs_TEXCOORD1.xyw;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _BaseSpeculars;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _LowLODColor;
uniform 	mediump vec4 _LowLODColor2;
uniform 	mediump vec4 _Height;
uniform 	mediump vec4 _SpecularExtra;
uniform 	mediump vec4 _DistanceCoeff;
uniform 	mediump vec4 _DistanceConst;
uniform 	vec4 _Pos;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat9;
vec3 u_xlat10;
vec3 u_xlat12;
bool u_xlatb12;
mediump float u_xlat16_14;
mediump vec3 u_xlat16_15;
bvec2 u_xlatb17;
mediump float u_xlat16_22;
float u_xlat25;
bool u_xlatb25;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.xz = in_POSITION0.xz;
    u_xlat0.w = 0.0;
    u_xlat1.w = 1.0;
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat3 = (-u_xlat1) + _Pos;
    u_xlat9 = dot(u_xlat3, u_xlat3);
    u_xlat9 = sqrt(u_xlat9);
    u_xlat10.xyz = vec3(u_xlat9) * _DistanceCoeff.xyz + _DistanceConst.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.xyz = min(max(u_xlat10.xyz, 0.0), 1.0);
#else
    u_xlat10.xyz = clamp(u_xlat10.xyz, 0.0, 1.0);
#endif
    u_xlat9 = min(u_xlat10.y, u_xlat10.x);
    u_xlat9 = u_xlat9 * in_POSITION0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x>=0.0);
#else
    u_xlatb25 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x>=0.0;
#endif
    u_xlat25 = u_xlatb25 ? 1.0 : float(0.0);
    u_xlat0.y = u_xlat25 * u_xlat9;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[1] * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat3;
    u_xlat3 = u_xlat3 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat4 = u_xlat0 + u_xlat3;
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_MatrixInvV[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_MatrixInvV[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixInvV[2].xyz * u_xlat4.zzz + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixInvV[3].xyz * u_xlat4.www + u_xlat4.xyz;
    u_xlat1.xy = (-u_xlat1.xz) + u_xlat4.xz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5.x = u_xlat1.x * _Height.y + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat5.y = u_xlat1.y * _Height.y + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat1.xy = -abs(u_xlat5.xy) * _Height.zz + vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat5.x = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat5.y = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat1.xy = u_xlat1.xy * u_xlat5.xy;
    u_xlatb17.xy = greaterThanEqual(u_xlat5.xyxy, vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat1.x = (u_xlatb17.x) ? float(1.0) : u_xlat1.x;
    u_xlat1.y = (u_xlatb17.y) ? float(1.0) : u_xlat1.y;
    u_xlat1.w = u_xlat1.y + u_xlat1.x;
    u_xlat1.xyz = u_xlat1.www * vec3(0.5, 0.5, 0.5);
    u_xlat0 = u_xlat0 * u_xlat1 + u_xlat3;
    u_xlat1.x = -0.200000003 * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0.x = u_xlat0.z + 0.649999976;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat16_1 = _Color + (-_Color2);
    u_xlat16_1 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].wwww * u_xlat16_1 + _Color2;
    u_xlat16_3 = _LowLODColor + (-_LowLODColor2);
    u_xlat16_3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].wwww * u_xlat16_3 + _LowLODColor2;
    u_xlat16_1 = u_xlat16_1 + (-u_xlat16_3);
    u_xlat16_1 = u_xlat10.zzzz * u_xlat16_1 + u_xlat16_3;
    u_xlat10.x = -0.600000024 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat10.x * 1.875 + 1.0;
    u_xlat10.x = u_xlat10.x * 0.0249999985;
    u_xlat3 = u_xlat16_1 * u_xlat16_6.xxxx + u_xlat10.xxxx;
    u_xlat16_3 = (-u_xlat16_1) + u_xlat3;
    u_xlat10.x = in_POSITION0.y * _Height.x;
    u_xlat10.x = u_xlat10.x * 8.0 + -5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat10.xxxx * u_xlat16_3 + u_xlat16_1;
    u_xlat16_6.x = u_xlat10.x * _SpecularExtra.x;
    vs_TEXCOORD0 = u_xlat16_1;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat4.x = dot(u_xlat10.xyz, unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat4.x<0.0);
#else
    u_xlatb12 = u_xlat4.x<0.0;
#endif
    u_xlat16_14 = u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_14 = (-u_xlat16_14) + 1.00010002;
    u_xlat16_14 = log2(u_xlat16_14);
    u_xlat16_14 = u_xlat16_14 * _BaseSpeculars.w;
    u_xlat16_14 = exp2(u_xlat16_14);
    u_xlat4.x = _BaseSpeculars.z * u_xlat16_14 + -0.5;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat12.xyz = (bool(u_xlatb12)) ? u_xlat10.xyz : unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat5.x = dot((-u_xlat10.xyz), u_xlat12.xyz);
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
    u_xlat5.x = u_xlat12.y * (-u_xlat5.x) + (-u_xlat10.y);
    u_xlat5.x = u_xlat5.x + (-_WorldSpaceLightPos0.y);
    u_xlat5.y = u_xlat16_6.x * u_xlat5.x + _WorldSpaceLightPos0.y;
    u_xlat5.xz = _WorldSpaceLightPos0.xz;
    u_xlat16_6.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat16_6.x = inversesqrt(u_xlat16_6.x);
    u_xlat16_6.xyz = u_xlat5.xyz * u_xlat16_6.xxx + u_xlat10.xyz;
    u_xlat16_30 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat12.x = dot(u_xlat16_6.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = dot(u_xlat16_6.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_14 = u_xlat12.x * u_xlat12.x;
    u_xlat10.x = (-_BaseSpeculars.y) + 1.0;
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat16_22 = u_xlat10.x * u_xlat10.x;
    u_xlat16_30 = u_xlat16_22 * u_xlat16_22 + -1.0;
    u_xlat16_22 = u_xlat16_22 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_22 * 0.5;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_30 + 1.0;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_14 + 9.99999975e-05;
    u_xlat16_14 = float(1.0) / float(u_xlat16_14);
    u_xlat16_14 = u_xlat16_14 * u_xlat16_22;
    u_xlat10.x = dot(unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3.xyz = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat16_14 = u_xlat10.x * u_xlat16_14;
    u_xlat16_14 = min(u_xlat16_14, 16.0);
    u_xlat16_22 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_22 = u_xlat16_22 * u_xlat16_22;
    u_xlat16_30 = u_xlat16_22 * u_xlat16_6.x;
    u_xlat16_6.x = (-u_xlat16_6.x) * u_xlat16_22 + 1.0;
    u_xlat16_7.xyz = u_xlat16_1.xyz * _BaseSpeculars.xxx;
    u_xlat16_6.xzw = u_xlat16_6.xxx * u_xlat16_7.xyz + vec3(u_xlat16_30);
    u_xlat2.x = in_POSITION0.y * _Height.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<u_xlat2.x);
#else
    u_xlatb2 = 0.0<u_xlat2.x;
#endif
    u_xlat2.x = (u_xlatb2) ? 1.0 : 0.5;
    u_xlat16_7.x = u_xlat2.x * u_xlat4.x;
    u_xlat16_15.xyz = u_xlat16_1.xyz * u_xlat16_7.xxx;
    vs_TEXCOORD1.w = u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_15.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_14) * u_xlat16_6.xzw + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_6.xyz * _LightColor0.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = _Color;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = _Color;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = _Color;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = _Color;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0.x) ? u_xlat16_1 : vs_TEXCOORD1.z;
    SV_Target0.xyz = vs_TEXCOORD3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0117647061;
    SV_Target1.xyz = vs_TEXCOORD0.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xyw = vs_TEXCOORD1.xyw;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MIHOYO_GRASS_ELEMENT_VIEW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color2;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[1] * hlslcc_mtx4x4unity_MatrixV[3].yyyy;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * hlslcc_mtx4x4unity_MatrixV[3].xxxx + u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z + 0.649999976;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * hlslcc_mtx4x4unity_MatrixV[3].wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = _Color2;
    vs_TEXCOORD1 = _Color2 * vec4(1.0, 1.0, 1.0, 5.0);
    vs_TEXCOORD3.xyz = vec3(0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump float u_xlat16_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
bool u_xlatb2;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = _Color;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = _Color;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = _Color;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = _Color;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_0 = vs_TEXCOORD1.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_0 = sqrt(u_xlat16_0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1 : vs_TEXCOORD1.z;
    SV_Target0.xyz = vs_TEXCOORD3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0274509806;
    SV_Target1.xyz = vs_TEXCOORD0.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vs_TEXCOORD1.xy;
    SV_Target2.w = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MIHOYO_GRASS_ELEMENT_VIEW" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _BurnedColor;
uniform 	mediump vec4 _Height;
uniform 	mediump vec4 _DistanceCoeff;
uniform 	mediump vec4 _DistanceConst;
uniform 	vec4 _Pos;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
int u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
bvec2 u_xlatb10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 3;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2 = (-u_xlat0) + _Pos;
    u_xlat5.x = dot(u_xlat2, u_xlat2);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat5.xz = u_xlat5.xx * _DistanceCoeff.xy + _DistanceConst.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xz = min(max(u_xlat5.xz, 0.0), 1.0);
#else
    u_xlat5.xz = clamp(u_xlat5.xz, 0.0, 1.0);
#endif
    u_xlat5.x = min(u_xlat5.z, u_xlat5.x);
    u_xlat5.x = u_xlat5.x * in_POSITION0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x>=0.0);
#else
    u_xlatb15 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x>=0.0;
#endif
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
    u_xlat2.y = u_xlat15 * u_xlat5.x;
    u_xlat2.xz = in_POSITION0.xz;
    u_xlat2.w = 0.0;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[1] * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat3;
    u_xlat3 = u_xlat3 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat4 = u_xlat2 + u_xlat3;
    u_xlat5.xz = u_xlat4.yy * hlslcc_mtx4x4unity_MatrixInvV[1].xz;
    u_xlat5.xz = hlslcc_mtx4x4unity_MatrixInvV[0].xz * u_xlat4.xx + u_xlat5.xz;
    u_xlat5.xz = hlslcc_mtx4x4unity_MatrixInvV[2].xz * u_xlat4.zz + u_xlat5.xz;
    u_xlat5.xz = hlslcc_mtx4x4unity_MatrixInvV[3].xz * u_xlat4.ww + u_xlat5.xz;
    u_xlat0.xy = (-u_xlat0.xz) + u_xlat5.xz;
    u_xlat4.x = u_xlat0.x * _Height.y + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat4.y = u_xlat0.y * _Height.y + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat0.xy = -abs(u_xlat4.xy) * _Height.zz + vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat4.x = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat4.y = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat0.xy = u_xlat0.xy * u_xlat4.xy;
    u_xlatb10.xy = greaterThanEqual(u_xlat4.xyxy, vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb10.x) ? float(1.0) : u_xlat0.x;
    u_xlat0.y = (u_xlatb10.y) ? float(1.0) : u_xlat0.y;
    u_xlat0.w = u_xlat0.y + u_xlat0.x;
    u_xlat0.xyz = u_xlat0.www * vec3(0.5, 0.5, 0.5);
    u_xlat0 = u_xlat2 * u_xlat0 + u_xlat3;
    u_xlat6 = -0.200000003 * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * vec3(u_xlat6) + u_xlat0.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0.x = u_xlat0.z + 0.649999976;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat2;
    gl_Position = u_xlat0;
    u_xlat16_2 = _Color + (-_Color2);
    u_xlat16_2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].wwww * u_xlat16_2 + _Color2;
    u_xlat6 = floor(abs(unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x));
    vs_TEXCOORD3.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlatb1.xy = equal(vec4(u_xlat6), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat16_3 = (u_xlatb1.y) ? _BurnedColor : vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_1 = (u_xlatb1.x) ? u_xlat16_2 : u_xlat16_3;
    vs_TEXCOORD0 = u_xlat16_1;
    vs_TEXCOORD1 = u_xlat16_1 * vec4(1.0, 1.0, 1.0, 5.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat4.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat4.zz + u_xlat4.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump vec4 _Color;
in mediump vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
mediump float u_xlat16_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
bool u_xlatb2;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==5.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = _Color;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==6.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==6.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = _Color;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==7.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==7.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = _Color;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(unity_DebugViewInfo.x==8.0);
#else
    u_xlatb0.x = unity_DebugViewInfo.x==8.0;
#endif
    if(u_xlatb0.x){
        SV_Target0 = _Color;
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
        SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
        SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_0 = vs_TEXCOORD1.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_0 = sqrt(u_xlat16_0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_1 = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb2) ? u_xlat16_1 : vs_TEXCOORD1.z;
    SV_Target0.xyz = vs_TEXCOORD3.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0274509806;
    SV_Target1.xyz = vs_TEXCOORD0.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vs_TEXCOORD1.xy;
    SV_Target2.w = u_xlat16_0;
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
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _BaseSpeculars;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _LowLODColor2;
uniform 	mediump vec4 _Height;
uniform 	mediump vec4 _DistanceCoeff;
uniform 	mediump vec4 _DistanceConst;
uniform 	vec4 _Pos;
in highp vec4 in_POSITION0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_7;
float u_xlat8;
bool u_xlatb8;
void main()
{
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[1] * hlslcc_mtx4x4unity_MatrixV[3].yyyy;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * hlslcc_mtx4x4unity_MatrixV[3].xxxx + u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z + 0.649999976;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * hlslcc_mtx4x4unity_MatrixV[3].wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1 = _Pos + vec4(-0.0, -0.0, -0.0, -1.0);
    u_xlat1.x = dot(u_xlat1, u_xlat1);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _DistanceCoeff.z + _DistanceConst.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_2 = _Color2 + (-_LowLODColor2);
    u_xlat16_1 = u_xlat1.xxxx * u_xlat16_2 + _LowLODColor2;
    vs_TEXCOORD0 = u_xlat16_1;
    u_xlat16_2.x = _BaseSpeculars.w * 0.000144286227;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat3.x = _BaseSpeculars.z * u_xlat16_2.x + -0.5;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat8 = in_POSITION0.y * _Height.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.0<u_xlat8);
#else
    u_xlatb8 = 0.0<u_xlat8;
#endif
    u_xlat8 = (u_xlatb8) ? 1.0 : 0.5;
    u_xlat16_2.x = u_xlat8 * u_xlat3.x;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
    vs_TEXCOORD1.w = u_xlat16_2.x;
    u_xlat16_4.xyz = _LightColor0.xyz * _LightColor0.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_7.xyz * u_xlat16_4.xyz;
    vs_TEXCOORD3.xyz = vec3(0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat3.zz + u_xlat3.xw;
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _BaseSpeculars;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _LowLODColor;
uniform 	mediump vec4 _LowLODColor2;
uniform 	mediump vec4 _Height;
uniform 	mediump vec4 _SpecularExtra;
uniform 	mediump vec4 _DistanceCoeff;
uniform 	mediump vec4 _DistanceConst;
uniform 	vec4 _Pos;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat9;
vec3 u_xlat10;
vec3 u_xlat12;
bool u_xlatb12;
mediump float u_xlat16_14;
mediump vec3 u_xlat16_15;
bvec2 u_xlatb17;
mediump float u_xlat16_22;
float u_xlat25;
bool u_xlatb25;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.xz = in_POSITION0.xz;
    u_xlat0.w = 0.0;
    u_xlat1.w = 1.0;
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat3 = (-u_xlat1) + _Pos;
    u_xlat9 = dot(u_xlat3, u_xlat3);
    u_xlat9 = sqrt(u_xlat9);
    u_xlat10.xyz = vec3(u_xlat9) * _DistanceCoeff.xyz + _DistanceConst.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.xyz = min(max(u_xlat10.xyz, 0.0), 1.0);
#else
    u_xlat10.xyz = clamp(u_xlat10.xyz, 0.0, 1.0);
#endif
    u_xlat9 = min(u_xlat10.y, u_xlat10.x);
    u_xlat9 = u_xlat9 * in_POSITION0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb25 = !!(unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x>=0.0);
#else
    u_xlatb25 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x>=0.0;
#endif
    u_xlat25 = u_xlatb25 ? 1.0 : float(0.0);
    u_xlat0.y = u_xlat25 * u_xlat9;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[1] * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat3;
    u_xlat3 = u_xlat3 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat4 = u_xlat0 + u_xlat3;
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_MatrixInvV[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_MatrixInvV[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixInvV[2].xyz * u_xlat4.zzz + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixInvV[3].xyz * u_xlat4.www + u_xlat4.xyz;
    u_xlat1.xy = (-u_xlat1.xz) + u_xlat4.xz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5.x = u_xlat1.x * _Height.y + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat5.y = u_xlat1.y * _Height.y + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat1.xy = -abs(u_xlat5.xy) * _Height.zz + vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat5.x = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat5.y = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat1.xy = u_xlat1.xy * u_xlat5.xy;
    u_xlatb17.xy = greaterThanEqual(u_xlat5.xyxy, vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat1.x = (u_xlatb17.x) ? float(1.0) : u_xlat1.x;
    u_xlat1.y = (u_xlatb17.y) ? float(1.0) : u_xlat1.y;
    u_xlat1.w = u_xlat1.y + u_xlat1.x;
    u_xlat1.xyz = u_xlat1.www * vec3(0.5, 0.5, 0.5);
    u_xlat0 = u_xlat0 * u_xlat1 + u_xlat3;
    u_xlat1.x = -0.200000003 * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0.x = u_xlat0.z + 0.649999976;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat16_1 = _Color + (-_Color2);
    u_xlat16_1 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].wwww * u_xlat16_1 + _Color2;
    u_xlat16_3 = _LowLODColor + (-_LowLODColor2);
    u_xlat16_3 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].wwww * u_xlat16_3 + _LowLODColor2;
    u_xlat16_1 = u_xlat16_1 + (-u_xlat16_3);
    u_xlat16_1 = u_xlat10.zzzz * u_xlat16_1 + u_xlat16_3;
    u_xlat10.x = -0.600000024 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat10.x * 1.875 + 1.0;
    u_xlat10.x = u_xlat10.x * 0.0249999985;
    u_xlat3 = u_xlat16_1 * u_xlat16_6.xxxx + u_xlat10.xxxx;
    u_xlat16_3 = (-u_xlat16_1) + u_xlat3;
    u_xlat10.x = in_POSITION0.y * _Height.x;
    u_xlat10.x = u_xlat10.x * 8.0 + -5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat10.xxxx * u_xlat16_3 + u_xlat16_1;
    u_xlat16_6.x = u_xlat10.x * _SpecularExtra.x;
    vs_TEXCOORD0 = u_xlat16_1;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat10.xyz = u_xlat10.xxx * u_xlat4.xyz;
    u_xlat4.x = dot(u_xlat10.xyz, unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat4.x<0.0);
#else
    u_xlatb12 = u_xlat4.x<0.0;
#endif
    u_xlat16_14 = u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_14 = (-u_xlat16_14) + 1.00010002;
    u_xlat16_14 = log2(u_xlat16_14);
    u_xlat16_14 = u_xlat16_14 * _BaseSpeculars.w;
    u_xlat16_14 = exp2(u_xlat16_14);
    u_xlat4.x = _BaseSpeculars.z * u_xlat16_14 + -0.5;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat12.xyz = (bool(u_xlatb12)) ? u_xlat10.xyz : unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat5.x = dot((-u_xlat10.xyz), u_xlat12.xyz);
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
    u_xlat5.x = u_xlat12.y * (-u_xlat5.x) + (-u_xlat10.y);
    u_xlat5.x = u_xlat5.x + (-_WorldSpaceLightPos0.y);
    u_xlat5.y = u_xlat16_6.x * u_xlat5.x + _WorldSpaceLightPos0.y;
    u_xlat5.xz = _WorldSpaceLightPos0.xz;
    u_xlat16_6.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat16_6.x = inversesqrt(u_xlat16_6.x);
    u_xlat16_6.xyz = u_xlat5.xyz * u_xlat16_6.xxx + u_xlat10.xyz;
    u_xlat16_30 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz;
    u_xlat12.x = dot(u_xlat16_6.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = dot(u_xlat16_6.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_14 = u_xlat12.x * u_xlat12.x;
    u_xlat10.x = (-_BaseSpeculars.y) + 1.0;
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat16_22 = u_xlat10.x * u_xlat10.x;
    u_xlat16_30 = u_xlat16_22 * u_xlat16_22 + -1.0;
    u_xlat16_22 = u_xlat16_22 * u_xlat16_22;
    u_xlat16_22 = u_xlat16_22 * 0.5;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_30 + 1.0;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_14 + 9.99999975e-05;
    u_xlat16_14 = float(1.0) / float(u_xlat16_14);
    u_xlat16_14 = u_xlat16_14 * u_xlat16_22;
    u_xlat10.x = dot(unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3.xyz = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat16_14 = u_xlat10.x * u_xlat16_14;
    u_xlat16_14 = min(u_xlat16_14, 16.0);
    u_xlat16_22 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_22 = u_xlat16_22 * u_xlat16_22;
    u_xlat16_30 = u_xlat16_22 * u_xlat16_6.x;
    u_xlat16_6.x = (-u_xlat16_6.x) * u_xlat16_22 + 1.0;
    u_xlat16_7.xyz = u_xlat16_1.xyz * _BaseSpeculars.xxx;
    u_xlat16_6.xzw = u_xlat16_6.xxx * u_xlat16_7.xyz + vec3(u_xlat16_30);
    u_xlat2.x = in_POSITION0.y * _Height.x + -0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<u_xlat2.x);
#else
    u_xlatb2 = 0.0<u_xlat2.x;
#endif
    u_xlat2.x = (u_xlatb2) ? 1.0 : 0.5;
    u_xlat16_7.x = u_xlat2.x * u_xlat4.x;
    u_xlat16_15.xyz = u_xlat16_1.xyz * u_xlat16_7.xxx;
    vs_TEXCOORD1.w = u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_15.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = vec3(u_xlat16_14) * u_xlat16_6.xzw + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_6.xyz * _LightColor0.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_ELEMENT_VIEW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color2;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[1] * hlslcc_mtx4x4unity_MatrixV[3].yyyy;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * hlslcc_mtx4x4unity_MatrixV[3].xxxx + u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z + 0.649999976;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * hlslcc_mtx4x4unity_MatrixV[3].wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = _Color2;
    vs_TEXCOORD1 = _Color2 * vec4(1.0, 1.0, 1.0, 5.0);
    vs_TEXCOORD3.xyz = vec3(0.0, 0.0, 0.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_ELEMENT_VIEW" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _BurnedColor;
uniform 	mediump vec4 _Height;
uniform 	mediump vec4 _DistanceCoeff;
uniform 	mediump vec4 _DistanceConst;
uniform 	vec4 _Pos;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
int u_xlati1;
bvec2 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
float u_xlat6;
bvec2 u_xlatb10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.w = 1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 3;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2 = (-u_xlat0) + _Pos;
    u_xlat5.x = dot(u_xlat2, u_xlat2);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat5.xz = u_xlat5.xx * _DistanceCoeff.xy + _DistanceConst.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xz = min(max(u_xlat5.xz, 0.0), 1.0);
#else
    u_xlat5.xz = clamp(u_xlat5.xz, 0.0, 1.0);
#endif
    u_xlat5.x = min(u_xlat5.z, u_xlat5.x);
    u_xlat5.x = u_xlat5.x * in_POSITION0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x>=0.0);
#else
    u_xlatb15 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x>=0.0;
#endif
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
    u_xlat2.y = u_xlat15 * u_xlat5.x;
    u_xlat2.xz = in_POSITION0.xz;
    u_xlat2.w = 0.0;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[1] * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[0] * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixV[2] * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat3;
    u_xlat3 = u_xlat3 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat4 = u_xlat2 + u_xlat3;
    u_xlat5.xz = u_xlat4.yy * hlslcc_mtx4x4unity_MatrixInvV[1].xz;
    u_xlat5.xz = hlslcc_mtx4x4unity_MatrixInvV[0].xz * u_xlat4.xx + u_xlat5.xz;
    u_xlat5.xz = hlslcc_mtx4x4unity_MatrixInvV[2].xz * u_xlat4.zz + u_xlat5.xz;
    u_xlat5.xz = hlslcc_mtx4x4unity_MatrixInvV[3].xz * u_xlat4.ww + u_xlat5.xz;
    u_xlat0.xy = (-u_xlat0.xz) + u_xlat5.xz;
    u_xlat4.x = u_xlat0.x * _Height.y + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat4.y = u_xlat0.y * _Height.y + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat0.xy = -abs(u_xlat4.xy) * _Height.zz + vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat4.x = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat4.y = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat0.xy = u_xlat0.xy * u_xlat4.xy;
    u_xlatb10.xy = greaterThanEqual(u_xlat4.xyxy, vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb10.x) ? float(1.0) : u_xlat0.x;
    u_xlat0.y = (u_xlatb10.y) ? float(1.0) : u_xlat0.y;
    u_xlat0.w = u_xlat0.y + u_xlat0.x;
    u_xlat0.xyz = u_xlat0.www * vec3(0.5, 0.5, 0.5);
    u_xlat0 = u_xlat2 * u_xlat0 + u_xlat3;
    u_xlat6 = -0.200000003 * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[1].xyz * vec3(u_xlat6) + u_xlat0.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0.x = u_xlat0.z + 0.649999976;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat2;
    gl_Position = u_xlat0;
    u_xlat16_2 = _Color + (-_Color2);
    u_xlat16_2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].wwww * u_xlat16_2 + _Color2;
    u_xlat6 = floor(abs(unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x));
    vs_TEXCOORD3.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlatb1.xy = equal(vec4(u_xlat6), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat16_3 = (u_xlatb1.y) ? _BurnedColor : vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_1 = (u_xlatb1.x) ? u_xlat16_2 : u_xlat16_3;
    vs_TEXCOORD0 = u_xlat16_1;
    vs_TEXCOORD1 = u_xlat16_1 * vec4(1.0, 1.0, 1.0, 5.0);
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat4.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat4.zz + u_xlat4.xw;
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
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
Keywords { "MIHOYO_GRASS_ELEMENT_VIEW" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MIHOYO_GRASS_ELEMENT_VIEW" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_ELEMENT_VIEW" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_ELEMENT_VIEW" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MIHOYO_GRASS_ELEMENT_VIEW" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MIHOYO_GRASS_ELEMENT_VIEW" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_ELEMENT_VIEW" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_ELEMENT_VIEW" }
""
}
}
}
}
}