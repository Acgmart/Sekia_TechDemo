//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Grass/Flower" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("MainTex", 2D) = "white" { }
_CutOut ("Alpha Cutout", Float) = 0.4
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "AlphaTest" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "AlphaTest" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 14499
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
float u_xlat5;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(1.5<in_COLOR0.y);
#else
    u_xlatb0 = 1.5<in_COLOR0.y;
#endif
    if(u_xlatb0){
        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xy = in_COLOR0.xz * _BoundsSize.xz + _BoundsMin.xz;
    u_xlat0 = (-u_xlat16_1.yyyy) * hlslcc_mtx4x4unity_MatrixVP[2];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * (-u_xlat16_1.xxxx) + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat5 * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.x = unity_SHAr.w;
    vs_TEXCOORD0.y = unity_SHAg.w;
    vs_TEXCOORD0.z = unity_SHAb.w;
    vs_TEXCOORD0.w = 0.0;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target0 = u_xlat10_0 * vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _MiHoYoTimeScale;
uniform 	mediump float _ReciprocalBurnTime;
uniform 	mediump vec4 _WindParams0;
uniform 	mediump vec4 _WindParams1;
uniform 	mediump vec4 _WindParams2;
uniform 	mediump vec4 _BaseSpeculars;
uniform 	mediump vec4 _LeafEdgeSpeculars;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _BurnedColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump vec4 _SpecularExtra;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
uniform 	mediump vec4 _Height;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec4 u_xlat8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_20;
float u_xlat22;
float u_xlat26;
mediump float u_xlat16_31;
float u_xlat33;
float u_xlat34;
float u_xlat36;
mediump float u_xlat16_42;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat11 = in_COLOR0.y + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(1.5<u_xlat11);
#else
    u_xlatb11 = 1.5<u_xlat11;
#endif
    if(u_xlatb11){
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat1;
        gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat11 = in_POSITION0.y * _Height.x;
    u_xlat11 = max(u_xlat11, 9.99999975e-05);
    u_xlat16_2.xyz = in_COLOR0.xyz * _BoundsSize.xyz + _BoundsMin.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0);
    u_xlat22 = _Time.y + (-unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x);
    u_xlat22 = u_xlat22 * _ReciprocalBurnTime;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat33 = fract(abs(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x));
    u_xlat22 = u_xlat33 * u_xlat22;
    u_xlat33 = 10000.0 * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].w;
    u_xlat33 = fract(u_xlat33);
    u_xlat3.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + (-in_POSITION0.xyz);
    u_xlat34 = (-u_xlat33) + 1.0;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat34) + in_POSITION0.xyz;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(-1.0, 0.0, -1.0) + u_xlat3.xyz;
    u_xlat34 = (-in_COLOR0.y) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
    u_xlat34 = u_xlat34 * 0.5 + in_COLOR0.y;
    u_xlat16_2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.xy = u_xlat16_2.xz * vec2(-1.0, -1.0) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xz;
    u_xlat5.z = u_xlat33 * u_xlat33;
    u_xlat33 = _WindParams1.y * 0.100000001;
    u_xlat36 = _MiHoYoWind.w * _WindParams0.x;
    u_xlat26 = log2(u_xlat11);
    u_xlat26 = u_xlat26 * 1.10000002;
    u_xlat26 = exp2(u_xlat26);
    u_xlat34 = u_xlat34 * 6.28299999;
    u_xlat4.x = dot(u_xlat4.xy, _MiHoYoWind.xz);
    u_xlat4.x = (-u_xlat4.x) * _WindParams0.y;
    u_xlat4.x = _Time.y * _WindParams2.x + u_xlat4.x;
    u_xlat33 = u_xlat34 * u_xlat33 + u_xlat4.x;
    u_xlat4.x = u_xlat33 + _WindParams2.y;
    u_xlat33 = _Time.y * _MiHoYoTimeScale.x + u_xlat34;
    u_xlat4.y = u_xlat33 + _MiHoYoTimeScale.y;
    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat6.xy = abs(u_xlat4.xy) * abs(u_xlat4.xy);
    u_xlat4.xy = -abs(u_xlat4.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat4.xy = u_xlat4.xy * u_xlat6.xy;
    u_xlat5.xy = u_xlat4.xy * vec2(u_xlat26);
    u_xlat4.xy = u_xlat5.zz * u_xlat5.xz;
    u_xlat5.xw = _MiHoYoWind.xz;
    u_xlat6.xy = u_xlat4.xx * u_xlat5.xw;
    u_xlat6.xz = vec2(u_xlat36) * u_xlat6.xy;
    u_xlat6.y = 0.0;
    u_xlat7.x = 0.0;
    u_xlat7.yz = _MiHoYoWind.zx * vec2(0.0, 1.0);
    u_xlat8.xy = _MiHoYoWind.zx * vec2(1.0, 0.0);
    u_xlat8.z = 0.0;
    u_xlat7.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat7.xyz = u_xlat4.xxx * u_xlat7.xyz;
    u_xlat7.xyz = vec3(u_xlat36) * u_xlat7.xyz;
    u_xlat8.xyz = u_xlat7.xyz * _WindParams2.zzz;
    u_xlat33 = u_xlat5.y * u_xlat4.y;
    u_xlat4.xyw = vec3(u_xlat33) * vec3(0.0848399997, 0.0, 0.0848399997);
    u_xlat33 = u_xlat26 * _MiHoYoWind.w;
    u_xlat33 = u_xlat33 * _WindParams1.x + 1.0;
    u_xlat33 = u_xlat33 * u_xlat33 + (-u_xlat33);
    u_xlat5.xy = u_xlat5.xw * vec2(u_xlat33);
    u_xlat5.xz = u_xlat5.zz * u_xlat5.xy;
    u_xlat5.y = 0.0;
    u_xlat8 = u_xlat8.xyzz * _WindParams0.wwww + u_xlat6.xyzz;
    u_xlat8 = u_xlat8 * _WindParams0.zzzz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyzz;
    u_xlat33 = dot(u_xlat8.xyw, u_xlat8.xyw);
    u_xlat33 = max(u_xlat33, 0.00100000005);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat8 = vec4(u_xlat33) * u_xlat8;
    u_xlat6.xyz = u_xlat7.xyz * _WindParams2.zzz + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyw * _WindParams2.www + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat5.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat4.xyz * vec3(0.25, 0.25, 0.25) + u_xlat3.xyz;
    u_xlat16_2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_2.xy = sqrt(u_xlat16_2.xy);
    u_xlat33 = u_xlat16_2.x + 0.00100000005;
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat33);
    u_xlat1.xyz = u_xlat3.xyz * u_xlat16_2.yyy + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    u_xlat33 = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat33 * 0.5;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat16_3 = _Color + (-_Color2);
    u_xlat16_3 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].wwww * u_xlat16_3 + _Color2;
    u_xlat16_4 = (-u_xlat16_3) + _BurnedColor;
    u_xlat16_3 = vec4(u_xlat22) * u_xlat16_4 + u_xlat16_3;
    u_xlat0.xzw = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx;
    u_xlat16_9.x = dot((-u_xlat0.xzw), u_xlat8.xyz);
    u_xlat16_9.x = u_xlat16_9.x + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat8.y * (-u_xlat16_9.x) + (-u_xlat0.z);
    u_xlat1.x = u_xlat16_9.x + (-_WorldSpaceLightPos0.y);
    u_xlat1.y = _SpecularExtra.x * u_xlat1.x + _WorldSpaceLightPos0.y;
    u_xlat1.xz = _WorldSpaceLightPos0.xz;
    u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
    u_xlat16_9.xyz = u_xlat1.xyz * u_xlat16_9.xxx + u_xlat0.xzw;
    u_xlat16_42 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_42 = inversesqrt(u_xlat16_42);
    u_xlat16_9.xyz = vec3(u_xlat16_42) * u_xlat16_9.xyz;
    u_xlat16_42 = dot(u_xlat8.xyw, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_42 = min(max(u_xlat16_42, 0.0), 1.0);
#else
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
#endif
    u_xlat16_9.x = dot(u_xlat16_9.xyz, u_xlat0.xzw);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
    u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat8.xyw, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat22 = _LeafEdgeSpeculars.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_3 * _BaseSpeculars.xxxx;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat22 * u_xlat22;
    u_xlat16_20 = u_xlat22 * u_xlat22;
    u_xlat16_31 = u_xlat16_20 * u_xlat16_20;
    u_xlat16_42 = u_xlat16_42 * u_xlat16_42;
    u_xlat16_20 = u_xlat16_20 * u_xlat16_20 + -1.0;
    u_xlat16_20 = u_xlat16_42 * u_xlat16_20 + 1.0;
    u_xlat16_31 = u_xlat16_31 * 0.5;
    u_xlat16_20 = u_xlat16_20 * u_xlat16_20 + 9.99999975e-05;
    u_xlat16_20 = float(1.0) / float(u_xlat16_20);
    u_xlat16_20 = u_xlat16_20 * u_xlat16_31;
    u_xlat16_20 = u_xlat0.x * u_xlat16_20;
    u_xlat16_20 = min(u_xlat16_20, 16.0);
    u_xlat16_9.x = (-u_xlat16_9.x) + 1.0;
    u_xlat16_31 = u_xlat16_9.x * u_xlat16_9.x;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_42 = u_xlat16_31 * u_xlat16_9.x;
    u_xlat16_9.x = (-u_xlat16_9.x) * u_xlat16_31 + 1.0;
    u_xlat16_1 = u_xlat16_9.xxxx * u_xlat16_1 + vec4(u_xlat16_42);
    u_xlat1 = u_xlat16_1 * vec4(u_xlat16_20);
    u_xlat16_1 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat1 = u_xlat16_1 * _LeafEdgeSpeculars.xxxx;
    u_xlat22 = (-_LeafEdgeSpeculars.z) + 1.0;
    u_xlat11 = u_xlat11 * u_xlat22 + _LeafEdgeSpeculars.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat1 = vec4(u_xlat11) * u_xlat1;
    u_xlat1 = u_xlat1 * _LightColor0;
    u_xlat16_9.x = _SpecularColor.w * 10.0 + _LeafEdgeSpeculars.x;
    u_xlat1 = u_xlat1 * u_xlat16_9.xxxx;
    u_xlat3.xyz = u_xlat8.xyw;
    u_xlat3.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4 = u_xlat8.ywzx * u_xlat8;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_42 = u_xlat3.y * u_xlat3.y;
    u_xlat16_42 = u_xlat3.x * u_xlat3.x + (-u_xlat16_42);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_42) + u_xlat16_10.xyz;
    vs_TEXCOORD0.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    vs_TEXCOORD1 = _LightColor0 * u_xlat0.xxxx + u_xlat1;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.w = 0.0;
    vs_TEXCOORD3.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target0 = u_xlat10_0 * vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
float u_xlat5;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(1.5<in_COLOR0.y);
#else
    u_xlatb0 = 1.5<in_COLOR0.y;
