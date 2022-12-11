//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Particles/Fresnel_AfterImage" {
Properties {
_MainColor ("MainColor", Color) = (1,1,1,1)
_OutterColor ("OutterColor", Color) = (0,1,0.08965516,1)
_InnerColor ("InnerColor", Color) = (1,0.3103448,0,1)
_ColorBrightness ("ColorBrightness", Float) = 1
_AlphaBrightness ("AlphaBrightness", Range(0, 1)) = 1
[MHYToggle] _NormalMapToggle ("NormalMapToggle", Float) = 0
_NormalMap ("NormalMap", 2D) = "bump" { }
_NormalIntensity ("NormalIntensity", Range(0, 20)) = 1
_Fresnal_Scale ("Fresnal_Scale", Float) = 1
_Fresnal_Power ("Fresnal_Power", Float) = 3
[Header(MiHoYoDepthFade)] [Toggle(_SOFTPARTICLES_ON)] _SOFTPARTICLES ("SOFTPARTICLES", Float) = 0
_DepthThresh ("DepthThresh", Range(0.001, 20)) = 1
_DepthFade ("DepthFade", Range(0.001, 20)) = 1
_DayColor ("DayColor", Color) = (1,1,1,1)
_MeshParticleColorArray ("MeshParticleColorArray", Vector) = (1,1,1,1)
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
[Header(Fog Mode)] [Toggle(EFFECTED_BY_FOG)] _EffectedByFog ("Effected by fog", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 63263
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
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD5.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _InnerColor;
uniform 	mediump vec4 _OutterColor;
uniform 	mediump float _NormalMapToggle;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NormalMap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb15 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb15){
        u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
        u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
        u_xlat1.xyz = u_xlat16_2.xyz;
    } else {
        u_xlat1.x = float(0.0);
        u_xlat1.y = float(0.0);
        u_xlat1.z = float(1.0);
    //ENDIF
    }
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD6.y;
    u_xlat4.y = vs_TEXCOORD8.y;
    u_xlat4.z = vs_TEXCOORD7.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD6.z;
    u_xlat4.y = vs_TEXCOORD8.z;
    u_xlat4.z = vs_TEXCOORD7.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat16_5.xyz = (-_InnerColor.xyz) + _OutterColor.xyz;
    u_xlat0.yzw = u_xlat0.xxx * u_xlat16_5.xyz + _InnerColor.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat0 = u_xlat0 * u_xlat1.wxyz;
    u_xlat5.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat2.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _InnerColor;
uniform 	mediump vec4 _OutterColor;
uniform 	mediump float _NormalMapToggle;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnel_AfterImageArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnel_AfterImage {
	miHoYoParticlesFresnel_AfterImageArray_Type miHoYoParticlesFresnel_AfterImageArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
vec3 u_xlat1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0 = vs_COLOR0 * miHoYoParticlesFresnel_AfterImageArray[u_xlati0]._MeshParticleColorArray;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb19 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb19){
        u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
        u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalIntensity);
        u_xlat2.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat2.x = float(0.0);
        u_xlat2.y = float(0.0);
        u_xlat2.z = float(1.0);
    //ENDIF
    }
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = vs_TEXCOORD6.z;
    u_xlat5.y = vs_TEXCOORD8.z;
    u_xlat5.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Power;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Scale;
    u_xlat16_7.xyz = (-_InnerColor.xyz) + _OutterColor.xyz;
    u_xlat7.xyz = u_xlat1.xxx * u_xlat16_7.xyz + _InnerColor.xyz;
    u_xlat0 = u_xlat0 * _MainColor;
    u_xlat0.xyz = u_xlat7.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD5.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _InnerColor;
