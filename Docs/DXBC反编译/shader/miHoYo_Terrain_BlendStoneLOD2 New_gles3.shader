//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Terrain/BlendStoneLOD2 New" {
Properties {
[Header(Main Setting)] _ElementViewEleID ("Element ID", Float) = 0
_MainColor ("Main Color", Color) = (1,1,1,1)
[MHYToggle] _InvertBlend ("Invert Blend", Float) = 0
_DefaultSmoothness_LOD2 ("LOD2 Default Smoothness", Range(0.01, 0.8)) = 0
[Header(Stone)] _StoneDiffuse ("Stone Diffuse", 2D) = "white" { }
_StoneColor ("Stone Color (Using in Low-end)", Color) = (1,1,1,1)
_StoneNormal ("Stone Normal", 2D) = "bump" { }
[Header(Grass)] _GrassDiffuse ("Grass diffuse", 2D) = "white" { }
_GrassColor ("Grass Color (Using in Low-end)", Color) = (1,1,1,1)
}
SubShader {
 Tags { "QUEUE" = "Geometry-100" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry-100" "RenderType" = "Opaque" }
  GpuProgramID 56936
Program "vp" {
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _InvertBlend;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _StoneDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat12;
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
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat12 = u_xlat12 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat12 = u_xlat12 + u_xlat2.x;
    u_xlat16_3.x = u_xlat12 * 0.330000013;
    u_xlat2.xy = u_xlat16_3.xx * in_TEXCOORD0.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _StoneDiffuse_ST.xy + _StoneDiffuse_ST.zw;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat16_3.x = in_COLOR0.w * -2.0 + 1.0;
    vs_COLOR0.w = _InvertBlend * u_xlat16_3.x + in_COLOR0.w;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    vs_TEXCOORD3.y = u_xlat16_3.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_3.y;
    vs_TEXCOORD5.y = u_xlat16_3.z;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _DiffuseBlendIntensity;
uniform 	mediump float _DiffuseBlendMethod;
uniform 	mediump float _NormalBlendIntensity;
uniform 	mediump float _NormalBlendMethod;
uniform 	float _StoneNormalScale;
uniform 	mediump float _DefaultSmoothness_Grass;
uniform 	mediump float _DefaultSmoothness_Stone;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _StoneDiffuse;
uniform lowp sampler2D _StoneNormal;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_9;
bool u_xlatb9;
float u_xlat18;
mediump float u_xlat16_18;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
float u_xlat34;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w>=0.00100000005);
#else
    u_xlatb0 = vs_COLOR0.w>=0.00100000005;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.999000013>=vs_COLOR0.w);
#else
    u_xlatb9 = 0.999000013>=vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat10_0.xzw = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_0.xzw;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb9){
        u_xlat10_0.xyz = texture(_StoneDiffuse, vs_TEXCOORD0.zw).xyz;
        u_xlat10_2.xyz = texture(_StoneNormal, vs_TEXCOORD0.zw).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(_StoneNormalScale);
        u_xlat16_4.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    } else {
        u_xlat16_4.x = float(0.0);
        u_xlat16_4.y = float(0.0);
        u_xlat16_4.z = float(0.0);
        u_xlat16_3.x = float(0.0);
        u_xlat16_3.y = float(0.0);
        u_xlat16_3.z = float(1.0);
    //ENDIF
    }
    u_xlat16_5.xy = vs_COLOR0.ww * vec2(_DiffuseBlendIntensity, _NormalBlendIntensity);
    u_xlat16_6.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = vec3(vec3(_DiffuseBlendMethod, _DiffuseBlendMethod, _DiffuseBlendMethod)) * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz + (-u_xlat16_4.xyz);
    u_xlat16_1.xyz = u_xlat16_5.xxx * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xy = u_xlat16_3.xy * vec2(vec2(_NormalBlendMethod, _NormalBlendMethod));
    u_xlat16_4.z = 1.0;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_5.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_28 = (-_DefaultSmoothness_Stone) + _DefaultSmoothness_Grass;
    u_xlat16_28 = vs_COLOR0.w * u_xlat16_28 + _DefaultSmoothness_Stone;
    u_xlat16_0 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_0 = min(u_xlat16_0, 0.999000013);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
    u_xlat7.x = vs_TEXCOORD3.w;
    u_xlat7.y = vs_TEXCOORD4.w;
    u_xlat7.z = vs_TEXCOORD5.w;
    u_xlat9.xyz = (-u_xlat7.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat7.xyz = (-u_xlat7.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat8 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat8);
    u_xlat16_28 = (-u_xlat16_0) + 1.0;
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_5 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_30 = u_xlat2.y * u_xlat2.y;
    u_xlat16_30 = u_xlat2.x * u_xlat2.x + (-u_xlat16_30);
    u_xlat16_5.xyz = unity_SHC.xyz * vec3(u_xlat16_30) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_30 = dot(u_xlat7.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat9.xyz * vec3(u_xlat34) + u_xlat7.xyz;
    u_xlat16_31 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_4.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat9.x = dot(u_xlat7.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat16_18 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_27 = u_xlat16_18 * u_xlat16_18;
    u_xlat2.x = u_xlat0 * u_xlat16_27 + (-u_xlat0);
    u_xlat0 = u_xlat2.x * u_xlat0 + 1.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = max(u_xlat0, 9.99999997e-07);
    u_xlat0 = u_xlat16_27 / u_xlat0;
    u_xlat0 = u_xlat0 * 0.318309873;
    u_xlat0 = min(u_xlat0, 64.0);
    u_xlat16_18 = (-u_xlat16_18) * u_xlat16_18 + 1.0;
    u_xlat16_18 = u_xlat16_18 + u_xlat16_18;
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat16_28 = u_xlat9.x * u_xlat9.x;
    u_xlat16_28 = u_xlat9.x * u_xlat16_28;
    u_xlat16_28 = u_xlat9.x * u_xlat16_28;
    u_xlat16_28 = u_xlat9.x * u_xlat16_28;
    u_xlat16_9 = u_xlat16_28 * 0.959999979;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_18 + 0.0399999991;
    u_xlat18 = u_xlat16_9 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat16_9 + 2.0;
    u_xlat0 = u_xlat18 / u_xlat0;
    u_xlat16_3.xyz = vec3(u_xlat0) * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _LightColor0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_30) + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _InvertBlend;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _StoneDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7 = sqrt(u_xlat7);
    u_xlat2.x = u_xlat7 + u_xlat2.x;
    u_xlat16_4.x = u_xlat2.x * 0.330000013;
    u_xlat2.xy = u_xlat16_4.xx * in_TEXCOORD0.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _StoneDiffuse_ST.xy + _StoneDiffuse_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat16_4.x = in_COLOR0.w * -2.0 + 1.0;
    vs_COLOR0.w = _InvertBlend * u_xlat16_4.x + in_COLOR0.w;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _DiffuseBlendIntensity;
uniform 	mediump float _DiffuseBlendMethod;
uniform 	mediump float _NormalBlendIntensity;
uniform 	mediump float _NormalBlendMethod;
uniform 	float _StoneNormalScale;
uniform 	mediump float _DefaultSmoothness_Grass;
uniform 	mediump float _DefaultSmoothness_Stone;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _StoneDiffuse;
uniform lowp sampler2D _StoneNormal;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_9;
bool u_xlatb9;
float u_xlat18;
mediump float u_xlat16_18;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
float u_xlat34;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w>=0.00100000005);
#else
    u_xlatb0 = vs_COLOR0.w>=0.00100000005;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.999000013>=vs_COLOR0.w);