#endif
    if(u_xlatb0){
        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xy = in_COLOR0.xz * _BoundsSize.xz + _BoundsMin.xz;
    u_xlat0 = (-u_xlat16_1.yyyy) * hlslcc_mtx4x4unity_MatrixVP[2];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * (-u_xlat16_1.xxxx) + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat5 * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.x = unity_SHAr.w;
    vs_TEXCOORD0.y = unity_SHAg.w;
    vs_TEXCOORD0.z = unity_SHAb.w;
    vs_TEXCOORD0.w = 0.0;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target0 = u_xlat10_0 * vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _MiHoYoTimeScale;
uniform 	mediump float _ReciprocalBurnTime;
uniform 	mediump vec4 _WindParams0;
uniform 	mediump vec4 _WindParams1;
uniform 	mediump vec4 _WindParams2;
uniform 	mediump vec4 _BaseSpeculars;
uniform 	mediump vec4 _LeafEdgeSpeculars;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _BurnedColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump vec4 _SpecularExtra;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
uniform 	mediump vec4 _Height;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat17;
mediump float u_xlat16_22;
float u_xlat24;
vec2 u_xlat27;
vec2 u_xlat29;
mediump float u_xlat16_34;
float u_xlat36;
float u_xlat37;
mediump float u_xlat16_38;
float u_xlat39;
float u_xlat40;
mediump float u_xlat16_46;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat12 = in_COLOR0.y + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(1.5<u_xlat12);
#else
    u_xlatb12 = 1.5<u_xlat12;
#endif
    if(u_xlatb12){
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat1;
        gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat12 = in_POSITION0.y * _Height.x;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat16_2.xyz = in_COLOR0.xyz * _BoundsSize.xyz + _BoundsMin.xyz;
    u_xlat24 = _Time.y + (-unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x);
    u_xlat24 = u_xlat24 * _ReciprocalBurnTime;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat36 = fract(abs(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x));
    u_xlat24 = u_xlat36 * u_xlat24;
    u_xlat36 = 10000.0 * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].w;
    u_xlat36 = fract(u_xlat36);
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + (-in_POSITION0.xyz);
    u_xlat37 = (-u_xlat36) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat37) + in_POSITION0.xyz;
    u_xlat1.xyz = (-u_xlat16_2.xyz) * vec3(-1.0, 0.0, -1.0) + u_xlat1.xyz;
    u_xlat37 = (-in_COLOR0.y) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
    u_xlat37 = u_xlat37 * 0.5 + in_COLOR0.y;
    u_xlat16_38 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_38 = sqrt(u_xlat16_38);
    u_xlat3.xy = u_xlat16_2.xz * vec2(-1.0, -1.0) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xz;
    u_xlat4.z = u_xlat36 * u_xlat36;
    u_xlat27.x = _WindParams1.y * 0.100000001;
    u_xlat39 = _MiHoYoWind.w * _WindParams0.x;
    u_xlat40 = log2(u_xlat12);
    u_xlat40 = u_xlat40 * 1.10000002;
    u_xlat40 = exp2(u_xlat40);
    u_xlat5.x = u_xlat37 * 6.28299999;
    u_xlat17 = dot(u_xlat3.xy, _MiHoYoWind.xz);
    u_xlat17 = (-u_xlat17) * _WindParams0.y;
    u_xlat17 = _Time.y * _WindParams2.x + u_xlat17;
    u_xlat27.x = u_xlat5.x * u_xlat27.x + u_xlat17;
    u_xlat6.x = u_xlat27.x + _WindParams2.y;
    u_xlat27.x = _Time.y * _MiHoYoTimeScale.x + u_xlat5.x;
    u_xlat6.y = u_xlat27.x + _MiHoYoTimeScale.y;
    u_xlat5.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat5.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat29.xy = abs(u_xlat5.xy) * abs(u_xlat5.xy);
    u_xlat5.xy = -abs(u_xlat5.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat5.xy = u_xlat5.xy * u_xlat29.xy;
    u_xlat4.xy = vec2(u_xlat40) * u_xlat5.xy;
    u_xlat5.xy = u_xlat4.zz * u_xlat4.xz;
    u_xlat29.xy = _MiHoYoWind.xz;
    u_xlat6.xy = u_xlat29.xy * u_xlat5.xx;
    u_xlat6.xz = vec2(u_xlat39) * u_xlat6.xy;
    u_xlat6.y = 0.0;
    u_xlat7.x = 0.0;
    u_xlat7.yz = _MiHoYoWind.zx * vec2(0.0, 1.0);
    u_xlat8.xy = _MiHoYoWind.zx * vec2(1.0, 0.0);
    u_xlat8.z = 0.0;
    u_xlat7.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat7.xyz = u_xlat5.xxx * u_xlat7.xyz;
    u_xlat7.xyz = vec3(u_xlat39) * u_xlat7.xyz;
    u_xlat8.xyz = u_xlat7.xyz * _WindParams2.zzz;
    u_xlat27.x = u_xlat4.y * u_xlat5.y;
    u_xlat9.xyz = u_xlat27.xxx * vec3(0.0848399997, 0.0, 0.0848399997);
    u_xlat27.x = u_xlat40 * _MiHoYoWind.w;
    u_xlat27.x = u_xlat27.x * _WindParams1.x + 1.0;
    u_xlat27.x = u_xlat27.x * u_xlat27.x + (-u_xlat27.x);
    u_xlat27.xy = u_xlat29.xy * u_xlat27.xx;
    u_xlat4.xz = u_xlat4.zz * u_xlat27.xy;
    u_xlat4.y = 0.0;
    u_xlat5 = u_xlat8.xyzz * _WindParams0.wwww + u_xlat6.xyzz;
    u_xlat5 = u_xlat5 * _WindParams0.zzzz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyzz;
    u_xlat27.x = dot(u_xlat5.xyw, u_xlat5.xyw);
    u_xlat27.x = max(u_xlat27.x, 0.00100000005);
    u_xlat27.x = inversesqrt(u_xlat27.x);
    u_xlat5 = u_xlat27.xxxx * u_xlat5;
    u_xlat6.xyz = u_xlat7.xyz * _WindParams2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat9.xyz * _WindParams2.www + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat4.xyz * vec3(0.25, 0.25, 0.25) + u_xlat1.xyz;
    u_xlat16_10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_10.x = sqrt(u_xlat16_10.x);
    u_xlat27.x = u_xlat16_10.x + 0.00100000005;
    u_xlat1.xyz = u_xlat1.xyz / u_xlat27.xxx;
    u_xlat36 = u_xlat36 * u_xlat16_38;
    u_xlat3.xy = u_xlat3.xy + (-_GrassDisplacementArea.xy);
    u_xlat3.xy = vec2(u_xlat3.x / _GrassDisplacementArea.z, u_xlat3.y / _GrassDisplacementArea.w);
    u_xlat3.xyz = textureLod(_GrassDisplacementTex, u_xlat3.xy, 0.0).xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat39 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat39 = sqrt(u_xlat39);
    u_xlat3.xy = vec2(u_xlat36) * u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * _DisplacementParam.xx;
    u_xlat37 = u_xlat37 * 0.649999976 + 1.13;
    u_xlat3.xy = vec2(u_xlat37) * u_xlat3.xy;
    u_xlat4.xz = u_xlat3.xy * vec2(0.75, 0.75);
    u_xlat36 = u_xlat36 * u_xlat39;
    u_xlat36 = u_xlat36 * _DisplacementParam.y;
    u_xlat37 = max(u_xlat3.z, _DisplacementParam.z);
    u_xlat37 = min(u_xlat37, _DisplacementParam.w);
    u_xlat4.y = (-u_xlat36) * u_xlat37;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat16_38) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    u_xlat36 = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat36 * 0.5;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat16_3 = _Color + (-_Color2);
    u_xlat16_3 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].wwww * u_xlat16_3 + _Color2;
    u_xlat16_4 = (-u_xlat16_3) + _BurnedColor;
    u_xlat16_3 = vec4(u_xlat24) * u_xlat16_4 + u_xlat16_3;
    u_xlat0.xzw = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx;
    u_xlat16_10.x = dot((-u_xlat0.xzw), u_xlat5.xyz);
    u_xlat16_10.x = u_xlat16_10.x + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat5.y * (-u_xlat16_10.x) + (-u_xlat0.z);
    u_xlat1.x = u_xlat16_10.x + (-_WorldSpaceLightPos0.y);
    u_xlat1.y = _SpecularExtra.x * u_xlat1.x + _WorldSpaceLightPos0.y;
    u_xlat1.xz = _WorldSpaceLightPos0.xz;
    u_xlat16_10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat1.xyz * u_xlat16_10.xxx + u_xlat0.xzw;
    u_xlat16_46 = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_46 = inversesqrt(u_xlat16_46);
    u_xlat16_10.xyz = vec3(u_xlat16_46) * u_xlat16_10.xyz;
    u_xlat16_46 = dot(u_xlat5.xyw, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_46 = min(max(u_xlat16_46, 0.0), 1.0);
#else
    u_xlat16_46 = clamp(u_xlat16_46, 0.0, 1.0);
#endif
    u_xlat16_10.x = dot(u_xlat16_10.xyz, u_xlat0.xzw);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10.x = min(max(u_xlat16_10.x, 0.0), 1.0);
#else
    u_xlat16_10.x = clamp(u_xlat16_10.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat5.xyw, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat24 = _LeafEdgeSpeculars.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_3 * _BaseSpeculars.xxxx;
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = u_xlat24 * u_xlat24;
    u_xlat16_22 = u_xlat24 * u_xlat24;
    u_xlat16_34 = u_xlat16_22 * u_xlat16_22;
    u_xlat16_46 = u_xlat16_46 * u_xlat16_46;
    u_xlat16_22 = u_xlat16_22 * u_xlat16_22 + -1.0;
    u_xlat16_22 = u_xlat16_46 * u_xlat16_22 + 1.0;
    u_xlat16_34 = u_xlat16_34 * 0.5;
    u_xlat16_22 = u_xlat16_22 * u_xlat16_22 + 9.99999975e-05;
    u_xlat16_22 = float(1.0) / float(u_xlat16_22);
    u_xlat16_22 = u_xlat16_22 * u_xlat16_34;
    u_xlat16_22 = u_xlat0.x * u_xlat16_22;
    u_xlat16_22 = min(u_xlat16_22, 16.0);
    u_xlat16_10.x = (-u_xlat16_10.x) + 1.0;
    u_xlat16_34 = u_xlat16_10.x * u_xlat16_10.x;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_46 = u_xlat16_34 * u_xlat16_10.x;
    u_xlat16_10.x = (-u_xlat16_10.x) * u_xlat16_34 + 1.0;
    u_xlat16_1 = u_xlat16_10.xxxx * u_xlat16_1 + vec4(u_xlat16_46);
    u_xlat1 = u_xlat16_1 * vec4(u_xlat16_22);
    u_xlat16_1 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat1 = u_xlat16_1 * _LeafEdgeSpeculars.xxxx;
    u_xlat24 = (-_LeafEdgeSpeculars.z) + 1.0;
    u_xlat12 = u_xlat12 * u_xlat24 + _LeafEdgeSpeculars.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1 = vec4(u_xlat12) * u_xlat1;
    u_xlat1 = u_xlat1 * _LightColor0;
    u_xlat16_10.x = _SpecularColor.w * 10.0 + _LeafEdgeSpeculars.x;
    u_xlat1 = u_xlat1 * u_xlat16_10.xxxx;
    u_xlat3.xyz = u_xlat5.xyw;
    u_xlat3.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4 = u_xlat5.ywzx * u_xlat5;
    u_xlat16_11.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_11.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_11.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_46 = u_xlat3.y * u_xlat3.y;
    u_xlat16_46 = u_xlat3.x * u_xlat3.x + (-u_xlat16_46);
    u_xlat16_11.xyz = unity_SHC.xyz * vec3(u_xlat16_46) + u_xlat16_11.xyz;
    vs_TEXCOORD0.xyz = u_xlat16_10.xyz + u_xlat16_11.xyz;
    vs_TEXCOORD1 = _LightColor0 * u_xlat0.xxxx + u_xlat1;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.w = 0.0;
    vs_TEXCOORD3.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target0 = u_xlat10_0 * vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
Keywords { "MIHOYO_GRASS_DISPLACEMENT" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" }
""
}
}
}
 Pass {
  LOD 100
  Tags { "LIGHTMODE" = "CUSTOMPREPASSBASE" "QUEUE" = "AlphaTest" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 82686
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
float u_xlat5;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(1.5<in_COLOR0.y);
#else
    u_xlatb0 = 1.5<in_COLOR0.y;
#endif
    if(u_xlatb0){
        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xy = in_COLOR0.xz * _BoundsSize.xz + _BoundsMin.xz;
    u_xlat0 = (-u_xlat16_1.yyyy) * hlslcc_mtx4x4unity_MatrixVP[2];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * (-u_xlat16_1.xxxx) + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat5 * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.x = unity_SHAr.w;
    vs_TEXCOORD0.y = unity_SHAg.w;
    vs_TEXCOORD0.z = unity_SHAb.w;
    vs_TEXCOORD0.w = 0.0;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target0 = u_xlat10_0 * vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _MiHoYoTimeScale;
uniform 	mediump float _ReciprocalBurnTime;
uniform 	mediump vec4 _WindParams0;
uniform 	mediump vec4 _WindParams1;
uniform 	mediump vec4 _WindParams2;
uniform 	mediump vec4 _BaseSpeculars;
uniform 	mediump vec4 _LeafEdgeSpeculars;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _BurnedColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump vec4 _SpecularExtra;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
uniform 	mediump vec4 _Height;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec4 u_xlat8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_20;
float u_xlat22;
float u_xlat26;
mediump float u_xlat16_31;
float u_xlat33;
float u_xlat34;
float u_xlat36;
mediump float u_xlat16_42;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat11 = in_COLOR0.y + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(1.5<u_xlat11);
#else
    u_xlatb11 = 1.5<u_xlat11;
#endif
    if(u_xlatb11){
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat1;
        gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat11 = in_POSITION0.y * _Height.x;
    u_xlat11 = max(u_xlat11, 9.99999975e-05);
    u_xlat16_2.xyz = in_COLOR0.xyz * _BoundsSize.xyz + _BoundsMin.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0);
    u_xlat22 = _Time.y + (-unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x);
    u_xlat22 = u_xlat22 * _ReciprocalBurnTime;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat33 = fract(abs(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x));
    u_xlat22 = u_xlat33 * u_xlat22;
    u_xlat33 = 10000.0 * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].w;
    u_xlat33 = fract(u_xlat33);
    u_xlat3.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + (-in_POSITION0.xyz);
    u_xlat34 = (-u_xlat33) + 1.0;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat34) + in_POSITION0.xyz;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(-1.0, 0.0, -1.0) + u_xlat3.xyz;
    u_xlat34 = (-in_COLOR0.y) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
    u_xlat34 = u_xlat34 * 0.5 + in_COLOR0.y;
    u_xlat16_2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.xy = u_xlat16_2.xz * vec2(-1.0, -1.0) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xz;
    u_xlat5.z = u_xlat33 * u_xlat33;
    u_xlat33 = _WindParams1.y * 0.100000001;
    u_xlat36 = _MiHoYoWind.w * _WindParams0.x;
    u_xlat26 = log2(u_xlat11);
    u_xlat26 = u_xlat26 * 1.10000002;
    u_xlat26 = exp2(u_xlat26);
    u_xlat34 = u_xlat34 * 6.28299999;
    u_xlat4.x = dot(u_xlat4.xy, _MiHoYoWind.xz);
    u_xlat4.x = (-u_xlat4.x) * _WindParams0.y;
    u_xlat4.x = _Time.y * _WindParams2.x + u_xlat4.x;
    u_xlat33 = u_xlat34 * u_xlat33 + u_xlat4.x;
    u_xlat4.x = u_xlat33 + _WindParams2.y;
    u_xlat33 = _Time.y * _MiHoYoTimeScale.x + u_xlat34;
    u_xlat4.y = u_xlat33 + _MiHoYoTimeScale.y;
    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat6.xy = abs(u_xlat4.xy) * abs(u_xlat4.xy);
    u_xlat4.xy = -abs(u_xlat4.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat4.xy = u_xlat4.xy * u_xlat6.xy;
    u_xlat5.xy = u_xlat4.xy * vec2(u_xlat26);
    u_xlat4.xy = u_xlat5.zz * u_xlat5.xz;
    u_xlat5.xw = _MiHoYoWind.xz;
    u_xlat6.xy = u_xlat4.xx * u_xlat5.xw;
    u_xlat6.xz = vec2(u_xlat36) * u_xlat6.xy;
    u_xlat6.y = 0.0;
    u_xlat7.x = 0.0;
    u_xlat7.yz = _MiHoYoWind.zx * vec2(0.0, 1.0);
    u_xlat8.xy = _MiHoYoWind.zx * vec2(1.0, 0.0);
    u_xlat8.z = 0.0;
    u_xlat7.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat7.xyz = u_xlat4.xxx * u_xlat7.xyz;
    u_xlat7.xyz = vec3(u_xlat36) * u_xlat7.xyz;
    u_xlat8.xyz = u_xlat7.xyz * _WindParams2.zzz;
    u_xlat33 = u_xlat5.y * u_xlat4.y;
    u_xlat4.xyw = vec3(u_xlat33) * vec3(0.0848399997, 0.0, 0.0848399997);
    u_xlat33 = u_xlat26 * _MiHoYoWind.w;
    u_xlat33 = u_xlat33 * _WindParams1.x + 1.0;
    u_xlat33 = u_xlat33 * u_xlat33 + (-u_xlat33);
    u_xlat5.xy = u_xlat5.xw * vec2(u_xlat33);
    u_xlat5.xz = u_xlat5.zz * u_xlat5.xy;
    u_xlat5.y = 0.0;
    u_xlat8 = u_xlat8.xyzz * _WindParams0.wwww + u_xlat6.xyzz;
    u_xlat8 = u_xlat8 * _WindParams0.zzzz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyzz;
    u_xlat33 = dot(u_xlat8.xyw, u_xlat8.xyw);
    u_xlat33 = max(u_xlat33, 0.00100000005);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat8 = vec4(u_xlat33) * u_xlat8;
    u_xlat6.xyz = u_xlat7.xyz * _WindParams2.zzz + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyw * _WindParams2.www + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat5.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat4.xyz * vec3(0.25, 0.25, 0.25) + u_xlat3.xyz;
    u_xlat16_2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_2.xy = sqrt(u_xlat16_2.xy);
    u_xlat33 = u_xlat16_2.x + 0.00100000005;
    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat33);
    u_xlat1.xyz = u_xlat3.xyz * u_xlat16_2.yyy + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    u_xlat33 = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat33 * 0.5;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat16_3 = _Color + (-_Color2);
    u_xlat16_3 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].wwww * u_xlat16_3 + _Color2;
    u_xlat16_4 = (-u_xlat16_3) + _BurnedColor;
    u_xlat16_3 = vec4(u_xlat22) * u_xlat16_4 + u_xlat16_3;
    u_xlat0.xzw = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx;
    u_xlat16_9.x = dot((-u_xlat0.xzw), u_xlat8.xyz);
    u_xlat16_9.x = u_xlat16_9.x + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat8.y * (-u_xlat16_9.x) + (-u_xlat0.z);
    u_xlat1.x = u_xlat16_9.x + (-_WorldSpaceLightPos0.y);
    u_xlat1.y = _SpecularExtra.x * u_xlat1.x + _WorldSpaceLightPos0.y;
    u_xlat1.xz = _WorldSpaceLightPos0.xz;
    u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
    u_xlat16_9.xyz = u_xlat1.xyz * u_xlat16_9.xxx + u_xlat0.xzw;
    u_xlat16_42 = dot(u_xlat16_9.xyz, u_xlat16_9.xyz);
    u_xlat16_42 = inversesqrt(u_xlat16_42);
    u_xlat16_9.xyz = vec3(u_xlat16_42) * u_xlat16_9.xyz;
    u_xlat16_42 = dot(u_xlat8.xyw, u_xlat16_9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_42 = min(max(u_xlat16_42, 0.0), 1.0);
#else
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
#endif
    u_xlat16_9.x = dot(u_xlat16_9.xyz, u_xlat0.xzw);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
    u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat8.xyw, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat22 = _LeafEdgeSpeculars.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_3 * _BaseSpeculars.xxxx;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat22 * u_xlat22;
    u_xlat16_20 = u_xlat22 * u_xlat22;
    u_xlat16_31 = u_xlat16_20 * u_xlat16_20;
    u_xlat16_42 = u_xlat16_42 * u_xlat16_42;
    u_xlat16_20 = u_xlat16_20 * u_xlat16_20 + -1.0;
    u_xlat16_20 = u_xlat16_42 * u_xlat16_20 + 1.0;
    u_xlat16_31 = u_xlat16_31 * 0.5;
    u_xlat16_20 = u_xlat16_20 * u_xlat16_20 + 9.99999975e-05;
    u_xlat16_20 = float(1.0) / float(u_xlat16_20);
    u_xlat16_20 = u_xlat16_20 * u_xlat16_31;
    u_xlat16_20 = u_xlat0.x * u_xlat16_20;
    u_xlat16_20 = min(u_xlat16_20, 16.0);
    u_xlat16_9.x = (-u_xlat16_9.x) + 1.0;
    u_xlat16_31 = u_xlat16_9.x * u_xlat16_9.x;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_42 = u_xlat16_31 * u_xlat16_9.x;
    u_xlat16_9.x = (-u_xlat16_9.x) * u_xlat16_31 + 1.0;
    u_xlat16_1 = u_xlat16_9.xxxx * u_xlat16_1 + vec4(u_xlat16_42);
    u_xlat1 = u_xlat16_1 * vec4(u_xlat16_20);
    u_xlat16_1 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat1 = u_xlat16_1 * _LeafEdgeSpeculars.xxxx;
    u_xlat22 = (-_LeafEdgeSpeculars.z) + 1.0;
    u_xlat11 = u_xlat11 * u_xlat22 + _LeafEdgeSpeculars.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat1 = vec4(u_xlat11) * u_xlat1;
    u_xlat1 = u_xlat1 * _LightColor0;
    u_xlat16_9.x = _SpecularColor.w * 10.0 + _LeafEdgeSpeculars.x;
    u_xlat1 = u_xlat1 * u_xlat16_9.xxxx;
    u_xlat3.xyz = u_xlat8.xyw;
    u_xlat3.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4 = u_xlat8.ywzx * u_xlat8;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_42 = u_xlat3.y * u_xlat3.y;
    u_xlat16_42 = u_xlat3.x * u_xlat3.x + (-u_xlat16_42);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_42) + u_xlat16_10.xyz;
    vs_TEXCOORD0.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    vs_TEXCOORD1 = _LightColor0 * u_xlat0.xxxx + u_xlat1;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.w = 0.0;
    vs_TEXCOORD3.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target0 = u_xlat10_0 * vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
float u_xlat5;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(1.5<in_COLOR0.y);
#else
    u_xlatb0 = 1.5<in_COLOR0.y;