uniform 	mediump vec4 _OutterColor;
uniform 	mediump float _NormalMapToggle;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NormalMap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb15 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb15){
        u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
        u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
        u_xlat1.xyz = u_xlat16_2.xyz;
    } else {
        u_xlat1.x = float(0.0);
        u_xlat1.y = float(0.0);
        u_xlat1.z = float(1.0);
    //ENDIF
    }
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD6.y;
    u_xlat4.y = vs_TEXCOORD8.y;
    u_xlat4.z = vs_TEXCOORD7.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD6.z;
    u_xlat4.y = vs_TEXCOORD8.z;
    u_xlat4.z = vs_TEXCOORD7.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat16_5.xyz = (-_InnerColor.xyz) + _OutterColor.xyz;
    u_xlat0.yzw = u_xlat0.xxx * u_xlat16_5.xyz + _InnerColor.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat0 = u_xlat0 * u_xlat1.wxyz;
    u_xlat5.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat2.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _InnerColor;
uniform 	mediump vec4 _OutterColor;
uniform 	mediump float _NormalMapToggle;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnel_AfterImageArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnel_AfterImage {
	miHoYoParticlesFresnel_AfterImageArray_Type miHoYoParticlesFresnel_AfterImageArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
vec3 u_xlat1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0 = vs_COLOR0 * miHoYoParticlesFresnel_AfterImageArray[u_xlati0]._MeshParticleColorArray;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb19 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb19){
        u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
        u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalIntensity);
        u_xlat2.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat2.x = float(0.0);
        u_xlat2.y = float(0.0);
        u_xlat2.z = float(1.0);
    //ENDIF
    }
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = vs_TEXCOORD6.z;
    u_xlat5.y = vs_TEXCOORD8.z;
    u_xlat5.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Power;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Scale;
    u_xlat16_7.xyz = (-_InnerColor.xyz) + _OutterColor.xyz;
    u_xlat7.xyz = u_xlat1.xxx * u_xlat16_7.xyz + _InnerColor.xyz;
    u_xlat0 = u_xlat0 * _MainColor;
    u_xlat0.xyz = u_xlat7.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD5.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _InnerColor;
uniform 	mediump vec4 _OutterColor;
uniform 	mediump float _NormalMapToggle;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NormalMap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb15 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb15){
        u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
        u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
        u_xlat1.xyz = u_xlat16_2.xyz;
    } else {
        u_xlat1.x = float(0.0);
        u_xlat1.y = float(0.0);
        u_xlat1.z = float(1.0);
    //ENDIF
    }
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD6.y;
    u_xlat4.y = vs_TEXCOORD8.y;
    u_xlat4.z = vs_TEXCOORD7.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD6.z;
    u_xlat4.y = vs_TEXCOORD8.z;
    u_xlat4.z = vs_TEXCOORD7.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat16_5.xyz = (-_InnerColor.xyz) + _OutterColor.xyz;
    u_xlat0.yzw = u_xlat0.xxx * u_xlat16_5.xyz + _InnerColor.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat0 = u_xlat0 * u_xlat1.wxyz;
    u_xlat5.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat2.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _InnerColor;
uniform 	mediump vec4 _OutterColor;
uniform 	mediump float _NormalMapToggle;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnel_AfterImageArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnel_AfterImage {
	miHoYoParticlesFresnel_AfterImageArray_Type miHoYoParticlesFresnel_AfterImageArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0 = vs_COLOR0 * miHoYoParticlesFresnel_AfterImageArray[u_xlati0]._MeshParticleColorArray;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb19 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb19){
        u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
        u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalIntensity);
        u_xlat2.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat2.x = float(0.0);
        u_xlat2.y = float(0.0);
        u_xlat2.z = float(1.0);
    //ENDIF
    }
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = vs_TEXCOORD6.z;
    u_xlat5.y = vs_TEXCOORD8.z;
    u_xlat5.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Power;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Scale;
    u_xlat16_7.xyz = (-_InnerColor.xyz) + _OutterColor.xyz;
    u_xlat7.xyz = u_xlat1.xxx * u_xlat16_7.xyz + _InnerColor.xyz;
    u_xlat0 = u_xlat0 * _MainColor;
    u_xlat0.xyz = u_xlat7.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD5.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _InnerColor;