#else
    u_xlatb9 = 0.999000013>=vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat10_0.xzw = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_0.xzw;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb9){
        u_xlat10_0.xyz = texture(_StoneDiffuse, vs_TEXCOORD0.zw).xyz;
        u_xlat10_2.xyz = texture(_StoneNormal, vs_TEXCOORD0.zw).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(_StoneNormalScale);
        u_xlat16_4.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    } else {
        u_xlat16_4.x = float(0.0);
        u_xlat16_4.y = float(0.0);
        u_xlat16_4.z = float(0.0);
        u_xlat16_3.x = float(0.0);
        u_xlat16_3.y = float(0.0);
        u_xlat16_3.z = float(1.0);
    //ENDIF
    }
    u_xlat16_5.xy = vs_COLOR0.ww * vec2(_DiffuseBlendIntensity, _NormalBlendIntensity);
    u_xlat16_6.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = vec3(vec3(_DiffuseBlendMethod, _DiffuseBlendMethod, _DiffuseBlendMethod)) * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz + (-u_xlat16_4.xyz);
    u_xlat16_1.xyz = u_xlat16_5.xxx * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xy = u_xlat16_3.xy * vec2(vec2(_NormalBlendMethod, _NormalBlendMethod));
    u_xlat16_4.z = 1.0;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_5.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_28 = (-_DefaultSmoothness_Stone) + _DefaultSmoothness_Grass;
    u_xlat16_28 = vs_COLOR0.w * u_xlat16_28 + _DefaultSmoothness_Stone;
    u_xlat16_0 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_0 = min(u_xlat16_0, 0.999000013);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
    u_xlat7.x = vs_TEXCOORD3.w;
    u_xlat7.y = vs_TEXCOORD4.w;
    u_xlat7.z = vs_TEXCOORD5.w;
    u_xlat9.xyz = (-u_xlat7.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat7.xyz = (-u_xlat7.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat8 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat8);
    u_xlat16_28 = (-u_xlat16_0) + 1.0;
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_5 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_30 = u_xlat2.y * u_xlat2.y;
    u_xlat16_30 = u_xlat2.x * u_xlat2.x + (-u_xlat16_30);
    u_xlat16_5.xyz = unity_SHC.xyz * vec3(u_xlat16_30) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_30 = dot(u_xlat7.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat9.xyz * vec3(u_xlat34) + u_xlat7.xyz;
    u_xlat16_31 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_4.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat9.x = dot(u_xlat7.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat16_18 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_27 = u_xlat16_18 * u_xlat16_18;
    u_xlat2.x = u_xlat0 * u_xlat16_27 + (-u_xlat0);
    u_xlat0 = u_xlat2.x * u_xlat0 + 1.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = max(u_xlat0, 9.99999997e-07);
    u_xlat0 = u_xlat16_27 / u_xlat0;
    u_xlat0 = u_xlat0 * 0.318309873;
    u_xlat0 = min(u_xlat0, 64.0);
    u_xlat16_18 = (-u_xlat16_18) * u_xlat16_18 + 1.0;
    u_xlat16_18 = u_xlat16_18 + u_xlat16_18;
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat16_28 = u_xlat9.x * u_xlat9.x;
    u_xlat16_28 = u_xlat9.x * u_xlat16_28;
    u_xlat16_28 = u_xlat9.x * u_xlat16_28;
    u_xlat16_28 = u_xlat9.x * u_xlat16_28;
    u_xlat16_9 = u_xlat16_28 * 0.959999979;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_18 + 0.0399999991;
    u_xlat18 = u_xlat16_9 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat16_9 + 2.0;
    u_xlat0 = u_xlat18 / u_xlat0;
    u_xlat16_3.xyz = vec3(u_xlat0) * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _LightColor0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_30) + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _InvertBlend;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _StoneDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat12;
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
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat12 = u_xlat12 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat12 = u_xlat12 + u_xlat2.x;
    u_xlat16_3.x = u_xlat12 * 0.330000013;
    u_xlat2.xy = u_xlat16_3.xx * in_TEXCOORD0.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _StoneDiffuse_ST.xy + _StoneDiffuse_ST.zw;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat16_3.x = in_COLOR0.w * -2.0 + 1.0;
    vs_COLOR0.w = _InvertBlend * u_xlat16_3.x + in_COLOR0.w;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    vs_TEXCOORD3.y = u_xlat16_3.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_3.y;
    vs_TEXCOORD5.y = u_xlat16_3.z;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _DiffuseBlendIntensity;
uniform 	mediump float _DiffuseBlendMethod;
uniform 	mediump float _NormalBlendIntensity;
uniform 	mediump float _NormalBlendMethod;
uniform 	float _StoneNormalScale;
uniform 	mediump float _DefaultSmoothness_Grass;
uniform 	mediump float _DefaultSmoothness_Stone;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _StoneDiffuse;
uniform lowp sampler2D _StoneNormal;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_9;
bool u_xlatb9;
float u_xlat18;
mediump float u_xlat16_18;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
float u_xlat34;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w>=0.00100000005);
#else
    u_xlatb0 = vs_COLOR0.w>=0.00100000005;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.999000013>=vs_COLOR0.w);