#endif
    if(u_xlatb0){
        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xy = in_COLOR0.xz * _BoundsSize.xz + _BoundsMin.xz;
    u_xlat0 = (-u_xlat16_1.yyyy) * hlslcc_mtx4x4unity_MatrixVP[2];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * (-u_xlat16_1.xxxx) + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat5 * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.x = unity_SHAr.w;
    vs_TEXCOORD0.y = unity_SHAg.w;
    vs_TEXCOORD0.z = unity_SHAb.w;
    vs_TEXCOORD0.w = 0.0;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target0 = u_xlat10_0 * vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _MiHoYoTimeScale;
uniform 	mediump float _ReciprocalBurnTime;
uniform 	mediump vec4 _WindParams0;
uniform 	mediump vec4 _WindParams1;
uniform 	mediump vec4 _WindParams2;
uniform 	mediump vec4 _BaseSpeculars;
uniform 	mediump vec4 _LeafEdgeSpeculars;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _BurnedColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	mediump vec4 _SpecularExtra;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
uniform 	mediump vec4 _Height;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
float u_xlat12;
bool u_xlatb12;
float u_xlat17;
mediump float u_xlat16_22;
float u_xlat24;
vec2 u_xlat27;
vec2 u_xlat29;
mediump float u_xlat16_34;
float u_xlat36;
float u_xlat37;
mediump float u_xlat16_38;
float u_xlat39;
float u_xlat40;
mediump float u_xlat16_46;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat12 = in_COLOR0.y + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(1.5<u_xlat12);
#else
    u_xlatb12 = 1.5<u_xlat12;
#endif
    if(u_xlatb12){
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat1;
        gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat12 = in_POSITION0.y * _Height.x;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat16_2.xyz = in_COLOR0.xyz * _BoundsSize.xyz + _BoundsMin.xyz;
    u_xlat24 = _Time.y + (-unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x);
    u_xlat24 = u_xlat24 * _ReciprocalBurnTime;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat36 = fract(abs(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x));
    u_xlat24 = u_xlat36 * u_xlat24;
    u_xlat36 = 10000.0 * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].w;
    u_xlat36 = fract(u_xlat36);
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + (-in_POSITION0.xyz);
    u_xlat37 = (-u_xlat36) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat37) + in_POSITION0.xyz;
    u_xlat1.xyz = (-u_xlat16_2.xyz) * vec3(-1.0, 0.0, -1.0) + u_xlat1.xyz;
    u_xlat37 = (-in_COLOR0.y) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
    u_xlat37 = u_xlat37 * 0.5 + in_COLOR0.y;
    u_xlat16_38 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_38 = sqrt(u_xlat16_38);
    u_xlat3.xy = u_xlat16_2.xz * vec2(-1.0, -1.0) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xz;
    u_xlat4.z = u_xlat36 * u_xlat36;
    u_xlat27.x = _WindParams1.y * 0.100000001;
    u_xlat39 = _MiHoYoWind.w * _WindParams0.x;
    u_xlat40 = log2(u_xlat12);
    u_xlat40 = u_xlat40 * 1.10000002;
    u_xlat40 = exp2(u_xlat40);
    u_xlat5.x = u_xlat37 * 6.28299999;
    u_xlat17 = dot(u_xlat3.xy, _MiHoYoWind.xz);
    u_xlat17 = (-u_xlat17) * _WindParams0.y;
    u_xlat17 = _Time.y * _WindParams2.x + u_xlat17;
    u_xlat27.x = u_xlat5.x * u_xlat27.x + u_xlat17;
    u_xlat6.x = u_xlat27.x + _WindParams2.y;
    u_xlat27.x = _Time.y * _MiHoYoTimeScale.x + u_xlat5.x;
    u_xlat6.y = u_xlat27.x + _MiHoYoTimeScale.y;
    u_xlat5.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat5.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat29.xy = abs(u_xlat5.xy) * abs(u_xlat5.xy);
    u_xlat5.xy = -abs(u_xlat5.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat5.xy = u_xlat5.xy * u_xlat29.xy;
    u_xlat4.xy = vec2(u_xlat40) * u_xlat5.xy;
    u_xlat5.xy = u_xlat4.zz * u_xlat4.xz;
    u_xlat29.xy = _MiHoYoWind.xz;
    u_xlat6.xy = u_xlat29.xy * u_xlat5.xx;
    u_xlat6.xz = vec2(u_xlat39) * u_xlat6.xy;
    u_xlat6.y = 0.0;
    u_xlat7.x = 0.0;
    u_xlat7.yz = _MiHoYoWind.zx * vec2(0.0, 1.0);
    u_xlat8.xy = _MiHoYoWind.zx * vec2(1.0, 0.0);
    u_xlat8.z = 0.0;
    u_xlat7.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat7.xyz = u_xlat5.xxx * u_xlat7.xyz;
    u_xlat7.xyz = vec3(u_xlat39) * u_xlat7.xyz;
    u_xlat8.xyz = u_xlat7.xyz * _WindParams2.zzz;
    u_xlat27.x = u_xlat4.y * u_xlat5.y;
    u_xlat9.xyz = u_xlat27.xxx * vec3(0.0848399997, 0.0, 0.0848399997);
    u_xlat27.x = u_xlat40 * _MiHoYoWind.w;
    u_xlat27.x = u_xlat27.x * _WindParams1.x + 1.0;
    u_xlat27.x = u_xlat27.x * u_xlat27.x + (-u_xlat27.x);
    u_xlat27.xy = u_xlat29.xy * u_xlat27.xx;
    u_xlat4.xz = u_xlat4.zz * u_xlat27.xy;
    u_xlat4.y = 0.0;
    u_xlat5 = u_xlat8.xyzz * _WindParams0.wwww + u_xlat6.xyzz;
    u_xlat5 = u_xlat5 * _WindParams0.zzzz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyzz;
    u_xlat27.x = dot(u_xlat5.xyw, u_xlat5.xyw);
    u_xlat27.x = max(u_xlat27.x, 0.00100000005);
    u_xlat27.x = inversesqrt(u_xlat27.x);
    u_xlat5 = u_xlat27.xxxx * u_xlat5;
    u_xlat6.xyz = u_xlat7.xyz * _WindParams2.zzz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat9.xyz * _WindParams2.www + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat4.xyz * vec3(0.25, 0.25, 0.25) + u_xlat1.xyz;
    u_xlat16_10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_10.x = sqrt(u_xlat16_10.x);
    u_xlat27.x = u_xlat16_10.x + 0.00100000005;
    u_xlat1.xyz = u_xlat1.xyz / u_xlat27.xxx;
    u_xlat36 = u_xlat36 * u_xlat16_38;
    u_xlat3.xy = u_xlat3.xy + (-_GrassDisplacementArea.xy);
    u_xlat3.xy = vec2(u_xlat3.x / _GrassDisplacementArea.z, u_xlat3.y / _GrassDisplacementArea.w);
    u_xlat3.xyz = textureLod(_GrassDisplacementTex, u_xlat3.xy, 0.0).xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat39 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat39 = sqrt(u_xlat39);
    u_xlat3.xy = vec2(u_xlat36) * u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * _DisplacementParam.xx;
    u_xlat37 = u_xlat37 * 0.649999976 + 1.13;
    u_xlat3.xy = vec2(u_xlat37) * u_xlat3.xy;
    u_xlat4.xz = u_xlat3.xy * vec2(0.75, 0.75);
    u_xlat36 = u_xlat36 * u_xlat39;
    u_xlat36 = u_xlat36 * _DisplacementParam.y;
    u_xlat37 = max(u_xlat3.z, _DisplacementParam.z);
    u_xlat37 = min(u_xlat37, _DisplacementParam.w);
    u_xlat4.y = (-u_xlat36) * u_xlat37;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat16_38) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    u_xlat36 = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat36 * 0.5;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat16_3 = _Color + (-_Color2);
    u_xlat16_3 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].wwww * u_xlat16_3 + _Color2;
    u_xlat16_4 = (-u_xlat16_3) + _BurnedColor;
    u_xlat16_3 = vec4(u_xlat24) * u_xlat16_4 + u_xlat16_3;
    u_xlat0.xzw = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx;
    u_xlat16_10.x = dot((-u_xlat0.xzw), u_xlat5.xyz);
    u_xlat16_10.x = u_xlat16_10.x + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat5.y * (-u_xlat16_10.x) + (-u_xlat0.z);
    u_xlat1.x = u_xlat16_10.x + (-_WorldSpaceLightPos0.y);
    u_xlat1.y = _SpecularExtra.x * u_xlat1.x + _WorldSpaceLightPos0.y;
    u_xlat1.xz = _WorldSpaceLightPos0.xz;
    u_xlat16_10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat1.xyz * u_xlat16_10.xxx + u_xlat0.xzw;
    u_xlat16_46 = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_46 = inversesqrt(u_xlat16_46);
    u_xlat16_10.xyz = vec3(u_xlat16_46) * u_xlat16_10.xyz;
    u_xlat16_46 = dot(u_xlat5.xyw, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_46 = min(max(u_xlat16_46, 0.0), 1.0);
#else
    u_xlat16_46 = clamp(u_xlat16_46, 0.0, 1.0);
#endif
    u_xlat16_10.x = dot(u_xlat16_10.xyz, u_xlat0.xzw);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10.x = min(max(u_xlat16_10.x, 0.0), 1.0);
#else
    u_xlat16_10.x = clamp(u_xlat16_10.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat5.xyw, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat24 = _LeafEdgeSpeculars.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_3 * _BaseSpeculars.xxxx;
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = u_xlat24 * u_xlat24;
    u_xlat16_22 = u_xlat24 * u_xlat24;
    u_xlat16_34 = u_xlat16_22 * u_xlat16_22;
    u_xlat16_46 = u_xlat16_46 * u_xlat16_46;
    u_xlat16_22 = u_xlat16_22 * u_xlat16_22 + -1.0;
    u_xlat16_22 = u_xlat16_46 * u_xlat16_22 + 1.0;
    u_xlat16_34 = u_xlat16_34 * 0.5;
    u_xlat16_22 = u_xlat16_22 * u_xlat16_22 + 9.99999975e-05;
    u_xlat16_22 = float(1.0) / float(u_xlat16_22);
    u_xlat16_22 = u_xlat16_22 * u_xlat16_34;
    u_xlat16_22 = u_xlat0.x * u_xlat16_22;
    u_xlat16_22 = min(u_xlat16_22, 16.0);
    u_xlat16_10.x = (-u_xlat16_10.x) + 1.0;
    u_xlat16_34 = u_xlat16_10.x * u_xlat16_10.x;
    u_xlat16_34 = u_xlat16_34 * u_xlat16_34;
    u_xlat16_46 = u_xlat16_34 * u_xlat16_10.x;
    u_xlat16_10.x = (-u_xlat16_10.x) * u_xlat16_34 + 1.0;
    u_xlat16_1 = u_xlat16_10.xxxx * u_xlat16_1 + vec4(u_xlat16_46);
    u_xlat1 = u_xlat16_1 * vec4(u_xlat16_22);
    u_xlat16_1 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat1 = u_xlat16_1 * _LeafEdgeSpeculars.xxxx;
    u_xlat24 = (-_LeafEdgeSpeculars.z) + 1.0;
    u_xlat12 = u_xlat12 * u_xlat24 + _LeafEdgeSpeculars.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1 = vec4(u_xlat12) * u_xlat1;
    u_xlat1 = u_xlat1 * _LightColor0;
    u_xlat16_10.x = _SpecularColor.w * 10.0 + _LeafEdgeSpeculars.x;
    u_xlat1 = u_xlat1 * u_xlat16_10.xxxx;
    u_xlat3.xyz = u_xlat5.xyw;
    u_xlat3.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4 = u_xlat5.ywzx * u_xlat5;
    u_xlat16_11.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_11.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_11.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_46 = u_xlat3.y * u_xlat3.y;
    u_xlat16_46 = u_xlat3.x * u_xlat3.x + (-u_xlat16_46);
    u_xlat16_11.xyz = unity_SHC.xyz * vec3(u_xlat16_46) + u_xlat16_11.xyz;
    vs_TEXCOORD0.xyz = u_xlat16_10.xyz + u_xlat16_11.xyz;
    vs_TEXCOORD1 = _LightColor0 * u_xlat0.xxxx + u_xlat1;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.w = 0.0;
    vs_TEXCOORD3.zw = u_xlat2.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target0 = u_xlat10_0 * vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
Keywords { "MIHOYO_GRASS_DISPLACEMENT" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" }
""
}
}
}
 Pass {
  LOD 100
  Tags { "LIGHTMODE" = "CUSTOMPREPASSFINAL" "QUEUE" = "AlphaTest" "RenderType" = "Opaque" }
  ZTest Equal
  ZWrite Off
  Cull Off
  GpuProgramID 150460
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
float u_xlat5;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(1.5<in_COLOR0.y);
#else
    u_xlatb0 = 1.5<in_COLOR0.y;
#endif
    if(u_xlatb0){
        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xy = in_COLOR0.xz * _BoundsSize.xz + _BoundsMin.xz;
    u_xlat0 = (-u_xlat16_1.yyyy) * hlslcc_mtx4x4unity_MatrixVP[2];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * (-u_xlat16_1.xxxx) + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat5 * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.x = unity_SHAr.w;
    vs_TEXCOORD0.y = unity_SHAg.w;
    vs_TEXCOORD0.z = unity_SHAb.w;
    vs_TEXCOORD0.w = 0.0;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target0 = u_xlat10_0 * vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _MiHoYoTimeScale;
uniform 	mediump vec4 _WindParams0;
uniform 	mediump vec4 _WindParams1;
uniform 	mediump vec4 _WindParams2;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
uniform 	mediump vec4 _Height;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec4 u_xlat8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
bool u_xlatb11;
float u_xlat12;
vec2 u_xlat22;
vec2 u_xlat26;
float u_xlat33;
float u_xlat34;
float u_xlat36;
mediump float u_xlat16_42;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat11.x = in_COLOR0.y + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(1.5<u_xlat11.x);
#else
    u_xlatb11 = 1.5<u_xlat11.x;
#endif
    if(u_xlatb11){
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat1;
        gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat11.x = in_POSITION0.y * _Height.x;
    u_xlat11.x = max(u_xlat11.x, 9.99999975e-05);
    u_xlat16_2.xyz = in_COLOR0.xyz * _BoundsSize.xyz + _BoundsMin.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0);
    u_xlat22.x = 10000.0 * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].w;
    u_xlat22.x = fract(u_xlat22.x);
    u_xlat3.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + (-in_POSITION0.xyz);
    u_xlat33 = (-u_xlat22.x) + 1.0;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat33) + in_POSITION0.xyz;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(-1.0, 0.0, -1.0) + u_xlat3.xyz;
    u_xlat33 = (-in_COLOR0.y) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
    u_xlat11.z = u_xlat33 * 0.5 + in_COLOR0.y;
    u_xlat16_2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.xy = u_xlat16_2.xz * vec2(-1.0, -1.0) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xz;
    u_xlat5.z = u_xlat22.x * u_xlat22.x;
    u_xlat22.x = _WindParams1.y * 0.100000001;
    u_xlat34 = _MiHoYoWind.w * _WindParams0.x;
    u_xlat11.x = log2(u_xlat11.x);
    u_xlat11.xz = u_xlat11.xz * vec2(1.10000002, 6.28299999);
    u_xlat11.x = exp2(u_xlat11.x);
    u_xlat36 = dot(u_xlat4.xy, _MiHoYoWind.xz);
    u_xlat36 = (-u_xlat36) * _WindParams0.y;
    u_xlat36 = _Time.y * _WindParams2.x + u_xlat36;
    u_xlat22.x = u_xlat11.z * u_xlat22.x + u_xlat36;
    u_xlat4.x = u_xlat22.x + _WindParams2.y;
    u_xlat22.x = _Time.y * _MiHoYoTimeScale.x + u_xlat11.z;
    u_xlat4.y = u_xlat22.x + _MiHoYoTimeScale.y;
    u_xlat22.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4.xy = abs(u_xlat22.xy) * abs(u_xlat22.xy);
    u_xlat22.xy = -abs(u_xlat22.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat22.xy = u_xlat22.xy * u_xlat4.xy;
    u_xlat5.xy = u_xlat22.xy * u_xlat11.xx;
    u_xlat22.xy = u_xlat5.zz * u_xlat5.xz;
    u_xlat4.xy = _MiHoYoWind.xz;
    u_xlat26.xy = u_xlat22.xx * u_xlat4.xy;
    u_xlat6.xz = vec2(u_xlat34) * u_xlat26.xy;
    u_xlat6.y = 0.0;
    u_xlat7.x = 0.0;
    u_xlat7.yz = _MiHoYoWind.zx * vec2(0.0, 1.0);
    u_xlat8.xy = _MiHoYoWind.zx * vec2(1.0, 0.0);
    u_xlat8.z = 0.0;
    u_xlat7.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat7.xyz = u_xlat22.xxx * u_xlat7.xyz;
    u_xlat7.xyz = vec3(u_xlat34) * u_xlat7.xyz;
    u_xlat8.xyz = u_xlat7.xyz * _WindParams2.zzz;
    u_xlat22.x = u_xlat5.y * u_xlat22.y;
    u_xlat5.xyw = u_xlat22.xxx * vec3(0.0848399997, 0.0, 0.0848399997);
    u_xlat11.x = u_xlat11.x * _MiHoYoWind.w;
    u_xlat11.x = u_xlat11.x * _WindParams1.x + 1.0;
    u_xlat11.x = u_xlat11.x * u_xlat11.x + (-u_xlat11.x);
    u_xlat11.xy = u_xlat4.xy * u_xlat11.xx;
    u_xlat4.xz = u_xlat5.zz * u_xlat11.xy;
    u_xlat4.y = 0.0;
    u_xlat8 = u_xlat8.xyzz * _WindParams0.wwww + u_xlat6.xyzz;
    u_xlat8 = u_xlat8 * _WindParams0.zzzz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyzz;
    u_xlat11.x = dot(u_xlat8.xyw, u_xlat8.xyw);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat8 = u_xlat11.xxxx * u_xlat8;
    u_xlat11.xyz = u_xlat7.xyz * _WindParams2.zzz + u_xlat6.xyz;
    u_xlat11.xyz = u_xlat5.xyw * _WindParams2.www + u_xlat11.xyz;
    u_xlat11.xyz = u_xlat4.xyz + u_xlat11.xyz;
    u_xlat11.xyz = u_xlat11.xyz * vec3(0.25, 0.25, 0.25) + u_xlat3.xyz;
    u_xlat16_2.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat16_2.xy = sqrt(u_xlat16_2.xy);
    u_xlat34 = u_xlat16_2.x + 0.00100000005;
    u_xlat11.xyz = u_xlat11.xyz / vec3(u_xlat34);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat16_2.yyy + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat11.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat12 * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(u_xlat8.xyw, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat8.xyw;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3 = u_xlat8.ywzx * u_xlat8;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_42 = u_xlat2.y * u_xlat2.y;
    u_xlat16_42 = u_xlat2.x * u_xlat2.x + (-u_xlat16_42);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_42) + u_xlat16_10.xyz;
    vs_TEXCOORD0.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    vs_TEXCOORD1 = u_xlat1.xxxx * _LightColor0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.w = 0.0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target0 = u_xlat10_0 * vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
float u_xlat5;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(1.5<in_COLOR0.y);
#else
    u_xlatb0 = 1.5<in_COLOR0.y;
#endif
    if(u_xlatb0){
        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xy = in_COLOR0.xz * _BoundsSize.xz + _BoundsMin.xz;
    u_xlat0 = (-u_xlat16_1.yyyy) * hlslcc_mtx4x4unity_MatrixVP[2];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * (-u_xlat16_1.xxxx) + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat5 * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.x = unity_SHAr.w;
    vs_TEXCOORD0.y = unity_SHAg.w;
    vs_TEXCOORD0.z = unity_SHAb.w;
    vs_TEXCOORD0.w = 0.0;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target0 = u_xlat10_0 * vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _MiHoYoTimeScale;
uniform 	mediump vec4 _WindParams0;
uniform 	mediump vec4 _WindParams1;
uniform 	mediump vec4 _WindParams2;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
uniform 	mediump vec4 _Height;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec4 u_xlat8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
bool u_xlatb11;
float u_xlat12;
float u_xlat22;
vec2 u_xlat25;
vec2 u_xlat27;
float u_xlat33;
float u_xlat34;
mediump float u_xlat16_35;
float u_xlat36;
float u_xlat37;
mediump float u_xlat16_42;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat11.x = in_COLOR0.y + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(1.5<u_xlat11.x);
#else
    u_xlatb11 = 1.5<u_xlat11.x;
#endif
    if(u_xlatb11){
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat1;
        gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat11.x = in_POSITION0.y * _Height.x;
    u_xlat11.x = max(u_xlat11.x, 9.99999975e-05);
    u_xlat16_2.xyz = in_COLOR0.xyz * _BoundsSize.xyz + _BoundsMin.xyz;
    u_xlat22 = 10000.0 * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].w;
    u_xlat22 = fract(u_xlat22);
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + (-in_POSITION0.xyz);
    u_xlat33 = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat33) + in_POSITION0.xyz;
    u_xlat1.xyz = (-u_xlat16_2.xyz) * vec3(-1.0, 0.0, -1.0) + u_xlat1.xyz;
    u_xlat33 = (-in_COLOR0.y) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
    u_xlat33 = u_xlat33 * 0.5 + in_COLOR0.y;
    u_xlat16_35 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_35 = sqrt(u_xlat16_35);
    u_xlat3.xy = u_xlat16_2.xz * vec2(-1.0, -1.0) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xz;
    u_xlat4.z = u_xlat22 * u_xlat22;
    u_xlat34 = _WindParams1.y * 0.100000001;
    u_xlat25.x = _MiHoYoWind.w * _WindParams0.x;
    u_xlat11.x = log2(u_xlat11.x);
    u_xlat11.x = u_xlat11.x * 1.10000002;
    u_xlat11.x = exp2(u_xlat11.x);
    u_xlat36 = u_xlat33 * 6.28299999;
    u_xlat37 = dot(u_xlat3.xy, _MiHoYoWind.xz);
    u_xlat37 = (-u_xlat37) * _WindParams0.y;
    u_xlat37 = _Time.y * _WindParams2.x + u_xlat37;
    u_xlat34 = u_xlat36 * u_xlat34 + u_xlat37;
    u_xlat5.x = u_xlat34 + _WindParams2.y;
    u_xlat34 = _Time.y * _MiHoYoTimeScale.x + u_xlat36;
    u_xlat5.y = u_xlat34 + _MiHoYoTimeScale.y;
    u_xlat5.xy = u_xlat5.xy + vec2(0.5, 0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat5.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat27.xy = abs(u_xlat5.xy) * abs(u_xlat5.xy);
    u_xlat5.xy = -abs(u_xlat5.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat5.xy = u_xlat5.xy * u_xlat27.xy;
    u_xlat4.xy = u_xlat11.xx * u_xlat5.xy;
    u_xlat4.xw = u_xlat4.zz * u_xlat4.xz;
    u_xlat5.xy = _MiHoYoWind.xz;
    u_xlat27.xy = u_xlat4.xx * u_xlat5.xy;
    u_xlat6.xz = u_xlat25.xx * u_xlat27.xy;
    u_xlat6.y = 0.0;
    u_xlat7.x = 0.0;
    u_xlat7.yz = _MiHoYoWind.zx * vec2(0.0, 1.0);
    u_xlat8.xy = _MiHoYoWind.zx * vec2(1.0, 0.0);
    u_xlat8.z = 0.0;
    u_xlat7.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat7.xyz = u_xlat4.xxx * u_xlat7.xyz;
    u_xlat7.xyz = u_xlat25.xxx * u_xlat7.xyz;
    u_xlat8.xyz = u_xlat7.xyz * _WindParams2.zzz;
    u_xlat34 = u_xlat4.y * u_xlat4.w;
    u_xlat4.xyw = vec3(u_xlat34) * vec3(0.0848399997, 0.0, 0.0848399997);
    u_xlat11.x = u_xlat11.x * _MiHoYoWind.w;
    u_xlat11.x = u_xlat11.x * _WindParams1.x + 1.0;
    u_xlat11.x = u_xlat11.x * u_xlat11.x + (-u_xlat11.x);
    u_xlat25.xy = u_xlat5.xy * u_xlat11.xx;
    u_xlat5.xz = u_xlat4.zz * u_xlat25.xy;
    u_xlat5.y = 0.0;
    u_xlat8 = u_xlat8.xyzz * _WindParams0.wwww + u_xlat6.xyzz;
    u_xlat8 = u_xlat8 * _WindParams0.zzzz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyzz;
    u_xlat11.x = dot(u_xlat8.xyw, u_xlat8.xyw);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat8 = u_xlat11.xxxx * u_xlat8;
    u_xlat6.xyz = u_xlat7.xyz * _WindParams2.zzz + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyw * _WindParams2.www + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat5.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat4.xyz * vec3(0.25, 0.25, 0.25) + u_xlat1.xyz;
    u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_9.x = sqrt(u_xlat16_9.x);
    u_xlat11.x = u_xlat16_9.x + 0.00100000005;
    u_xlat1.xyz = u_xlat1.xyz / u_xlat11.xxx;
    u_xlat11.x = u_xlat22 * u_xlat16_35;
    u_xlat3.xy = u_xlat3.xy + (-_GrassDisplacementArea.xy);
    u_xlat3.xy = vec2(u_xlat3.x / _GrassDisplacementArea.z, u_xlat3.y / _GrassDisplacementArea.w);
    u_xlat3.xyz = textureLod(_GrassDisplacementTex, u_xlat3.xy, 0.0).xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat22 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat3.xy = u_xlat11.xx * u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * _DisplacementParam.xx;
    u_xlat33 = u_xlat33 * 0.649999976 + 1.13;
    u_xlat3.xy = vec2(u_xlat33) * u_xlat3.xy;
    u_xlat4.xz = u_xlat3.xy * vec2(0.75, 0.75);
    u_xlat11.x = u_xlat11.x * u_xlat22;
    u_xlat11.x = u_xlat11.x * _DisplacementParam.y;
    u_xlat22 = max(u_xlat3.z, _DisplacementParam.z);
    u_xlat22 = min(u_xlat22, _DisplacementParam.w);
    u_xlat4.y = u_xlat22 * (-u_xlat11.x);
    u_xlat11.xyz = u_xlat1.xyz * vec3(u_xlat16_35) + u_xlat4.xyz;
    u_xlat11.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + u_xlat11.xyz;
    u_xlat0.xyz = u_xlat11.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat12 * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(u_xlat8.xyw, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat8.xyw;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3 = u_xlat8.ywzx * u_xlat8;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_42 = u_xlat2.y * u_xlat2.y;
    u_xlat16_42 = u_xlat2.x * u_xlat2.x + (-u_xlat16_42);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_42) + u_xlat16_10.xyz;
    vs_TEXCOORD0.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    vs_TEXCOORD1 = u_xlat1.xxxx * _LightColor0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.w = 0.0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target0 = u_xlat10_0 * vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
Keywords { "MIHOYO_GRASS_DISPLACEMENT" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" }
""
}
}
}
 Pass {
  LOD 100
  Tags { "LIGHTMODE" = "DepthOnly" "QUEUE" = "AlphaTest" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 203214
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
float u_xlat5;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(1.5<in_COLOR0.y);
#else
    u_xlatb0 = 1.5<in_COLOR0.y;
#endif
    if(u_xlatb0){
        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xy = in_COLOR0.xz * _BoundsSize.xz + _BoundsMin.xz;
    u_xlat0 = (-u_xlat16_1.yyyy) * hlslcc_mtx4x4unity_MatrixVP[2];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * (-u_xlat16_1.xxxx) + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat5 * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.x = unity_SHAr.w;
    vs_TEXCOORD0.y = unity_SHAg.w;
    vs_TEXCOORD0.z = unity_SHAb.w;
    vs_TEXCOORD0.w = 0.0;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target0 = u_xlat10_0 * vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _MiHoYoTimeScale;
uniform 	mediump vec4 _WindParams0;
uniform 	mediump vec4 _WindParams1;
uniform 	mediump vec4 _WindParams2;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
uniform 	mediump vec4 _Height;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec4 u_xlat8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
bool u_xlatb11;
float u_xlat12;
vec2 u_xlat22;
vec2 u_xlat26;
float u_xlat33;
float u_xlat34;
float u_xlat36;
mediump float u_xlat16_42;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat11.x = in_COLOR0.y + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(1.5<u_xlat11.x);
#else
    u_xlatb11 = 1.5<u_xlat11.x;
#endif
    if(u_xlatb11){
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat1;
        gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat11.x = in_POSITION0.y * _Height.x;
    u_xlat11.x = max(u_xlat11.x, 9.99999975e-05);
    u_xlat16_2.xyz = in_COLOR0.xyz * _BoundsSize.xyz + _BoundsMin.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0);
    u_xlat22.x = 10000.0 * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].w;
    u_xlat22.x = fract(u_xlat22.x);
    u_xlat3.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + (-in_POSITION0.xyz);
    u_xlat33 = (-u_xlat22.x) + 1.0;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat33) + in_POSITION0.xyz;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(-1.0, 0.0, -1.0) + u_xlat3.xyz;
    u_xlat33 = (-in_COLOR0.y) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
    u_xlat11.z = u_xlat33 * 0.5 + in_COLOR0.y;
    u_xlat16_2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.xy = u_xlat16_2.xz * vec2(-1.0, -1.0) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xz;
    u_xlat5.z = u_xlat22.x * u_xlat22.x;
    u_xlat22.x = _WindParams1.y * 0.100000001;
    u_xlat34 = _MiHoYoWind.w * _WindParams0.x;
    u_xlat11.x = log2(u_xlat11.x);
    u_xlat11.xz = u_xlat11.xz * vec2(1.10000002, 6.28299999);
    u_xlat11.x = exp2(u_xlat11.x);
    u_xlat36 = dot(u_xlat4.xy, _MiHoYoWind.xz);
    u_xlat36 = (-u_xlat36) * _WindParams0.y;
    u_xlat36 = _Time.y * _WindParams2.x + u_xlat36;
    u_xlat22.x = u_xlat11.z * u_xlat22.x + u_xlat36;
    u_xlat4.x = u_xlat22.x + _WindParams2.y;
    u_xlat22.x = _Time.y * _MiHoYoTimeScale.x + u_xlat11.z;
    u_xlat4.y = u_xlat22.x + _MiHoYoTimeScale.y;
    u_xlat22.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4.xy = abs(u_xlat22.xy) * abs(u_xlat22.xy);
    u_xlat22.xy = -abs(u_xlat22.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat22.xy = u_xlat22.xy * u_xlat4.xy;
    u_xlat5.xy = u_xlat22.xy * u_xlat11.xx;
    u_xlat22.xy = u_xlat5.zz * u_xlat5.xz;
    u_xlat4.xy = _MiHoYoWind.xz;
    u_xlat26.xy = u_xlat22.xx * u_xlat4.xy;
    u_xlat6.xz = vec2(u_xlat34) * u_xlat26.xy;
    u_xlat6.y = 0.0;
    u_xlat7.x = 0.0;
    u_xlat7.yz = _MiHoYoWind.zx * vec2(0.0, 1.0);
    u_xlat8.xy = _MiHoYoWind.zx * vec2(1.0, 0.0);
    u_xlat8.z = 0.0;
    u_xlat7.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat7.xyz = u_xlat22.xxx * u_xlat7.xyz;
    u_xlat7.xyz = vec3(u_xlat34) * u_xlat7.xyz;
    u_xlat8.xyz = u_xlat7.xyz * _WindParams2.zzz;
    u_xlat22.x = u_xlat5.y * u_xlat22.y;
    u_xlat5.xyw = u_xlat22.xxx * vec3(0.0848399997, 0.0, 0.0848399997);
    u_xlat11.x = u_xlat11.x * _MiHoYoWind.w;
    u_xlat11.x = u_xlat11.x * _WindParams1.x + 1.0;
    u_xlat11.x = u_xlat11.x * u_xlat11.x + (-u_xlat11.x);
    u_xlat11.xy = u_xlat4.xy * u_xlat11.xx;
    u_xlat4.xz = u_xlat5.zz * u_xlat11.xy;
    u_xlat4.y = 0.0;
    u_xlat8 = u_xlat8.xyzz * _WindParams0.wwww + u_xlat6.xyzz;
    u_xlat8 = u_xlat8 * _WindParams0.zzzz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyzz;
    u_xlat11.x = dot(u_xlat8.xyw, u_xlat8.xyw);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat8 = u_xlat11.xxxx * u_xlat8;
    u_xlat11.xyz = u_xlat7.xyz * _WindParams2.zzz + u_xlat6.xyz;
    u_xlat11.xyz = u_xlat5.xyw * _WindParams2.www + u_xlat11.xyz;
    u_xlat11.xyz = u_xlat4.xyz + u_xlat11.xyz;
    u_xlat11.xyz = u_xlat11.xyz * vec3(0.25, 0.25, 0.25) + u_xlat3.xyz;
    u_xlat16_2.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat16_2.xy = sqrt(u_xlat16_2.xy);
    u_xlat34 = u_xlat16_2.x + 0.00100000005;
    u_xlat11.xyz = u_xlat11.xyz / vec3(u_xlat34);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat16_2.yyy + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat11.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat12 * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(u_xlat8.xyw, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat8.xyw;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3 = u_xlat8.ywzx * u_xlat8;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_42 = u_xlat2.y * u_xlat2.y;
    u_xlat16_42 = u_xlat2.x * u_xlat2.x + (-u_xlat16_42);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_42) + u_xlat16_10.xyz;
    vs_TEXCOORD0.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    vs_TEXCOORD1 = u_xlat1.xxxx * _LightColor0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.w = 0.0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target0 = u_xlat10_0 * vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
vec4 u_xlat2;
float u_xlat5;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(1.5<in_COLOR0.y);
#else
    u_xlatb0 = 1.5<in_COLOR0.y;
#endif
    if(u_xlatb0){
        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xy = in_COLOR0.xz * _BoundsSize.xz + _BoundsMin.xz;
    u_xlat0 = (-u_xlat16_1.yyyy) * hlslcc_mtx4x4unity_MatrixVP[2];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * (-u_xlat16_1.xxxx) + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat5 = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat5 * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.x = unity_SHAr.w;
    vs_TEXCOORD0.y = unity_SHAg.w;
    vs_TEXCOORD0.z = unity_SHAb.w;
    vs_TEXCOORD0.w = 0.0;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target0 = u_xlat10_0 * vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _MiHoYoTimeScale;
uniform 	mediump vec4 _WindParams0;
uniform 	mediump vec4 _WindParams1;
uniform 	mediump vec4 _WindParams2;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
uniform 	mediump vec4 _Height;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec4 u_xlat8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
bool u_xlatb11;
float u_xlat12;
float u_xlat22;
vec2 u_xlat25;
vec2 u_xlat27;
float u_xlat33;
float u_xlat34;
mediump float u_xlat16_35;
float u_xlat36;
float u_xlat37;
mediump float u_xlat16_42;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat11.x = in_COLOR0.y + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(1.5<u_xlat11.x);
#else
    u_xlatb11 = 1.5<u_xlat11.x;
#endif
    if(u_xlatb11){
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat1;
        gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat11.x = in_POSITION0.y * _Height.x;
    u_xlat11.x = max(u_xlat11.x, 9.99999975e-05);
    u_xlat16_2.xyz = in_COLOR0.xyz * _BoundsSize.xyz + _BoundsMin.xyz;
    u_xlat22 = 10000.0 * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].w;
    u_xlat22 = fract(u_xlat22);
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + (-in_POSITION0.xyz);
    u_xlat33 = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat33) + in_POSITION0.xyz;
    u_xlat1.xyz = (-u_xlat16_2.xyz) * vec3(-1.0, 0.0, -1.0) + u_xlat1.xyz;
    u_xlat33 = (-in_COLOR0.y) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
    u_xlat33 = u_xlat33 * 0.5 + in_COLOR0.y;
    u_xlat16_35 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_35 = sqrt(u_xlat16_35);
    u_xlat3.xy = u_xlat16_2.xz * vec2(-1.0, -1.0) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xz;
    u_xlat4.z = u_xlat22 * u_xlat22;
    u_xlat34 = _WindParams1.y * 0.100000001;
    u_xlat25.x = _MiHoYoWind.w * _WindParams0.x;
    u_xlat11.x = log2(u_xlat11.x);
    u_xlat11.x = u_xlat11.x * 1.10000002;
    u_xlat11.x = exp2(u_xlat11.x);
    u_xlat36 = u_xlat33 * 6.28299999;
    u_xlat37 = dot(u_xlat3.xy, _MiHoYoWind.xz);
    u_xlat37 = (-u_xlat37) * _WindParams0.y;
    u_xlat37 = _Time.y * _WindParams2.x + u_xlat37;
    u_xlat34 = u_xlat36 * u_xlat34 + u_xlat37;
    u_xlat5.x = u_xlat34 + _WindParams2.y;
    u_xlat34 = _Time.y * _MiHoYoTimeScale.x + u_xlat36;
    u_xlat5.y = u_xlat34 + _MiHoYoTimeScale.y;
    u_xlat5.xy = u_xlat5.xy + vec2(0.5, 0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat5.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat27.xy = abs(u_xlat5.xy) * abs(u_xlat5.xy);
    u_xlat5.xy = -abs(u_xlat5.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat5.xy = u_xlat5.xy * u_xlat27.xy;
    u_xlat4.xy = u_xlat11.xx * u_xlat5.xy;
    u_xlat4.xw = u_xlat4.zz * u_xlat4.xz;
    u_xlat5.xy = _MiHoYoWind.xz;
    u_xlat27.xy = u_xlat4.xx * u_xlat5.xy;
    u_xlat6.xz = u_xlat25.xx * u_xlat27.xy;
    u_xlat6.y = 0.0;
    u_xlat7.x = 0.0;
    u_xlat7.yz = _MiHoYoWind.zx * vec2(0.0, 1.0);
    u_xlat8.xy = _MiHoYoWind.zx * vec2(1.0, 0.0);
    u_xlat8.z = 0.0;
    u_xlat7.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat7.xyz = u_xlat4.xxx * u_xlat7.xyz;
    u_xlat7.xyz = u_xlat25.xxx * u_xlat7.xyz;
    u_xlat8.xyz = u_xlat7.xyz * _WindParams2.zzz;
    u_xlat34 = u_xlat4.y * u_xlat4.w;
    u_xlat4.xyw = vec3(u_xlat34) * vec3(0.0848399997, 0.0, 0.0848399997);
    u_xlat11.x = u_xlat11.x * _MiHoYoWind.w;
    u_xlat11.x = u_xlat11.x * _WindParams1.x + 1.0;
    u_xlat11.x = u_xlat11.x * u_xlat11.x + (-u_xlat11.x);
    u_xlat25.xy = u_xlat5.xy * u_xlat11.xx;
    u_xlat5.xz = u_xlat4.zz * u_xlat25.xy;
    u_xlat5.y = 0.0;
    u_xlat8 = u_xlat8.xyzz * _WindParams0.wwww + u_xlat6.xyzz;
    u_xlat8 = u_xlat8 * _WindParams0.zzzz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyzz;
    u_xlat11.x = dot(u_xlat8.xyw, u_xlat8.xyw);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat8 = u_xlat11.xxxx * u_xlat8;
    u_xlat6.xyz = u_xlat7.xyz * _WindParams2.zzz + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyw * _WindParams2.www + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat5.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat4.xyz * vec3(0.25, 0.25, 0.25) + u_xlat1.xyz;
    u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_9.x = sqrt(u_xlat16_9.x);
    u_xlat11.x = u_xlat16_9.x + 0.00100000005;
    u_xlat1.xyz = u_xlat1.xyz / u_xlat11.xxx;
    u_xlat11.x = u_xlat22 * u_xlat16_35;
    u_xlat3.xy = u_xlat3.xy + (-_GrassDisplacementArea.xy);
    u_xlat3.xy = vec2(u_xlat3.x / _GrassDisplacementArea.z, u_xlat3.y / _GrassDisplacementArea.w);
    u_xlat3.xyz = textureLod(_GrassDisplacementTex, u_xlat3.xy, 0.0).xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat22 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat3.xy = u_xlat11.xx * u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * _DisplacementParam.xx;
    u_xlat33 = u_xlat33 * 0.649999976 + 1.13;
    u_xlat3.xy = vec2(u_xlat33) * u_xlat3.xy;
    u_xlat4.xz = u_xlat3.xy * vec2(0.75, 0.75);
    u_xlat11.x = u_xlat11.x * u_xlat22;
    u_xlat11.x = u_xlat11.x * _DisplacementParam.y;
    u_xlat22 = max(u_xlat3.z, _DisplacementParam.z);
    u_xlat22 = min(u_xlat22, _DisplacementParam.w);
    u_xlat4.y = u_xlat22 * (-u_xlat11.x);
    u_xlat11.xyz = u_xlat1.xyz * vec3(u_xlat16_35) + u_xlat4.xyz;
    u_xlat11.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + u_xlat11.xyz;
    u_xlat0.xyz = u_xlat11.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat12 = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat12 * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1.x = dot(u_xlat8.xyw, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat8.xyw;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3 = u_xlat8.ywzx * u_xlat8;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_42 = u_xlat2.y * u_xlat2.y;
    u_xlat16_42 = u_xlat2.x * u_xlat2.x + (-u_xlat16_42);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_42) + u_xlat16_10.xyz;
    vs_TEXCOORD0.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    vs_TEXCOORD1 = u_xlat1.xxxx * _LightColor0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.w = 0.0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target0 = u_xlat10_0 * vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
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
Keywords { "MIHOYO_GRASS_DISPLACEMENT" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" }
""
}
}
}
 Pass {
  LOD 100
  Tags { "DebugView" = "On" "LIGHTMODE" = "HYBRIDDEFERRED" "QUEUE" = "AlphaTest" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 319479
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _Lightings;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(1.5<in_COLOR0.y);
#else
    u_xlatb0 = 1.5<in_COLOR0.y;
#endif
    if(u_xlatb0){
        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xy = in_COLOR0.xz * _BoundsSize.xz + _BoundsMin.xz;
    u_xlat0 = (-u_xlat16_1.yyyy) * hlslcc_mtx4x4unity_MatrixVP[2];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * (-u_xlat16_1.xxxx) + u_xlat0;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0.x = _Lightings.w * 0.300000012;
    vs_TEXCOORD0.xyz = _Color2.xyz;
    vs_TEXCOORD0.w = u_xlat0.x;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD2.w = _Lightings.w;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0117647061;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : vs_TEXCOORD1.z;
    SV_Target2.xy = vs_TEXCOORD1.xy;
    SV_Target2.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _MiHoYoTimeScale;
uniform 	mediump float _ReciprocalBurnTime;
uniform 	mediump vec4 _WindParams0;
uniform 	mediump vec4 _WindParams1;
uniform 	mediump vec4 _WindParams2;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _BurnedColor;
uniform 	mediump vec4 _Lightings;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
uniform 	mediump vec4 _Height;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD4;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
bool u_xlatb11;
float u_xlat22;
vec2 u_xlat26;
float u_xlat33;
float u_xlat34;
float u_xlat36;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat11.x = in_COLOR0.y + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(1.5<u_xlat11.x);
#else
    u_xlatb11 = 1.5<u_xlat11.x;
#endif
    if(u_xlatb11){
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat1;
        gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat11.x = in_POSITION0.y * _Height.x;
    u_xlat11.x = max(u_xlat11.x, 9.99999975e-05);
    u_xlat16_2.xyz = in_COLOR0.xyz * _BoundsSize.xyz + _BoundsMin.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0);
    u_xlat22 = _Time.y + (-unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x);
    u_xlat22 = u_xlat22 * _ReciprocalBurnTime;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat33 = fract(abs(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x));
    u_xlat22 = u_xlat33 * u_xlat22;
    u_xlat33 = 10000.0 * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].w;
    u_xlat33 = fract(u_xlat33);
    u_xlat3.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + (-in_POSITION0.xyz);
    u_xlat34 = (-u_xlat33) + 1.0;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat34) + in_POSITION0.xyz;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(-1.0, 0.0, -1.0) + u_xlat3.xyz;
    u_xlat34 = (-in_COLOR0.y) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
    u_xlat34 = u_xlat34 * 0.5 + in_COLOR0.y;
    u_xlat16_2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.xy = u_xlat16_2.xz * vec2(-1.0, -1.0) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xz;
    u_xlat5.z = u_xlat33 * u_xlat33;
    u_xlat33 = _WindParams1.y * 0.100000001;
    u_xlat36 = _MiHoYoWind.w * _WindParams0.x;
    u_xlat11.x = log2(u_xlat11.x);
    u_xlat11.x = u_xlat11.x * 1.10000002;
    u_xlat11.x = exp2(u_xlat11.x);
    u_xlat34 = u_xlat34 * 6.28299999;
    u_xlat4.x = dot(u_xlat4.xy, _MiHoYoWind.xz);
    u_xlat4.x = (-u_xlat4.x) * _WindParams0.y;
    u_xlat4.x = _Time.y * _WindParams2.x + u_xlat4.x;
    u_xlat33 = u_xlat34 * u_xlat33 + u_xlat4.x;
    u_xlat4.x = u_xlat33 + _WindParams2.y;
    u_xlat33 = _Time.y * _MiHoYoTimeScale.x + u_xlat34;
    u_xlat4.y = u_xlat33 + _MiHoYoTimeScale.y;
    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat26.xy = abs(u_xlat4.xy) * abs(u_xlat4.xy);
    u_xlat4.xy = -abs(u_xlat4.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat4.xy = u_xlat4.xy * u_xlat26.xy;
    u_xlat5.xy = u_xlat11.xx * u_xlat4.xy;
    u_xlat4.xy = u_xlat5.zz * u_xlat5.xz;
    u_xlat26.xy = _MiHoYoWind.xz;
    u_xlat5.xw = u_xlat26.xy * u_xlat4.xx;
    u_xlat6.xz = vec2(u_xlat36) * u_xlat5.xw;
    u_xlat6.y = 0.0;
    u_xlat7.x = 0.0;
    u_xlat7.yz = _MiHoYoWind.zx * vec2(0.0, 1.0);
    u_xlat8.xy = _MiHoYoWind.zx * vec2(1.0, 0.0);
    u_xlat8.z = 0.0;
    u_xlat7.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat7.xyz = u_xlat4.xxx * u_xlat7.xyz;
    u_xlat7.xyz = vec3(u_xlat36) * u_xlat7.xyz;
    u_xlat8.xyz = u_xlat7.xyz * _WindParams2.zzz;
    u_xlat33 = u_xlat5.y * u_xlat4.y;
    u_xlat5.xyw = vec3(u_xlat33) * vec3(0.0848399997, 0.0, 0.0848399997);
    u_xlat11.x = u_xlat11.x * _MiHoYoWind.w;
    u_xlat11.x = u_xlat11.x * _WindParams1.x + 1.0;
    u_xlat11.x = u_xlat11.x * u_xlat11.x + (-u_xlat11.x);
    u_xlat11.xz = u_xlat26.xy * u_xlat11.xx;
    u_xlat4.xz = u_xlat5.zz * u_xlat11.xz;
    u_xlat4.y = 0.0;
    u_xlat8.xyz = u_xlat8.xyz * _WindParams0.www + u_xlat6.xyz;
    u_xlat8.xyz = u_xlat8.xyz * _WindParams0.zzz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat11.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat8.xyz = u_xlat11.xxx * u_xlat8.xyz;
    u_xlat6.xyz = u_xlat7.xyz * _WindParams2.zzz + u_xlat6.xyz;
    u_xlat5.xyz = u_xlat5.xyw * _WindParams2.www + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat5.xyz;
    u_xlat3.xyz = u_xlat4.xyz * vec3(0.25, 0.25, 0.25) + u_xlat3.xyz;
    u_xlat16_2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_2.xy = sqrt(u_xlat16_2.xy);
    u_xlat11.x = u_xlat16_2.x + 0.00100000005;
    u_xlat3.xyz = u_xlat3.xyz / u_xlat11.xxx;
    u_xlat1.xyz = u_xlat3.xyz * u_xlat16_2.yyy + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat16_9.xyz = _Color.xyz + (-_Color2.xyz);
    u_xlat16_9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www * u_xlat16_9.xyz + _Color2.xyz;
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + _BurnedColor.xyz;
    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat0 = _Lightings.w * 0.300000012;
    vs_TEXCOORD0.w = u_xlat0;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD2.xyz = u_xlat8.xyz;
    vs_TEXCOORD2.w = _Lightings.w;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0117647061;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : vs_TEXCOORD1.z;
    SV_Target2.xy = vs_TEXCOORD1.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _Lightings;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(1.5<in_COLOR0.y);
#else
    u_xlatb0 = 1.5<in_COLOR0.y;
#endif
    if(u_xlatb0){
        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xy = in_COLOR0.xz * _BoundsSize.xz + _BoundsMin.xz;
    u_xlat0 = (-u_xlat16_1.yyyy) * hlslcc_mtx4x4unity_MatrixVP[2];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * (-u_xlat16_1.xxxx) + u_xlat0;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0.x = _Lightings.w * 0.300000012;
    vs_TEXCOORD0.xyz = _Color2.xyz;
    vs_TEXCOORD0.w = u_xlat0.x;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD2.w = _Lightings.w;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0117647061;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : vs_TEXCOORD1.z;
    SV_Target2.xy = vs_TEXCOORD1.xy;
    SV_Target2.w = 0.0;
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

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _MiHoYoTimeScale;
uniform 	mediump float _ReciprocalBurnTime;
uniform 	mediump vec4 _WindParams0;
uniform 	mediump vec4 _WindParams1;
uniform 	mediump vec4 _WindParams2;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _BurnedColor;
uniform 	mediump vec4 _Lightings;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
uniform 	mediump vec4 _Height;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD4;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
bool u_xlatb11;
float u_xlat22;
vec2 u_xlat26;
float u_xlat33;
float u_xlat34;
float u_xlat36;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat11.x = in_COLOR0.y + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(1.5<u_xlat11.x);
#else
    u_xlatb11 = 1.5<u_xlat11.x;
#endif
    if(u_xlatb11){
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat1;
        gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat11.x = in_POSITION0.y * _Height.x;
    u_xlat11.x = max(u_xlat11.x, 9.99999975e-05);
    u_xlat16_2.xyz = in_COLOR0.xyz * _BoundsSize.xyz + _BoundsMin.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0);
    u_xlat22 = _Time.y + (-unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x);
    u_xlat22 = u_xlat22 * _ReciprocalBurnTime;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat33 = fract(abs(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x));
    u_xlat22 = u_xlat33 * u_xlat22;
    u_xlat33 = 10000.0 * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].w;
    u_xlat33 = fract(u_xlat33);
    u_xlat3.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + (-in_POSITION0.xyz);
    u_xlat34 = (-u_xlat33) + 1.0;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat34) + in_POSITION0.xyz;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(-1.0, 0.0, -1.0) + u_xlat3.xyz;
    u_xlat34 = (-in_COLOR0.y) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
    u_xlat34 = u_xlat34 * 0.5 + in_COLOR0.y;
    u_xlat16_2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.xy = u_xlat16_2.xz * vec2(-1.0, -1.0) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xz;
    u_xlat5.z = u_xlat33 * u_xlat33;
    u_xlat33 = _WindParams1.y * 0.100000001;
    u_xlat36 = _MiHoYoWind.w * _WindParams0.x;
    u_xlat11.x = log2(u_xlat11.x);
    u_xlat11.x = u_xlat11.x * 1.10000002;
    u_xlat11.x = exp2(u_xlat11.x);
    u_xlat34 = u_xlat34 * 6.28299999;
    u_xlat4.x = dot(u_xlat4.xy, _MiHoYoWind.xz);
    u_xlat4.x = (-u_xlat4.x) * _WindParams0.y;
    u_xlat4.x = _Time.y * _WindParams2.x + u_xlat4.x;
    u_xlat33 = u_xlat34 * u_xlat33 + u_xlat4.x;
    u_xlat4.x = u_xlat33 + _WindParams2.y;
    u_xlat33 = _Time.y * _MiHoYoTimeScale.x + u_xlat34;
    u_xlat4.y = u_xlat33 + _MiHoYoTimeScale.y;
    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat26.xy = abs(u_xlat4.xy) * abs(u_xlat4.xy);
    u_xlat4.xy = -abs(u_xlat4.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat4.xy = u_xlat4.xy * u_xlat26.xy;
    u_xlat5.xy = u_xlat11.xx * u_xlat4.xy;
    u_xlat4.xy = u_xlat5.zz * u_xlat5.xz;
    u_xlat26.xy = _MiHoYoWind.xz;
    u_xlat5.xw = u_xlat26.xy * u_xlat4.xx;
    u_xlat6.xz = vec2(u_xlat36) * u_xlat5.xw;
    u_xlat6.y = 0.0;
    u_xlat7.x = 0.0;
    u_xlat7.yz = _MiHoYoWind.zx * vec2(0.0, 1.0);
    u_xlat8.xy = _MiHoYoWind.zx * vec2(1.0, 0.0);
    u_xlat8.z = 0.0;
    u_xlat7.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat7.xyz = u_xlat4.xxx * u_xlat7.xyz;
    u_xlat7.xyz = vec3(u_xlat36) * u_xlat7.xyz;
    u_xlat8.xyz = u_xlat7.xyz * _WindParams2.zzz;
    u_xlat33 = u_xlat5.y * u_xlat4.y;
    u_xlat5.xyw = vec3(u_xlat33) * vec3(0.0848399997, 0.0, 0.0848399997);
    u_xlat11.x = u_xlat11.x * _MiHoYoWind.w;
    u_xlat11.x = u_xlat11.x * _WindParams1.x + 1.0;
    u_xlat11.x = u_xlat11.x * u_xlat11.x + (-u_xlat11.x);
    u_xlat11.xz = u_xlat26.xy * u_xlat11.xx;
    u_xlat4.xz = u_xlat5.zz * u_xlat11.xz;
    u_xlat4.y = 0.0;
    u_xlat8.xyz = u_xlat8.xyz * _WindParams0.www + u_xlat6.xyz;
    u_xlat8.xyz = u_xlat8.xyz * _WindParams0.zzz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat11.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat8.xyz = u_xlat11.xxx * u_xlat8.xyz;
    u_xlat6.xyz = u_xlat7.xyz * _WindParams2.zzz + u_xlat6.xyz;
    u_xlat5.xyz = u_xlat5.xyw * _WindParams2.www + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat5.xyz;
    u_xlat3.xyz = u_xlat4.xyz * vec3(0.25, 0.25, 0.25) + u_xlat3.xyz;
    u_xlat16_2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_2.xy = sqrt(u_xlat16_2.xy);
    u_xlat11.x = u_xlat16_2.x + 0.00100000005;
    u_xlat3.xyz = u_xlat3.xyz / u_xlat11.xxx;
    u_xlat1.xyz = u_xlat3.xyz * u_xlat16_2.yyy + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat16_9.xyz = _Color.xyz + (-_Color2.xyz);
    u_xlat16_9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www * u_xlat16_9.xyz + _Color2.xyz;
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + _BurnedColor.xyz;
    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat0 = _Lightings.w * 0.300000012;
    vs_TEXCOORD0.w = u_xlat0;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD2.xyz = u_xlat8.xyz;
    vs_TEXCOORD2.w = _Lightings.w;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0117647061;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : vs_TEXCOORD1.z;
    SV_Target2.xy = vs_TEXCOORD1.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _Lightings;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(1.5<in_COLOR0.y);
#else
    u_xlatb0 = 1.5<in_COLOR0.y;
#endif
    if(u_xlatb0){
        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xy = in_COLOR0.xz * _BoundsSize.xz + _BoundsMin.xz;
    u_xlat0 = (-u_xlat16_1.yyyy) * hlslcc_mtx4x4unity_MatrixVP[2];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * (-u_xlat16_1.xxxx) + u_xlat0;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0.x = _Lightings.w * 0.300000012;
    vs_TEXCOORD0.xyz = _Color2.xyz;
    vs_TEXCOORD0.w = u_xlat0.x;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD2.w = _Lightings.w;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
bool u_xlatb6;
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
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat16_1<0.0);
#else
    u_xlatb6 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb6) * int(0xffffffffu))!=0){discard;}
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0.x) ? 0.0 : vs_TEXCOORD1.z;
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0117647061;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vs_TEXCOORD1.xy;
    SV_Target2.w = 0.0;
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

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _MiHoYoTimeScale;
uniform 	mediump float _ReciprocalBurnTime;
uniform 	mediump vec4 _WindParams0;
uniform 	mediump vec4 _WindParams1;
uniform 	mediump vec4 _WindParams2;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _BurnedColor;
uniform 	mediump vec4 _Lightings;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
uniform 	mediump vec4 _Height;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD4;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
bool u_xlatb11;
float u_xlat22;
vec2 u_xlat26;
float u_xlat33;
float u_xlat34;
float u_xlat36;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat11.x = in_COLOR0.y + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(1.5<u_xlat11.x);
#else
    u_xlatb11 = 1.5<u_xlat11.x;
#endif
    if(u_xlatb11){
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat1;
        gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat11.x = in_POSITION0.y * _Height.x;
    u_xlat11.x = max(u_xlat11.x, 9.99999975e-05);
    u_xlat16_2.xyz = in_COLOR0.xyz * _BoundsSize.xyz + _BoundsMin.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0);
    u_xlat22 = _Time.y + (-unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x);
    u_xlat22 = u_xlat22 * _ReciprocalBurnTime;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat33 = fract(abs(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x));
    u_xlat22 = u_xlat33 * u_xlat22;
    u_xlat33 = 10000.0 * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].w;
    u_xlat33 = fract(u_xlat33);
    u_xlat3.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + (-in_POSITION0.xyz);
    u_xlat34 = (-u_xlat33) + 1.0;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat34) + in_POSITION0.xyz;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(-1.0, 0.0, -1.0) + u_xlat3.xyz;
    u_xlat34 = (-in_COLOR0.y) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
    u_xlat34 = u_xlat34 * 0.5 + in_COLOR0.y;
    u_xlat16_2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.xy = u_xlat16_2.xz * vec2(-1.0, -1.0) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xz;
    u_xlat5.z = u_xlat33 * u_xlat33;
    u_xlat33 = _WindParams1.y * 0.100000001;
    u_xlat36 = _MiHoYoWind.w * _WindParams0.x;
    u_xlat11.x = log2(u_xlat11.x);
    u_xlat11.x = u_xlat11.x * 1.10000002;
    u_xlat11.x = exp2(u_xlat11.x);
    u_xlat34 = u_xlat34 * 6.28299999;
    u_xlat4.x = dot(u_xlat4.xy, _MiHoYoWind.xz);
    u_xlat4.x = (-u_xlat4.x) * _WindParams0.y;
    u_xlat4.x = _Time.y * _WindParams2.x + u_xlat4.x;
    u_xlat33 = u_xlat34 * u_xlat33 + u_xlat4.x;
    u_xlat4.x = u_xlat33 + _WindParams2.y;
    u_xlat33 = _Time.y * _MiHoYoTimeScale.x + u_xlat34;
    u_xlat4.y = u_xlat33 + _MiHoYoTimeScale.y;
    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat26.xy = abs(u_xlat4.xy) * abs(u_xlat4.xy);
    u_xlat4.xy = -abs(u_xlat4.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat4.xy = u_xlat4.xy * u_xlat26.xy;
    u_xlat5.xy = u_xlat11.xx * u_xlat4.xy;
    u_xlat4.xy = u_xlat5.zz * u_xlat5.xz;
    u_xlat26.xy = _MiHoYoWind.xz;
    u_xlat5.xw = u_xlat26.xy * u_xlat4.xx;
    u_xlat6.xz = vec2(u_xlat36) * u_xlat5.xw;
    u_xlat6.y = 0.0;
    u_xlat7.x = 0.0;
    u_xlat7.yz = _MiHoYoWind.zx * vec2(0.0, 1.0);
    u_xlat8.xy = _MiHoYoWind.zx * vec2(1.0, 0.0);
    u_xlat8.z = 0.0;
    u_xlat7.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat7.xyz = u_xlat4.xxx * u_xlat7.xyz;
    u_xlat7.xyz = vec3(u_xlat36) * u_xlat7.xyz;
    u_xlat8.xyz = u_xlat7.xyz * _WindParams2.zzz;
    u_xlat33 = u_xlat5.y * u_xlat4.y;
    u_xlat5.xyw = vec3(u_xlat33) * vec3(0.0848399997, 0.0, 0.0848399997);
    u_xlat11.x = u_xlat11.x * _MiHoYoWind.w;
    u_xlat11.x = u_xlat11.x * _WindParams1.x + 1.0;
    u_xlat11.x = u_xlat11.x * u_xlat11.x + (-u_xlat11.x);
    u_xlat11.xz = u_xlat26.xy * u_xlat11.xx;
    u_xlat4.xz = u_xlat5.zz * u_xlat11.xz;
    u_xlat4.y = 0.0;
    u_xlat8.xyz = u_xlat8.xyz * _WindParams0.www + u_xlat6.xyz;
    u_xlat8.xyz = u_xlat8.xyz * _WindParams0.zzz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat11.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat8.xyz = u_xlat11.xxx * u_xlat8.xyz;
    u_xlat6.xyz = u_xlat7.xyz * _WindParams2.zzz + u_xlat6.xyz;
    u_xlat5.xyz = u_xlat5.xyw * _WindParams2.www + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat5.xyz;
    u_xlat3.xyz = u_xlat4.xyz * vec3(0.25, 0.25, 0.25) + u_xlat3.xyz;
    u_xlat16_2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_2.xy = sqrt(u_xlat16_2.xy);
    u_xlat11.x = u_xlat16_2.x + 0.00100000005;
    u_xlat3.xyz = u_xlat3.xyz / u_xlat11.xxx;
    u_xlat1.xyz = u_xlat3.xyz * u_xlat16_2.yyy + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat16_9.xyz = _Color.xyz + (-_Color2.xyz);
    u_xlat16_9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www * u_xlat16_9.xyz + _Color2.xyz;
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + _BurnedColor.xyz;
    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat0 = _Lightings.w * 0.300000012;
    vs_TEXCOORD0.w = u_xlat0;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD2.xyz = u_xlat8.xyz;
    vs_TEXCOORD2.w = _Lightings.w;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
bool u_xlatb6;
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
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat16_1<0.0);
#else
    u_xlatb6 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb6) * int(0xffffffffu))!=0){discard;}
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0.x) ? 0.0 : vs_TEXCOORD1.z;
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0117647061;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vs_TEXCOORD1.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _Lightings;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(1.5<in_COLOR0.y);
#else
    u_xlatb0 = 1.5<in_COLOR0.y;