uniform 	mediump vec4 _OutterColor;
uniform 	mediump float _NormalMapToggle;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NormalMap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb15 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb15){
        u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
        u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
        u_xlat1.xyz = u_xlat16_2.xyz;
    } else {
        u_xlat1.x = float(0.0);
        u_xlat1.y = float(0.0);
        u_xlat1.z = float(1.0);
    //ENDIF
    }
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD6.y;
    u_xlat4.y = vs_TEXCOORD8.y;
    u_xlat4.z = vs_TEXCOORD7.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD6.z;
    u_xlat4.y = vs_TEXCOORD8.z;
    u_xlat4.z = vs_TEXCOORD7.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat16_5.xyz = (-_InnerColor.xyz) + _OutterColor.xyz;
    u_xlat0.yzw = u_xlat0.xxx * u_xlat16_5.xyz + _InnerColor.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat0 = u_xlat0 * u_xlat1.wxyz;
    u_xlat5.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat2.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _InnerColor;
uniform 	mediump vec4 _OutterColor;
uniform 	mediump float _NormalMapToggle;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnel_AfterImageArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnel_AfterImage {
	miHoYoParticlesFresnel_AfterImageArray_Type miHoYoParticlesFresnel_AfterImageArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0 = vs_COLOR0 * miHoYoParticlesFresnel_AfterImageArray[u_xlati0]._MeshParticleColorArray;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb19 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb19){
        u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
        u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalIntensity);
        u_xlat2.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat2.x = float(0.0);
        u_xlat2.y = float(0.0);
        u_xlat2.z = float(1.0);
    //ENDIF
    }
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = vs_TEXCOORD6.z;
    u_xlat5.y = vs_TEXCOORD8.z;
    u_xlat5.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Power;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Scale;
    u_xlat16_7.xyz = (-_InnerColor.xyz) + _OutterColor.xyz;
    u_xlat7.xyz = u_xlat1.xxx * u_xlat16_7.xyz + _InnerColor.xyz;
    u_xlat0 = u_xlat0 * _MainColor;
    u_xlat0.xyz = u_xlat7.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD5.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _InnerColor;
uniform 	mediump vec4 _OutterColor;
uniform 	mediump float _NormalMapToggle;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NormalMap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb15 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb15){
        u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
        u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
        u_xlat1.xyz = u_xlat16_2.xyz;
    } else {
        u_xlat1.x = float(0.0);
        u_xlat1.y = float(0.0);
        u_xlat1.z = float(1.0);
    //ENDIF
    }
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD6.y;
    u_xlat4.y = vs_TEXCOORD8.y;
    u_xlat4.z = vs_TEXCOORD7.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD6.z;
    u_xlat4.y = vs_TEXCOORD8.z;
    u_xlat4.z = vs_TEXCOORD7.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat16_5.xyz = (-_InnerColor.xyz) + _OutterColor.xyz;
    u_xlat0.yzw = u_xlat0.xxx * u_xlat16_5.xyz + _InnerColor.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat0 = u_xlat0 * u_xlat1.wxyz;
    u_xlat5.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat2.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _InnerColor;
uniform 	mediump vec4 _OutterColor;
uniform 	mediump float _NormalMapToggle;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnel_AfterImageArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnel_AfterImage {
	miHoYoParticlesFresnel_AfterImageArray_Type miHoYoParticlesFresnel_AfterImageArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
vec3 u_xlat1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0 = vs_COLOR0 * miHoYoParticlesFresnel_AfterImageArray[u_xlati0]._MeshParticleColorArray;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb19 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb19){
        u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
        u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalIntensity);
        u_xlat2.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat2.x = float(0.0);
        u_xlat2.y = float(0.0);
        u_xlat2.z = float(1.0);
    //ENDIF
    }
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = vs_TEXCOORD6.z;
    u_xlat5.y = vs_TEXCOORD8.z;
    u_xlat5.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Power;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Scale;
    u_xlat16_7.xyz = (-_InnerColor.xyz) + _OutterColor.xyz;
    u_xlat7.xyz = u_xlat1.xxx * u_xlat16_7.xyz + _InnerColor.xyz;
    u_xlat0 = u_xlat0 * _MainColor;
    u_xlat0.xyz = u_xlat7.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD5.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _InnerColor;