#else
    u_xlatb9 = 0.999000013>=vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat10_0.xzw = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_0.xzw;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb9){
        u_xlat10_0.xyz = texture(_StoneDiffuse, vs_TEXCOORD0.zw).xyz;
        u_xlat10_2.xyz = texture(_StoneNormal, vs_TEXCOORD0.zw).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(_StoneNormalScale);
        u_xlat16_4.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    } else {
        u_xlat16_4.x = float(0.0);
        u_xlat16_4.y = float(0.0);
        u_xlat16_4.z = float(0.0);
        u_xlat16_3.x = float(0.0);
        u_xlat16_3.y = float(0.0);
        u_xlat16_3.z = float(1.0);
    //ENDIF
    }
    u_xlat16_5.xy = vs_COLOR0.ww * vec2(_DiffuseBlendIntensity, _NormalBlendIntensity);
    u_xlat16_6.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = vec3(vec3(_DiffuseBlendMethod, _DiffuseBlendMethod, _DiffuseBlendMethod)) * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz + (-u_xlat16_4.xyz);
    u_xlat16_1.xyz = u_xlat16_5.xxx * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xy = u_xlat16_3.xy * vec2(vec2(_NormalBlendMethod, _NormalBlendMethod));
    u_xlat16_4.z = 1.0;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_5.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_28 = (-_DefaultSmoothness_Stone) + _DefaultSmoothness_Grass;
    u_xlat16_28 = vs_COLOR0.w * u_xlat16_28 + _DefaultSmoothness_Stone;
    u_xlat16_0 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_0 = min(u_xlat16_0, 0.999000013);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
    u_xlat7.x = vs_TEXCOORD3.w;
    u_xlat7.y = vs_TEXCOORD4.w;
    u_xlat7.z = vs_TEXCOORD5.w;
    u_xlat9.xyz = (-u_xlat7.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat7.xyz = (-u_xlat7.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat8 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat8);
    u_xlat16_28 = (-u_xlat16_0) + 1.0;
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_5 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_30 = u_xlat2.y * u_xlat2.y;
    u_xlat16_30 = u_xlat2.x * u_xlat2.x + (-u_xlat16_30);
    u_xlat16_5.xyz = unity_SHC.xyz * vec3(u_xlat16_30) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_30 = dot(u_xlat7.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat9.xyz * vec3(u_xlat34) + u_xlat7.xyz;
    u_xlat16_31 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_4.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat9.x = dot(u_xlat7.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat16_18 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_27 = u_xlat16_18 * u_xlat16_18;
    u_xlat2.x = u_xlat0 * u_xlat16_27 + (-u_xlat0);
    u_xlat0 = u_xlat2.x * u_xlat0 + 1.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = max(u_xlat0, 9.99999997e-07);
    u_xlat0 = u_xlat16_27 / u_xlat0;
    u_xlat0 = u_xlat0 * 0.318309873;
    u_xlat0 = min(u_xlat0, 64.0);
    u_xlat16_18 = (-u_xlat16_18) * u_xlat16_18 + 1.0;
    u_xlat16_18 = u_xlat16_18 + u_xlat16_18;
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat16_28 = u_xlat9.x * u_xlat9.x;
    u_xlat16_28 = u_xlat9.x * u_xlat16_28;
    u_xlat16_28 = u_xlat9.x * u_xlat16_28;
    u_xlat16_28 = u_xlat9.x * u_xlat16_28;
    u_xlat16_9 = u_xlat16_28 * 0.959999979;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_18 + 0.0399999991;
    u_xlat18 = u_xlat16_9 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat16_9 + 2.0;
    u_xlat0 = u_xlat18 / u_xlat0;
    u_xlat16_3.xyz = vec3(u_xlat0) * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _LightColor0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_30) + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _InvertBlend;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _StoneDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7 = sqrt(u_xlat7);
    u_xlat2.x = u_xlat7 + u_xlat2.x;
    u_xlat16_4.x = u_xlat2.x * 0.330000013;
    u_xlat2.xy = u_xlat16_4.xx * in_TEXCOORD0.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _StoneDiffuse_ST.xy + _StoneDiffuse_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat16_4.x = in_COLOR0.w * -2.0 + 1.0;
    vs_COLOR0.w = _InvertBlend * u_xlat16_4.x + in_COLOR0.w;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _DiffuseBlendIntensity;
uniform 	mediump float _DiffuseBlendMethod;
uniform 	mediump float _NormalBlendIntensity;
uniform 	mediump float _NormalBlendMethod;
uniform 	float _StoneNormalScale;
uniform 	mediump float _DefaultSmoothness_Grass;
uniform 	mediump float _DefaultSmoothness_Stone;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _StoneDiffuse;
uniform lowp sampler2D _StoneNormal;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_9;
bool u_xlatb9;
float u_xlat18;
mediump float u_xlat16_18;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
float u_xlat34;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w>=0.00100000005);
#else
    u_xlatb0 = vs_COLOR0.w>=0.00100000005;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.999000013>=vs_COLOR0.w);