#endif
    if(u_xlatb0){
        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xy = in_COLOR0.xz * _BoundsSize.xz + _BoundsMin.xz;
    u_xlat0 = (-u_xlat16_1.yyyy) * hlslcc_mtx4x4unity_MatrixVP[2];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * (-u_xlat16_1.xxxx) + u_xlat0;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0.x = _Lightings.w * 0.300000012;
    vs_TEXCOORD0.xyz = _Color2.xyz;
    vs_TEXCOORD0.w = u_xlat0.x;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD2.w = _Lightings.w;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
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

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _MiHoYoTimeScale;
uniform 	mediump float _ReciprocalBurnTime;
uniform 	mediump vec4 _WindParams0;
uniform 	mediump vec4 _WindParams1;
uniform 	mediump vec4 _WindParams2;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _BurnedColor;
uniform 	mediump vec4 _Lightings;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
uniform 	mediump vec4 _Height;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD4;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
bool u_xlatb11;
float u_xlat22;
vec2 u_xlat26;
float u_xlat33;
float u_xlat34;
float u_xlat36;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat11.x = in_COLOR0.y + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(1.5<u_xlat11.x);
#else
    u_xlatb11 = 1.5<u_xlat11.x;
#endif
    if(u_xlatb11){
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat1;
        gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat11.x = in_POSITION0.y * _Height.x;
    u_xlat11.x = max(u_xlat11.x, 9.99999975e-05);
    u_xlat16_2.xyz = in_COLOR0.xyz * _BoundsSize.xyz + _BoundsMin.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0);
    u_xlat22 = _Time.y + (-unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x);
    u_xlat22 = u_xlat22 * _ReciprocalBurnTime;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat33 = fract(abs(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x));
    u_xlat22 = u_xlat33 * u_xlat22;
    u_xlat33 = 10000.0 * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].w;
    u_xlat33 = fract(u_xlat33);
    u_xlat3.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + (-in_POSITION0.xyz);
    u_xlat34 = (-u_xlat33) + 1.0;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat34) + in_POSITION0.xyz;
    u_xlat3.xyz = (-u_xlat16_2.xyz) * vec3(-1.0, 0.0, -1.0) + u_xlat3.xyz;
    u_xlat34 = (-in_COLOR0.y) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
    u_xlat34 = u_xlat34 * 0.5 + in_COLOR0.y;
    u_xlat16_2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat4.xy = u_xlat16_2.xz * vec2(-1.0, -1.0) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xz;
    u_xlat5.z = u_xlat33 * u_xlat33;
    u_xlat33 = _WindParams1.y * 0.100000001;
    u_xlat36 = _MiHoYoWind.w * _WindParams0.x;
    u_xlat11.x = log2(u_xlat11.x);
    u_xlat11.x = u_xlat11.x * 1.10000002;
    u_xlat11.x = exp2(u_xlat11.x);
    u_xlat34 = u_xlat34 * 6.28299999;
    u_xlat4.x = dot(u_xlat4.xy, _MiHoYoWind.xz);
    u_xlat4.x = (-u_xlat4.x) * _WindParams0.y;
    u_xlat4.x = _Time.y * _WindParams2.x + u_xlat4.x;
    u_xlat33 = u_xlat34 * u_xlat33 + u_xlat4.x;
    u_xlat4.x = u_xlat33 + _WindParams2.y;
    u_xlat33 = _Time.y * _MiHoYoTimeScale.x + u_xlat34;
    u_xlat4.y = u_xlat33 + _MiHoYoTimeScale.y;
    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat26.xy = abs(u_xlat4.xy) * abs(u_xlat4.xy);
    u_xlat4.xy = -abs(u_xlat4.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat4.xy = u_xlat4.xy * u_xlat26.xy;
    u_xlat5.xy = u_xlat11.xx * u_xlat4.xy;
    u_xlat4.xy = u_xlat5.zz * u_xlat5.xz;
    u_xlat26.xy = _MiHoYoWind.xz;
    u_xlat5.xw = u_xlat26.xy * u_xlat4.xx;
    u_xlat6.xz = vec2(u_xlat36) * u_xlat5.xw;
    u_xlat6.y = 0.0;
    u_xlat7.x = 0.0;
    u_xlat7.yz = _MiHoYoWind.zx * vec2(0.0, 1.0);
    u_xlat8.xy = _MiHoYoWind.zx * vec2(1.0, 0.0);
    u_xlat8.z = 0.0;
    u_xlat7.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat7.xyz = u_xlat4.xxx * u_xlat7.xyz;
    u_xlat7.xyz = vec3(u_xlat36) * u_xlat7.xyz;
    u_xlat8.xyz = u_xlat7.xyz * _WindParams2.zzz;
    u_xlat33 = u_xlat5.y * u_xlat4.y;
    u_xlat5.xyw = vec3(u_xlat33) * vec3(0.0848399997, 0.0, 0.0848399997);
    u_xlat11.x = u_xlat11.x * _MiHoYoWind.w;
    u_xlat11.x = u_xlat11.x * _WindParams1.x + 1.0;
    u_xlat11.x = u_xlat11.x * u_xlat11.x + (-u_xlat11.x);
    u_xlat11.xz = u_xlat26.xy * u_xlat11.xx;
    u_xlat4.xz = u_xlat5.zz * u_xlat11.xz;
    u_xlat4.y = 0.0;
    u_xlat8.xyz = u_xlat8.xyz * _WindParams0.www + u_xlat6.xyz;
    u_xlat8.xyz = u_xlat8.xyz * _WindParams0.zzz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat11.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat8.xyz = u_xlat11.xxx * u_xlat8.xyz;
    u_xlat6.xyz = u_xlat7.xyz * _WindParams2.zzz + u_xlat6.xyz;
    u_xlat5.xyz = u_xlat5.xyw * _WindParams2.www + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat5.xyz;
    u_xlat3.xyz = u_xlat4.xyz * vec3(0.25, 0.25, 0.25) + u_xlat3.xyz;
    u_xlat16_2.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat16_2.xy = sqrt(u_xlat16_2.xy);
    u_xlat11.x = u_xlat16_2.x + 0.00100000005;
    u_xlat3.xyz = u_xlat3.xyz / u_xlat11.xxx;
    u_xlat1.xyz = u_xlat3.xyz * u_xlat16_2.yyy + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat16_9.xyz = _Color.xyz + (-_Color2.xyz);
    u_xlat16_9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www * u_xlat16_9.xyz + _Color2.xyz;
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + _BurnedColor.xyz;
    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat0 = _Lightings.w * 0.300000012;
    vs_TEXCOORD0.w = u_xlat0;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD2.xyz = u_xlat8.xyz;
    vs_TEXCOORD2.w = _Lightings.w;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
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
Keywords { "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _Lightings;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(1.5<in_COLOR0.y);
#else
    u_xlatb0 = 1.5<in_COLOR0.y;
#endif
    if(u_xlatb0){
        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xy = in_COLOR0.xz * _BoundsSize.xz + _BoundsMin.xz;
    u_xlat0 = (-u_xlat16_1.yyyy) * hlslcc_mtx4x4unity_MatrixVP[2];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * (-u_xlat16_1.xxxx) + u_xlat0;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0.x = _Lightings.w * 0.300000012;
    vs_TEXCOORD0.xyz = _Color2.xyz;
    vs_TEXCOORD0.w = u_xlat0.x;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD2.w = _Lightings.w;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0117647061;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : vs_TEXCOORD1.z;
    SV_Target2.xy = vs_TEXCOORD1.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _MiHoYoTimeScale;
uniform 	mediump float _ReciprocalBurnTime;
uniform 	mediump vec4 _WindParams0;
uniform 	mediump vec4 _WindParams1;
uniform 	mediump vec4 _WindParams2;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _BurnedColor;
uniform 	mediump vec4 _Lightings;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
uniform 	mediump vec4 _Height;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD4;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
float u_xlat22;
vec2 u_xlat25;
vec2 u_xlat27;
float u_xlat33;
float u_xlat34;
mediump float u_xlat16_35;
float u_xlat36;
float u_xlat37;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat11 = in_COLOR0.y + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(1.5<u_xlat11);
#else
    u_xlatb11 = 1.5<u_xlat11;
#endif
    if(u_xlatb11){
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat1;
        gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat11 = in_POSITION0.y * _Height.x;
    u_xlat11 = max(u_xlat11, 9.99999975e-05);
    u_xlat16_2.xyz = in_COLOR0.xyz * _BoundsSize.xyz + _BoundsMin.xyz;
    u_xlat22 = _Time.y + (-unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x);
    u_xlat22 = u_xlat22 * _ReciprocalBurnTime;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat33 = fract(abs(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x));
    u_xlat22 = u_xlat33 * u_xlat22;
    u_xlat33 = 10000.0 * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + (-in_POSITION0.xyz);
    u_xlat34 = (-u_xlat33) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + in_POSITION0.xyz;
    u_xlat1.xyz = (-u_xlat16_2.xyz) * vec3(-1.0, 0.0, -1.0) + u_xlat1.xyz;
    u_xlat34 = (-in_COLOR0.y) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
    u_xlat34 = u_xlat34 * 0.5 + in_COLOR0.y;
    u_xlat16_35 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_35 = sqrt(u_xlat16_35);
    u_xlat3.xy = u_xlat16_2.xz * vec2(-1.0, -1.0) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xz;
    u_xlat4.z = u_xlat33 * u_xlat33;
    u_xlat25.x = _WindParams1.y * 0.100000001;
    u_xlat36 = _MiHoYoWind.w * _WindParams0.x;
    u_xlat11 = log2(u_xlat11);
    u_xlat11 = u_xlat11 * 1.10000002;
    u_xlat11 = exp2(u_xlat11);
    u_xlat37 = u_xlat34 * 6.28299999;
    u_xlat5.x = dot(u_xlat3.xy, _MiHoYoWind.xz);
    u_xlat5.x = (-u_xlat5.x) * _WindParams0.y;
    u_xlat5.x = _Time.y * _WindParams2.x + u_xlat5.x;
    u_xlat25.x = u_xlat37 * u_xlat25.x + u_xlat5.x;
    u_xlat5.x = u_xlat25.x + _WindParams2.y;
    u_xlat25.x = _Time.y * _MiHoYoTimeScale.x + u_xlat37;
    u_xlat5.y = u_xlat25.x + _MiHoYoTimeScale.y;
    u_xlat5.xy = u_xlat5.xy + vec2(0.5, 0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat5.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat27.xy = abs(u_xlat5.xy) * abs(u_xlat5.xy);
    u_xlat5.xy = -abs(u_xlat5.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat5.xy = u_xlat5.xy * u_xlat27.xy;
    u_xlat4.xy = vec2(u_xlat11) * u_xlat5.xy;
    u_xlat4.xw = u_xlat4.zz * u_xlat4.xz;
    u_xlat5.xy = _MiHoYoWind.xz;
    u_xlat27.xy = u_xlat4.xx * u_xlat5.xy;
    u_xlat6.xz = vec2(u_xlat36) * u_xlat27.xy;
    u_xlat6.y = 0.0;
    u_xlat7.x = 0.0;
    u_xlat7.yz = _MiHoYoWind.zx * vec2(0.0, 1.0);
    u_xlat8.xy = _MiHoYoWind.zx * vec2(1.0, 0.0);
    u_xlat8.z = 0.0;
    u_xlat7.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat7.xyz = u_xlat4.xxx * u_xlat7.xyz;
    u_xlat7.xyz = vec3(u_xlat36) * u_xlat7.xyz;
    u_xlat8.xyz = u_xlat7.xyz * _WindParams2.zzz;
    u_xlat25.x = u_xlat4.y * u_xlat4.w;
    u_xlat4.xyw = u_xlat25.xxx * vec3(0.0848399997, 0.0, 0.0848399997);
    u_xlat11 = u_xlat11 * _MiHoYoWind.w;
    u_xlat11 = u_xlat11 * _WindParams1.x + 1.0;
    u_xlat11 = u_xlat11 * u_xlat11 + (-u_xlat11);
    u_xlat25.xy = u_xlat5.xy * vec2(u_xlat11);
    u_xlat5.xz = u_xlat4.zz * u_xlat25.xy;
    u_xlat5.y = 0.0;
    u_xlat8.xyz = u_xlat8.xyz * _WindParams0.www + u_xlat6.xyz;
    u_xlat8.xyz = u_xlat8.xyz * _WindParams0.zzz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat11 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat11 = max(u_xlat11, 0.00100000005);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat8.xyz = vec3(u_xlat11) * u_xlat8.xyz;
    u_xlat6.xyz = u_xlat7.xyz * _WindParams2.zzz + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyw * _WindParams2.www + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat5.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat4.xyz * vec3(0.25, 0.25, 0.25) + u_xlat1.xyz;
    u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_9.x = sqrt(u_xlat16_9.x);
    u_xlat11 = u_xlat16_9.x + 0.00100000005;
    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat11);
    u_xlat11 = u_xlat33 * u_xlat16_35;
    u_xlat3.xy = u_xlat3.xy + (-_GrassDisplacementArea.xy);
    u_xlat3.xy = vec2(u_xlat3.x / _GrassDisplacementArea.z, u_xlat3.y / _GrassDisplacementArea.w);
    u_xlat3.xyz = textureLod(_GrassDisplacementTex, u_xlat3.xy, 0.0).xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat33 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat3.xy = vec2(u_xlat11) * u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * _DisplacementParam.xx;
    u_xlat34 = u_xlat34 * 0.649999976 + 1.13;
    u_xlat3.xy = vec2(u_xlat34) * u_xlat3.xy;
    u_xlat4.xz = u_xlat3.xy * vec2(0.75, 0.75);
    u_xlat11 = u_xlat11 * u_xlat33;
    u_xlat11 = u_xlat11 * _DisplacementParam.y;
    u_xlat33 = max(u_xlat3.z, _DisplacementParam.z);
    u_xlat33 = min(u_xlat33, _DisplacementParam.w);
    u_xlat4.y = u_xlat33 * (-u_xlat11);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat16_35) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat16_9.xyz = _Color.xyz + (-_Color2.xyz);
    u_xlat16_9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www * u_xlat16_9.xyz + _Color2.xyz;
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + _BurnedColor.xyz;
    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat0 = _Lightings.w * 0.300000012;
    vs_TEXCOORD0.w = u_xlat0;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD2.xyz = u_xlat8.xyz;
    vs_TEXCOORD2.w = _Lightings.w;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0117647061;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : vs_TEXCOORD1.z;
    SV_Target2.xy = vs_TEXCOORD1.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _Lightings;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(1.5<in_COLOR0.y);
#else
    u_xlatb0 = 1.5<in_COLOR0.y;
#endif
    if(u_xlatb0){
        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xy = in_COLOR0.xz * _BoundsSize.xz + _BoundsMin.xz;
    u_xlat0 = (-u_xlat16_1.yyyy) * hlslcc_mtx4x4unity_MatrixVP[2];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * (-u_xlat16_1.xxxx) + u_xlat0;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0.x = _Lightings.w * 0.300000012;
    vs_TEXCOORD0.xyz = _Color2.xyz;
    vs_TEXCOORD0.w = u_xlat0.x;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD2.w = _Lightings.w;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0117647061;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : vs_TEXCOORD1.z;
    SV_Target2.xy = vs_TEXCOORD1.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _MiHoYoTimeScale;
uniform 	mediump float _ReciprocalBurnTime;
uniform 	mediump vec4 _WindParams0;
uniform 	mediump vec4 _WindParams1;
uniform 	mediump vec4 _WindParams2;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _BurnedColor;
uniform 	mediump vec4 _Lightings;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
uniform 	mediump vec4 _Height;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD4;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
float u_xlat22;
vec2 u_xlat25;
vec2 u_xlat27;
float u_xlat33;
float u_xlat34;
mediump float u_xlat16_35;
float u_xlat36;
float u_xlat37;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat11 = in_COLOR0.y + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(1.5<u_xlat11);
#else
    u_xlatb11 = 1.5<u_xlat11;
#endif
    if(u_xlatb11){
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat1;
        gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat11 = in_POSITION0.y * _Height.x;
    u_xlat11 = max(u_xlat11, 9.99999975e-05);
    u_xlat16_2.xyz = in_COLOR0.xyz * _BoundsSize.xyz + _BoundsMin.xyz;
    u_xlat22 = _Time.y + (-unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x);
    u_xlat22 = u_xlat22 * _ReciprocalBurnTime;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat33 = fract(abs(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x));
    u_xlat22 = u_xlat33 * u_xlat22;
    u_xlat33 = 10000.0 * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + (-in_POSITION0.xyz);
    u_xlat34 = (-u_xlat33) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + in_POSITION0.xyz;
    u_xlat1.xyz = (-u_xlat16_2.xyz) * vec3(-1.0, 0.0, -1.0) + u_xlat1.xyz;
    u_xlat34 = (-in_COLOR0.y) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
    u_xlat34 = u_xlat34 * 0.5 + in_COLOR0.y;
    u_xlat16_35 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_35 = sqrt(u_xlat16_35);
    u_xlat3.xy = u_xlat16_2.xz * vec2(-1.0, -1.0) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xz;
    u_xlat4.z = u_xlat33 * u_xlat33;
    u_xlat25.x = _WindParams1.y * 0.100000001;
    u_xlat36 = _MiHoYoWind.w * _WindParams0.x;
    u_xlat11 = log2(u_xlat11);
    u_xlat11 = u_xlat11 * 1.10000002;
    u_xlat11 = exp2(u_xlat11);
    u_xlat37 = u_xlat34 * 6.28299999;
    u_xlat5.x = dot(u_xlat3.xy, _MiHoYoWind.xz);
    u_xlat5.x = (-u_xlat5.x) * _WindParams0.y;
    u_xlat5.x = _Time.y * _WindParams2.x + u_xlat5.x;
    u_xlat25.x = u_xlat37 * u_xlat25.x + u_xlat5.x;
    u_xlat5.x = u_xlat25.x + _WindParams2.y;
    u_xlat25.x = _Time.y * _MiHoYoTimeScale.x + u_xlat37;
    u_xlat5.y = u_xlat25.x + _MiHoYoTimeScale.y;
    u_xlat5.xy = u_xlat5.xy + vec2(0.5, 0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat5.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat27.xy = abs(u_xlat5.xy) * abs(u_xlat5.xy);
    u_xlat5.xy = -abs(u_xlat5.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat5.xy = u_xlat5.xy * u_xlat27.xy;
    u_xlat4.xy = vec2(u_xlat11) * u_xlat5.xy;
    u_xlat4.xw = u_xlat4.zz * u_xlat4.xz;
    u_xlat5.xy = _MiHoYoWind.xz;
    u_xlat27.xy = u_xlat4.xx * u_xlat5.xy;
    u_xlat6.xz = vec2(u_xlat36) * u_xlat27.xy;
    u_xlat6.y = 0.0;
    u_xlat7.x = 0.0;
    u_xlat7.yz = _MiHoYoWind.zx * vec2(0.0, 1.0);
    u_xlat8.xy = _MiHoYoWind.zx * vec2(1.0, 0.0);
    u_xlat8.z = 0.0;
    u_xlat7.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat7.xyz = u_xlat4.xxx * u_xlat7.xyz;
    u_xlat7.xyz = vec3(u_xlat36) * u_xlat7.xyz;
    u_xlat8.xyz = u_xlat7.xyz * _WindParams2.zzz;
    u_xlat25.x = u_xlat4.y * u_xlat4.w;
    u_xlat4.xyw = u_xlat25.xxx * vec3(0.0848399997, 0.0, 0.0848399997);
    u_xlat11 = u_xlat11 * _MiHoYoWind.w;
    u_xlat11 = u_xlat11 * _WindParams1.x + 1.0;
    u_xlat11 = u_xlat11 * u_xlat11 + (-u_xlat11);
    u_xlat25.xy = u_xlat5.xy * vec2(u_xlat11);
    u_xlat5.xz = u_xlat4.zz * u_xlat25.xy;
    u_xlat5.y = 0.0;
    u_xlat8.xyz = u_xlat8.xyz * _WindParams0.www + u_xlat6.xyz;
    u_xlat8.xyz = u_xlat8.xyz * _WindParams0.zzz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat11 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat11 = max(u_xlat11, 0.00100000005);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat8.xyz = vec3(u_xlat11) * u_xlat8.xyz;
    u_xlat6.xyz = u_xlat7.xyz * _WindParams2.zzz + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyw * _WindParams2.www + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat5.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat4.xyz * vec3(0.25, 0.25, 0.25) + u_xlat1.xyz;
    u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_9.x = sqrt(u_xlat16_9.x);
    u_xlat11 = u_xlat16_9.x + 0.00100000005;
    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat11);
    u_xlat11 = u_xlat33 * u_xlat16_35;
    u_xlat3.xy = u_xlat3.xy + (-_GrassDisplacementArea.xy);
    u_xlat3.xy = vec2(u_xlat3.x / _GrassDisplacementArea.z, u_xlat3.y / _GrassDisplacementArea.w);
    u_xlat3.xyz = textureLod(_GrassDisplacementTex, u_xlat3.xy, 0.0).xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat33 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat3.xy = vec2(u_xlat11) * u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * _DisplacementParam.xx;
    u_xlat34 = u_xlat34 * 0.649999976 + 1.13;
    u_xlat3.xy = vec2(u_xlat34) * u_xlat3.xy;
    u_xlat4.xz = u_xlat3.xy * vec2(0.75, 0.75);
    u_xlat11 = u_xlat11 * u_xlat33;
    u_xlat11 = u_xlat11 * _DisplacementParam.y;
    u_xlat33 = max(u_xlat3.z, _DisplacementParam.z);
    u_xlat33 = min(u_xlat33, _DisplacementParam.w);
    u_xlat4.y = u_xlat33 * (-u_xlat11);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat16_35) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat16_9.xyz = _Color.xyz + (-_Color2.xyz);
    u_xlat16_9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www * u_xlat16_9.xyz + _Color2.xyz;
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + _BurnedColor.xyz;
    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat0 = _Lightings.w * 0.300000012;
    vs_TEXCOORD0.w = u_xlat0;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD2.xyz = u_xlat8.xyz;
    vs_TEXCOORD2.w = _Lightings.w;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0117647061;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : vs_TEXCOORD1.z;
    SV_Target2.xy = vs_TEXCOORD1.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _Lightings;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(1.5<in_COLOR0.y);
#else
    u_xlatb0 = 1.5<in_COLOR0.y;
#endif
    if(u_xlatb0){
        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xy = in_COLOR0.xz * _BoundsSize.xz + _BoundsMin.xz;
    u_xlat0 = (-u_xlat16_1.yyyy) * hlslcc_mtx4x4unity_MatrixVP[2];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * (-u_xlat16_1.xxxx) + u_xlat0;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0.x = _Lightings.w * 0.300000012;
    vs_TEXCOORD0.xyz = _Color2.xyz;
    vs_TEXCOORD0.w = u_xlat0.x;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD2.w = _Lightings.w;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
bool u_xlatb6;
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
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat16_1<0.0);
#else
    u_xlatb6 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb6) * int(0xffffffffu))!=0){discard;}
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0.x) ? 0.0 : vs_TEXCOORD1.z;
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0117647061;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vs_TEXCOORD1.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _MiHoYoTimeScale;
uniform 	mediump float _ReciprocalBurnTime;
uniform 	mediump vec4 _WindParams0;
uniform 	mediump vec4 _WindParams1;
uniform 	mediump vec4 _WindParams2;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _BurnedColor;
uniform 	mediump vec4 _Lightings;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
uniform 	mediump vec4 _Height;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD4;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
float u_xlat22;
vec2 u_xlat25;
vec2 u_xlat27;
float u_xlat33;
float u_xlat34;
mediump float u_xlat16_35;
float u_xlat36;
float u_xlat37;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat11 = in_COLOR0.y + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(1.5<u_xlat11);
#else
    u_xlatb11 = 1.5<u_xlat11;
#endif
    if(u_xlatb11){
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat1;
        gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat11 = in_POSITION0.y * _Height.x;
    u_xlat11 = max(u_xlat11, 9.99999975e-05);
    u_xlat16_2.xyz = in_COLOR0.xyz * _BoundsSize.xyz + _BoundsMin.xyz;
    u_xlat22 = _Time.y + (-unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x);
    u_xlat22 = u_xlat22 * _ReciprocalBurnTime;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat33 = fract(abs(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x));
    u_xlat22 = u_xlat33 * u_xlat22;
    u_xlat33 = 10000.0 * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + (-in_POSITION0.xyz);
    u_xlat34 = (-u_xlat33) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + in_POSITION0.xyz;
    u_xlat1.xyz = (-u_xlat16_2.xyz) * vec3(-1.0, 0.0, -1.0) + u_xlat1.xyz;
    u_xlat34 = (-in_COLOR0.y) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
    u_xlat34 = u_xlat34 * 0.5 + in_COLOR0.y;
    u_xlat16_35 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_35 = sqrt(u_xlat16_35);
    u_xlat3.xy = u_xlat16_2.xz * vec2(-1.0, -1.0) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xz;
    u_xlat4.z = u_xlat33 * u_xlat33;
    u_xlat25.x = _WindParams1.y * 0.100000001;
    u_xlat36 = _MiHoYoWind.w * _WindParams0.x;
    u_xlat11 = log2(u_xlat11);
    u_xlat11 = u_xlat11 * 1.10000002;
    u_xlat11 = exp2(u_xlat11);
    u_xlat37 = u_xlat34 * 6.28299999;
    u_xlat5.x = dot(u_xlat3.xy, _MiHoYoWind.xz);
    u_xlat5.x = (-u_xlat5.x) * _WindParams0.y;
    u_xlat5.x = _Time.y * _WindParams2.x + u_xlat5.x;
    u_xlat25.x = u_xlat37 * u_xlat25.x + u_xlat5.x;
    u_xlat5.x = u_xlat25.x + _WindParams2.y;
    u_xlat25.x = _Time.y * _MiHoYoTimeScale.x + u_xlat37;
    u_xlat5.y = u_xlat25.x + _MiHoYoTimeScale.y;
    u_xlat5.xy = u_xlat5.xy + vec2(0.5, 0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat5.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat27.xy = abs(u_xlat5.xy) * abs(u_xlat5.xy);
    u_xlat5.xy = -abs(u_xlat5.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat5.xy = u_xlat5.xy * u_xlat27.xy;
    u_xlat4.xy = vec2(u_xlat11) * u_xlat5.xy;
    u_xlat4.xw = u_xlat4.zz * u_xlat4.xz;
    u_xlat5.xy = _MiHoYoWind.xz;
    u_xlat27.xy = u_xlat4.xx * u_xlat5.xy;
    u_xlat6.xz = vec2(u_xlat36) * u_xlat27.xy;
    u_xlat6.y = 0.0;
    u_xlat7.x = 0.0;
    u_xlat7.yz = _MiHoYoWind.zx * vec2(0.0, 1.0);
    u_xlat8.xy = _MiHoYoWind.zx * vec2(1.0, 0.0);
    u_xlat8.z = 0.0;
    u_xlat7.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat7.xyz = u_xlat4.xxx * u_xlat7.xyz;
    u_xlat7.xyz = vec3(u_xlat36) * u_xlat7.xyz;
    u_xlat8.xyz = u_xlat7.xyz * _WindParams2.zzz;
    u_xlat25.x = u_xlat4.y * u_xlat4.w;
    u_xlat4.xyw = u_xlat25.xxx * vec3(0.0848399997, 0.0, 0.0848399997);
    u_xlat11 = u_xlat11 * _MiHoYoWind.w;
    u_xlat11 = u_xlat11 * _WindParams1.x + 1.0;
    u_xlat11 = u_xlat11 * u_xlat11 + (-u_xlat11);
    u_xlat25.xy = u_xlat5.xy * vec2(u_xlat11);
    u_xlat5.xz = u_xlat4.zz * u_xlat25.xy;
    u_xlat5.y = 0.0;
    u_xlat8.xyz = u_xlat8.xyz * _WindParams0.www + u_xlat6.xyz;
    u_xlat8.xyz = u_xlat8.xyz * _WindParams0.zzz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat11 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat11 = max(u_xlat11, 0.00100000005);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat8.xyz = vec3(u_xlat11) * u_xlat8.xyz;
    u_xlat6.xyz = u_xlat7.xyz * _WindParams2.zzz + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyw * _WindParams2.www + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat5.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat4.xyz * vec3(0.25, 0.25, 0.25) + u_xlat1.xyz;
    u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_9.x = sqrt(u_xlat16_9.x);
    u_xlat11 = u_xlat16_9.x + 0.00100000005;
    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat11);
    u_xlat11 = u_xlat33 * u_xlat16_35;
    u_xlat3.xy = u_xlat3.xy + (-_GrassDisplacementArea.xy);
    u_xlat3.xy = vec2(u_xlat3.x / _GrassDisplacementArea.z, u_xlat3.y / _GrassDisplacementArea.w);
    u_xlat3.xyz = textureLod(_GrassDisplacementTex, u_xlat3.xy, 0.0).xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat33 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat3.xy = vec2(u_xlat11) * u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * _DisplacementParam.xx;
    u_xlat34 = u_xlat34 * 0.649999976 + 1.13;
    u_xlat3.xy = vec2(u_xlat34) * u_xlat3.xy;
    u_xlat4.xz = u_xlat3.xy * vec2(0.75, 0.75);
    u_xlat11 = u_xlat11 * u_xlat33;
    u_xlat11 = u_xlat11 * _DisplacementParam.y;
    u_xlat33 = max(u_xlat3.z, _DisplacementParam.z);
    u_xlat33 = min(u_xlat33, _DisplacementParam.w);
    u_xlat4.y = u_xlat33 * (-u_xlat11);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat16_35) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat16_9.xyz = _Color.xyz + (-_Color2.xyz);
    u_xlat16_9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www * u_xlat16_9.xyz + _Color2.xyz;
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + _BurnedColor.xyz;
    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat0 = _Lightings.w * 0.300000012;
    vs_TEXCOORD0.w = u_xlat0;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD2.xyz = u_xlat8.xyz;
    vs_TEXCOORD2.w = _Lightings.w;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _CutOut;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump float u_xlat16_1;
bool u_xlatb6;
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
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD4.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_CutOut);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat16_1<0.0);
#else
    u_xlatb6 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb6) * int(0xffffffffu))!=0){discard;}
    SV_Target1.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0.x = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0.x) ? 0.0 : vs_TEXCOORD1.z;
    SV_Target0.xyz = vs_TEXCOORD2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0117647061;
    SV_Target1.w = 0.0;
    SV_Target2.xy = vs_TEXCOORD1.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _Lightings;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD4;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(1.5<in_COLOR0.y);