uniform 	mediump vec4 _OutterColor;
uniform 	mediump float _NormalMapToggle;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NormalMap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb15 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb15){
        u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
        u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
        u_xlat1.xyz = u_xlat16_2.xyz;
    } else {
        u_xlat1.x = float(0.0);
        u_xlat1.y = float(0.0);
        u_xlat1.z = float(1.0);
    //ENDIF
    }
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD6.y;
    u_xlat4.y = vs_TEXCOORD8.y;
    u_xlat4.z = vs_TEXCOORD7.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD6.z;
    u_xlat4.y = vs_TEXCOORD8.z;
    u_xlat4.z = vs_TEXCOORD7.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat16_5.xyz = (-_InnerColor.xyz) + _OutterColor.xyz;
    u_xlat0.yzw = u_xlat0.xxx * u_xlat16_5.xyz + _InnerColor.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat0 = u_xlat0 * u_xlat1.wxyz;
    u_xlat5.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat2.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _InnerColor;
uniform 	mediump vec4 _OutterColor;
uniform 	mediump float _NormalMapToggle;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnel_AfterImageArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnel_AfterImage {
	miHoYoParticlesFresnel_AfterImageArray_Type miHoYoParticlesFresnel_AfterImageArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
vec3 u_xlat1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0 = vs_COLOR0 * miHoYoParticlesFresnel_AfterImageArray[u_xlati0]._MeshParticleColorArray;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb19 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb19){
        u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
        u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalIntensity);
        u_xlat2.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat2.x = float(0.0);
        u_xlat2.y = float(0.0);
        u_xlat2.z = float(1.0);
    //ENDIF
    }
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = vs_TEXCOORD6.z;
    u_xlat5.y = vs_TEXCOORD8.z;
    u_xlat5.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Power;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Scale;
    u_xlat16_7.xyz = (-_InnerColor.xyz) + _OutterColor.xyz;
    u_xlat7.xyz = u_xlat1.xxx * u_xlat16_7.xyz + _InnerColor.xyz;
    u_xlat0 = u_xlat0 * _MainColor;
    u_xlat0.xyz = u_xlat7.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD5.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _InnerColor;
uniform 	mediump vec4 _OutterColor;
uniform 	mediump float _NormalMapToggle;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NormalMap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb15 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb15){
        u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
        u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
        u_xlat1.xyz = u_xlat16_2.xyz;
    } else {
        u_xlat1.x = float(0.0);
        u_xlat1.y = float(0.0);
        u_xlat1.z = float(1.0);
    //ENDIF
    }
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD6.y;
    u_xlat4.y = vs_TEXCOORD8.y;
    u_xlat4.z = vs_TEXCOORD7.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD6.z;
    u_xlat4.y = vs_TEXCOORD8.z;
    u_xlat4.z = vs_TEXCOORD7.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat16_5.xyz = (-_InnerColor.xyz) + _OutterColor.xyz;
    u_xlat0.yzw = u_xlat0.xxx * u_xlat16_5.xyz + _InnerColor.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat0 = u_xlat0 * u_xlat1.wxyz;
    u_xlat5.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat2.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _InnerColor;