#else
    u_xlatb9 = 0.999000013>=vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat10_0.xzw = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_0.xzw;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb9){
        u_xlat10_0.xyz = texture(_StoneDiffuse, vs_TEXCOORD0.zw).xyz;
        u_xlat10_2.xyz = texture(_StoneNormal, vs_TEXCOORD0.zw).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(_StoneNormalScale);
        u_xlat16_4.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    } else {
        u_xlat16_4.x = float(0.0);
        u_xlat16_4.y = float(0.0);
        u_xlat16_4.z = float(0.0);
        u_xlat16_3.x = float(0.0);
        u_xlat16_3.y = float(0.0);
        u_xlat16_3.z = float(1.0);
    //ENDIF
    }
    u_xlat16_5.xy = vs_COLOR0.ww * vec2(_DiffuseBlendIntensity, _NormalBlendIntensity);
    u_xlat16_6.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = vec3(vec3(_DiffuseBlendMethod, _DiffuseBlendMethod, _DiffuseBlendMethod)) * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz + (-u_xlat16_4.xyz);
    u_xlat16_1.xyz = u_xlat16_5.xxx * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xy = u_xlat16_3.xy * vec2(vec2(_NormalBlendMethod, _NormalBlendMethod));
    u_xlat16_4.z = 1.0;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_5.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_28 = (-_DefaultSmoothness_Stone) + _DefaultSmoothness_Grass;
    u_xlat16_28 = vs_COLOR0.w * u_xlat16_28 + _DefaultSmoothness_Stone;
    u_xlat16_0 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_0 = min(u_xlat16_0, 0.999000013);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
    u_xlat7.x = vs_TEXCOORD3.w;
    u_xlat7.y = vs_TEXCOORD4.w;
    u_xlat7.z = vs_TEXCOORD5.w;
    u_xlat9.xyz = (-u_xlat7.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat7.xyz = (-u_xlat7.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat8 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat8);
    u_xlat16_28 = (-u_xlat16_0) + 1.0;
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_5 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_30 = u_xlat2.y * u_xlat2.y;
    u_xlat16_30 = u_xlat2.x * u_xlat2.x + (-u_xlat16_30);
    u_xlat16_5.xyz = unity_SHC.xyz * vec3(u_xlat16_30) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_30 = dot(u_xlat7.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat9.xyz * vec3(u_xlat34) + u_xlat7.xyz;
    u_xlat16_31 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_4.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat9.x = dot(u_xlat7.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat16_18 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_27 = u_xlat16_18 * u_xlat16_18;
    u_xlat2.x = u_xlat0 * u_xlat16_27 + (-u_xlat0);
    u_xlat0 = u_xlat2.x * u_xlat0 + 1.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = max(u_xlat0, 9.99999997e-07);
    u_xlat0 = u_xlat16_27 / u_xlat0;
    u_xlat0 = u_xlat0 * 0.318309873;
    u_xlat0 = min(u_xlat0, 64.0);
    u_xlat16_18 = (-u_xlat16_18) * u_xlat16_18 + 1.0;
    u_xlat16_18 = u_xlat16_18 + u_xlat16_18;
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat16_28 = u_xlat9.x * u_xlat9.x;
    u_xlat16_28 = u_xlat9.x * u_xlat16_28;
    u_xlat16_28 = u_xlat9.x * u_xlat16_28;
    u_xlat16_28 = u_xlat9.x * u_xlat16_28;
    u_xlat16_9 = u_xlat16_28 * 0.959999979;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_18 + 0.0399999991;
    u_xlat18 = u_xlat16_9 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat16_9 + 2.0;
    u_xlat0 = u_xlat18 / u_xlat0;
    u_xlat16_3.xyz = vec3(u_xlat0) * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _LightColor0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_30) + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _InvertBlend;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _StoneDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat12;
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
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat12 = u_xlat12 + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat12 = u_xlat12 + u_xlat2.x;
    u_xlat16_3.x = u_xlat12 * 0.330000013;
    u_xlat2.xy = u_xlat16_3.xx * in_TEXCOORD0.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _StoneDiffuse_ST.xy + _StoneDiffuse_ST.zw;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat16_3.x = in_COLOR0.w * -2.0 + 1.0;
    vs_COLOR0.w = _InvertBlend * u_xlat16_3.x + in_COLOR0.w;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    vs_TEXCOORD3.y = u_xlat16_3.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat0.y;
    vs_TEXCOORD5.w = u_xlat0.z;
    vs_TEXCOORD4.y = u_xlat16_3.y;
    vs_TEXCOORD5.y = u_xlat16_3.z;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _DiffuseBlendIntensity;
uniform 	mediump float _DiffuseBlendMethod;
uniform 	mediump float _NormalBlendIntensity;
uniform 	mediump float _NormalBlendMethod;
uniform 	float _StoneNormalScale;
uniform 	mediump float _DefaultSmoothness_Grass;
uniform 	mediump float _DefaultSmoothness_Stone;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _StoneDiffuse;
uniform lowp sampler2D _StoneNormal;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_9;
bool u_xlatb9;
float u_xlat18;
mediump float u_xlat16_18;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
float u_xlat34;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w>=0.00100000005);
#else
    u_xlatb0 = vs_COLOR0.w>=0.00100000005;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.999000013>=vs_COLOR0.w);
