//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Decal/Decal" {
Properties {
_MainTex ("Albedo (RGBA)", 2D) = "white" { }
_Color ("Albedo (Multiplier)", Color) = (1,1,1,1)
_NormalTex ("Normal Map", 2D) = "bump" { }
_NormalMultiplier ("Normal (Multiplier)", Float) = 1
_SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
_Shininess ("Shininess", Range(0.03, 1)) = 0.078125
_DecalBlendMode ("Blend Mode", Float) = 0
_DecalSrcBlend ("SrcBlend", Float) = 1
_DecalDstBlend ("DstBlend", Float) = 10
_AngleLimit ("Angle Limit", Float) = 0.5
_InstancedTexST ("", Vector) = (1,1,0,0)
_InstancedNomralTexST ("", Vector) = (1,1,0,0)
}
SubShader {
 Pass {
  Tags { "LIGHTMODE" = "PREPASSDECALFINAL" }
  ZWrite Off
  GpuProgramID 1528
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD6.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _LightColor0;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp vec2 u_xlat10_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
float u_xlat18;
mediump float u_xlat16_20;
float u_xlat21;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_0 * _Color;
    u_xlat0.x = u_xlat10_0.w * _Color.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(-0.999000013<vs_TEXCOORD1.x);
#else
    u_xlatb0 = -0.999000013<vs_TEXCOORD1.x;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat0.xy = u_xlat16_2.xy * vec2(_NormalMultiplier);
        u_xlat6.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat6.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat16_2.zzz + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-vs_TEXCOORD3.xyz);
        u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
        u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat18 = inversesqrt(u_xlat18);
        u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    } else {
        u_xlat0.xyz = vs_TEXCOORD3.xyz;
    //ENDIF
    }
    u_xlat3.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_5.xy = texture(_ShadowMapTexture, u_xlat5.xy).xy;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat4.xyz;
    u_xlat16_20 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_0 = _Shininess * 128.0;
    u_xlat16_6 = log2(u_xlat16_2.x);
    u_xlat16_0 = u_xlat16_6 * u_xlat16_0;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat1.w * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat21) * _LightColor0.xyz;
    u_xlat6.xyz = u_xlat10_5.xxx * u_xlat6.xyz;
    u_xlat3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat10_5.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _SpecColor.xyz;
    u_xlat4.xyz = abs(u_xlat1.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_0 = (-u_xlat10_5.y) * 0.5 + 0.5;
    u_xlat16_0 = max(u_xlat16_0, 0.00100000005);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = vec3(u_xlat16_0) * u_xlat4.xyz;
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat6.xyz;
    u_xlat3.xyz = u_xlat10_5.yyy * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat0.xyz = vs_TEXCOORD6.xyz * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat1.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
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
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD6;
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
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD6.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _LightColor0;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp vec2 u_xlat10_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
float u_xlat18;
mediump float u_xlat16_20;
float u_xlat21;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_0 * _Color;
    u_xlat0.x = u_xlat10_0.w * _Color.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(-0.999000013<vs_TEXCOORD1.x);
#else
    u_xlatb0 = -0.999000013<vs_TEXCOORD1.x;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat0.xy = u_xlat16_2.xy * vec2(_NormalMultiplier);
        u_xlat6.xyz = u_xlat0.yyy * unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
        u_xlat0.xyz = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * u_xlat0.xxx + u_xlat6.xyz;
        u_xlat0.xyz = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * u_xlat16_2.zzz + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-vs_TEXCOORD3.xyz);
        u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
        u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat18 = inversesqrt(u_xlat18);
        u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    } else {
        u_xlat0.xyz = vs_TEXCOORD3.xyz;
    //ENDIF
    }
    u_xlat3.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_5.xy = texture(_ShadowMapTexture, u_xlat5.xy).xy;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat4.xyz;
    u_xlat16_20 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_0 = _Shininess * 128.0;
    u_xlat16_6 = log2(u_xlat16_2.x);
    u_xlat16_0 = u_xlat16_6 * u_xlat16_0;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat1.w * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat21) * _LightColor0.xyz;
    u_xlat6.xyz = u_xlat10_5.xxx * u_xlat6.xyz;
    u_xlat3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat10_5.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _SpecColor.xyz;
    u_xlat4.xyz = abs(u_xlat1.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_0 = (-u_xlat10_5.y) * 0.5 + 0.5;
    u_xlat16_0 = max(u_xlat16_0, 0.00100000005);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = vec3(u_xlat16_0) * u_xlat4.xyz;
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat6.xyz;
    u_xlat3.xyz = u_xlat10_5.yyy * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat0.xyz = vs_TEXCOORD6.xyz * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat1.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
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
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD6.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _LightColor0;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp vec2 u_xlat10_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
float u_xlat18;
mediump float u_xlat16_20;
float u_xlat21;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_0 * _Color;
    u_xlat0.x = u_xlat10_0.w * _Color.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(-0.999000013<vs_TEXCOORD1.x);
#else
    u_xlatb0 = -0.999000013<vs_TEXCOORD1.x;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat0.xy = u_xlat16_2.xy * vec2(_NormalMultiplier);
        u_xlat6.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat6.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat16_2.zzz + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-vs_TEXCOORD3.xyz);
        u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
        u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat18 = inversesqrt(u_xlat18);
        u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    } else {
        u_xlat0.xyz = vs_TEXCOORD3.xyz;
    //ENDIF
    }
    u_xlat3.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_5.xy = texture(_ShadowMapTexture, u_xlat5.xy).xy;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat4.xyz;
    u_xlat16_20 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_0 = _Shininess * 128.0;
    u_xlat16_6 = log2(u_xlat16_2.x);
    u_xlat16_0 = u_xlat16_6 * u_xlat16_0;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat1.w * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat21) * _LightColor0.xyz;
    u_xlat6.xyz = u_xlat10_5.xxx * u_xlat6.xyz;
    u_xlat3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat10_5.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _SpecColor.xyz;
    u_xlat4.xyz = abs(u_xlat1.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_0 = (-u_xlat10_5.y) * 0.5 + 0.5;
    u_xlat16_0 = max(u_xlat16_0, 0.00100000005);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = vec3(u_xlat16_0) * u_xlat4.xyz;
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat6.xyz;
    u_xlat3.xyz = u_xlat10_5.yyy * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat0.xyz = vs_TEXCOORD6.xyz * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat1.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
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
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD6;
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
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD6.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _LightColor0;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp vec2 u_xlat10_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
float u_xlat18;
mediump float u_xlat16_20;
float u_xlat21;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_0 * _Color;
    u_xlat0.x = u_xlat10_0.w * _Color.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(-0.999000013<vs_TEXCOORD1.x);
#else
    u_xlatb0 = -0.999000013<vs_TEXCOORD1.x;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat0.xy = u_xlat16_2.xy * vec2(_NormalMultiplier);
        u_xlat6.xyz = u_xlat0.yyy * unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
        u_xlat0.xyz = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * u_xlat0.xxx + u_xlat6.xyz;
        u_xlat0.xyz = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * u_xlat16_2.zzz + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-vs_TEXCOORD3.xyz);
        u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
        u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat18 = inversesqrt(u_xlat18);
        u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    } else {
        u_xlat0.xyz = vs_TEXCOORD3.xyz;
    //ENDIF
    }
    u_xlat3.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_5.xy = texture(_ShadowMapTexture, u_xlat5.xy).xy;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat4.xyz;
    u_xlat16_20 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_0 = _Shininess * 128.0;
    u_xlat16_6 = log2(u_xlat16_2.x);
    u_xlat16_0 = u_xlat16_6 * u_xlat16_0;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat1.w * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat21) * _LightColor0.xyz;
    u_xlat6.xyz = u_xlat10_5.xxx * u_xlat6.xyz;
    u_xlat3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat10_5.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _SpecColor.xyz;
    u_xlat4.xyz = abs(u_xlat1.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_0 = (-u_xlat10_5.y) * 0.5 + 0.5;
    u_xlat16_0 = max(u_xlat16_0, 0.00100000005);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = vec3(u_xlat16_0) * u_xlat4.xyz;
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat6.xyz;
    u_xlat3.xyz = u_xlat10_5.yyy * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat0.xyz = vs_TEXCOORD6.xyz * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat1.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = in_NORMAL0.xyz;
    u_xlat16_2.x = in_NORMAL0.y * in_NORMAL0.y;
    u_xlat16_2.x = in_NORMAL0.x * in_NORMAL0.x + (-u_xlat16_2.x);
    u_xlat16_0 = in_NORMAL0.yzzx * in_NORMAL0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.xyz = in_NORMAL0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD6.xyz = u_xlat16_2.xyz;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _LightColor0;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp vec2 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_7;
float u_xlat21;
mediump float u_xlat16_23;
float u_xlat24;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_0 * _Color;
    u_xlat0.x = u_xlat10_0.w * _Color.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(-0.999000013<vs_TEXCOORD1.x);
#else
    u_xlatb0 = -0.999000013<vs_TEXCOORD1.x;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat0.xy = u_xlat16_2.xy * vec2(_NormalMultiplier);
        u_xlat7.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat7.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat16_2.zzz + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-vs_TEXCOORD3.xyz);
        u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
        u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat21 = inversesqrt(u_xlat21);
        u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    } else {
        u_xlat0.xyz = vs_TEXCOORD3.xyz;
    //ENDIF
    }
    u_xlat3.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
    u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_5.xy = texture(_ShadowMapTexture, u_xlat5.xy).xy;
    u_xlat6.xyz = u_xlat10_5.yyy * vs_TEXCOORD6.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat3.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_0 = _Shininess * 128.0;
    u_xlat16_7 = log2(u_xlat16_2.x);
    u_xlat16_0 = u_xlat16_7 * u_xlat16_0;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat1.w * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat24) * _LightColor0.xyz;
    u_xlat7.xyz = u_xlat10_5.xxx * u_xlat7.xyz;
    u_xlat3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat10_5.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _SpecColor.xyz;
    u_xlat4.xyz = abs(u_xlat1.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_0 = (-u_xlat10_5.y) * 0.5 + 0.5;
    u_xlat16_0 = max(u_xlat16_0, 0.00100000005);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = vec3(u_xlat16_0) * u_xlat4.xyz;
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat7.xyz;
    u_xlat3.xyz = u_xlat10_5.yyy * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat6.xyz * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat1.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = in_NORMAL0.xyz;
    u_xlat16_3.x = in_NORMAL0.y * in_NORMAL0.y;
    u_xlat16_3.x = in_NORMAL0.x * in_NORMAL0.x + (-u_xlat16_3.x);
    u_xlat16_0 = in_NORMAL0.yzzx * in_NORMAL0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    vs_TEXCOORD6.xyz = u_xlat16_3.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _LightColor0;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp vec2 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump float u_xlat16_7;
float u_xlat21;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_0 * _Color;
    u_xlat0.x = u_xlat10_0.w * _Color.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(-0.999000013<vs_TEXCOORD1.x);
#else
    u_xlatb0 = -0.999000013<vs_TEXCOORD1.x;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat0.xy = u_xlat16_2.xy * vec2(_NormalMultiplier);
        u_xlat7.xyz = u_xlat0.yyy * unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
        u_xlat0.xyz = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * u_xlat0.xxx + u_xlat7.xyz;
        u_xlat0.xyz = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * u_xlat16_2.zzz + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-vs_TEXCOORD3.xyz);
        u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
        u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat21 = inversesqrt(u_xlat21);
        u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    } else {
        u_xlat0.xyz = vs_TEXCOORD3.xyz;
    //ENDIF
    }
    u_xlat3.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
    u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_5.xy = texture(_ShadowMapTexture, u_xlat5.xy).xy;
    u_xlat0.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD6.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat10_5.yyy * u_xlat16_2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat4.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_0 = _Shininess * 128.0;
    u_xlat16_7 = log2(u_xlat16_2.x);
    u_xlat16_0 = u_xlat16_7 * u_xlat16_0;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat1.w * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat21) * _LightColor0.xyz;
    u_xlat7.xyz = u_xlat10_5.xxx * u_xlat7.xyz;
    u_xlat3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat10_5.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _SpecColor.xyz;
    u_xlat4.xyz = abs(u_xlat1.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_0 = (-u_xlat10_5.y) * 0.5 + 0.5;
    u_xlat16_0 = max(u_xlat16_0, 0.00100000005);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = vec3(u_xlat16_0) * u_xlat4.xyz;
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat7.xyz;
    u_xlat3.xyz = u_xlat10_5.yyy * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat1.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = in_NORMAL0.xyz;
    u_xlat16_2.x = in_NORMAL0.y * in_NORMAL0.y;
    u_xlat16_2.x = in_NORMAL0.x * in_NORMAL0.x + (-u_xlat16_2.x);
    u_xlat16_0 = in_NORMAL0.yzzx * in_NORMAL0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.xyz = in_NORMAL0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD6.xyz = u_xlat16_2.xyz;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _LightColor0;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp vec2 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_7;
float u_xlat21;
mediump float u_xlat16_23;
float u_xlat24;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_0 * _Color;
    u_xlat0.x = u_xlat10_0.w * _Color.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(-0.999000013<vs_TEXCOORD1.x);
#else
    u_xlatb0 = -0.999000013<vs_TEXCOORD1.x;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat0.xy = u_xlat16_2.xy * vec2(_NormalMultiplier);
        u_xlat7.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat7.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat16_2.zzz + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-vs_TEXCOORD3.xyz);
        u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
        u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat21 = inversesqrt(u_xlat21);
        u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    } else {
        u_xlat0.xyz = vs_TEXCOORD3.xyz;
    //ENDIF
    }
    u_xlat3.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
    u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_5.xy = texture(_ShadowMapTexture, u_xlat5.xy).xy;
    u_xlat6.xyz = u_xlat10_5.yyy * vs_TEXCOORD6.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat3.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_0 = _Shininess * 128.0;
    u_xlat16_7 = log2(u_xlat16_2.x);
    u_xlat16_0 = u_xlat16_7 * u_xlat16_0;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat1.w * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat24) * _LightColor0.xyz;
    u_xlat7.xyz = u_xlat10_5.xxx * u_xlat7.xyz;
    u_xlat3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat10_5.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _SpecColor.xyz;
    u_xlat4.xyz = abs(u_xlat1.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_0 = (-u_xlat10_5.y) * 0.5 + 0.5;
    u_xlat16_0 = max(u_xlat16_0, 0.00100000005);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = vec3(u_xlat16_0) * u_xlat4.xyz;
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat7.xyz;
    u_xlat3.xyz = u_xlat10_5.yyy * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat6.xyz * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat1.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "INSTANCING_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = in_NORMAL0.xyz;
    u_xlat16_3.x = in_NORMAL0.y * in_NORMAL0.y;
    u_xlat16_3.x = in_NORMAL0.x * in_NORMAL0.x + (-u_xlat16_3.x);
    u_xlat16_0 = in_NORMAL0.yzzx * in_NORMAL0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    vs_TEXCOORD6.xyz = u_xlat16_3.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _LightColor0;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp vec2 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump float u_xlat16_7;
float u_xlat21;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_0 * _Color;
    u_xlat0.x = u_xlat10_0.w * _Color.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(-0.999000013<vs_TEXCOORD1.x);
#else
    u_xlatb0 = -0.999000013<vs_TEXCOORD1.x;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat0.xy = u_xlat16_2.xy * vec2(_NormalMultiplier);
        u_xlat7.xyz = u_xlat0.yyy * unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
        u_xlat0.xyz = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * u_xlat0.xxx + u_xlat7.xyz;
        u_xlat0.xyz = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * u_xlat16_2.zzz + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-vs_TEXCOORD3.xyz);
        u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
        u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat21 = inversesqrt(u_xlat21);
        u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    } else {
        u_xlat0.xyz = vs_TEXCOORD3.xyz;
    //ENDIF
    }
    u_xlat3.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
    u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_5.xy = texture(_ShadowMapTexture, u_xlat5.xy).xy;
    u_xlat0.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD6.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat10_5.yyy * u_xlat16_2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat4.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_0 = _Shininess * 128.0;
    u_xlat16_7 = log2(u_xlat16_2.x);
    u_xlat16_0 = u_xlat16_7 * u_xlat16_0;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat1.w * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat21) * _LightColor0.xyz;
    u_xlat7.xyz = u_xlat10_5.xxx * u_xlat7.xyz;
    u_xlat3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat10_5.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _SpecColor.xyz;
    u_xlat4.xyz = abs(u_xlat1.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_0 = (-u_xlat10_5.y) * 0.5 + 0.5;
    u_xlat16_0 = max(u_xlat16_0, 0.00100000005);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = vec3(u_xlat16_0) * u_xlat4.xyz;
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat7.xyz;
    u_xlat3.xyz = u_xlat10_5.yyy * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat1.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD6.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _LightColor0;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp vec2 u_xlat10_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
float u_xlat18;
mediump float u_xlat16_20;
float u_xlat21;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_0 * _Color;
    u_xlat0.x = u_xlat10_0.w * _Color.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(-0.999000013<vs_TEXCOORD1.x);
#else
    u_xlatb0 = -0.999000013<vs_TEXCOORD1.x;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat0.xy = u_xlat16_2.xy * vec2(_NormalMultiplier);
        u_xlat6.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat6.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat16_2.zzz + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-vs_TEXCOORD3.xyz);
        u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
        u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat18 = inversesqrt(u_xlat18);
        u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    } else {
        u_xlat0.xyz = vs_TEXCOORD3.xyz;
    //ENDIF
    }
    u_xlat3.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_5.xy = texture(_ShadowMapTexture, u_xlat5.xy).xy;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat4.xyz;
    u_xlat16_20 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_0 = _Shininess * 128.0;
    u_xlat16_6 = log2(u_xlat16_2.x);
    u_xlat16_0 = u_xlat16_6 * u_xlat16_0;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat1.w * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat21) * _LightColor0.xyz;
    u_xlat6.xyz = u_xlat10_5.xxx * u_xlat6.xyz;
    u_xlat3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat10_5.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _SpecColor.xyz;
    u_xlat4.xyz = abs(u_xlat1.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_0 = (-u_xlat10_5.y) * 0.5 + 0.5;
    u_xlat16_0 = max(u_xlat16_0, 0.00100000005);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = vec3(u_xlat16_0) * u_xlat4.xyz;
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat6.xyz;
    u_xlat3.xyz = u_xlat10_5.yyy * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat0.xyz = vs_TEXCOORD6.xyz * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat1.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_HDR_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
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
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD6;
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
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD6.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _LightColor0;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp vec2 u_xlat10_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
float u_xlat18;
mediump float u_xlat16_20;
float u_xlat21;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_0 * _Color;
    u_xlat0.x = u_xlat10_0.w * _Color.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(-0.999000013<vs_TEXCOORD1.x);
#else
    u_xlatb0 = -0.999000013<vs_TEXCOORD1.x;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat0.xy = u_xlat16_2.xy * vec2(_NormalMultiplier);
        u_xlat6.xyz = u_xlat0.yyy * unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
        u_xlat0.xyz = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * u_xlat0.xxx + u_xlat6.xyz;
        u_xlat0.xyz = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * u_xlat16_2.zzz + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-vs_TEXCOORD3.xyz);
        u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
        u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat18 = inversesqrt(u_xlat18);
        u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    } else {
        u_xlat0.xyz = vs_TEXCOORD3.xyz;
    //ENDIF
    }
    u_xlat3.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_5.xy = texture(_ShadowMapTexture, u_xlat5.xy).xy;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat4.xyz;
    u_xlat16_20 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_0 = _Shininess * 128.0;
    u_xlat16_6 = log2(u_xlat16_2.x);
    u_xlat16_0 = u_xlat16_6 * u_xlat16_0;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat1.w * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat21) * _LightColor0.xyz;
    u_xlat6.xyz = u_xlat10_5.xxx * u_xlat6.xyz;
    u_xlat3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat10_5.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _SpecColor.xyz;
    u_xlat4.xyz = abs(u_xlat1.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_0 = (-u_xlat10_5.y) * 0.5 + 0.5;
    u_xlat16_0 = max(u_xlat16_0, 0.00100000005);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = vec3(u_xlat16_0) * u_xlat4.xyz;
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat6.xyz;
    u_xlat3.xyz = u_xlat10_5.yyy * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat0.xyz = vs_TEXCOORD6.xyz * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat1.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_HDR_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD6.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _LightColor0;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp vec2 u_xlat10_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
float u_xlat18;
mediump float u_xlat16_20;
float u_xlat21;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_0 * _Color;
    u_xlat0.x = u_xlat10_0.w * _Color.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(-0.999000013<vs_TEXCOORD1.x);
#else
    u_xlatb0 = -0.999000013<vs_TEXCOORD1.x;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat0.xy = u_xlat16_2.xy * vec2(_NormalMultiplier);
        u_xlat6.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat6.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat16_2.zzz + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-vs_TEXCOORD3.xyz);
        u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
        u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat18 = inversesqrt(u_xlat18);
        u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    } else {
        u_xlat0.xyz = vs_TEXCOORD3.xyz;
    //ENDIF
    }
    u_xlat3.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_5.xy = texture(_ShadowMapTexture, u_xlat5.xy).xy;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat4.xyz;
    u_xlat16_20 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_0 = _Shininess * 128.0;
    u_xlat16_6 = log2(u_xlat16_2.x);
    u_xlat16_0 = u_xlat16_6 * u_xlat16_0;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat1.w * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat21) * _LightColor0.xyz;
    u_xlat6.xyz = u_xlat10_5.xxx * u_xlat6.xyz;
    u_xlat3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat10_5.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _SpecColor.xyz;
    u_xlat4.xyz = abs(u_xlat1.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_0 = (-u_xlat10_5.y) * 0.5 + 0.5;
    u_xlat16_0 = max(u_xlat16_0, 0.00100000005);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = vec3(u_xlat16_0) * u_xlat4.xyz;
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat6.xyz;
    u_xlat3.xyz = u_xlat10_5.yyy * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat0.xyz = vs_TEXCOORD6.xyz * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat1.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_HDR_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
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
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD6;
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
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = in_NORMAL0.xyz;
    vs_TEXCOORD6.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _LightColor0;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp vec2 u_xlat10_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
float u_xlat18;
mediump float u_xlat16_20;
float u_xlat21;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_0 * _Color;
    u_xlat0.x = u_xlat10_0.w * _Color.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(-0.999000013<vs_TEXCOORD1.x);
#else
    u_xlatb0 = -0.999000013<vs_TEXCOORD1.x;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat0.xy = u_xlat16_2.xy * vec2(_NormalMultiplier);
        u_xlat6.xyz = u_xlat0.yyy * unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
        u_xlat0.xyz = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * u_xlat0.xxx + u_xlat6.xyz;
        u_xlat0.xyz = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * u_xlat16_2.zzz + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-vs_TEXCOORD3.xyz);
        u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
        u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat18 = inversesqrt(u_xlat18);
        u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    } else {
        u_xlat0.xyz = vs_TEXCOORD3.xyz;
    //ENDIF
    }
    u_xlat3.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_5.xy = texture(_ShadowMapTexture, u_xlat5.xy).xy;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat4.xyz;
    u_xlat16_20 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_20 = inversesqrt(u_xlat16_20);
    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_0 = _Shininess * 128.0;
    u_xlat16_6 = log2(u_xlat16_2.x);
    u_xlat16_0 = u_xlat16_6 * u_xlat16_0;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat1.w * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.xyz = vec3(u_xlat21) * _LightColor0.xyz;
    u_xlat6.xyz = u_xlat10_5.xxx * u_xlat6.xyz;
    u_xlat3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat10_5.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _SpecColor.xyz;
    u_xlat4.xyz = abs(u_xlat1.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_0 = (-u_xlat10_5.y) * 0.5 + 0.5;
    u_xlat16_0 = max(u_xlat16_0, 0.00100000005);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = vec3(u_xlat16_0) * u_xlat4.xyz;
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat6.xyz;
    u_xlat3.xyz = u_xlat10_5.yyy * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat0.xyz = vs_TEXCOORD6.xyz * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat1.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = in_NORMAL0.xyz;
    u_xlat16_2.x = in_NORMAL0.y * in_NORMAL0.y;
    u_xlat16_2.x = in_NORMAL0.x * in_NORMAL0.x + (-u_xlat16_2.x);
    u_xlat16_0 = in_NORMAL0.yzzx * in_NORMAL0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.xyz = in_NORMAL0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD6.xyz = u_xlat16_2.xyz;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _LightColor0;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp vec2 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_7;
float u_xlat21;
mediump float u_xlat16_23;
float u_xlat24;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_0 * _Color;
    u_xlat0.x = u_xlat10_0.w * _Color.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(-0.999000013<vs_TEXCOORD1.x);
#else
    u_xlatb0 = -0.999000013<vs_TEXCOORD1.x;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat0.xy = u_xlat16_2.xy * vec2(_NormalMultiplier);
        u_xlat7.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat7.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat16_2.zzz + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-vs_TEXCOORD3.xyz);
        u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
        u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat21 = inversesqrt(u_xlat21);
        u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    } else {
        u_xlat0.xyz = vs_TEXCOORD3.xyz;
    //ENDIF
    }
    u_xlat3.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
    u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_5.xy = texture(_ShadowMapTexture, u_xlat5.xy).xy;
    u_xlat6.xyz = u_xlat10_5.yyy * vs_TEXCOORD6.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat3.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_0 = _Shininess * 128.0;
    u_xlat16_7 = log2(u_xlat16_2.x);
    u_xlat16_0 = u_xlat16_7 * u_xlat16_0;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat1.w * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat24) * _LightColor0.xyz;
    u_xlat7.xyz = u_xlat10_5.xxx * u_xlat7.xyz;
    u_xlat3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat10_5.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _SpecColor.xyz;
    u_xlat4.xyz = abs(u_xlat1.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_0 = (-u_xlat10_5.y) * 0.5 + 0.5;
    u_xlat16_0 = max(u_xlat16_0, 0.00100000005);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = vec3(u_xlat16_0) * u_xlat4.xyz;
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat7.xyz;
    u_xlat3.xyz = u_xlat10_5.yyy * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat6.xyz * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat1.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = in_NORMAL0.xyz;
    u_xlat16_3.x = in_NORMAL0.y * in_NORMAL0.y;
    u_xlat16_3.x = in_NORMAL0.x * in_NORMAL0.x + (-u_xlat16_3.x);
    u_xlat16_0 = in_NORMAL0.yzzx * in_NORMAL0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    vs_TEXCOORD6.xyz = u_xlat16_3.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _LightColor0;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp vec2 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump float u_xlat16_7;
float u_xlat21;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_0 * _Color;
    u_xlat0.x = u_xlat10_0.w * _Color.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(-0.999000013<vs_TEXCOORD1.x);
#else
    u_xlatb0 = -0.999000013<vs_TEXCOORD1.x;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat0.xy = u_xlat16_2.xy * vec2(_NormalMultiplier);
        u_xlat7.xyz = u_xlat0.yyy * unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
        u_xlat0.xyz = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * u_xlat0.xxx + u_xlat7.xyz;
        u_xlat0.xyz = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * u_xlat16_2.zzz + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-vs_TEXCOORD3.xyz);
        u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
        u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat21 = inversesqrt(u_xlat21);
        u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    } else {
        u_xlat0.xyz = vs_TEXCOORD3.xyz;
    //ENDIF
    }
    u_xlat3.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
    u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_5.xy = texture(_ShadowMapTexture, u_xlat5.xy).xy;
    u_xlat0.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD6.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat10_5.yyy * u_xlat16_2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat4.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_0 = _Shininess * 128.0;
    u_xlat16_7 = log2(u_xlat16_2.x);
    u_xlat16_0 = u_xlat16_7 * u_xlat16_0;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat1.w * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat21) * _LightColor0.xyz;
    u_xlat7.xyz = u_xlat10_5.xxx * u_xlat7.xyz;
    u_xlat3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat10_5.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _SpecColor.xyz;
    u_xlat4.xyz = abs(u_xlat1.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_0 = (-u_xlat10_5.y) * 0.5 + 0.5;
    u_xlat16_0 = max(u_xlat16_0, 0.00100000005);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = vec3(u_xlat16_0) * u_xlat4.xyz;
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat7.xyz;
    u_xlat3.xyz = u_xlat10_5.yyy * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat1.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = in_NORMAL0.xyz;
    u_xlat16_2.x = in_NORMAL0.y * in_NORMAL0.y;
    u_xlat16_2.x = in_NORMAL0.x * in_NORMAL0.x + (-u_xlat16_2.x);
    u_xlat16_0 = in_NORMAL0.yzzx * in_NORMAL0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.xyz = in_NORMAL0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD6.xyz = u_xlat16_2.xyz;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _LightColor0;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp vec2 u_xlat10_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_7;
float u_xlat21;
mediump float u_xlat16_23;
float u_xlat24;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_0 * _Color;
    u_xlat0.x = u_xlat10_0.w * _Color.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(-0.999000013<vs_TEXCOORD1.x);
#else
    u_xlatb0 = -0.999000013<vs_TEXCOORD1.x;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat0.xy = u_xlat16_2.xy * vec2(_NormalMultiplier);
        u_xlat7.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat7.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat16_2.zzz + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-vs_TEXCOORD3.xyz);
        u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
        u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat21 = inversesqrt(u_xlat21);
        u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    } else {
        u_xlat0.xyz = vs_TEXCOORD3.xyz;
    //ENDIF
    }
    u_xlat3.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
    u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_5.xy = texture(_ShadowMapTexture, u_xlat5.xy).xy;
    u_xlat6.xyz = u_xlat10_5.yyy * vs_TEXCOORD6.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat3.xyz * vec3(u_xlat21) + u_xlat4.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_0 = _Shininess * 128.0;
    u_xlat16_7 = log2(u_xlat16_2.x);
    u_xlat16_0 = u_xlat16_7 * u_xlat16_0;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat1.w * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat24) * _LightColor0.xyz;
    u_xlat7.xyz = u_xlat10_5.xxx * u_xlat7.xyz;
    u_xlat3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat10_5.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _SpecColor.xyz;
    u_xlat4.xyz = abs(u_xlat1.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_0 = (-u_xlat10_5.y) * 0.5 + 0.5;
    u_xlat16_0 = max(u_xlat16_0, 0.00100000005);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = vec3(u_xlat16_0) * u_xlat4.xyz;
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat7.xyz;
    u_xlat3.xyz = u_xlat10_5.yyy * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat6.xyz * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat1.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD6;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD3.xyz = in_NORMAL0.xyz;
    u_xlat16_3.x = in_NORMAL0.y * in_NORMAL0.y;
    u_xlat16_3.x = in_NORMAL0.x * in_NORMAL0.x + (-u_xlat16_3.x);
    u_xlat16_0 = in_NORMAL0.yzzx * in_NORMAL0.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    vs_TEXCOORD6.xyz = u_xlat16_3.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	vec4 _Color;
uniform 	float _NormalMultiplier;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _Shininess;
uniform 	mediump vec4 _LightColor0;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _ShadowMapTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
lowp vec2 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump float u_xlat16_7;
float u_xlat21;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_0 * _Color;
    u_xlat0.x = u_xlat10_0.w * _Color.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(-0.999000013<vs_TEXCOORD1.x);
#else
    u_xlatb0 = -0.999000013<vs_TEXCOORD1.x;
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat0.xy = u_xlat16_2.xy * vec2(_NormalMultiplier);
        u_xlat7.xyz = u_xlat0.yyy * unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
        u_xlat0.xyz = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * u_xlat0.xxx + u_xlat7.xyz;
        u_xlat0.xyz = unity_Builtins0Array[0].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * u_xlat16_2.zzz + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-vs_TEXCOORD3.xyz);
        u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
        u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat21 = inversesqrt(u_xlat21);
        u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    } else {
        u_xlat0.xyz = vs_TEXCOORD3.xyz;
    //ENDIF
    }
    u_xlat3.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = (-vs_TEXCOORD4.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
    u_xlat5.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat10_5.xy = texture(_ShadowMapTexture, u_xlat5.xy).xy;
    u_xlat0.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD6.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = u_xlat10_5.yyy * u_xlat16_2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat3.xyz * vec3(u_xlat24) + u_xlat4.xyz;
    u_xlat16_23 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = max(u_xlat16_2.x, 0.00100000005);
    u_xlat16_0 = _Shininess * 128.0;
    u_xlat16_7 = log2(u_xlat16_2.x);
    u_xlat16_0 = u_xlat16_7 * u_xlat16_0;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat0.x = u_xlat1.w * u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat21) * _LightColor0.xyz;
    u_xlat7.xyz = u_xlat10_5.xxx * u_xlat7.xyz;
    u_xlat3.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat3.xyz = u_xlat10_5.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _SpecColor.xyz;
    u_xlat4.xyz = abs(u_xlat1.xyz) + vec3(0.00100000005, 0.00100000005, 0.00100000005);
    u_xlat16_0 = (-u_xlat10_5.y) * 0.5 + 0.5;
    u_xlat16_0 = max(u_xlat16_0, 0.00100000005);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = vec3(u_xlat16_0) * u_xlat4.xyz;
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat7.xyz;
    u_xlat3.xyz = u_xlat10_5.yyy * u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat1.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
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
Keywords { "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_HDR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_HDR_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_HDR_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_HDR_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
}
}
}
CustomEditor "MoleMole.DeferredDecalShaderGUI"
}