uniform 	mediump vec4 _OutterColor;
uniform 	mediump float _NormalMapToggle;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnel_AfterImageArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnel_AfterImage {
	miHoYoParticlesFresnel_AfterImageArray_Type miHoYoParticlesFresnel_AfterImageArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0 = vs_COLOR0 * miHoYoParticlesFresnel_AfterImageArray[u_xlati0]._MeshParticleColorArray;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb19 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb19){
        u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
        u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalIntensity);
        u_xlat2.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat2.x = float(0.0);
        u_xlat2.y = float(0.0);
        u_xlat2.z = float(1.0);
    //ENDIF
    }
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = vs_TEXCOORD6.z;
    u_xlat5.y = vs_TEXCOORD8.z;
    u_xlat5.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Power;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Scale;
    u_xlat16_7.xyz = (-_InnerColor.xyz) + _OutterColor.xyz;
    u_xlat7.xyz = u_xlat1.xxx * u_xlat16_7.xyz + _InnerColor.xyz;
    u_xlat0 = u_xlat0 * _MainColor;
    u_xlat0.xyz = u_xlat7.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD5.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _InnerColor;
uniform 	mediump vec4 _OutterColor;
uniform 	mediump float _NormalMapToggle;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _NormalMap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb15 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb15){
        u_xlat1.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
        u_xlat10_1.xyz = texture(_NormalMap, u_xlat1.xy).xyz;
        u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_2.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
        u_xlat1.xyz = u_xlat16_2.xyz;
    } else {
        u_xlat1.x = float(0.0);
        u_xlat1.y = float(0.0);
        u_xlat1.z = float(1.0);
    //ENDIF
    }
    u_xlat3.x = vs_TEXCOORD6.x;
    u_xlat3.y = vs_TEXCOORD8.x;
    u_xlat3.z = vs_TEXCOORD7.x;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD6.y;
    u_xlat4.y = vs_TEXCOORD8.y;
    u_xlat4.z = vs_TEXCOORD7.y;
    u_xlat3.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD6.z;
    u_xlat4.y = vs_TEXCOORD8.z;
    u_xlat4.z = vs_TEXCOORD7.z;
    u_xlat3.z = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
    u_xlat16_5.xyz = (-_InnerColor.xyz) + _OutterColor.xyz;
    u_xlat0.yzw = u_xlat0.xxx * u_xlat16_5.xyz + _InnerColor.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat0 = u_xlat0 * u_xlat1.wxyz;
    u_xlat5.xyz = vec3(u_xlat0.y * _ColorBrightness, u_xlat0.z * _ColorBrightness, u_xlat0.w * _ColorBrightness);
    u_xlat2.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat4.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _InnerColor;
uniform 	mediump vec4 _OutterColor;
uniform 	mediump float _NormalMapToggle;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalMap_ST;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesFresnel_AfterImageArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFresnel_AfterImage {
	miHoYoParticlesFresnel_AfterImageArray_Type miHoYoParticlesFresnel_AfterImageArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalMap;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0 = vs_COLOR0 * miHoYoParticlesFresnel_AfterImageArray[u_xlati0]._MeshParticleColorArray;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_NormalMapToggle==1.0);
#else
    u_xlatb19 = _NormalMapToggle==1.0;
#endif
    if(u_xlatb19){
        u_xlat2.xy = vs_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
        u_xlat10_2.xyz = texture(_NormalMap, u_xlat2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_3.xy = u_xlat16_3.xy * vec2(_NormalIntensity);
        u_xlat2.xyz = u_xlat16_3.xyz;
    } else {
        u_xlat2.x = float(0.0);
        u_xlat2.y = float(0.0);
        u_xlat2.z = float(1.0);
    //ENDIF
    }
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat5.x = vs_TEXCOORD6.y;
    u_xlat5.y = vs_TEXCOORD8.y;
    u_xlat5.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = vs_TEXCOORD6.z;
    u_xlat5.y = vs_TEXCOORD8.z;
    u_xlat5.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Power;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Fresnal_Scale;
    u_xlat16_7.xyz = (-_InnerColor.xyz) + _OutterColor.xyz;
    u_xlat7.xyz = u_xlat1.xxx * u_xlat16_7.xyz + _InnerColor.xyz;
    u_xlat0 = u_xlat0 * _MainColor;
    u_xlat0.xyz = u_xlat7.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat1.x * u_xlat0.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}