//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Particles/OneChannel_VertexScale" {
Properties {
_TintColor ("Tint Color", Color) = (0.5019608,0.5019608,0.5019608,0.5019608)
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
_AlphaScaler ("Alpha Scaler", Range(0, 50)) = 1
_MainTex ("Particle Texture", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _OpacityChannelToggle ("OpacityChannelToggle", Float) = 0
[MHYToggle] _DistanceBlendToggle ("DistanceBlendToggle", Float) = 0
_FadeDistance ("FadeDistance", Float) = 20
_FadePower ("FadePower", Float) = 5
_VertexScale ("VertexScale", Float) = 5
_VertexScaleDistance ("VertexScaleDistance", Float) = 2
_VertexScaleOffset ("VertexScaleOffset", Float) = 0
[Header(MiHoYoDepthFade)] [Toggle(_SOFTPARTICLES_ON)] _SOFTPARTICLES ("SOFTPARTICLES", Float) = 0
_DepthThresh ("DepthThresh", Range(0.001, 20)) = 1
_DepthFade ("DepthFade", Range(0.001, 20)) = 1
_MeshParticleColorArray ("MeshParticleColorArray", Vector) = (1,1,1,1)
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
  GpuProgramID 57541
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _VertexScale;
uniform 	float _VertexScaleDistance;
uniform 	float _VertexScaleOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_VertexScaleOffset);
    u_xlat1.x = u_xlat1.x / _VertexScaleDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat4.x = _VertexScale + -1.0;
    u_xlat1.x = u_xlat1.x * u_xlat4.x + 1.0;
    u_xlat4.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.xyz = u_xlat4.xyz * u_xlat1.xxx + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD6.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _EmissionScaler;
uniform 	vec4 _TintColor;
uniform 	mediump float _DistanceBlendToggle;
uniform 	mediump float _OpacityChannelToggle;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadePower;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb2;
vec2 u_xlat3;
bool u_xlatb6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FadePower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat3.xy);
    u_xlat3.x = (-u_xlat1.x) + u_xlat1.y;
    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat1.x;
    u_xlatb2 = equal(vec4(vec4(_OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_DistanceBlendToggle==1.0);
#else
    u_xlatb6 = _DistanceBlendToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.x = vs_COLOR0.w * _TintColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.w = dot(u_xlat0.xx, vec2(_AlphaScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(_EmissionScaler) * _TintColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _VertexScale;
uniform 	float _VertexScaleDistance;
uniform 	float _VertexScaleOffset;
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
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat5;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat12 = _VertexScale + -1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 3;
    u_xlat2 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5 = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat5;
    u_xlat5 = (-u_xlat5) + (-_ProjectionParams.y);
    u_xlat5 = u_xlat5 + (-_VertexScaleOffset);
    u_xlat5 = u_xlat5 / _VertexScaleDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5 * u_xlat12 + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + in_TEXCOORD1.xyz;
    u_xlat3 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat3;
    u_xlat0 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat3;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat3;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat3;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD6.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	int unity_BaseInstanceID;
uniform 	float _EmissionScaler;
uniform 	vec4 _TintColor;
uniform 	mediump float _DistanceBlendToggle;
uniform 	mediump float _OpacityChannelToggle;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadePower;
uniform 	float _AlphaScaler;
struct miHoYoParticlesOneChannel_VertexScaleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel_VertexScale {
	miHoYoParticlesOneChannel_VertexScaleArray_Type miHoYoParticlesOneChannel_VertexScaleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
int u_xlati3;
bool u_xlatb6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FadePower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat3.xy);
    u_xlat3.x = (-u_xlat1.x) + u_xlat1.y;
    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat1.x;
    u_xlatb2 = equal(vec4(vec4(_OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_DistanceBlendToggle==1.0);
#else
    u_xlatb6 = _DistanceBlendToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : u_xlat3.x;
    u_xlati3 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesOneChannel_VertexScaleArray[u_xlati3]._MeshParticleColorArray;
    u_xlat3.x = u_xlat1.w * _TintColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.w = dot(u_xlat0.xx, vec2(_AlphaScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(_EmissionScaler) * _TintColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _VertexScale;
uniform 	float _VertexScaleDistance;
uniform 	float _VertexScaleOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_VertexScaleOffset);
    u_xlat1.x = u_xlat1.x / _VertexScaleDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat4.x = _VertexScale + -1.0;
    u_xlat1.x = u_xlat1.x * u_xlat4.x + 1.0;
    u_xlat4.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.xyz = u_xlat4.xyz * u_xlat1.xxx + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD6.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _EmissionScaler;
uniform 	vec4 _TintColor;
uniform 	mediump float _DistanceBlendToggle;
uniform 	mediump float _OpacityChannelToggle;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadePower;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb2;
vec2 u_xlat3;
bool u_xlatb6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FadePower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat3.xy);
    u_xlat3.x = (-u_xlat1.x) + u_xlat1.y;
    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat1.x;
    u_xlatb2 = equal(vec4(vec4(_OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_DistanceBlendToggle==1.0);
#else
    u_xlatb6 = _DistanceBlendToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.x = vs_COLOR0.w * _TintColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.w = dot(u_xlat0.xx, vec2(_AlphaScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(_EmissionScaler) * _TintColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _VertexScale;
uniform 	float _VertexScaleDistance;
uniform 	float _VertexScaleOffset;
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
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat5;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat12 = _VertexScale + -1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 3;
    u_xlat2 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5 = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat5;
    u_xlat5 = (-u_xlat5) + (-_ProjectionParams.y);
    u_xlat5 = u_xlat5 + (-_VertexScaleOffset);
    u_xlat5 = u_xlat5 / _VertexScaleDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5 * u_xlat12 + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + in_TEXCOORD1.xyz;
    u_xlat3 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat3;
    u_xlat0 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat3;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat3;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat3;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD6.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	int unity_BaseInstanceID;
uniform 	float _EmissionScaler;
uniform 	vec4 _TintColor;
uniform 	mediump float _DistanceBlendToggle;
uniform 	mediump float _OpacityChannelToggle;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadePower;
uniform 	float _AlphaScaler;
struct miHoYoParticlesOneChannel_VertexScaleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel_VertexScale {
	miHoYoParticlesOneChannel_VertexScaleArray_Type miHoYoParticlesOneChannel_VertexScaleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
int u_xlati3;
bool u_xlatb6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FadePower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat3.xy);
    u_xlat3.x = (-u_xlat1.x) + u_xlat1.y;
    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat1.x;
    u_xlatb2 = equal(vec4(vec4(_OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_DistanceBlendToggle==1.0);
#else
    u_xlatb6 = _DistanceBlendToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : u_xlat3.x;
    u_xlati3 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesOneChannel_VertexScaleArray[u_xlati3]._MeshParticleColorArray;
    u_xlat3.x = u_xlat1.w * _TintColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.w = dot(u_xlat0.xx, vec2(_AlphaScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(_EmissionScaler) * _TintColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _VertexScale;
uniform 	float _VertexScaleDistance;
uniform 	float _VertexScaleOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_VertexScaleOffset);
    u_xlat1.x = u_xlat1.x / _VertexScaleDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat4.x = _VertexScale + -1.0;
    u_xlat1.x = u_xlat1.x * u_xlat4.x + 1.0;
    u_xlat4.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.xyz = u_xlat4.xyz * u_xlat1.xxx + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD6.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _EmissionScaler;
uniform 	vec4 _TintColor;
uniform 	mediump float _DistanceBlendToggle;
uniform 	mediump float _OpacityChannelToggle;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadePower;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat4;
float u_xlat6;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(vec4(_OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat6 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat4 = (u_xlatb1.z) ? u_xlat0.z : u_xlat6;
    u_xlat4 = (u_xlatb1.y) ? u_xlat0.y : u_xlat4;
    u_xlat4 = (u_xlatb1.x) ? u_xlat0.x : u_xlat4;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6 = sqrt(u_xlat6);
    u_xlat6 = u_xlat6 / _FadeDistance;
    u_xlat6 = max(u_xlat6, 9.99999975e-05);
    u_xlat6 = log2(u_xlat6);
    u_xlat6 = u_xlat6 * _FadePower;
    u_xlat6 = exp2(u_xlat6);
    u_xlat6 = min(u_xlat6, 1.0);
    u_xlat2 = (-u_xlat0.x) + u_xlat0.y;
    u_xlat0.x = u_xlat6 * u_xlat2 + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_DistanceBlendToggle==1.0);
#else
    u_xlatb2 = _DistanceBlendToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb2) ? u_xlat0.x : u_xlat4;
    u_xlat2 = vs_COLOR0.w * _TintColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.w = dot(u_xlat0.xx, vec2(_AlphaScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(_EmissionScaler) * _TintColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _VertexScale;
uniform 	float _VertexScaleDistance;
uniform 	float _VertexScaleOffset;
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
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat5;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat12 = _VertexScale + -1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 3;
    u_xlat2 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5 = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat5;
    u_xlat5 = (-u_xlat5) + (-_ProjectionParams.y);
    u_xlat5 = u_xlat5 + (-_VertexScaleOffset);
    u_xlat5 = u_xlat5 / _VertexScaleDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5 * u_xlat12 + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + in_TEXCOORD1.xyz;
    u_xlat3 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat3;
    u_xlat0 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat3;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat3;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat3;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD6.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _EmissionScaler;
uniform 	vec4 _TintColor;
uniform 	mediump float _DistanceBlendToggle;
uniform 	mediump float _OpacityChannelToggle;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadePower;
uniform 	float _AlphaScaler;
struct miHoYoParticlesOneChannel_VertexScaleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel_VertexScale {
	miHoYoParticlesOneChannel_VertexScaleArray_Type miHoYoParticlesOneChannel_VertexScaleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
bvec4 u_xlatb2;
float u_xlat4;
bool u_xlatb4;
float u_xlat7;
float u_xlat9;
float u_xlat10;
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
    u_xlat0 = vs_COLOR0 * miHoYoParticlesOneChannel_VertexScaleArray[u_xlati0]._MeshParticleColorArray;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat7 = (u_xlatb2.z) ? u_xlat1.z : u_xlat10;
    u_xlat7 = (u_xlatb2.y) ? u_xlat1.y : u_xlat7;
    u_xlat7 = (u_xlatb2.x) ? u_xlat1.x : u_xlat7;
    u_xlat2.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = sqrt(u_xlat10);
    u_xlat10 = u_xlat10 / _FadeDistance;
    u_xlat10 = max(u_xlat10, 9.99999975e-05);
    u_xlat10 = log2(u_xlat10);
    u_xlat10 = u_xlat10 * _FadePower;
    u_xlat10 = exp2(u_xlat10);
    u_xlat10 = min(u_xlat10, 1.0);
    u_xlat4 = (-u_xlat1.x) + u_xlat1.y;
    u_xlat1.x = u_xlat10 * u_xlat4 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DistanceBlendToggle==1.0);
#else
    u_xlatb4 = _DistanceBlendToggle==1.0;
#endif
    u_xlat1.x = (u_xlatb4) ? u_xlat1.x : u_xlat7;
    u_xlat9 = u_xlat0.w * _TintColor.w;
    u_xlat9 = u_xlat1.x * u_xlat9;
    u_xlat1.w = dot(vec2(u_xlat9), vec2(_AlphaScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(_EmissionScaler) * _TintColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _VertexScale;
uniform 	float _VertexScaleDistance;
uniform 	float _VertexScaleOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_VertexScaleOffset);
    u_xlat1.x = u_xlat1.x / _VertexScaleDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat4.x = _VertexScale + -1.0;
    u_xlat1.x = u_xlat1.x * u_xlat4.x + 1.0;
    u_xlat4.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.xyz = u_xlat4.xyz * u_xlat1.xxx + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD6.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _EmissionScaler;
uniform 	vec4 _TintColor;
uniform 	mediump float _DistanceBlendToggle;
uniform 	mediump float _OpacityChannelToggle;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadePower;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat4;
float u_xlat6;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(vec4(_OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat6 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat4 = (u_xlatb1.z) ? u_xlat0.z : u_xlat6;
    u_xlat4 = (u_xlatb1.y) ? u_xlat0.y : u_xlat4;
    u_xlat4 = (u_xlatb1.x) ? u_xlat0.x : u_xlat4;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6 = sqrt(u_xlat6);
    u_xlat6 = u_xlat6 / _FadeDistance;
    u_xlat6 = max(u_xlat6, 9.99999975e-05);
    u_xlat6 = log2(u_xlat6);
    u_xlat6 = u_xlat6 * _FadePower;
    u_xlat6 = exp2(u_xlat6);
    u_xlat6 = min(u_xlat6, 1.0);
    u_xlat2 = (-u_xlat0.x) + u_xlat0.y;
    u_xlat0.x = u_xlat6 * u_xlat2 + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_DistanceBlendToggle==1.0);
#else
    u_xlatb2 = _DistanceBlendToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb2) ? u_xlat0.x : u_xlat4;
    u_xlat2 = vs_COLOR0.w * _TintColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.w = dot(u_xlat0.xx, vec2(_AlphaScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(_EmissionScaler) * _TintColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _VertexScale;
uniform 	float _VertexScaleDistance;
uniform 	float _VertexScaleOffset;
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
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat5;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat12 = _VertexScale + -1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 3;
    u_xlat2 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5 = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat5;
    u_xlat5 = (-u_xlat5) + (-_ProjectionParams.y);
    u_xlat5 = u_xlat5 + (-_VertexScaleOffset);
    u_xlat5 = u_xlat5 / _VertexScaleDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5 * u_xlat12 + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + in_TEXCOORD1.xyz;
    u_xlat3 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat3;
    u_xlat0 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat3;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat3;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat3;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD6.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _EmissionScaler;
uniform 	vec4 _TintColor;
uniform 	mediump float _DistanceBlendToggle;
uniform 	mediump float _OpacityChannelToggle;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadePower;
uniform 	float _AlphaScaler;
struct miHoYoParticlesOneChannel_VertexScaleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel_VertexScale {
	miHoYoParticlesOneChannel_VertexScaleArray_Type miHoYoParticlesOneChannel_VertexScaleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
bvec4 u_xlatb2;
float u_xlat4;
bool u_xlatb4;
float u_xlat7;
float u_xlat9;
float u_xlat10;
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
    u_xlat0 = vs_COLOR0 * miHoYoParticlesOneChannel_VertexScaleArray[u_xlati0]._MeshParticleColorArray;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat7 = (u_xlatb2.z) ? u_xlat1.z : u_xlat10;
    u_xlat7 = (u_xlatb2.y) ? u_xlat1.y : u_xlat7;
    u_xlat7 = (u_xlatb2.x) ? u_xlat1.x : u_xlat7;
    u_xlat2.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = sqrt(u_xlat10);
    u_xlat10 = u_xlat10 / _FadeDistance;
    u_xlat10 = max(u_xlat10, 9.99999975e-05);
    u_xlat10 = log2(u_xlat10);
    u_xlat10 = u_xlat10 * _FadePower;
    u_xlat10 = exp2(u_xlat10);
    u_xlat10 = min(u_xlat10, 1.0);
    u_xlat4 = (-u_xlat1.x) + u_xlat1.y;
    u_xlat1.x = u_xlat10 * u_xlat4 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DistanceBlendToggle==1.0);
#else
    u_xlatb4 = _DistanceBlendToggle==1.0;
#endif
    u_xlat1.x = (u_xlatb4) ? u_xlat1.x : u_xlat7;
    u_xlat9 = u_xlat0.w * _TintColor.w;
    u_xlat9 = u_xlat1.x * u_xlat9;
    u_xlat1.w = dot(vec2(u_xlat9), vec2(_AlphaScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(_EmissionScaler) * _TintColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _VertexScale;
uniform 	float _VertexScaleDistance;
uniform 	float _VertexScaleOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_VertexScaleOffset);
    u_xlat1.x = u_xlat1.x / _VertexScaleDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat4.x = _VertexScale + -1.0;
    u_xlat1.x = u_xlat1.x * u_xlat4.x + 1.0;
    u_xlat4.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.xyz = u_xlat4.xyz * u_xlat1.xxx + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD6.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _EmissionScaler;
uniform 	vec4 _TintColor;
uniform 	mediump float _DistanceBlendToggle;
uniform 	mediump float _OpacityChannelToggle;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadePower;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb2;
vec2 u_xlat3;
bool u_xlatb6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FadePower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat3.xy);
    u_xlat3.x = (-u_xlat1.x) + u_xlat1.y;
    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat1.x;
    u_xlatb2 = equal(vec4(vec4(_OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_DistanceBlendToggle==1.0);
#else
    u_xlatb6 = _DistanceBlendToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.x = vs_COLOR0.w * _TintColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.w = dot(u_xlat0.xx, vec2(_AlphaScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(_EmissionScaler) * _TintColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _VertexScale;
uniform 	float _VertexScaleDistance;
uniform 	float _VertexScaleOffset;
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
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat5;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat12 = _VertexScale + -1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 3;
    u_xlat2 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5 = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat5;
    u_xlat5 = (-u_xlat5) + (-_ProjectionParams.y);
    u_xlat5 = u_xlat5 + (-_VertexScaleOffset);
    u_xlat5 = u_xlat5 / _VertexScaleDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5 * u_xlat12 + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + in_TEXCOORD1.xyz;
    u_xlat3 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat3;
    u_xlat0 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat3;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat3;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat3;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD6.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	int unity_BaseInstanceID;
uniform 	float _EmissionScaler;
uniform 	vec4 _TintColor;
uniform 	mediump float _DistanceBlendToggle;
uniform 	mediump float _OpacityChannelToggle;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadePower;
uniform 	float _AlphaScaler;
struct miHoYoParticlesOneChannel_VertexScaleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel_VertexScale {
	miHoYoParticlesOneChannel_VertexScaleArray_Type miHoYoParticlesOneChannel_VertexScaleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
int u_xlati3;
bool u_xlatb6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FadePower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat3.xy);
    u_xlat3.x = (-u_xlat1.x) + u_xlat1.y;
    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat1.x;
    u_xlatb2 = equal(vec4(vec4(_OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_DistanceBlendToggle==1.0);
#else
    u_xlatb6 = _DistanceBlendToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : u_xlat3.x;
    u_xlati3 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesOneChannel_VertexScaleArray[u_xlati3]._MeshParticleColorArray;
    u_xlat3.x = u_xlat1.w * _TintColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.w = dot(u_xlat0.xx, vec2(_AlphaScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(_EmissionScaler) * _TintColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _VertexScale;
uniform 	float _VertexScaleDistance;
uniform 	float _VertexScaleOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_VertexScaleOffset);
    u_xlat1.x = u_xlat1.x / _VertexScaleDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat4.x = _VertexScale + -1.0;
    u_xlat1.x = u_xlat1.x * u_xlat4.x + 1.0;
    u_xlat4.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.xyz = u_xlat4.xyz * u_xlat1.xxx + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD6.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _EmissionScaler;
uniform 	vec4 _TintColor;
uniform 	mediump float _DistanceBlendToggle;
uniform 	mediump float _OpacityChannelToggle;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadePower;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb2;
vec2 u_xlat3;
bool u_xlatb6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FadePower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat3.xy);
    u_xlat3.x = (-u_xlat1.x) + u_xlat1.y;
    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat1.x;
    u_xlatb2 = equal(vec4(vec4(_OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_DistanceBlendToggle==1.0);
#else
    u_xlatb6 = _DistanceBlendToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.x = vs_COLOR0.w * _TintColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.w = dot(u_xlat0.xx, vec2(_AlphaScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(_EmissionScaler) * _TintColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _VertexScale;
uniform 	float _VertexScaleDistance;
uniform 	float _VertexScaleOffset;
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
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat5;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat12 = _VertexScale + -1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 3;
    u_xlat2 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5 = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat5;
    u_xlat5 = (-u_xlat5) + (-_ProjectionParams.y);
    u_xlat5 = u_xlat5 + (-_VertexScaleOffset);
    u_xlat5 = u_xlat5 / _VertexScaleDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5 * u_xlat12 + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + in_TEXCOORD1.xyz;
    u_xlat3 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat3;
    u_xlat0 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat3;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat3;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat3;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD6.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	int unity_BaseInstanceID;
uniform 	float _EmissionScaler;
uniform 	vec4 _TintColor;
uniform 	mediump float _DistanceBlendToggle;
uniform 	mediump float _OpacityChannelToggle;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadePower;
uniform 	float _AlphaScaler;
struct miHoYoParticlesOneChannel_VertexScaleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel_VertexScale {
	miHoYoParticlesOneChannel_VertexScaleArray_Type miHoYoParticlesOneChannel_VertexScaleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
int u_xlati3;
bool u_xlatb6;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FadePower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat3.xy);
    u_xlat3.x = (-u_xlat1.x) + u_xlat1.y;
    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat1.x;
    u_xlatb2 = equal(vec4(vec4(_OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat3.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat3.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_DistanceBlendToggle==1.0);
#else
    u_xlatb6 = _DistanceBlendToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : u_xlat3.x;
    u_xlati3 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesOneChannel_VertexScaleArray[u_xlati3]._MeshParticleColorArray;
    u_xlat3.x = u_xlat1.w * _TintColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.w = dot(u_xlat0.xx, vec2(_AlphaScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(_EmissionScaler) * _TintColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _VertexScale;
uniform 	float _VertexScaleDistance;
uniform 	float _VertexScaleOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_VertexScaleOffset);
    u_xlat1.x = u_xlat1.x / _VertexScaleDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat4.x = _VertexScale + -1.0;
    u_xlat1.x = u_xlat1.x * u_xlat4.x + 1.0;
    u_xlat4.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.xyz = u_xlat4.xyz * u_xlat1.xxx + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD6.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _EmissionScaler;
uniform 	vec4 _TintColor;
uniform 	mediump float _DistanceBlendToggle;
uniform 	mediump float _OpacityChannelToggle;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadePower;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat4;
float u_xlat6;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(vec4(_OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat6 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat4 = (u_xlatb1.z) ? u_xlat0.z : u_xlat6;
    u_xlat4 = (u_xlatb1.y) ? u_xlat0.y : u_xlat4;
    u_xlat4 = (u_xlatb1.x) ? u_xlat0.x : u_xlat4;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6 = sqrt(u_xlat6);
    u_xlat6 = u_xlat6 / _FadeDistance;
    u_xlat6 = max(u_xlat6, 9.99999975e-05);
    u_xlat6 = log2(u_xlat6);
    u_xlat6 = u_xlat6 * _FadePower;
    u_xlat6 = exp2(u_xlat6);
    u_xlat6 = min(u_xlat6, 1.0);
    u_xlat2 = (-u_xlat0.x) + u_xlat0.y;
    u_xlat0.x = u_xlat6 * u_xlat2 + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_DistanceBlendToggle==1.0);
#else
    u_xlatb2 = _DistanceBlendToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb2) ? u_xlat0.x : u_xlat4;
    u_xlat2 = vs_COLOR0.w * _TintColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.w = dot(u_xlat0.xx, vec2(_AlphaScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(_EmissionScaler) * _TintColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _VertexScale;
uniform 	float _VertexScaleDistance;
uniform 	float _VertexScaleOffset;
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
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat5;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat12 = _VertexScale + -1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 3;
    u_xlat2 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5 = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat5;
    u_xlat5 = (-u_xlat5) + (-_ProjectionParams.y);
    u_xlat5 = u_xlat5 + (-_VertexScaleOffset);
    u_xlat5 = u_xlat5 / _VertexScaleDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5 * u_xlat12 + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + in_TEXCOORD1.xyz;
    u_xlat3 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat3;
    u_xlat0 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat3;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat3;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat3;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD6.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _EmissionScaler;
uniform 	vec4 _TintColor;
uniform 	mediump float _DistanceBlendToggle;
uniform 	mediump float _OpacityChannelToggle;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadePower;
uniform 	float _AlphaScaler;
struct miHoYoParticlesOneChannel_VertexScaleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel_VertexScale {
	miHoYoParticlesOneChannel_VertexScaleArray_Type miHoYoParticlesOneChannel_VertexScaleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
bvec4 u_xlatb2;
float u_xlat4;
bool u_xlatb4;
float u_xlat7;
float u_xlat9;
float u_xlat10;
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
    u_xlat0 = vs_COLOR0 * miHoYoParticlesOneChannel_VertexScaleArray[u_xlati0]._MeshParticleColorArray;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat7 = (u_xlatb2.z) ? u_xlat1.z : u_xlat10;
    u_xlat7 = (u_xlatb2.y) ? u_xlat1.y : u_xlat7;
    u_xlat7 = (u_xlatb2.x) ? u_xlat1.x : u_xlat7;
    u_xlat2.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = sqrt(u_xlat10);
    u_xlat10 = u_xlat10 / _FadeDistance;
    u_xlat10 = max(u_xlat10, 9.99999975e-05);
    u_xlat10 = log2(u_xlat10);
    u_xlat10 = u_xlat10 * _FadePower;
    u_xlat10 = exp2(u_xlat10);
    u_xlat10 = min(u_xlat10, 1.0);
    u_xlat4 = (-u_xlat1.x) + u_xlat1.y;
    u_xlat1.x = u_xlat10 * u_xlat4 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DistanceBlendToggle==1.0);
#else
    u_xlatb4 = _DistanceBlendToggle==1.0;
#endif
    u_xlat1.x = (u_xlatb4) ? u_xlat1.x : u_xlat7;
    u_xlat9 = u_xlat0.w * _TintColor.w;
    u_xlat9 = u_xlat1.x * u_xlat9;
    u_xlat1.w = dot(vec2(u_xlat9), vec2(_AlphaScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(_EmissionScaler) * _TintColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _VertexScale;
uniform 	float _VertexScaleDistance;
uniform 	float _VertexScaleOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat1.x;
    u_xlat1.x = (-u_xlat1.x) + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_VertexScaleOffset);
    u_xlat1.x = u_xlat1.x / _VertexScaleDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat4.x = _VertexScale + -1.0;
    u_xlat1.x = u_xlat1.x * u_xlat4.x + 1.0;
    u_xlat4.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.xyz = u_xlat4.xyz * u_xlat1.xxx + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD6.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _EmissionScaler;
uniform 	vec4 _TintColor;
uniform 	mediump float _DistanceBlendToggle;
uniform 	mediump float _OpacityChannelToggle;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadePower;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
float u_xlat2;
bool u_xlatb2;
float u_xlat4;
float u_xlat6;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = texture(_MainTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(vec4(_OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat6 = u_xlatb1.w ? u_xlat0.w : float(0.0);
    u_xlat4 = (u_xlatb1.z) ? u_xlat0.z : u_xlat6;
    u_xlat4 = (u_xlatb1.y) ? u_xlat0.y : u_xlat4;
    u_xlat4 = (u_xlatb1.x) ? u_xlat0.x : u_xlat4;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6 = sqrt(u_xlat6);
    u_xlat6 = u_xlat6 / _FadeDistance;
    u_xlat6 = max(u_xlat6, 9.99999975e-05);
    u_xlat6 = log2(u_xlat6);
    u_xlat6 = u_xlat6 * _FadePower;
    u_xlat6 = exp2(u_xlat6);
    u_xlat6 = min(u_xlat6, 1.0);
    u_xlat2 = (-u_xlat0.x) + u_xlat0.y;
    u_xlat0.x = u_xlat6 * u_xlat2 + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_DistanceBlendToggle==1.0);
#else
    u_xlatb2 = _DistanceBlendToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb2) ? u_xlat0.x : u_xlat4;
    u_xlat2 = vs_COLOR0.w * _TintColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.w = dot(u_xlat0.xx, vec2(_AlphaScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(_EmissionScaler) * _TintColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _VertexScale;
uniform 	float _VertexScaleDistance;
uniform 	float _VertexScaleOffset;
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
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat5;
float u_xlat12;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat12 = _VertexScale + -1.0;
    u_xlati1 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati1 = u_xlati1 << 3;
    u_xlat2 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat5 = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat5;
    u_xlat5 = (-u_xlat5) + (-_ProjectionParams.y);
    u_xlat5 = u_xlat5 + (-_VertexScaleOffset);
    u_xlat5 = u_xlat5 / _VertexScaleDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat5 * u_xlat12 + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + in_TEXCOORD1.xyz;
    u_xlat3 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat3;
    u_xlat0 = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat3;
    u_xlat0 = u_xlat0 + unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat3;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat3;
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati1 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD6.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _EmissionScaler;
uniform 	vec4 _TintColor;
uniform 	mediump float _DistanceBlendToggle;
uniform 	mediump float _OpacityChannelToggle;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadePower;
uniform 	float _AlphaScaler;
struct miHoYoParticlesOneChannel_VertexScaleArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel_VertexScale {
	miHoYoParticlesOneChannel_VertexScaleArray_Type miHoYoParticlesOneChannel_VertexScaleArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
bvec4 u_xlatb2;
float u_xlat4;
bool u_xlatb4;
float u_xlat7;
float u_xlat9;
float u_xlat10;
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
    u_xlat0 = vs_COLOR0 * miHoYoParticlesOneChannel_VertexScaleArray[u_xlati0]._MeshParticleColorArray;
    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat1.xy);
    u_xlatb2 = equal(vec4(vec4(_OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat7 = (u_xlatb2.z) ? u_xlat1.z : u_xlat10;
    u_xlat7 = (u_xlatb2.y) ? u_xlat1.y : u_xlat7;
    u_xlat7 = (u_xlatb2.x) ? u_xlat1.x : u_xlat7;
    u_xlat2.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = sqrt(u_xlat10);
    u_xlat10 = u_xlat10 / _FadeDistance;
    u_xlat10 = max(u_xlat10, 9.99999975e-05);
    u_xlat10 = log2(u_xlat10);
    u_xlat10 = u_xlat10 * _FadePower;
    u_xlat10 = exp2(u_xlat10);
    u_xlat10 = min(u_xlat10, 1.0);
    u_xlat4 = (-u_xlat1.x) + u_xlat1.y;
    u_xlat1.x = u_xlat10 * u_xlat4 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_DistanceBlendToggle==1.0);
#else
    u_xlatb4 = _DistanceBlendToggle==1.0;
#endif
    u_xlat1.x = (u_xlatb4) ? u_xlat1.x : u_xlat7;
    u_xlat9 = u_xlat0.w * _TintColor.w;
    u_xlat9 = u_xlat1.x * u_xlat9;
    u_xlat1.w = dot(vec2(u_xlat9), vec2(_AlphaScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(_EmissionScaler) * _TintColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat1;
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
 Pass {
  Name "DISTORTIONVECTORS"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DISTORTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 107882
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _VertexScale;
uniform 	float _VertexScaleDistance;
uniform 	float _VertexScaleOffset;
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
vec3 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_VertexScaleOffset);
    u_xlat0.x = u_xlat0.x / _VertexScaleDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.x = _VertexScale + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat2.x + 1.0;
    u_xlat2.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xxx + in_TEXCOORD1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _VertexScale;
uniform 	float _VertexScaleDistance;
uniform 	float _VertexScaleOffset;
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
vec3 u_xlat2;
float u_xlat4;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat2.x;
    u_xlat2.x = (-u_xlat2.x) + (-_ProjectionParams.y);
    u_xlat2.x = u_xlat2.x + (-_VertexScaleOffset);
    u_xlat2.x = u_xlat2.x / _VertexScaleDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat4 = _VertexScale + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat4 + 1.0;
    u_xlat1.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xxx + in_TEXCOORD1.xyz;
    u_xlat1 = u_xlat2.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat2.zzzz + u_xlat1;
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
  GpuProgramID 166379
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	float _VertexScale;
uniform 	float _VertexScaleDistance;
uniform 	float _VertexScaleOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    u_xlat4.x = (-u_xlat4.x) + (-_ProjectionParams.y);
    u_xlat4.x = u_xlat4.x + (-_VertexScaleOffset);
    u_xlat4.x = u_xlat4.x / _VertexScaleDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat8 = _VertexScale + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat8 + 1.0;
    u_xlat2.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xxx + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat4.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat4.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat4.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD6.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _TintColor;
uniform 	mediump float _DistanceBlendToggle;
uniform 	mediump float _OpacityChannelToggle;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadePower;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
vec2 u_xlat8;
ivec2 u_xlati8;
bool u_xlatb8;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FadePower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat4.xy);
    u_xlat4.x = (-u_xlat1.x) + u_xlat1.y;
    u_xlat0.x = u_xlat0.x * u_xlat4.x + u_xlat1.x;
    u_xlatb2 = equal(vec4(vec4(_OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_DistanceBlendToggle==1.0);
#else
    u_xlatb8 = _DistanceBlendToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
    u_xlat4.x = vs_COLOR0.w * _TintColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(_AlphaScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati1.xy;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	float _VertexScale;
uniform 	float _VertexScaleDistance;
uniform 	float _VertexScaleOffset;
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
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
int u_xlati6;
float u_xlat11;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat5.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.x = _VertexScale + -1.0;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat2 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat11 = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat11;
    u_xlat11 = (-u_xlat11) + (-_ProjectionParams.y);
    u_xlat11 = u_xlat11 + (-_VertexScaleOffset);
    u_xlat11 = u_xlat11 / _VertexScaleDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat11 * u_xlat1.x + 1.0;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xxx + in_TEXCOORD1.xyz;
    u_xlat3 = u_xlat5.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat5.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat5.zzzz + u_xlat3;
    u_xlat3 = u_xlat3 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    gl_Position.z = u_xlat0.x * u_xlat4.w + u_xlat4.z;
    gl_Position.xyw = u_xlat4.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD6.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = u_xlat3.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat3.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat3.wwww + u_xlat0;
    u_xlat0 = u_xlat3.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat3.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat3.wwww + u_xlat0;
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
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _TintColor;
uniform 	mediump float _DistanceBlendToggle;
uniform 	mediump float _OpacityChannelToggle;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadePower;
uniform 	float _AlphaScaler;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
int u_xlati4;
vec2 u_xlat8;
ivec2 u_xlati8;
bool u_xlatb8;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FadePower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat4.xy);
    u_xlat4.x = (-u_xlat1.x) + u_xlat1.y;
    u_xlat0.x = u_xlat0.x * u_xlat4.x + u_xlat1.x;
    u_xlatb2 = equal(vec4(vec4(_OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_DistanceBlendToggle==1.0);
#else
    u_xlatb8 = _DistanceBlendToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat4.x = vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.w;
    u_xlat4.x = u_xlat4.x * _TintColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(_AlphaScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati1.xy;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	float _VertexScale;
uniform 	float _VertexScaleDistance;
uniform 	float _VertexScaleOffset;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    u_xlat4.x = (-u_xlat4.x) + (-_ProjectionParams.y);
    u_xlat4.x = u_xlat4.x + (-_VertexScaleOffset);
    u_xlat4.x = u_xlat4.x / _VertexScaleDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat8 = _VertexScale + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat8 + 1.0;
    u_xlat2.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xxx + in_TEXCOORD1.xyz;
    u_xlat2 = u_xlat4.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat4.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat4.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD6.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _TintColor;
uniform 	mediump float _DistanceBlendToggle;
uniform 	mediump float _OpacityChannelToggle;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadePower;
uniform 	float _AlphaScaler;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
vec2 u_xlat8;
ivec2 u_xlati8;
bool u_xlatb8;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FadePower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat4.xy);
    u_xlat4.x = (-u_xlat1.x) + u_xlat1.y;
    u_xlat0.x = u_xlat0.x * u_xlat4.x + u_xlat1.x;
    u_xlatb2 = equal(vec4(vec4(_OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_DistanceBlendToggle==1.0);
#else
    u_xlatb8 = _DistanceBlendToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
    u_xlat4.x = vs_COLOR0.w * _TintColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(_AlphaScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati1.xy;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	float _VertexScale;
uniform 	float _VertexScaleDistance;
uniform 	float _VertexScaleOffset;
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
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
int u_xlati6;
float u_xlat11;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat5.xyz = in_POSITION0.xyz + (-in_TEXCOORD1.xyz);
    u_xlat1.x = _VertexScale + -1.0;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat2 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat11 = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat11;
    u_xlat11 = (-u_xlat11) + (-_ProjectionParams.y);
    u_xlat11 = u_xlat11 + (-_VertexScaleOffset);
    u_xlat11 = u_xlat11 / _VertexScaleDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat11 * u_xlat1.x + 1.0;
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xxx + in_TEXCOORD1.xyz;
    u_xlat3 = u_xlat5.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat5.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat5.zzzz + u_xlat3;
    u_xlat3 = u_xlat3 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat4 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat4;
    gl_Position.z = u_xlat0.x * u_xlat4.w + u_xlat4.z;
    gl_Position.xyw = u_xlat4.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.x = u_xlat0.y * _ProjectionParams.x;
    vs_TEXCOORD6.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat0.x * 0.5;
    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = u_xlat3.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat3.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat3.wwww + u_xlat0;
    u_xlat0 = u_xlat3.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat3.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat3.wwww + u_xlat0;
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
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _TintColor;
uniform 	mediump float _DistanceBlendToggle;
uniform 	mediump float _OpacityChannelToggle;
uniform 	vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadePower;
uniform 	float _AlphaScaler;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
int u_xlati4;
vec2 u_xlat8;
ivec2 u_xlati8;
bool u_xlatb8;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FadePower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = texture(_MainTex, u_xlat4.xy);
    u_xlat4.x = (-u_xlat1.x) + u_xlat1.y;
    u_xlat0.x = u_xlat0.x * u_xlat4.x + u_xlat1.x;
    u_xlatb2 = equal(vec4(vec4(_OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle, _OpacityChannelToggle)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_DistanceBlendToggle==1.0);
#else
    u_xlatb8 = _DistanceBlendToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat4.x = vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.w;
    u_xlat4.x = u_xlat4.x * _TintColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(_AlphaScaler));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati1.xy;
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
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}