#else
    u_xlatb9 = 0.999000013>=vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat10_0.xzw = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_0.xzw;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb9){
        u_xlat10_0.xyz = texture(_StoneDiffuse, vs_TEXCOORD0.zw).xyz;
        u_xlat10_2.xyz = texture(_StoneNormal, vs_TEXCOORD0.zw).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(_StoneNormalScale);
        u_xlat16_4.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    } else {
        u_xlat16_4.x = float(0.0);
        u_xlat16_4.y = float(0.0);
        u_xlat16_4.z = float(0.0);
        u_xlat16_3.x = float(0.0);
        u_xlat16_3.y = float(0.0);
        u_xlat16_3.z = float(1.0);
    //ENDIF
    }
    u_xlat16_5.xy = vs_COLOR0.ww * vec2(_DiffuseBlendIntensity, _NormalBlendIntensity);
    u_xlat16_6.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = vec3(vec3(_DiffuseBlendMethod, _DiffuseBlendMethod, _DiffuseBlendMethod)) * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz + (-u_xlat16_4.xyz);
    u_xlat16_1.xyz = u_xlat16_5.xxx * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xy = u_xlat16_3.xy * vec2(vec2(_NormalBlendMethod, _NormalBlendMethod));
    u_xlat16_4.z = 1.0;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_5.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_28 = (-_DefaultSmoothness_Stone) + _DefaultSmoothness_Grass;
    u_xlat16_28 = vs_COLOR0.w * u_xlat16_28 + _DefaultSmoothness_Stone;
    u_xlat16_0 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_0 = min(u_xlat16_0, 0.999000013);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
    u_xlat7.x = vs_TEXCOORD3.w;
    u_xlat7.y = vs_TEXCOORD4.w;
    u_xlat7.z = vs_TEXCOORD5.w;
    u_xlat9.xyz = (-u_xlat7.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat7.xyz = (-u_xlat7.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat8 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat8);
    u_xlat16_28 = (-u_xlat16_0) + 1.0;
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_5 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_30 = u_xlat2.y * u_xlat2.y;
    u_xlat16_30 = u_xlat2.x * u_xlat2.x + (-u_xlat16_30);
    u_xlat16_5.xyz = unity_SHC.xyz * vec3(u_xlat16_30) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_30 = dot(u_xlat7.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat9.xyz * vec3(u_xlat34) + u_xlat7.xyz;
    u_xlat16_31 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_4.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat9.x = dot(u_xlat7.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat16_18 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_27 = u_xlat16_18 * u_xlat16_18;
    u_xlat2.x = u_xlat0 * u_xlat16_27 + (-u_xlat0);
    u_xlat0 = u_xlat2.x * u_xlat0 + 1.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = max(u_xlat0, 9.99999997e-07);
    u_xlat0 = u_xlat16_27 / u_xlat0;
    u_xlat0 = u_xlat0 * 0.318309873;
    u_xlat0 = min(u_xlat0, 64.0);
    u_xlat16_18 = (-u_xlat16_18) * u_xlat16_18 + 1.0;
    u_xlat16_18 = u_xlat16_18 + u_xlat16_18;
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat16_28 = u_xlat9.x * u_xlat9.x;
    u_xlat16_28 = u_xlat9.x * u_xlat16_28;
    u_xlat16_28 = u_xlat9.x * u_xlat16_28;
    u_xlat16_28 = u_xlat9.x * u_xlat16_28;
    u_xlat16_9 = u_xlat16_28 * 0.959999979;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_18 + 0.0399999991;
    u_xlat18 = u_xlat16_9 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat16_9 + 2.0;
    u_xlat0 = u_xlat18 / u_xlat0;
    u_xlat16_3.xyz = vec3(u_xlat0) * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _LightColor0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_30) + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _InvertBlend;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _StoneDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat7;
float u_xlat16;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat2.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat2.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat2.xy = sqrt(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat3.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat3.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat3.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat7 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7 = sqrt(u_xlat7);
    u_xlat2.x = u_xlat7 + u_xlat2.x;
    u_xlat16_4.x = u_xlat2.x * 0.330000013;
    u_xlat2.xy = u_xlat16_4.xx * in_TEXCOORD0.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _StoneDiffuse_ST.xy + _StoneDiffuse_ST.zw;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat16_4.x = in_COLOR0.w * -2.0 + 1.0;
    vs_COLOR0.w = _InvertBlend * u_xlat16_4.x + in_COLOR0.w;
    vs_COLOR0.xyz = in_COLOR0.xyz;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat16_4.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = vec3(u_xlat0) * u_xlat16_4.xyz;
    vs_TEXCOORD3.y = u_xlat16_4.x;
    vs_TEXCOORD3.x = u_xlat2.z;
    vs_TEXCOORD3.z = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat5.x;
    vs_TEXCOORD4.x = u_xlat2.x;
    vs_TEXCOORD5.x = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat1.z;
    vs_TEXCOORD5.z = u_xlat1.x;
    vs_TEXCOORD4.w = u_xlat5.y;
    vs_TEXCOORD5.w = u_xlat5.z;
    vs_TEXCOORD4.y = u_xlat16_4.y;
    vs_TEXCOORD5.y = u_xlat16_4.z;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _DiffuseBlendIntensity;
uniform 	mediump float _DiffuseBlendMethod;
uniform 	mediump float _NormalBlendIntensity;
uniform 	mediump float _NormalBlendMethod;
uniform 	float _StoneNormalScale;
uniform 	mediump float _DefaultSmoothness_Grass;
uniform 	mediump float _DefaultSmoothness_Stone;
uniform lowp sampler2D _GrassDiffuse;
uniform lowp sampler2D _StoneDiffuse;
uniform lowp sampler2D _StoneNormal;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_9;
bool u_xlatb9;
float u_xlat18;
mediump float u_xlat16_18;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
float u_xlat34;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_COLOR0.w>=0.00100000005);
#else
    u_xlatb0 = vs_COLOR0.w>=0.00100000005;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.999000013>=vs_COLOR0.w);
#else
    u_xlatb9 = 0.999000013>=vs_COLOR0.w;
#endif
    if(u_xlatb0){
        u_xlat10_0.xzw = texture(_GrassDiffuse, vs_TEXCOORD0.xy).xyz;
        u_xlat16_1.xyz = u_xlat10_0.xzw;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
    //ENDIF
    }
    if(u_xlatb9){
        u_xlat10_0.xyz = texture(_StoneDiffuse, vs_TEXCOORD0.zw).xyz;
        u_xlat10_2.xyz = texture(_StoneNormal, vs_TEXCOORD0.zw).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(_StoneNormalScale);
        u_xlat16_4.xyz = u_xlat10_0.xyz * _MainColor.xyz;
    } else {
        u_xlat16_4.x = float(0.0);
        u_xlat16_4.y = float(0.0);
        u_xlat16_4.z = float(0.0);
        u_xlat16_3.x = float(0.0);
        u_xlat16_3.y = float(0.0);
        u_xlat16_3.z = float(1.0);
    //ENDIF
    }
    u_xlat16_5.xy = vs_COLOR0.ww * vec2(_DiffuseBlendIntensity, _NormalBlendIntensity);
    u_xlat16_6.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_6.xyz = vec3(vec3(_DiffuseBlendMethod, _DiffuseBlendMethod, _DiffuseBlendMethod)) * u_xlat16_6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz + (-u_xlat16_4.xyz);
    u_xlat16_1.xyz = u_xlat16_5.xxx * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xy = u_xlat16_3.xy * vec2(vec2(_NormalBlendMethod, _NormalBlendMethod));
    u_xlat16_4.z = 1.0;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_5.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_28 = (-_DefaultSmoothness_Stone) + _DefaultSmoothness_Grass;
    u_xlat16_28 = vs_COLOR0.w * u_xlat16_28 + _DefaultSmoothness_Stone;
    u_xlat16_0 = max(u_xlat16_28, 0.00100000005);
    u_xlat16_0 = min(u_xlat16_0, 0.999000013);
    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
    u_xlat7.x = vs_TEXCOORD3.w;
    u_xlat7.y = vs_TEXCOORD4.w;
    u_xlat7.z = vs_TEXCOORD5.w;
    u_xlat9.xyz = (-u_xlat7.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat34 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(0.959999979, 0.959999979, 0.959999979);
    u_xlat7.xyz = (-u_xlat7.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat8 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat8);
    u_xlat16_28 = (-u_xlat16_0) + 1.0;
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_5 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_30 = u_xlat2.y * u_xlat2.y;
    u_xlat16_30 = u_xlat2.x * u_xlat2.x + (-u_xlat16_30);
    u_xlat16_5.xyz = unity_SHC.xyz * vec3(u_xlat16_30) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_30 = dot(u_xlat7.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat9.xyz * vec3(u_xlat34) + u_xlat7.xyz;
    u_xlat16_31 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_4.xyz;
    u_xlat0 = dot(u_xlat2.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat9.x = dot(u_xlat7.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat16_18 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_27 = u_xlat16_18 * u_xlat16_18;
    u_xlat2.x = u_xlat0 * u_xlat16_27 + (-u_xlat0);
    u_xlat0 = u_xlat2.x * u_xlat0 + 1.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = max(u_xlat0, 9.99999997e-07);
    u_xlat0 = u_xlat16_27 / u_xlat0;
    u_xlat0 = u_xlat0 * 0.318309873;
    u_xlat0 = min(u_xlat0, 64.0);
    u_xlat16_18 = (-u_xlat16_18) * u_xlat16_18 + 1.0;
    u_xlat16_18 = u_xlat16_18 + u_xlat16_18;
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat16_28 = u_xlat9.x * u_xlat9.x;
    u_xlat16_28 = u_xlat9.x * u_xlat16_28;
    u_xlat16_28 = u_xlat9.x * u_xlat16_28;
    u_xlat16_28 = u_xlat9.x * u_xlat16_28;
    u_xlat16_9 = u_xlat16_28 * 0.959999979;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_18 + 0.0399999991;
    u_xlat18 = u_xlat16_9 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat16_9 + 2.0;
    u_xlat0 = u_xlat18 / u_xlat0;
    u_xlat16_3.xyz = vec3(u_xlat0) * vec3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _LightColor0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_30) + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
}
}
 Pass {
  Name "DEPTHONLY"
  Tags { "LIGHTMODE" = "DepthOnly" "QUEUE" = "Geometry-100" "RenderType" = "Opaque" }
  GpuProgramID 85096
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.0, 0.0, 0.0);
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
out highp vec2 vs_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = vec2(0.0, 0.0);
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
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.0, 0.0, 0.0);
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
  Name "HYBRIDDEFERRED"
  Tags { "DebugView" = "On" "LIGHTMODE" = "HYBRIDDEFERRED" "QUEUE" = "Geometry-100" "RenderType" = "Opaque" }
  GpuProgramID 132832
Program "vp" {
SubProgram "gles3 " {
Keywords { "MHY_SHADER_HIGH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _InvertBlend;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _StoneDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3 = sqrt(u_xlat3);
    u_xlat0.x = u_xlat3 + u_xlat0.x;
    u_xlat16_2.x = u_xlat0.x * 0.330000013;
    u_xlat0.xy = u_xlat16_2.xx * in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = u_xlat0.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _StoneDiffuse_ST.xy + _StoneDiffuse_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_2.xyz = vec3(u_xlat9) * u_xlat16_2.xyz;
    vs_TEXCOORD1.y = u_xlat16_2.x;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.y = u_xlat16_2.y;
    vs_TEXCOORD3.y = u_xlat16_2.z;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.w = 0.0;
    u_xlat16_2.x = (-_InvertBlend) + 1.0;
    u_xlat16_5 = in_COLOR0.w * -2.0 + 1.0;
    u_xlat16_0.w = u_xlat16_2.x * u_xlat16_5 + in_COLOR0.w;
    u_xlat16_0.xyz = in_COLOR0.xyz;
    vs_COLOR0 = u_xlat16_0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _DefaultSmoothness_LOD2;
uniform lowp sampler2D _StoneNormal;
uniform lowp sampler2D _StoneDiffuse;
uniform lowp sampler2D _GrassDiffuse;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat10_0.xyz = texture(_StoneNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + vec3(0.0, 0.0, 1.0);
    u_xlat0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
    u_xlat16_1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.zw).xyz;
    u_xlat10_2.xyz = texture(_StoneDiffuse, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = (-u_xlat10_2.xyz) * _MainColor.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : 0.0399999991;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    SV_Target2.w = _DefaultSmoothness_LOD2;
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

uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _InvertBlend;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _StoneDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_7;
float u_xlat8;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat1.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat1.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat1.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat1.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat4.y = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.xy = sqrt(u_xlat4.xy);
    u_xlat4.x = u_xlat4.y + u_xlat4.x;
    u_xlat1.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat1.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat1.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = sqrt(u_xlat8);
    u_xlat4.x = u_xlat8 + u_xlat4.x;
    u_xlat16_3.x = u_xlat4.x * 0.330000013;
    u_xlat4.xy = u_xlat16_3.xx * in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = u_xlat4.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _StoneDiffuse_ST.xy + _StoneDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.zxy * u_xlat1.yzx + (-u_xlat16_3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_3.xyz = vec3(u_xlat0) * u_xlat16_3.xyz;
    vs_TEXCOORD1.y = u_xlat16_3.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat4.y;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat4.z;
    vs_TEXCOORD3.z = u_xlat4.x;
    vs_TEXCOORD2.y = u_xlat16_3.y;
    vs_TEXCOORD3.y = u_xlat16_3.z;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.w = 0.0;
    u_xlat16_3.x = (-_InvertBlend) + 1.0;
    u_xlat16_7 = in_COLOR0.w * -2.0 + 1.0;
    u_xlat16_0.w = u_xlat16_3.x * u_xlat16_7 + in_COLOR0.w;
    u_xlat16_0.xyz = in_COLOR0.xyz;
    vs_COLOR0 = u_xlat16_0;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _DefaultSmoothness_LOD2;
uniform lowp sampler2D _StoneNormal;
uniform lowp sampler2D _StoneDiffuse;
uniform lowp sampler2D _GrassDiffuse;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat10_0.xyz = texture(_StoneNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + vec3(0.0, 0.0, 1.0);
    u_xlat0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
    u_xlat16_1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.zw).xyz;
    u_xlat10_2.xyz = texture(_StoneDiffuse, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = (-u_xlat10_2.xyz) * _MainColor.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : 0.0399999991;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    SV_Target2.w = _DefaultSmoothness_LOD2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_MIDDLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _InvertBlend;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _StoneDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.xy = sqrt(u_xlat0.xy);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat3 = sqrt(u_xlat3);
    u_xlat0.x = u_xlat3 + u_xlat0.x;
    u_xlat16_2.x = u_xlat0.x * 0.330000013;
    u_xlat0.xy = u_xlat16_2.xx * in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = u_xlat0.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _StoneDiffuse_ST.xy + _StoneDiffuse_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_2.xyz = vec3(u_xlat9) * u_xlat16_2.xyz;
    vs_TEXCOORD1.y = u_xlat16_2.x;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.y = u_xlat16_2.y;
    vs_TEXCOORD3.y = u_xlat16_2.z;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.w = 0.0;
    u_xlat16_2.x = (-_InvertBlend) + 1.0;
    u_xlat16_5 = in_COLOR0.w * -2.0 + 1.0;
    u_xlat16_0.w = u_xlat16_2.x * u_xlat16_5 + in_COLOR0.w;
    u_xlat16_0.xyz = in_COLOR0.xyz;
    vs_COLOR0 = u_xlat16_0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _DefaultSmoothness_LOD2;
uniform lowp sampler2D _StoneNormal;
uniform lowp sampler2D _StoneDiffuse;
uniform lowp sampler2D _GrassDiffuse;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat10_0.xyz = texture(_StoneNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + vec3(0.0, 0.0, 1.0);
    u_xlat0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
    u_xlat16_1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.zw).xyz;
    u_xlat10_2.xyz = texture(_StoneDiffuse, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = (-u_xlat10_2.xyz) * _MainColor.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : 0.0399999991;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    SV_Target2.w = _DefaultSmoothness_LOD2;
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

uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _InvertBlend;
uniform 	vec4 _GrassDiffuse_ST;
uniform 	vec4 _StoneDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_7;
float u_xlat8;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].x;
    u_xlat1.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].x;
    u_xlat1.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].x;
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y;
    u_xlat1.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].y;
    u_xlat1.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y;
    u_xlat4.y = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.xy = sqrt(u_xlat4.xy);
    u_xlat4.x = u_xlat4.y + u_xlat4.x;
    u_xlat1.x = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].z;
    u_xlat1.y = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].z;
    u_xlat1.z = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].z;
    u_xlat8 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8 = sqrt(u_xlat8);
    u_xlat4.x = u_xlat8 + u_xlat4.x;
    u_xlat16_3.x = u_xlat4.x * 0.330000013;
    u_xlat4.xy = u_xlat16_3.xx * in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = u_xlat4.xy * _GrassDiffuse_ST.xy + _GrassDiffuse_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _StoneDiffuse_ST.xy + _StoneDiffuse_ST.zw;
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.zxy * u_xlat1.yzx + (-u_xlat16_3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_3.xyz = vec3(u_xlat0) * u_xlat16_3.xyz;
    vs_TEXCOORD1.y = u_xlat16_3.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat4.y;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat4.z;
    vs_TEXCOORD3.z = u_xlat4.x;
    vs_TEXCOORD2.y = u_xlat16_3.y;
    vs_TEXCOORD3.y = u_xlat16_3.z;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.w = 0.0;
    u_xlat16_3.x = (-_InvertBlend) + 1.0;
    u_xlat16_7 = in_COLOR0.w * -2.0 + 1.0;
    u_xlat16_0.w = u_xlat16_3.x * u_xlat16_7 + in_COLOR0.w;
    u_xlat16_0.xyz = in_COLOR0.xyz;
    vs_COLOR0 = u_xlat16_0;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _DefaultSmoothness_LOD2;
uniform lowp sampler2D _StoneNormal;
uniform lowp sampler2D _StoneDiffuse;
uniform lowp sampler2D _GrassDiffuse;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
void main()
{
    u_xlat10_0.xyz = texture(_StoneNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + vec3(0.0, 0.0, 1.0);
    u_xlat0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
    u_xlat16_1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat10_0.xyz = texture(_GrassDiffuse, vs_TEXCOORD0.zw).xyz;
    u_xlat10_2.xyz = texture(_StoneDiffuse, vs_TEXCOORD0.xy).xyz;
    u_xlat16_0.xyz = (-u_xlat10_2.xyz) * _MainColor.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat10_2.xyz * _MainColor.xyz;
    u_xlat0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : 0.0399999991;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    SV_Target2.w = _DefaultSmoothness_LOD2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MHY_SHADER_LOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _InvertBlend;
uniform 	vec4 _StoneDiffuse_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _StoneDiffuse_ST.xy + _StoneDiffuse_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_2.xyz = vec3(u_xlat9) * u_xlat16_2.xyz;
    vs_TEXCOORD1.y = u_xlat16_2.x;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat0.z;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD2.y = u_xlat16_2.y;
    vs_TEXCOORD3.y = u_xlat16_2.z;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.w = 0.0;
    u_xlat16_2.x = (-_InvertBlend) + 1.0;
    u_xlat16_5 = in_COLOR0.w * -2.0 + 1.0;
    u_xlat16_0.w = u_xlat16_2.x * u_xlat16_5 + in_COLOR0.w;
    u_xlat16_0.xyz = in_COLOR0.xyz;
    vs_COLOR0 = u_xlat16_0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _DefaultSmoothness_LOD2;
uniform 	mediump vec4 _StoneColor;
uniform 	mediump vec4 _GrassColor;
uniform lowp sampler2D _StoneNormal;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat10_0.xyz = texture(_StoneNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + vec3(0.0, 0.0, 1.0);
    u_xlat0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
    u_xlat16_1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat16_1.xyz = _MainColor.xyz * _StoneColor.xyz;
    u_xlat16_0.xyz = (-_StoneColor.xyz) * _MainColor.xyz + _GrassColor.xyz;
    u_xlat0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : 0.0399999991;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    SV_Target2.w = _DefaultSmoothness_LOD2;
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

uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _InvertBlend;
uniform 	vec4 _StoneDiffuse_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_7;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _StoneDiffuse_ST.xy + _StoneDiffuse_ST.zw;
    vs_TEXCOORD0.zw = vec2(0.0, 0.0);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.zxy * u_xlat1.yzx + (-u_xlat16_3.xyz);
    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_3.xyz = vec3(u_xlat0) * u_xlat16_3.xyz;
    vs_TEXCOORD1.y = u_xlat16_3.x;
    vs_TEXCOORD1.x = u_xlat1.z;
    vs_TEXCOORD1.z = u_xlat4.y;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.x = u_xlat1.y;
    vs_TEXCOORD2.z = u_xlat4.z;
    vs_TEXCOORD3.z = u_xlat4.x;
    vs_TEXCOORD2.y = u_xlat16_3.y;
    vs_TEXCOORD3.y = u_xlat16_3.z;
    vs_TEXCOORD2.w = 0.0;
    vs_TEXCOORD3.w = 0.0;
    u_xlat16_3.x = (-_InvertBlend) + 1.0;
    u_xlat16_7 = in_COLOR0.w * -2.0 + 1.0;
    u_xlat16_0.w = u_xlat16_3.x * u_xlat16_7 + in_COLOR0.w;
    u_xlat16_0.xyz = in_COLOR0.xyz;
    vs_COLOR0 = u_xlat16_0;
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
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _DefaultSmoothness_LOD2;
uniform 	mediump vec4 _StoneColor;
uniform 	mediump vec4 _GrassColor;
uniform lowp sampler2D _StoneNormal;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat10_0.xyz = texture(_StoneNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + vec3(0.0, 0.0, 1.0);
    u_xlat0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
    u_xlat16_1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat16_1.xyz = _MainColor.xyz * _StoneColor.xyz;
    u_xlat16_0.xyz = (-_StoneColor.xyz) * _MainColor.xyz + _GrassColor.xyz;
    u_xlat0.xyz = vs_COLOR0.www * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : 0.0399999991;
    SV_Target2.xy = vec2(0.0399999991, 0.0399999991);
    SV_Target2.w = _DefaultSmoothness_LOD2;
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
}
}
 UsePass "miHoYo/Shadow/ShadowMapPass/LSPSMCULLNONE"
}
Fallback "Nature/Terrain/Diffuse"
}