#else
    u_xlatb0 = 1.5<in_COLOR0.y;
#endif
    if(u_xlatb0){
        gl_Position = hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xy = in_COLOR0.xz * _BoundsSize.xz + _BoundsMin.xz;
    u_xlat0 = (-u_xlat16_1.yyyy) * hlslcc_mtx4x4unity_MatrixVP[2];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * (-u_xlat16_1.xxxx) + u_xlat0;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0.x = _Lightings.w * 0.300000012;
    vs_TEXCOORD0.xyz = _Color2.xyz;
    vs_TEXCOORD0.w = u_xlat0.x;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD2.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD2.w = _Lightings.w;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
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
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _MiHoYoTimeScale;
uniform 	mediump float _ReciprocalBurnTime;
uniform 	mediump vec4 _WindParams0;
uniform 	mediump vec4 _WindParams1;
uniform 	mediump vec4 _WindParams2;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _BurnedColor;
uniform 	mediump vec4 _Lightings;
uniform 	mediump vec4 _BoundsMin;
uniform 	mediump vec4 _BoundsSize;
uniform 	mediump vec4 _Height;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD4;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
bool u_xlatb11;
float u_xlat22;
vec2 u_xlat25;
vec2 u_xlat27;
float u_xlat33;
float u_xlat34;
mediump float u_xlat16_35;
float u_xlat36;
float u_xlat37;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat11 = in_COLOR0.y + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(1.5<u_xlat11);
#else
    u_xlatb11 = 1.5<u_xlat11;
#endif
    if(u_xlatb11){
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].yyyy;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xxxx + u_xlat1;
        u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].zzzz + u_xlat1;
        gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
        vs_TEXCOORD0 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
        vs_TEXCOORD4.xy = vec2(0.0, 0.0);
        return;
    //ENDIF
    }
    u_xlat11 = in_POSITION0.y * _Height.x;
    u_xlat11 = max(u_xlat11, 9.99999975e-05);
    u_xlat16_2.xyz = in_COLOR0.xyz * _BoundsSize.xyz + _BoundsMin.xyz;
    u_xlat22 = _Time.y + (-unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x);
    u_xlat22 = u_xlat22 * _ReciprocalBurnTime;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat33 = fract(abs(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x));
    u_xlat22 = u_xlat33 * u_xlat22;
    u_xlat33 = 10000.0 * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + (-in_POSITION0.xyz);
    u_xlat34 = (-u_xlat33) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat34) + in_POSITION0.xyz;
    u_xlat1.xyz = (-u_xlat16_2.xyz) * vec3(-1.0, 0.0, -1.0) + u_xlat1.xyz;
    u_xlat34 = (-in_COLOR0.y) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].w;
    u_xlat34 = u_xlat34 * 0.5 + in_COLOR0.y;
    u_xlat16_35 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_35 = sqrt(u_xlat16_35);
    u_xlat3.xy = u_xlat16_2.xz * vec2(-1.0, -1.0) + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xz;
    u_xlat4.z = u_xlat33 * u_xlat33;
    u_xlat25.x = _WindParams1.y * 0.100000001;
    u_xlat36 = _MiHoYoWind.w * _WindParams0.x;
    u_xlat11 = log2(u_xlat11);
    u_xlat11 = u_xlat11 * 1.10000002;
    u_xlat11 = exp2(u_xlat11);
    u_xlat37 = u_xlat34 * 6.28299999;
    u_xlat5.x = dot(u_xlat3.xy, _MiHoYoWind.xz);
    u_xlat5.x = (-u_xlat5.x) * _WindParams0.y;
    u_xlat5.x = _Time.y * _WindParams2.x + u_xlat5.x;
    u_xlat25.x = u_xlat37 * u_xlat25.x + u_xlat5.x;
    u_xlat5.x = u_xlat25.x + _WindParams2.y;
    u_xlat25.x = _Time.y * _MiHoYoTimeScale.x + u_xlat37;
    u_xlat5.y = u_xlat25.x + _MiHoYoTimeScale.y;
    u_xlat5.xy = u_xlat5.xy + vec2(0.5, 0.5);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat5.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat27.xy = abs(u_xlat5.xy) * abs(u_xlat5.xy);
    u_xlat5.xy = -abs(u_xlat5.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat5.xy = u_xlat5.xy * u_xlat27.xy;
    u_xlat4.xy = vec2(u_xlat11) * u_xlat5.xy;
    u_xlat4.xw = u_xlat4.zz * u_xlat4.xz;
    u_xlat5.xy = _MiHoYoWind.xz;
    u_xlat27.xy = u_xlat4.xx * u_xlat5.xy;
    u_xlat6.xz = vec2(u_xlat36) * u_xlat27.xy;
    u_xlat6.y = 0.0;
    u_xlat7.x = 0.0;
    u_xlat7.yz = _MiHoYoWind.zx * vec2(0.0, 1.0);
    u_xlat8.xy = _MiHoYoWind.zx * vec2(1.0, 0.0);
    u_xlat8.z = 0.0;
    u_xlat7.xyz = (-u_xlat7.xyz) + u_xlat8.xyz;
    u_xlat7.xyz = u_xlat4.xxx * u_xlat7.xyz;
    u_xlat7.xyz = vec3(u_xlat36) * u_xlat7.xyz;
    u_xlat8.xyz = u_xlat7.xyz * _WindParams2.zzz;
    u_xlat25.x = u_xlat4.y * u_xlat4.w;
    u_xlat4.xyw = u_xlat25.xxx * vec3(0.0848399997, 0.0, 0.0848399997);
    u_xlat11 = u_xlat11 * _MiHoYoWind.w;
    u_xlat11 = u_xlat11 * _WindParams1.x + 1.0;
    u_xlat11 = u_xlat11 * u_xlat11 + (-u_xlat11);
    u_xlat25.xy = u_xlat5.xy * vec2(u_xlat11);
    u_xlat5.xz = u_xlat4.zz * u_xlat25.xy;
    u_xlat5.y = 0.0;
    u_xlat8.xyz = u_xlat8.xyz * _WindParams0.www + u_xlat6.xyz;
    u_xlat8.xyz = u_xlat8.xyz * _WindParams0.zzz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    u_xlat11 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat11 = max(u_xlat11, 0.00100000005);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat8.xyz = vec3(u_xlat11) * u_xlat8.xyz;
    u_xlat6.xyz = u_xlat7.xyz * _WindParams2.zzz + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyw * _WindParams2.www + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat5.xyz + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat4.xyz * vec3(0.25, 0.25, 0.25) + u_xlat1.xyz;
    u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_9.x = sqrt(u_xlat16_9.x);
    u_xlat11 = u_xlat16_9.x + 0.00100000005;
    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat11);
    u_xlat11 = u_xlat33 * u_xlat16_35;
    u_xlat3.xy = u_xlat3.xy + (-_GrassDisplacementArea.xy);
    u_xlat3.xy = vec2(u_xlat3.x / _GrassDisplacementArea.z, u_xlat3.y / _GrassDisplacementArea.w);
    u_xlat3.xyz = textureLod(_GrassDisplacementTex, u_xlat3.xy, 0.0).xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat33 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat33 = sqrt(u_xlat33);
    u_xlat3.xy = vec2(u_xlat11) * u_xlat3.xy;
    u_xlat3.xy = u_xlat3.xy * _DisplacementParam.xx;
    u_xlat34 = u_xlat34 * 0.649999976 + 1.13;
    u_xlat3.xy = vec2(u_xlat34) * u_xlat3.xy;
    u_xlat4.xz = u_xlat3.xy * vec2(0.75, 0.75);
    u_xlat11 = u_xlat11 * u_xlat33;
    u_xlat11 = u_xlat11 * _DisplacementParam.y;
    u_xlat33 = max(u_xlat3.z, _DisplacementParam.z);
    u_xlat33 = min(u_xlat33, _DisplacementParam.w);
    u_xlat4.y = u_xlat33 * (-u_xlat11);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat16_35) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(-1.0, 0.0, -1.0) + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat16_9.xyz = _Color.xyz + (-_Color2.xyz);
    u_xlat16_9.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].www * u_xlat16_9.xyz + _Color2.xyz;
    u_xlat16_10.xyz = (-u_xlat16_9.xyz) + _BurnedColor.xyz;
    vs_TEXCOORD0.xyz = vec3(u_xlat22) * u_xlat16_10.xyz + u_xlat16_9.xyz;
    u_xlat0 = _Lightings.w * 0.300000012;
    vs_TEXCOORD0.w = u_xlat0;
    vs_TEXCOORD1 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD2.xyz = u_xlat8.xyz;
    vs_TEXCOORD2.w = _Lightings.w;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
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
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "MIHOYO_GRASS_DISPLACEMENT" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MIHOYO_GRASS_DISPLACEMENT" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" }
""
}
}
}
}
}