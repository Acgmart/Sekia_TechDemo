//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/WaveVertexAni_UV2Mask" {
Properties {
_MainColor ("MainColor", Color) = (1,1,1,1)
_ColorScale ("ColorScale", Float) = 1
_Mask_SetUV2 ("Mask_SetUV2", 2D) = "white" { }
_AddNoiseG ("AddNoise(G)", Range(0, 1)) = 0
_VertexAniDirXYZStrW ("VertexAniDir(XYZ)Str(W)", Vector) = (0,0,0,0)
_AniThreshold ("AniThreshold", Range(0, 1)) = 0
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
  GpuProgramID 45730
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 _Mask_SetUV2_ST;
uniform 	mediump float _AniThreshold;
uniform 	mediump float _AddNoiseG;
uniform 	mediump vec4 _VertexAniDirXYZStrW;
uniform lowp sampler2D _Mask_SetUV2;
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
mediump vec3 u_xlat16_1;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = in_TEXCOORD1.xy * _Mask_SetUV2_ST.xy + _Mask_SetUV2_ST.zw;
    u_xlat4.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = textureLod(_Mask_SetUV2, u_xlat0.xy, 0.0).xy;
    u_xlat4.x = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat16_1.x = _AniThreshold * 1.20000005 + -0.200000003;
    u_xlat4.x = (-u_xlat4.x) + u_xlat16_1.x;
    u_xlat4.x = abs(u_xlat4.x) + 0.769999981;
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat16_1.x = u_xlat0.y + -1.0;
    u_xlat16_1.x = _AddNoiseG * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _VertexAniDirXYZStrW.xyz;
    u_xlat16_1.xyz = u_xlat4.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * _VertexAniDirXYZStrW.www + in_POSITION0.xyz;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	vec4 _Mask_SetUV2_ST;
uniform 	mediump float _AniThreshold;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _Mask_SetUV2_ST.xy + _Mask_SetUV2_ST.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1.x = _AniThreshold * 1.20000005 + -0.200000003;
    u_xlat0.x = (-u_xlat0.x) + u_xlat16_1.x;
    u_xlat0.x = abs(u_xlat0.x) + 0.769999981;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    SV_Target0.w = u_xlat0.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.yyy * _MainColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
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
uniform 	mediump float _MHYZBias;
uniform 	vec4 _Mask_SetUV2_ST;
uniform 	mediump float _AniThreshold;
uniform 	mediump float _AddNoiseG;
uniform 	mediump vec4 _VertexAniDirXYZStrW;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Mask_SetUV2;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat4;
int u_xlati6;
void main()
{
    u_xlat0.xy = in_TEXCOORD1.xy * _Mask_SetUV2_ST.xy + _Mask_SetUV2_ST.zw;
    u_xlat4.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = textureLod(_Mask_SetUV2, u_xlat0.xy, 0.0).xy;
    u_xlat4.x = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat16_1.x = _AniThreshold * 1.20000005 + -0.200000003;
    u_xlat4.x = (-u_xlat4.x) + u_xlat16_1.x;
    u_xlat4.x = abs(u_xlat4.x) + 0.769999981;
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat16_1.x = u_xlat0.y + -1.0;
    u_xlat16_1.x = _AddNoiseG * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _VertexAniDirXYZStrW.xyz;
    u_xlat16_1.xyz = u_xlat4.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * _VertexAniDirXYZStrW.www + in_POSITION0.xyz;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	vec4 _Mask_SetUV2_ST;
uniform 	mediump float _AniThreshold;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _Mask_SetUV2_ST.xy + _Mask_SetUV2_ST.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1.x = _AniThreshold * 1.20000005 + -0.200000003;
    u_xlat0.x = (-u_xlat0.x) + u_xlat16_1.x;
    u_xlat0.x = abs(u_xlat0.x) + 0.769999981;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    SV_Target0.w = u_xlat0.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.yyy * _MainColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 _Mask_SetUV2_ST;
uniform 	mediump float _AniThreshold;
uniform 	mediump float _AddNoiseG;
uniform 	mediump vec4 _VertexAniDirXYZStrW;
uniform lowp sampler2D _Mask_SetUV2;
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
mediump vec3 u_xlat16_1;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = in_TEXCOORD1.xy * _Mask_SetUV2_ST.xy + _Mask_SetUV2_ST.zw;
    u_xlat4.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = textureLod(_Mask_SetUV2, u_xlat0.xy, 0.0).xy;
    u_xlat4.x = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat16_1.x = _AniThreshold * 1.20000005 + -0.200000003;
    u_xlat4.x = (-u_xlat4.x) + u_xlat16_1.x;
    u_xlat4.x = abs(u_xlat4.x) + 0.769999981;
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat16_1.x = u_xlat0.y + -1.0;
    u_xlat16_1.x = _AddNoiseG * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _VertexAniDirXYZStrW.xyz;
    u_xlat16_1.xyz = u_xlat4.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * _VertexAniDirXYZStrW.www + in_POSITION0.xyz;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	vec4 _Mask_SetUV2_ST;
uniform 	mediump float _AniThreshold;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD1.xy * _Mask_SetUV2_ST.xy + _Mask_SetUV2_ST.zw;
    u_xlat16_1.x = _AniThreshold * 1.20000005 + -0.200000003;
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x + (-u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + 0.769999981;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat16_1.xyz = vs_TEXCOORD0.yyy * _MainColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 _Mask_SetUV2_ST;
uniform 	mediump float _AniThreshold;
uniform 	mediump float _AddNoiseG;
uniform 	mediump vec4 _VertexAniDirXYZStrW;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Mask_SetUV2;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat4;
int u_xlati6;
void main()
{
    u_xlat0.xy = in_TEXCOORD1.xy * _Mask_SetUV2_ST.xy + _Mask_SetUV2_ST.zw;
    u_xlat4.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = textureLod(_Mask_SetUV2, u_xlat0.xy, 0.0).xy;
    u_xlat4.x = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat16_1.x = _AniThreshold * 1.20000005 + -0.200000003;
    u_xlat4.x = (-u_xlat4.x) + u_xlat16_1.x;
    u_xlat4.x = abs(u_xlat4.x) + 0.769999981;
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat16_1.x = u_xlat0.y + -1.0;
    u_xlat16_1.x = _AddNoiseG * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _VertexAniDirXYZStrW.xyz;
    u_xlat16_1.xyz = u_xlat4.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * _VertexAniDirXYZStrW.www + in_POSITION0.xyz;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	vec4 _Mask_SetUV2_ST;
uniform 	mediump float _AniThreshold;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD1.xy * _Mask_SetUV2_ST.xy + _Mask_SetUV2_ST.zw;
    u_xlat16_1.x = _AniThreshold * 1.20000005 + -0.200000003;
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x + (-u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + 0.769999981;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat16_1.xyz = vs_TEXCOORD0.yyy * _MainColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 _Mask_SetUV2_ST;
uniform 	mediump float _AniThreshold;
uniform 	mediump float _AddNoiseG;
uniform 	mediump vec4 _VertexAniDirXYZStrW;
uniform lowp sampler2D _Mask_SetUV2;
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
mediump vec3 u_xlat16_1;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = in_TEXCOORD1.xy * _Mask_SetUV2_ST.xy + _Mask_SetUV2_ST.zw;
    u_xlat4.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = textureLod(_Mask_SetUV2, u_xlat0.xy, 0.0).xy;
    u_xlat4.x = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat16_1.x = _AniThreshold * 1.20000005 + -0.200000003;
    u_xlat4.x = (-u_xlat4.x) + u_xlat16_1.x;
    u_xlat4.x = abs(u_xlat4.x) + 0.769999981;
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat16_1.x = u_xlat0.y + -1.0;
    u_xlat16_1.x = _AddNoiseG * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _VertexAniDirXYZStrW.xyz;
    u_xlat16_1.xyz = u_xlat4.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * _VertexAniDirXYZStrW.www + in_POSITION0.xyz;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	vec4 _Mask_SetUV2_ST;
uniform 	mediump float _AniThreshold;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _Mask_SetUV2_ST.xy + _Mask_SetUV2_ST.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1.x = _AniThreshold * 1.20000005 + -0.200000003;
    u_xlat0.x = (-u_xlat0.x) + u_xlat16_1.x;
    u_xlat0.x = abs(u_xlat0.x) + 0.769999981;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    SV_Target0.w = u_xlat0.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.yyy * _MainColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 _Mask_SetUV2_ST;
uniform 	mediump float _AniThreshold;
uniform 	mediump float _AddNoiseG;
uniform 	mediump vec4 _VertexAniDirXYZStrW;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Mask_SetUV2;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat4;
int u_xlati6;
void main()
{
    u_xlat0.xy = in_TEXCOORD1.xy * _Mask_SetUV2_ST.xy + _Mask_SetUV2_ST.zw;
    u_xlat4.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = textureLod(_Mask_SetUV2, u_xlat0.xy, 0.0).xy;
    u_xlat4.x = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat16_1.x = _AniThreshold * 1.20000005 + -0.200000003;
    u_xlat4.x = (-u_xlat4.x) + u_xlat16_1.x;
    u_xlat4.x = abs(u_xlat4.x) + 0.769999981;
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat16_1.x = u_xlat0.y + -1.0;
    u_xlat16_1.x = _AddNoiseG * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _VertexAniDirXYZStrW.xyz;
    u_xlat16_1.xyz = u_xlat4.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * _VertexAniDirXYZStrW.www + in_POSITION0.xyz;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	vec4 _Mask_SetUV2_ST;
uniform 	mediump float _AniThreshold;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _Mask_SetUV2_ST.xy + _Mask_SetUV2_ST.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1.x = _AniThreshold * 1.20000005 + -0.200000003;
    u_xlat0.x = (-u_xlat0.x) + u_xlat16_1.x;
    u_xlat0.x = abs(u_xlat0.x) + 0.769999981;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    SV_Target0.w = u_xlat0.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.yyy * _MainColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 _Mask_SetUV2_ST;
uniform 	mediump float _AniThreshold;
uniform 	mediump float _AddNoiseG;
uniform 	mediump vec4 _VertexAniDirXYZStrW;
uniform lowp sampler2D _Mask_SetUV2;
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
mediump vec3 u_xlat16_1;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = in_TEXCOORD1.xy * _Mask_SetUV2_ST.xy + _Mask_SetUV2_ST.zw;
    u_xlat4.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = textureLod(_Mask_SetUV2, u_xlat0.xy, 0.0).xy;
    u_xlat4.x = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat16_1.x = _AniThreshold * 1.20000005 + -0.200000003;
    u_xlat4.x = (-u_xlat4.x) + u_xlat16_1.x;
    u_xlat4.x = abs(u_xlat4.x) + 0.769999981;
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat16_1.x = u_xlat0.y + -1.0;
    u_xlat16_1.x = _AddNoiseG * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _VertexAniDirXYZStrW.xyz;
    u_xlat16_1.xyz = u_xlat4.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * _VertexAniDirXYZStrW.www + in_POSITION0.xyz;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	vec4 _Mask_SetUV2_ST;
uniform 	mediump float _AniThreshold;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD1.xy * _Mask_SetUV2_ST.xy + _Mask_SetUV2_ST.zw;
    u_xlat16_1.x = _AniThreshold * 1.20000005 + -0.200000003;
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x + (-u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + 0.769999981;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat16_1.xyz = vs_TEXCOORD0.yyy * _MainColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 _Mask_SetUV2_ST;
uniform 	mediump float _AniThreshold;
uniform 	mediump float _AddNoiseG;
uniform 	mediump vec4 _VertexAniDirXYZStrW;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Mask_SetUV2;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat4;
int u_xlati6;
void main()
{
    u_xlat0.xy = in_TEXCOORD1.xy * _Mask_SetUV2_ST.xy + _Mask_SetUV2_ST.zw;
    u_xlat4.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = textureLod(_Mask_SetUV2, u_xlat0.xy, 0.0).xy;
    u_xlat4.x = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat16_1.x = _AniThreshold * 1.20000005 + -0.200000003;
    u_xlat4.x = (-u_xlat4.x) + u_xlat16_1.x;
    u_xlat4.x = abs(u_xlat4.x) + 0.769999981;
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat16_1.x = u_xlat0.y + -1.0;
    u_xlat16_1.x = _AddNoiseG * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _VertexAniDirXYZStrW.xyz;
    u_xlat16_1.xyz = u_xlat4.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * _VertexAniDirXYZStrW.www + in_POSITION0.xyz;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	vec4 _Mask_SetUV2_ST;
uniform 	mediump float _AniThreshold;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD1.xy * _Mask_SetUV2_ST.xy + _Mask_SetUV2_ST.zw;
    u_xlat16_1.x = _AniThreshold * 1.20000005 + -0.200000003;
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x + (-u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) + 0.769999981;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat16_1.xyz = vs_TEXCOORD0.yyy * _MainColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    SV_Target0.w = u_xlat0.x;
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
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
}
}
 Pass {
  Name "DISTORTIONVECTORS"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DISTORTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 87811
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 _Mask_SetUV2_ST;
uniform 	mediump float _AddNoiseG;
uniform 	mediump vec4 _VertexAniDirXYZStrW;
uniform 	mediump float _AniThreshold;
uniform lowp sampler2D _Mask_SetUV2;
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
mediump vec3 u_xlat16_1;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = in_TEXCOORD1.xy * _Mask_SetUV2_ST.xy + _Mask_SetUV2_ST.zw;
    u_xlat4.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = textureLod(_Mask_SetUV2, u_xlat0.xy, 0.0).xy;
    u_xlat4.x = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat16_1.x = _AniThreshold * 1.20000005 + -0.200000003;
    u_xlat4.x = (-u_xlat4.x) + u_xlat16_1.x;
    u_xlat4.x = abs(u_xlat4.x) + 0.769999981;
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat16_1.x = u_xlat0.y + -1.0;
    u_xlat16_1.x = _AddNoiseG * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _VertexAniDirXYZStrW.xyz;
    u_xlat16_1.xyz = u_xlat4.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * _VertexAniDirXYZStrW.www + in_POSITION0.xyz;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 _Mask_SetUV2_ST;
uniform 	mediump float _AddNoiseG;
uniform 	mediump vec4 _VertexAniDirXYZStrW;
uniform 	mediump float _AniThreshold;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Mask_SetUV2;
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
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat4;
int u_xlati6;
void main()
{
    u_xlat0.xy = in_TEXCOORD1.xy * _Mask_SetUV2_ST.xy + _Mask_SetUV2_ST.zw;
    u_xlat4.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = textureLod(_Mask_SetUV2, u_xlat0.xy, 0.0).xy;
    u_xlat4.x = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat16_1.x = _AniThreshold * 1.20000005 + -0.200000003;
    u_xlat4.x = (-u_xlat4.x) + u_xlat16_1.x;
    u_xlat4.x = abs(u_xlat4.x) + 0.769999981;
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat16_1.x = u_xlat0.y + -1.0;
    u_xlat16_1.x = _AddNoiseG * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _VertexAniDirXYZStrW.xyz;
    u_xlat16_1.xyz = u_xlat4.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * _VertexAniDirXYZStrW.www + in_POSITION0.xyz;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
  GpuProgramID 181752
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	vec4 _Mask_SetUV2_ST;
uniform 	mediump float _AniThreshold;
uniform 	mediump float _AddNoiseG;
uniform 	mediump vec4 _VertexAniDirXYZStrW;
uniform lowp sampler2D _Mask_SetUV2;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
float u_xlat2;
vec2 u_xlat6;
void main()
{
    u_xlat0.xy = in_TEXCOORD1.xy * _Mask_SetUV2_ST.xy + _Mask_SetUV2_ST.zw;
    u_xlat6.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = textureLod(_Mask_SetUV2, u_xlat0.xy, 0.0).xy;
    u_xlat6.x = dot(u_xlat6.xy, u_xlat6.xy);
    u_xlat6.x = sqrt(u_xlat6.x);
    u_xlat16_1.x = _AniThreshold * 1.20000005 + -0.200000003;
    u_xlat6.x = (-u_xlat6.x) + u_xlat16_1.x;
    u_xlat6.x = abs(u_xlat6.x) + 0.769999981;
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat16_1.x = u_xlat0.y + -1.0;
    u_xlat16_1.x = _AddNoiseG * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _VertexAniDirXYZStrW.xyz;
    u_xlat16_1.xyz = u_xlat6.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * _VertexAniDirXYZStrW.www + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2 = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat2 * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _Mask_SetUV2_ST;
uniform 	mediump float _AniThreshold;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
ivec2 u_xlati2;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _Mask_SetUV2_ST.xy + _Mask_SetUV2_ST.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1 = _AniThreshold * 1.20000005 + -0.200000003;
    u_xlat0.x = (-u_xlat0.x) + u_xlat16_1;
    u_xlat0.x = abs(u_xlat0.x) + 0.769999981;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat16_1 = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati2.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	vec4 _Mask_SetUV2_ST;
uniform 	mediump float _AniThreshold;
uniform 	mediump float _AddNoiseG;
uniform 	mediump vec4 _VertexAniDirXYZStrW;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Mask_SetUV2;
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
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
float u_xlat2;
vec2 u_xlat6;
int u_xlati9;
void main()
{
    u_xlat0.xy = in_TEXCOORD1.xy * _Mask_SetUV2_ST.xy + _Mask_SetUV2_ST.zw;
    u_xlat6.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = textureLod(_Mask_SetUV2, u_xlat0.xy, 0.0).xy;
    u_xlat6.x = dot(u_xlat6.xy, u_xlat6.xy);
    u_xlat6.x = sqrt(u_xlat6.x);
    u_xlat16_1.x = _AniThreshold * 1.20000005 + -0.200000003;
    u_xlat6.x = (-u_xlat6.x) + u_xlat16_1.x;
    u_xlat6.x = abs(u_xlat6.x) + 0.769999981;
    u_xlat6.x = (-u_xlat6.x) + 1.0;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat16_1.x = u_xlat0.y + -1.0;
    u_xlat16_1.x = _AddNoiseG * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _VertexAniDirXYZStrW.xyz;
    u_xlat16_1.xyz = u_xlat6.xxx * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * _VertexAniDirXYZStrW.www + in_POSITION0.xyz;
    u_xlati9 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati9 = u_xlati9 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati9 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2 = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat2 * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _Mask_SetUV2_ST;
uniform 	mediump float _AniThreshold;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
ivec2 u_xlati2;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _Mask_SetUV2_ST.xy + _Mask_SetUV2_ST.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1 = _AniThreshold * 1.20000005 + -0.200000003;
    u_xlat0.x = (-u_xlat0.x) + u_xlat16_1;
    u_xlat0.x = abs(u_xlat0.x) + 0.769999981;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat16_1 = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati2.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
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
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}