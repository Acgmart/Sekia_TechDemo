//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/UnityBuiltin/Window_Opacity" {
Properties {
_OpacityMask ("Opacity Mask", 2D) = "white" { }
_Color1 ("Color 1", Color) = (0.8823529,0.8823529,0.8823529,0)
_NVint ("N.V int", Float) = 0
_NVfalloff ("N.V falloff", Float) = 0
_TextureSample6 ("Texture Sample 6", Cube) = "white" { }
_TextureSample5 ("Texture Sample 5", Cube) = "white" { }
_TextureSample0 ("Texture Sample 0", Cube) = "white" { }
_Float4 ("Float 4", Range(-10, 10)) = 0
_CubePower ("Cube Power", Range(-10, 10)) = 0
_cubeoffet ("cube offet", Range(0, 1)) = 0
_Float8 ("Float 8", Range(0, 0.01)) = 0
_Fade ("Fade", Float) = 0
_Falloff ("Falloff", Float) = 0
_cubeint ("cube int", Range(0, 1)) = 0
_R_Mask_Intensity ("R_Mask_Intensity", Range(0, 1)) = 0
_Float3 ("Float 3", Range(0, 1)) = 0
_Float7 ("Float 7", Float) = 0
_DayColor ("DayColor", Color) = (0,0,0,0)
_texcoord ("", 2D) = "white" { }
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "DebugView" = "On" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 37792
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
float u_xlat12;
float u_xlat18;
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
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_2.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_2.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_2.x);
    u_xlat16_3 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_2.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat6 * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat18 = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat18;
    vs_TEXCOORD3.z = (-u_xlat18);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat5.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat5.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat5.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat5.xyz);
    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump float _Float7;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _R_Mask_Intensity;
uniform 	mediump float _Float3;
uniform 	mediump float _CubePower;
uniform 	mediump float _Float8;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _cubeint;
uniform 	mediump float _Float4;
uniform 	mediump float _Falloff;
uniform 	mediump float _Fade;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Color1;
uniform lowp sampler2D _OpacityMask;
uniform lowp samplerCube _TextureSample5;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_8;
float u_xlat18;
mediump float u_xlat16_18;
float u_xlat19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat18 = dot((-u_xlat0.xyz), vs_TEXCOORD4.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat1.xyz = vs_TEXCOORD4.xyz * (-vec3(u_xlat18)) + (-u_xlat0.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat18) + vec3(vec3(_Float8, _Float8, _Float8));
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat10_3.xyz = texture(_TextureSample6, u_xlat16_2.xyz).xyz;
    u_xlat10_4.xyz = texture(_TextureSample5, u_xlat1.xyz).xyz;
    u_xlat10_1.xyz = texture(_TextureSample0, u_xlat1.xyz, _Float4).xyz;
    u_xlat16_5.xyz = (-u_xlat10_3.xyz) + u_xlat10_4.xyz;
    u_xlat16_3.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_5.xyz + u_xlat10_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_3.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_CubePower);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_CubePower);
    u_xlat16_3.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = (-u_xlat10_1.xyz) + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(0.200000003, 0.200000003, 0.200000003) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.514705896, 0.514705896, 0.514705896) + u_xlat16_3.xyz;
    u_xlat18 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat18 = u_xlat18 + (-_Fade);
    u_xlat16_20 = _Falloff * 5.0;
    u_xlat16_20 = u_xlat18 / u_xlat16_20;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vec3(u_xlat16_20) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
    u_xlat3.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_3.xy = texture(_OpacityMask, u_xlat3.xy).xy;
    u_xlat16_2.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_18 = (-u_xlat10_3.y) + 1.0;
    u_xlat16_18 = u_xlat16_18 + (-_Float7);
    u_xlat16_1.xyz = u_xlat16_2.xxx * (-u_xlat16_1.xyz) + u_xlat16_1.xyz;
    u_xlat16_8.xyz = (-_DayColor.xyz) + _Color1.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + _DayColor.xyz;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + u_xlat16_8.xyz;
    u_xlat19 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat16_18 + _Float7;
    u_xlat0.x = _R_Mask_Intensity * u_xlat16_2.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Float3;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.x;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
float u_xlat18;
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
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat2.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    u_xlat1 = u_xlat6.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat6.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat6.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat7;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
    vs_TEXCOORD3.z = (-u_xlat1.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat6.xyz;
    u_xlat6.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    vs_TEXCOORD5.xyz = u_xlat6.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat6.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat6.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat6.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump float _Float7;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _R_Mask_Intensity;
uniform 	mediump float _Float3;
uniform 	mediump float _CubePower;
uniform 	mediump float _Float8;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _cubeint;
uniform 	mediump float _Float4;
uniform 	mediump float _Falloff;
uniform 	mediump float _Fade;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Color1;
uniform lowp sampler2D _OpacityMask;
uniform lowp samplerCube _TextureSample5;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_8;
float u_xlat18;
mediump float u_xlat16_18;
float u_xlat19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat18 = dot((-u_xlat0.xyz), vs_TEXCOORD4.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat1.xyz = vs_TEXCOORD4.xyz * (-vec3(u_xlat18)) + (-u_xlat0.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat18) + vec3(vec3(_Float8, _Float8, _Float8));
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat10_3.xyz = texture(_TextureSample6, u_xlat16_2.xyz).xyz;
    u_xlat10_4.xyz = texture(_TextureSample5, u_xlat1.xyz).xyz;
    u_xlat10_1.xyz = texture(_TextureSample0, u_xlat1.xyz, _Float4).xyz;
    u_xlat16_5.xyz = (-u_xlat10_3.xyz) + u_xlat10_4.xyz;
    u_xlat16_3.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_5.xyz + u_xlat10_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_3.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_CubePower);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_CubePower);
    u_xlat16_3.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = (-u_xlat10_1.xyz) + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(0.200000003, 0.200000003, 0.200000003) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.514705896, 0.514705896, 0.514705896) + u_xlat16_3.xyz;
    u_xlat18 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat18 = u_xlat18 + (-_Fade);
    u_xlat16_20 = _Falloff * 5.0;
    u_xlat16_20 = u_xlat18 / u_xlat16_20;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vec3(u_xlat16_20) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
    u_xlat3.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_3.xy = texture(_OpacityMask, u_xlat3.xy).xy;
    u_xlat16_2.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_18 = (-u_xlat10_3.y) + 1.0;
    u_xlat16_18 = u_xlat16_18 + (-_Float7);
    u_xlat16_1.xyz = u_xlat16_2.xxx * (-u_xlat16_1.xyz) + u_xlat16_1.xyz;
    u_xlat16_8.xyz = (-_DayColor.xyz) + _Color1.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + _DayColor.xyz;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + u_xlat16_8.xyz;
    u_xlat19 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat16_18 + _Float7;
    u_xlat0.x = _R_Mask_Intensity * u_xlat16_2.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Float3;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.x;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
float u_xlat12;
float u_xlat18;
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
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_2.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_2.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_2.x);
    u_xlat16_3 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_2.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat6 * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat18 = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat18;
    vs_TEXCOORD3.z = (-u_xlat18);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat5.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat5.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat5.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat5.xyz);
    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _Float7;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _R_Mask_Intensity;
uniform 	mediump float _Float3;
uniform 	mediump float _CubePower;
uniform 	mediump float _Float8;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _cubeint;
uniform 	mediump float _Float4;
uniform 	mediump float _Falloff;
uniform 	mediump float _Fade;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Color1;
uniform lowp sampler2D _OpacityMask;
uniform lowp samplerCube _TextureSample5;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_9;
float u_xlat12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat0.xy = texture(_OpacityMask, u_xlat0.xy).xy;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
    u_xlat12 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD5.xyz;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat6.xy = vec2((-u_xlat0.y) + float(1.0), (-u_xlat0.z) + float(1.0));
    u_xlat12 = u_xlat6.y * _NVint;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _NVfalloff;
    u_xlat12 = exp2(u_xlat12);
    u_xlat6.x = u_xlat6.x + (-_Float7);
    u_xlat6.x = u_xlat12 * u_xlat6.x + _Float7;
    u_xlat16_3.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = _R_Mask_Intensity * u_xlat16_3.x + u_xlat6.x;
    u_xlat0.x = u_xlat0.x + _Float3;
    u_xlat6.x = dot((-u_xlat2.xyz), vs_TEXCOORD4.xyz);
    u_xlat6.x = u_xlat6.x + u_xlat6.x;
    u_xlat6.xyz = vs_TEXCOORD4.xyz * (-u_xlat6.xxx) + (-u_xlat2.xyz);
    u_xlat1.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat7.xyz = u_xlat6.xyz * u_xlat1.xxx;
    u_xlat16_9.xyz = u_xlat6.xyz * u_xlat1.xxx + vec3(vec3(_Float8, _Float8, _Float8));
    u_xlat10_6.xyz = texture(_TextureSample5, u_xlat7.xyz).xyz;
    u_xlat10_2.xyz = texture(_TextureSample6, u_xlat16_9.xyz).xyz;
    u_xlat16_4.xyz = u_xlat10_6.xyz + (-u_xlat10_2.xyz);
    u_xlat16_2.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_4.xyz + u_xlat10_2.xyz;
    u_xlat16_9.xyz = max(u_xlat16_2.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_9.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_CubePower);
    u_xlat16_9.xyz = exp2(u_xlat16_9.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_CubePower);
    u_xlat16_2.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_9.xyz) + u_xlat16_9.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat10_1.xyz = texture(_TextureSample0, u_xlat7.xyz, _Float4).xyz;
    u_xlat16_6.xyz = u_xlat10_6.xyz + (-u_xlat10_1.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.200000003, 0.200000003, 0.200000003) + u_xlat10_1.xyz;
    u_xlat16_9.xyz = (-u_xlat16_2.xyz) + u_xlat16_6.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(0.514705896, 0.514705896, 0.514705896) + u_xlat16_2.xyz;
    u_xlat6.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat6.x = u_xlat6.x + (-_Fade);
    u_xlat16_5 = _Falloff * 5.0;
    u_xlat16_5 = u_xlat6.x / u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_5) * (-u_xlat16_9.xyz) + u_xlat16_9.xyz;
    u_xlat16_6.xyz = u_xlat16_3.xxx * (-u_xlat16_6.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.xyz = (-_DayColor.xyz) + _Color1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5) + _DayColor.xyz;
    u_xlat16_3.xyz = (-u_xlat16_6.xyz) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
float u_xlat18;
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
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat2.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    u_xlat1 = u_xlat6.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat6.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat6.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat7;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
    vs_TEXCOORD3.z = (-u_xlat1.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat6.xyz;
    u_xlat6.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    vs_TEXCOORD5.xyz = u_xlat6.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat6.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat6.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat6.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _Float7;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _R_Mask_Intensity;
uniform 	mediump float _Float3;
uniform 	mediump float _CubePower;
uniform 	mediump float _Float8;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _cubeint;
uniform 	mediump float _Float4;
uniform 	mediump float _Falloff;
uniform 	mediump float _Fade;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Color1;
uniform lowp sampler2D _OpacityMask;
uniform lowp samplerCube _TextureSample5;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_9;
float u_xlat12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat0.xy = texture(_OpacityMask, u_xlat0.xy).xy;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
    u_xlat12 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD5.xyz;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat6.xy = vec2((-u_xlat0.y) + float(1.0), (-u_xlat0.z) + float(1.0));
    u_xlat12 = u_xlat6.y * _NVint;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _NVfalloff;
    u_xlat12 = exp2(u_xlat12);
    u_xlat6.x = u_xlat6.x + (-_Float7);
    u_xlat6.x = u_xlat12 * u_xlat6.x + _Float7;
    u_xlat16_3.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = _R_Mask_Intensity * u_xlat16_3.x + u_xlat6.x;
    u_xlat0.x = u_xlat0.x + _Float3;
    u_xlat6.x = dot((-u_xlat2.xyz), vs_TEXCOORD4.xyz);
    u_xlat6.x = u_xlat6.x + u_xlat6.x;
    u_xlat6.xyz = vs_TEXCOORD4.xyz * (-u_xlat6.xxx) + (-u_xlat2.xyz);
    u_xlat1.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat7.xyz = u_xlat6.xyz * u_xlat1.xxx;
    u_xlat16_9.xyz = u_xlat6.xyz * u_xlat1.xxx + vec3(vec3(_Float8, _Float8, _Float8));
    u_xlat10_6.xyz = texture(_TextureSample5, u_xlat7.xyz).xyz;
    u_xlat10_2.xyz = texture(_TextureSample6, u_xlat16_9.xyz).xyz;
    u_xlat16_4.xyz = u_xlat10_6.xyz + (-u_xlat10_2.xyz);
    u_xlat16_2.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_4.xyz + u_xlat10_2.xyz;
    u_xlat16_9.xyz = max(u_xlat16_2.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_9.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_CubePower);
    u_xlat16_9.xyz = exp2(u_xlat16_9.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_CubePower);
    u_xlat16_2.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_9.xyz) + u_xlat16_9.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat10_1.xyz = texture(_TextureSample0, u_xlat7.xyz, _Float4).xyz;
    u_xlat16_6.xyz = u_xlat10_6.xyz + (-u_xlat10_1.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.200000003, 0.200000003, 0.200000003) + u_xlat10_1.xyz;
    u_xlat16_9.xyz = (-u_xlat16_2.xyz) + u_xlat16_6.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(0.514705896, 0.514705896, 0.514705896) + u_xlat16_2.xyz;
    u_xlat6.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat6.x = u_xlat6.x + (-_Fade);
    u_xlat16_5 = _Falloff * 5.0;
    u_xlat16_5 = u_xlat6.x / u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_5) * (-u_xlat16_9.xyz) + u_xlat16_9.xyz;
    u_xlat16_6.xyz = u_xlat16_3.xxx * (-u_xlat16_6.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.xyz = (-_DayColor.xyz) + _Color1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5) + _DayColor.xyz;
    u_xlat16_3.xyz = (-u_xlat16_6.xyz) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
float u_xlat12;
float u_xlat18;
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
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_2.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_2.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_2.x);
    u_xlat16_3 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_2.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat6 * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat18 = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat18;
    vs_TEXCOORD3.z = (-u_xlat18);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat5.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat5.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat5.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat5.xyz);
    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump float _Float7;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _R_Mask_Intensity;
uniform 	mediump float _Float3;
uniform 	mediump float _CubePower;
uniform 	mediump float _Float8;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _cubeint;
uniform 	mediump float _Float4;
uniform 	mediump float _Falloff;
uniform 	mediump float _Fade;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Color1;
uniform lowp sampler2D _OpacityMask;
uniform lowp samplerCube _TextureSample5;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_8;
float u_xlat18;
mediump float u_xlat16_18;
float u_xlat19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat18 = dot((-u_xlat0.xyz), vs_TEXCOORD4.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat1.xyz = vs_TEXCOORD4.xyz * (-vec3(u_xlat18)) + (-u_xlat0.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat18) + vec3(vec3(_Float8, _Float8, _Float8));
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat10_3.xyz = texture(_TextureSample6, u_xlat16_2.xyz).xyz;
    u_xlat10_4.xyz = texture(_TextureSample5, u_xlat1.xyz).xyz;
    u_xlat10_1.xyz = texture(_TextureSample0, u_xlat1.xyz, _Float4).xyz;
    u_xlat16_5.xyz = (-u_xlat10_3.xyz) + u_xlat10_4.xyz;
    u_xlat16_3.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_5.xyz + u_xlat10_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_3.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_CubePower);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_CubePower);
    u_xlat16_3.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = (-u_xlat10_1.xyz) + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(0.200000003, 0.200000003, 0.200000003) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.514705896, 0.514705896, 0.514705896) + u_xlat16_3.xyz;
    u_xlat18 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat18 = u_xlat18 + (-_Fade);
    u_xlat16_20 = _Falloff * 5.0;
    u_xlat16_20 = u_xlat18 / u_xlat16_20;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vec3(u_xlat16_20) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
    u_xlat3.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_3.xy = texture(_OpacityMask, u_xlat3.xy).xy;
    u_xlat16_2.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_18 = (-u_xlat10_3.y) + 1.0;
    u_xlat16_18 = u_xlat16_18 + (-_Float7);
    u_xlat16_1.xyz = u_xlat16_2.xxx * (-u_xlat16_1.xyz) + u_xlat16_1.xyz;
    u_xlat16_8.xyz = (-_DayColor.xyz) + _Color1.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + _DayColor.xyz;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + u_xlat16_8.xyz;
    u_xlat19 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat16_18 + _Float7;
    u_xlat0.x = _R_Mask_Intensity * u_xlat16_2.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Float3;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
float u_xlat18;
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
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat2.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    u_xlat1 = u_xlat6.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat6.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat6.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat7;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
    vs_TEXCOORD3.z = (-u_xlat1.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat6.xyz;
    u_xlat6.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    vs_TEXCOORD5.xyz = u_xlat6.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat6.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat6.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat6.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump float _Float7;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _R_Mask_Intensity;
uniform 	mediump float _Float3;
uniform 	mediump float _CubePower;
uniform 	mediump float _Float8;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _cubeint;
uniform 	mediump float _Float4;
uniform 	mediump float _Falloff;
uniform 	mediump float _Fade;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Color1;
uniform lowp sampler2D _OpacityMask;
uniform lowp samplerCube _TextureSample5;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_8;
float u_xlat18;
mediump float u_xlat16_18;
float u_xlat19;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat18 = dot((-u_xlat0.xyz), vs_TEXCOORD4.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat1.xyz = vs_TEXCOORD4.xyz * (-vec3(u_xlat18)) + (-u_xlat0.xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat18) + vec3(vec3(_Float8, _Float8, _Float8));
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat10_3.xyz = texture(_TextureSample6, u_xlat16_2.xyz).xyz;
    u_xlat10_4.xyz = texture(_TextureSample5, u_xlat1.xyz).xyz;
    u_xlat10_1.xyz = texture(_TextureSample0, u_xlat1.xyz, _Float4).xyz;
    u_xlat16_5.xyz = (-u_xlat10_3.xyz) + u_xlat10_4.xyz;
    u_xlat16_3.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_5.xyz + u_xlat10_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_3.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_CubePower);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_CubePower);
    u_xlat16_3.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = (-u_xlat10_1.xyz) + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(0.200000003, 0.200000003, 0.200000003) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.514705896, 0.514705896, 0.514705896) + u_xlat16_3.xyz;
    u_xlat18 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat18 = u_xlat18 + (-_Fade);
    u_xlat16_20 = _Falloff * 5.0;
    u_xlat16_20 = u_xlat18 / u_xlat16_20;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vec3(u_xlat16_20) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
    u_xlat3.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_3.xy = texture(_OpacityMask, u_xlat3.xy).xy;
    u_xlat16_2.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_18 = (-u_xlat10_3.y) + 1.0;
    u_xlat16_18 = u_xlat16_18 + (-_Float7);
    u_xlat16_1.xyz = u_xlat16_2.xxx * (-u_xlat16_1.xyz) + u_xlat16_1.xyz;
    u_xlat16_8.xyz = (-_DayColor.xyz) + _Color1.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5) + _DayColor.xyz;
    u_xlat16_8.xyz = (-u_xlat16_1.xyz) + u_xlat16_8.xyz;
    u_xlat19 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat16_18 + _Float7;
    u_xlat0.x = _R_Mask_Intensity * u_xlat16_2.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Float3;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
float u_xlat12;
float u_xlat18;
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
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_2.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_2.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_2.x);
    u_xlat16_3 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_2.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat6 * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat18 = u_xlat2.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat2.x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat2.z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat2.w + u_xlat18;
    vs_TEXCOORD3.z = (-u_xlat18);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat5.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD5.xyz = u_xlat0.xxx * u_xlat5.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat5.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat5.xyz);
    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _Float7;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _R_Mask_Intensity;
uniform 	mediump float _Float3;
uniform 	mediump float _CubePower;
uniform 	mediump float _Float8;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _cubeint;
uniform 	mediump float _Float4;
uniform 	mediump float _Falloff;
uniform 	mediump float _Fade;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Color1;
uniform lowp sampler2D _OpacityMask;
uniform lowp samplerCube _TextureSample5;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_9;
float u_xlat12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat0.xy = texture(_OpacityMask, u_xlat0.xy).xy;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
    u_xlat12 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD5.xyz;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat6.xy = vec2((-u_xlat0.y) + float(1.0), (-u_xlat0.z) + float(1.0));
    u_xlat12 = u_xlat6.y * _NVint;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _NVfalloff;
    u_xlat12 = exp2(u_xlat12);
    u_xlat6.x = u_xlat6.x + (-_Float7);
    u_xlat6.x = u_xlat12 * u_xlat6.x + _Float7;
    u_xlat16_3.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = _R_Mask_Intensity * u_xlat16_3.x + u_xlat6.x;
    u_xlat0.x = u_xlat0.x + _Float3;
    u_xlat6.x = dot((-u_xlat2.xyz), vs_TEXCOORD4.xyz);
    u_xlat6.x = u_xlat6.x + u_xlat6.x;
    u_xlat6.xyz = vs_TEXCOORD4.xyz * (-u_xlat6.xxx) + (-u_xlat2.xyz);
    u_xlat1.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat7.xyz = u_xlat6.xyz * u_xlat1.xxx;
    u_xlat16_9.xyz = u_xlat6.xyz * u_xlat1.xxx + vec3(vec3(_Float8, _Float8, _Float8));
    u_xlat10_6.xyz = texture(_TextureSample5, u_xlat7.xyz).xyz;
    u_xlat10_2.xyz = texture(_TextureSample6, u_xlat16_9.xyz).xyz;
    u_xlat16_4.xyz = u_xlat10_6.xyz + (-u_xlat10_2.xyz);
    u_xlat16_2.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_4.xyz + u_xlat10_2.xyz;
    u_xlat16_9.xyz = max(u_xlat16_2.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_9.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_CubePower);
    u_xlat16_9.xyz = exp2(u_xlat16_9.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_CubePower);
    u_xlat16_2.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_9.xyz) + u_xlat16_9.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat10_1.xyz = texture(_TextureSample0, u_xlat7.xyz, _Float4).xyz;
    u_xlat16_6.xyz = u_xlat10_6.xyz + (-u_xlat10_1.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.200000003, 0.200000003, 0.200000003) + u_xlat10_1.xyz;
    u_xlat16_9.xyz = (-u_xlat16_2.xyz) + u_xlat16_6.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(0.514705896, 0.514705896, 0.514705896) + u_xlat16_2.xyz;
    u_xlat6.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat6.x = u_xlat6.x + (-_Fade);
    u_xlat16_5 = _Falloff * 5.0;
    u_xlat16_5 = u_xlat6.x / u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_5) * (-u_xlat16_9.xyz) + u_xlat16_9.xyz;
    u_xlat16_6.xyz = u_xlat16_3.xxx * (-u_xlat16_6.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.xyz = (-_DayColor.xyz) + _Color1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5) + _DayColor.xyz;
    u_xlat16_3.xyz = (-u_xlat16_6.xyz) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
float u_xlat18;
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
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat2.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.w = u_xlat6.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    u_xlat1 = u_xlat6.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat6.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat6.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat7;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
    vs_TEXCOORD3.z = (-u_xlat1.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat6.xyz;
    u_xlat6.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    vs_TEXCOORD5.xyz = u_xlat6.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat6.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat6.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat6.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _Float7;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _R_Mask_Intensity;
uniform 	mediump float _Float3;
uniform 	mediump float _CubePower;
uniform 	mediump float _Float8;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _cubeint;
uniform 	mediump float _Float4;
uniform 	mediump float _Falloff;
uniform 	mediump float _Fade;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Color1;
uniform lowp sampler2D _OpacityMask;
uniform lowp samplerCube _TextureSample5;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
lowp vec3 u_xlat10_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_9;
float u_xlat12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat0.xy = texture(_OpacityMask, u_xlat0.xy).xy;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
    u_xlat12 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD5.xyz;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat6.xy = vec2((-u_xlat0.y) + float(1.0), (-u_xlat0.z) + float(1.0));
    u_xlat12 = u_xlat6.y * _NVint;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _NVfalloff;
    u_xlat12 = exp2(u_xlat12);
    u_xlat6.x = u_xlat6.x + (-_Float7);
    u_xlat6.x = u_xlat12 * u_xlat6.x + _Float7;
    u_xlat16_3.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = _R_Mask_Intensity * u_xlat16_3.x + u_xlat6.x;
    u_xlat0.x = u_xlat0.x + _Float3;
    u_xlat6.x = dot((-u_xlat2.xyz), vs_TEXCOORD4.xyz);
    u_xlat6.x = u_xlat6.x + u_xlat6.x;
    u_xlat6.xyz = vs_TEXCOORD4.xyz * (-u_xlat6.xxx) + (-u_xlat2.xyz);
    u_xlat1.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat7.xyz = u_xlat6.xyz * u_xlat1.xxx;
    u_xlat16_9.xyz = u_xlat6.xyz * u_xlat1.xxx + vec3(vec3(_Float8, _Float8, _Float8));
    u_xlat10_6.xyz = texture(_TextureSample5, u_xlat7.xyz).xyz;
    u_xlat10_2.xyz = texture(_TextureSample6, u_xlat16_9.xyz).xyz;
    u_xlat16_4.xyz = u_xlat10_6.xyz + (-u_xlat10_2.xyz);
    u_xlat16_2.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_4.xyz + u_xlat10_2.xyz;
    u_xlat16_9.xyz = max(u_xlat16_2.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_9.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_CubePower);
    u_xlat16_9.xyz = exp2(u_xlat16_9.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_CubePower);
    u_xlat16_2.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_9.xyz) + u_xlat16_9.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat10_1.xyz = texture(_TextureSample0, u_xlat7.xyz, _Float4).xyz;
    u_xlat16_6.xyz = u_xlat10_6.xyz + (-u_xlat10_1.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.200000003, 0.200000003, 0.200000003) + u_xlat10_1.xyz;
    u_xlat16_9.xyz = (-u_xlat16_2.xyz) + u_xlat16_6.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(0.514705896, 0.514705896, 0.514705896) + u_xlat16_2.xyz;
    u_xlat6.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat6.x = u_xlat6.x + (-_Fade);
    u_xlat16_5 = _Falloff * 5.0;
    u_xlat16_5 = u_xlat6.x / u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_5) * (-u_xlat16_9.xyz) + u_xlat16_9.xyz;
    u_xlat16_6.xyz = u_xlat16_3.xxx * (-u_xlat16_6.xyz) + u_xlat16_6.xyz;
    u_xlat16_3.xyz = (-_DayColor.xyz) + _Color1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5) + _DayColor.xyz;
    u_xlat16_3.xyz = (-u_xlat16_6.xyz) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
bool u_xlatb14;
float u_xlat16;
float u_xlat21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
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
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat14 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat22 = u_xlat14 * -1.44269502;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat22 / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_3.x = (u_xlatb14) ? u_xlat22 : 1.0;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = sqrt(u_xlat14);
    u_xlat22 = u_xlat14 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat22 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat22 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_10 = (u_xlatb22) ? u_xlat23 : 1.0;
    u_xlat22 = u_xlat14 * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat22 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat22 = u_xlat14 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat22) + 2.0;
    u_xlat16_10 = u_xlat22 * u_xlat16_10;
    u_xlat22 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat22 = u_xlat22 + 1.0;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat23 = (-u_xlat22) + 1.0;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat4.x);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat4.x;
#endif
    u_xlat9 = u_xlat14 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat14 + (-_HeigtFogRamp.w);
    u_xlat14 = u_xlat14 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9) + 2.0;
    u_xlat9 = u_xlat16 * u_xlat9;
    u_xlat16 = u_xlat9 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat9) + 2.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat4.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = vec3(u_xlat14) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat14 = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat23 * u_xlat14;
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz;
    u_xlat14 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat7 * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat7 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat7;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD5.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump float _Float7;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _R_Mask_Intensity;
uniform 	mediump float _Float3;
uniform 	mediump float _CubePower;
uniform 	mediump float _Float8;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _cubeint;
uniform 	mediump float _Float4;
uniform 	mediump float _Falloff;
uniform 	mediump float _Fade;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Color1;
uniform lowp sampler2D _OpacityMask;
uniform lowp samplerCube _TextureSample5;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
vec3 u_xlat8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
float u_xlat15;
float u_xlat21;
mediump float u_xlat16_21;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat21 = dot((-u_xlat0.xyz), vs_TEXCOORD4.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = vs_TEXCOORD4.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat21) + vec3(vec3(_Float8, _Float8, _Float8));
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat10_3.xyz = texture(_TextureSample6, u_xlat16_2.xyz).xyz;
    u_xlat10_4.xyz = texture(_TextureSample5, u_xlat1.xyz).xyz;
    u_xlat10_1.xyz = texture(_TextureSample0, u_xlat1.xyz, _Float4).xyz;
    u_xlat16_5.xyz = (-u_xlat10_3.xyz) + u_xlat10_4.xyz;
    u_xlat16_3.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_5.xyz + u_xlat10_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_3.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_CubePower);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_CubePower);
    u_xlat16_3.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = (-u_xlat10_1.xyz) + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(0.200000003, 0.200000003, 0.200000003) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.514705896, 0.514705896, 0.514705896) + u_xlat16_3.xyz;
    u_xlat21 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat21 = u_xlat21 + (-_Fade);
    u_xlat16_23 = _Falloff * 5.0;
    u_xlat16_23 = u_xlat21 / u_xlat16_23;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vec3(u_xlat16_23) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
    u_xlat3.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_3.xy = texture(_OpacityMask, u_xlat3.xy).xy;
    u_xlat16_2.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_21 = (-u_xlat10_3.y) + 1.0;
    u_xlat16_21 = u_xlat16_21 + (-_Float7);
    u_xlat16_1.xyz = u_xlat16_2.xxx * (-u_xlat16_1.xyz) + u_xlat16_1.xyz;
    u_xlat16_9.xyz = (-_DayColor.xyz) + _Color1.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(0.5, 0.5, 0.5) + _DayColor.xyz;
    u_xlat16_9.xyz = (-u_xlat16_1.xyz) + u_xlat16_9.xyz;
    u_xlat22 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat3.xyz = vec3(u_xlat22) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat16_21 + _Float7;
    u_xlat0.x = _R_Mask_Intensity * u_xlat16_2.x + u_xlat0.x;
    u_xlat0.w = u_xlat0.x + _Float3;
    u_xlat16_2.xyz = u_xlat0.www * u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = vs_TEXCOORD8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat22 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat3.x = u_xlat22 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_23 = (u_xlatb22) ? u_xlat3.x : 1.0;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat3.x = u_xlat22 * _HeigtFogParams.y;
    u_xlat16_23 = u_xlat16_23 * u_xlat3.x;
    u_xlat16_23 = exp2((-u_xlat16_23));
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat16_23 = max(u_xlat16_23, 0.0);
    u_xlat3.x = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat3.x * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3.x));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3.x);
#endif
    u_xlat16_6 = (u_xlatb3) ? u_xlat10.x : 1.0;
    u_xlat3.x = u_xlat22 * _HeigtFogParams2.y;
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_23 = u_xlat16_23 + u_xlat16_6;
    u_xlat3.x = u_xlat22 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat3.x) + 2.0;
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat3.x = u_xlat16_6 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat3.x = u_xlat3.x + 1.0;
    u_xlat16_23 = u_xlat16_23 * u_xlat3.x;
    u_xlat3.x = min(u_xlat16_23, _HeigtFogColBase.w);
    u_xlat10.x = (-u_xlat3.x) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat8.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat8.x;
#endif
    u_xlat8.x = u_xlat22 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat22 + (-_HeigtFogRamp.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat22 = (-u_xlat8.x) + 2.0;
    u_xlat8.x = u_xlat22 * u_xlat8.x;
    u_xlat22 = u_xlat8.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat22 : u_xlat8.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat8.x = vs_TEXCOORD8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat16_23 = (-u_xlat8.x) + 2.0;
    u_xlat16_23 = u_xlat8.x * u_xlat16_23;
    u_xlat4.xyz = vec3(u_xlat16_23) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat15) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat1.yzw = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1 = u_xlat10.xxxx * u_xlat1;
    u_xlat10.x = vs_TEXCOORD8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat10.xyz = u_xlat10.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat8.xyz = u_xlat10.xyz * u_xlat3.xxx + u_xlat1.yzw;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat16_2.xyz + u_xlat8.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
bool u_xlatb7;
float u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat15;
float u_xlat16;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = u_xlat7.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7.x = u_xlat2.y * _HeigtFogParams.x;
    u_xlat21 = u_xlat7.x * -1.44269502;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = u_xlat21 / u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7.x));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7.x);
#endif
    u_xlat16_3.x = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat21 = u_xlat7.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat21 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat15 = u_xlat21 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 / u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.00999999978<abs(u_xlat21));
#else
    u_xlatb21 = 0.00999999978<abs(u_xlat21);
#endif
    u_xlat16_10 = (u_xlatb21) ? u_xlat15 : 1.0;
    u_xlat21 = u_xlat7.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat21 = u_xlat7.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat21) + 2.0;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat21 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat21 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat15 = (-u_xlat21) + 1.0;
    u_xlat23 = _ProjectionParams.z * 0.999899983;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat23);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat23;
#endif
    u_xlat9.x = u_xlat7.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x + (-_HeigtFogRamp.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9.x) + 2.0;
    u_xlat9.x = u_xlat16 * u_xlat9.x;
    u_xlat16 = u_xlat9.x * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9.x = u_xlat7.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat7.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat9.x) + 2.0;
    u_xlat16_3.x = u_xlat9.x * u_xlat16_3.x;
    u_xlat9.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat9.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat9.xyz = u_xlat7.xxx * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat2.xxx * u_xlat9.xyz;
    u_xlat7.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat15 * u_xlat7.x;
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat9.xyz;
    vs_TEXCOORD0.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.w = u_xlat7.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat7.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat7.xyz;
    u_xlat1 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat8;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
    vs_TEXCOORD3.z = (-u_xlat1.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.xyz = (-u_xlat7.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat7.xyz;
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    vs_TEXCOORD5.xyz = u_xlat7.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat7.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat7.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat7.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump float _Float7;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _R_Mask_Intensity;
uniform 	mediump float _Float3;
uniform 	mediump float _CubePower;
uniform 	mediump float _Float8;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _cubeint;
uniform 	mediump float _Float4;
uniform 	mediump float _Falloff;
uniform 	mediump float _Fade;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Color1;
uniform lowp sampler2D _OpacityMask;
uniform lowp samplerCube _TextureSample5;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
vec3 u_xlat8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
float u_xlat15;
float u_xlat21;
mediump float u_xlat16_21;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat21 = dot((-u_xlat0.xyz), vs_TEXCOORD4.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = vs_TEXCOORD4.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat21) + vec3(vec3(_Float8, _Float8, _Float8));
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat10_3.xyz = texture(_TextureSample6, u_xlat16_2.xyz).xyz;
    u_xlat10_4.xyz = texture(_TextureSample5, u_xlat1.xyz).xyz;
    u_xlat10_1.xyz = texture(_TextureSample0, u_xlat1.xyz, _Float4).xyz;
    u_xlat16_5.xyz = (-u_xlat10_3.xyz) + u_xlat10_4.xyz;
    u_xlat16_3.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_5.xyz + u_xlat10_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_3.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_CubePower);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_CubePower);
    u_xlat16_3.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = (-u_xlat10_1.xyz) + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(0.200000003, 0.200000003, 0.200000003) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.514705896, 0.514705896, 0.514705896) + u_xlat16_3.xyz;
    u_xlat21 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat21 = u_xlat21 + (-_Fade);
    u_xlat16_23 = _Falloff * 5.0;
    u_xlat16_23 = u_xlat21 / u_xlat16_23;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vec3(u_xlat16_23) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
    u_xlat3.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_3.xy = texture(_OpacityMask, u_xlat3.xy).xy;
    u_xlat16_2.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_21 = (-u_xlat10_3.y) + 1.0;
    u_xlat16_21 = u_xlat16_21 + (-_Float7);
    u_xlat16_1.xyz = u_xlat16_2.xxx * (-u_xlat16_1.xyz) + u_xlat16_1.xyz;
    u_xlat16_9.xyz = (-_DayColor.xyz) + _Color1.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(0.5, 0.5, 0.5) + _DayColor.xyz;
    u_xlat16_9.xyz = (-u_xlat16_1.xyz) + u_xlat16_9.xyz;
    u_xlat22 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat3.xyz = vec3(u_xlat22) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat16_21 + _Float7;
    u_xlat0.x = _R_Mask_Intensity * u_xlat16_2.x + u_xlat0.x;
    u_xlat0.w = u_xlat0.x + _Float3;
    u_xlat16_2.xyz = u_xlat0.www * u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = vs_TEXCOORD8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat22 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat3.x = u_xlat22 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_23 = (u_xlatb22) ? u_xlat3.x : 1.0;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat3.x = u_xlat22 * _HeigtFogParams.y;
    u_xlat16_23 = u_xlat16_23 * u_xlat3.x;
    u_xlat16_23 = exp2((-u_xlat16_23));
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat16_23 = max(u_xlat16_23, 0.0);
    u_xlat3.x = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat3.x * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3.x));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3.x);
#endif
    u_xlat16_6 = (u_xlatb3) ? u_xlat10.x : 1.0;
    u_xlat3.x = u_xlat22 * _HeigtFogParams2.y;
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_23 = u_xlat16_23 + u_xlat16_6;
    u_xlat3.x = u_xlat22 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat3.x) + 2.0;
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat3.x = u_xlat16_6 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat3.x = u_xlat3.x + 1.0;
    u_xlat16_23 = u_xlat16_23 * u_xlat3.x;
    u_xlat3.x = min(u_xlat16_23, _HeigtFogColBase.w);
    u_xlat10.x = (-u_xlat3.x) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat8.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat8.x;
#endif
    u_xlat8.x = u_xlat22 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat22 + (-_HeigtFogRamp.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat22 = (-u_xlat8.x) + 2.0;
    u_xlat8.x = u_xlat22 * u_xlat8.x;
    u_xlat22 = u_xlat8.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat22 : u_xlat8.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat8.x = vs_TEXCOORD8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat16_23 = (-u_xlat8.x) + 2.0;
    u_xlat16_23 = u_xlat8.x * u_xlat16_23;
    u_xlat4.xyz = vec3(u_xlat16_23) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat15) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat1.yzw = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1 = u_xlat10.xxxx * u_xlat1;
    u_xlat10.x = vs_TEXCOORD8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat10.xyz = u_xlat10.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat8.xyz = u_xlat10.xyz * u_xlat3.xxx + u_xlat1.yzw;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat16_2.xyz + u_xlat8.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
bool u_xlatb14;
float u_xlat16;
float u_xlat21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
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
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat14 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat22 = u_xlat14 * -1.44269502;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat22 / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_3.x = (u_xlatb14) ? u_xlat22 : 1.0;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = sqrt(u_xlat14);
    u_xlat22 = u_xlat14 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat22 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat22 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_10 = (u_xlatb22) ? u_xlat23 : 1.0;
    u_xlat22 = u_xlat14 * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat22 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat22 = u_xlat14 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat22) + 2.0;
    u_xlat16_10 = u_xlat22 * u_xlat16_10;
    u_xlat22 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat22 = u_xlat22 + 1.0;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat23 = (-u_xlat22) + 1.0;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat4.x);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat4.x;
#endif
    u_xlat9 = u_xlat14 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat14 + (-_HeigtFogRamp.w);
    u_xlat14 = u_xlat14 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9) + 2.0;
    u_xlat9 = u_xlat16 * u_xlat9;
    u_xlat16 = u_xlat9 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat9) + 2.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat4.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = vec3(u_xlat14) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat14 = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat23 * u_xlat14;
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz;
    u_xlat14 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat7 * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat7 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat7;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD5.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _Float7;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _R_Mask_Intensity;
uniform 	mediump float _Float3;
uniform 	mediump float _CubePower;
uniform 	mediump float _Float8;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _cubeint;
uniform 	mediump float _Float4;
uniform 	mediump float _Falloff;
uniform 	mediump float _Fade;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Color1;
uniform lowp sampler2D _OpacityMask;
uniform lowp samplerCube _TextureSample5;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
vec2 u_xlat7;
float u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
float u_xlat11;
float u_xlat14;
float u_xlat15;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
mediump float u_xlat16_24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat0.xy = texture(_OpacityMask, u_xlat0.xy).xy;
    u_xlat14 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xyz = vec3(u_xlat14) * vs_TEXCOORD4.xyz;
    u_xlat14 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * vs_TEXCOORD5.xyz;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat7.xy = vec2((-u_xlat0.y) + float(1.0), (-u_xlat0.z) + float(1.0));
    u_xlat14 = u_xlat7.y * _NVint;
    u_xlat14 = max(u_xlat14, 9.99999975e-05);
    u_xlat14 = log2(u_xlat14);
    u_xlat14 = u_xlat14 * _NVfalloff;
    u_xlat14 = exp2(u_xlat14);
    u_xlat7.x = u_xlat7.x + (-_Float7);
    u_xlat7.x = u_xlat14 * u_xlat7.x + _Float7;
    u_xlat16_3.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = _R_Mask_Intensity * u_xlat16_3.x + u_xlat7.x;
    u_xlat0.w = u_xlat0.x + _Float3;
    u_xlat1.x = dot((-u_xlat2.xyz), vs_TEXCOORD4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.xyz = vs_TEXCOORD4.xyz * (-u_xlat1.xxx) + (-u_xlat2.xyz);
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat16_10.xyz = u_xlat1.xyz * vec3(u_xlat22) + vec3(vec3(_Float8, _Float8, _Float8));
    u_xlat10_1.xyz = texture(_TextureSample5, u_xlat2.xyz).xyz;
    u_xlat10_4.xyz = texture(_TextureSample6, u_xlat16_10.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_1.xyz + (-u_xlat10_4.xyz);
    u_xlat16_4.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_5.xyz + u_xlat10_4.xyz;
    u_xlat16_10.xyz = max(u_xlat16_4.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_10.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_CubePower);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_CubePower);
    u_xlat16_4.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_10.xyz) + u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_TextureSample0, u_xlat2.xyz, _Float4).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.200000003, 0.200000003, 0.200000003) + u_xlat10_2.xyz;
    u_xlat16_10.xyz = (-u_xlat16_4.xyz) + u_xlat16_1.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.514705896, 0.514705896, 0.514705896) + u_xlat16_4.xyz;
    u_xlat1.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_Fade);
    u_xlat16_6 = _Falloff * 5.0;
    u_xlat16_6 = u_xlat1.x / u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vec3(u_xlat16_6) * (-u_xlat16_10.xyz) + u_xlat16_10.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xxx * (-u_xlat16_1.xyz) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-_DayColor.xyz) + _Color1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5) + _DayColor.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat0.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = vs_TEXCOORD8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat15 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat2.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat9 * u_xlat2.x;
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!((-u_xlat22)>=u_xlat9);
#else
    u_xlatb22 = (-u_xlat22)>=u_xlat9;
#endif
    u_xlat9 = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat22 = (u_xlatb22) ? u_xlat9 : u_xlat2.x;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * unity_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat2.x = vs_TEXCOORD8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_24 = (-u_xlat2.x) + 2.0;
    u_xlat16_24 = u_xlat2.x * u_xlat16_24;
    u_xlat2.xyz = vec3(u_xlat16_24) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat23 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat1.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat11 = u_xlat23 * -1.44269502;
    u_xlat11 = exp2(u_xlat11);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat23 = u_xlat11 / u_xlat23;
    u_xlat16_24 = (u_xlatb4) ? u_xlat23 : 1.0;
    u_xlat8 = u_xlat1.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat4.x = u_xlat8 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat8 = u_xlat4.x / u_xlat8;
    u_xlat16_6 = (u_xlatb23) ? u_xlat8 : 1.0;
    u_xlat8 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_24 = u_xlat15 * u_xlat16_24;
    u_xlat16_6 = u_xlat8 * u_xlat16_6;
    u_xlat16_24 = exp2((-u_xlat16_24));
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_24 = u_xlat16_24 + u_xlat16_6;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat1.x) + 2.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.x = u_xlat16_6 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_24 = u_xlat1.x * u_xlat16_24;
    u_xlat1.x = min(u_xlat16_24, _HeigtFogColBase.w);
    u_xlat8 = vs_TEXCOORD8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat8) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat8 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat4.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.x = (-u_xlat22) + 1.0;
    u_xlat1.x = u_xlat8 * u_xlat1.x;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat16_3.xyz + u_xlat2.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
bool u_xlatb7;
float u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat15;
float u_xlat16;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = u_xlat7.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7.x = u_xlat2.y * _HeigtFogParams.x;
    u_xlat21 = u_xlat7.x * -1.44269502;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = u_xlat21 / u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7.x));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7.x);
#endif
    u_xlat16_3.x = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat21 = u_xlat7.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat21 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat15 = u_xlat21 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 / u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.00999999978<abs(u_xlat21));
#else
    u_xlatb21 = 0.00999999978<abs(u_xlat21);
#endif
    u_xlat16_10 = (u_xlatb21) ? u_xlat15 : 1.0;
    u_xlat21 = u_xlat7.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat21 = u_xlat7.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat21) + 2.0;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat21 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat21 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat15 = (-u_xlat21) + 1.0;
    u_xlat23 = _ProjectionParams.z * 0.999899983;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat23);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat23;
#endif
    u_xlat9.x = u_xlat7.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x + (-_HeigtFogRamp.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9.x) + 2.0;
    u_xlat9.x = u_xlat16 * u_xlat9.x;
    u_xlat16 = u_xlat9.x * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9.x = u_xlat7.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat7.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat9.x) + 2.0;
    u_xlat16_3.x = u_xlat9.x * u_xlat16_3.x;
    u_xlat9.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat9.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat9.xyz = u_xlat7.xxx * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat2.xxx * u_xlat9.xyz;
    u_xlat7.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat15 * u_xlat7.x;
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat9.xyz;
    vs_TEXCOORD0.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.w = u_xlat7.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat7.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat7.xyz;
    u_xlat1 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat8;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
    vs_TEXCOORD3.z = (-u_xlat1.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.xyz = (-u_xlat7.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat7.xyz;
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    vs_TEXCOORD5.xyz = u_xlat7.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat7.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat7.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat7.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _Float7;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _R_Mask_Intensity;
uniform 	mediump float _Float3;
uniform 	mediump float _CubePower;
uniform 	mediump float _Float8;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _cubeint;
uniform 	mediump float _Float4;
uniform 	mediump float _Falloff;
uniform 	mediump float _Fade;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Color1;
uniform lowp sampler2D _OpacityMask;
uniform lowp samplerCube _TextureSample5;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
vec2 u_xlat7;
float u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
float u_xlat11;
float u_xlat14;
float u_xlat15;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
mediump float u_xlat16_24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat0.xy = texture(_OpacityMask, u_xlat0.xy).xy;
    u_xlat14 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xyz = vec3(u_xlat14) * vs_TEXCOORD4.xyz;
    u_xlat14 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * vs_TEXCOORD5.xyz;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat7.xy = vec2((-u_xlat0.y) + float(1.0), (-u_xlat0.z) + float(1.0));
    u_xlat14 = u_xlat7.y * _NVint;
    u_xlat14 = max(u_xlat14, 9.99999975e-05);
    u_xlat14 = log2(u_xlat14);
    u_xlat14 = u_xlat14 * _NVfalloff;
    u_xlat14 = exp2(u_xlat14);
    u_xlat7.x = u_xlat7.x + (-_Float7);
    u_xlat7.x = u_xlat14 * u_xlat7.x + _Float7;
    u_xlat16_3.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = _R_Mask_Intensity * u_xlat16_3.x + u_xlat7.x;
    u_xlat0.w = u_xlat0.x + _Float3;
    u_xlat1.x = dot((-u_xlat2.xyz), vs_TEXCOORD4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.xyz = vs_TEXCOORD4.xyz * (-u_xlat1.xxx) + (-u_xlat2.xyz);
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat16_10.xyz = u_xlat1.xyz * vec3(u_xlat22) + vec3(vec3(_Float8, _Float8, _Float8));
    u_xlat10_1.xyz = texture(_TextureSample5, u_xlat2.xyz).xyz;
    u_xlat10_4.xyz = texture(_TextureSample6, u_xlat16_10.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_1.xyz + (-u_xlat10_4.xyz);
    u_xlat16_4.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_5.xyz + u_xlat10_4.xyz;
    u_xlat16_10.xyz = max(u_xlat16_4.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_10.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_CubePower);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_CubePower);
    u_xlat16_4.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_10.xyz) + u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_TextureSample0, u_xlat2.xyz, _Float4).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.200000003, 0.200000003, 0.200000003) + u_xlat10_2.xyz;
    u_xlat16_10.xyz = (-u_xlat16_4.xyz) + u_xlat16_1.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.514705896, 0.514705896, 0.514705896) + u_xlat16_4.xyz;
    u_xlat1.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_Fade);
    u_xlat16_6 = _Falloff * 5.0;
    u_xlat16_6 = u_xlat1.x / u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vec3(u_xlat16_6) * (-u_xlat16_10.xyz) + u_xlat16_10.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xxx * (-u_xlat16_1.xyz) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-_DayColor.xyz) + _Color1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5) + _DayColor.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat0.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = vs_TEXCOORD8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat15 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat2.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat9 * u_xlat2.x;
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!((-u_xlat22)>=u_xlat9);
#else
    u_xlatb22 = (-u_xlat22)>=u_xlat9;
#endif
    u_xlat9 = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat22 = (u_xlatb22) ? u_xlat9 : u_xlat2.x;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * unity_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat2.x = vs_TEXCOORD8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_24 = (-u_xlat2.x) + 2.0;
    u_xlat16_24 = u_xlat2.x * u_xlat16_24;
    u_xlat2.xyz = vec3(u_xlat16_24) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat23 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat1.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat11 = u_xlat23 * -1.44269502;
    u_xlat11 = exp2(u_xlat11);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat23 = u_xlat11 / u_xlat23;
    u_xlat16_24 = (u_xlatb4) ? u_xlat23 : 1.0;
    u_xlat8 = u_xlat1.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat4.x = u_xlat8 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat8 = u_xlat4.x / u_xlat8;
    u_xlat16_6 = (u_xlatb23) ? u_xlat8 : 1.0;
    u_xlat8 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_24 = u_xlat15 * u_xlat16_24;
    u_xlat16_6 = u_xlat8 * u_xlat16_6;
    u_xlat16_24 = exp2((-u_xlat16_24));
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_24 = u_xlat16_24 + u_xlat16_6;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat1.x) + 2.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.x = u_xlat16_6 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_24 = u_xlat1.x * u_xlat16_24;
    u_xlat1.x = min(u_xlat16_24, _HeigtFogColBase.w);
    u_xlat8 = vs_TEXCOORD8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat8) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat8 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat4.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.x = (-u_xlat22) + 1.0;
    u_xlat1.x = u_xlat8 * u_xlat1.x;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat16_3.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
bool u_xlatb14;
float u_xlat16;
float u_xlat21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
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
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat14 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat22 = u_xlat14 * -1.44269502;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat22 / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_3.x = (u_xlatb14) ? u_xlat22 : 1.0;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = sqrt(u_xlat14);
    u_xlat22 = u_xlat14 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat22 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat22 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_10 = (u_xlatb22) ? u_xlat23 : 1.0;
    u_xlat22 = u_xlat14 * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat22 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat22 = u_xlat14 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat22) + 2.0;
    u_xlat16_10 = u_xlat22 * u_xlat16_10;
    u_xlat22 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat22 = u_xlat22 + 1.0;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat23 = (-u_xlat22) + 1.0;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat4.x);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat4.x;
#endif
    u_xlat9 = u_xlat14 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat14 + (-_HeigtFogRamp.w);
    u_xlat14 = u_xlat14 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9) + 2.0;
    u_xlat9 = u_xlat16 * u_xlat9;
    u_xlat16 = u_xlat9 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat9) + 2.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat4.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = vec3(u_xlat14) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat14 = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat23 * u_xlat14;
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz;
    u_xlat14 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat7 * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat7 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat7;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD5.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump float _Float7;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _R_Mask_Intensity;
uniform 	mediump float _Float3;
uniform 	mediump float _CubePower;
uniform 	mediump float _Float8;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _cubeint;
uniform 	mediump float _Float4;
uniform 	mediump float _Falloff;
uniform 	mediump float _Fade;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Color1;
uniform lowp sampler2D _OpacityMask;
uniform lowp samplerCube _TextureSample5;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
vec3 u_xlat8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
float u_xlat15;
float u_xlat21;
mediump float u_xlat16_21;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat21 = dot((-u_xlat0.xyz), vs_TEXCOORD4.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = vs_TEXCOORD4.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat21) + vec3(vec3(_Float8, _Float8, _Float8));
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat10_3.xyz = texture(_TextureSample6, u_xlat16_2.xyz).xyz;
    u_xlat10_4.xyz = texture(_TextureSample5, u_xlat1.xyz).xyz;
    u_xlat10_1.xyz = texture(_TextureSample0, u_xlat1.xyz, _Float4).xyz;
    u_xlat16_5.xyz = (-u_xlat10_3.xyz) + u_xlat10_4.xyz;
    u_xlat16_3.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_5.xyz + u_xlat10_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_3.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_CubePower);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_CubePower);
    u_xlat16_3.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = (-u_xlat10_1.xyz) + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(0.200000003, 0.200000003, 0.200000003) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.514705896, 0.514705896, 0.514705896) + u_xlat16_3.xyz;
    u_xlat21 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat21 = u_xlat21 + (-_Fade);
    u_xlat16_23 = _Falloff * 5.0;
    u_xlat16_23 = u_xlat21 / u_xlat16_23;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vec3(u_xlat16_23) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
    u_xlat3.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_3.xy = texture(_OpacityMask, u_xlat3.xy).xy;
    u_xlat16_2.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_21 = (-u_xlat10_3.y) + 1.0;
    u_xlat16_21 = u_xlat16_21 + (-_Float7);
    u_xlat16_1.xyz = u_xlat16_2.xxx * (-u_xlat16_1.xyz) + u_xlat16_1.xyz;
    u_xlat16_9.xyz = (-_DayColor.xyz) + _Color1.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(0.5, 0.5, 0.5) + _DayColor.xyz;
    u_xlat16_9.xyz = (-u_xlat16_1.xyz) + u_xlat16_9.xyz;
    u_xlat22 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat3.xyz = vec3(u_xlat22) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat16_21 + _Float7;
    u_xlat0.x = _R_Mask_Intensity * u_xlat16_2.x + u_xlat0.x;
    u_xlat0.w = u_xlat0.x + _Float3;
    u_xlat16_2.xyz = u_xlat0.www * u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = vs_TEXCOORD8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat22 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat3.x = u_xlat22 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_23 = (u_xlatb22) ? u_xlat3.x : 1.0;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat3.x = u_xlat22 * _HeigtFogParams.y;
    u_xlat16_23 = u_xlat16_23 * u_xlat3.x;
    u_xlat16_23 = exp2((-u_xlat16_23));
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat16_23 = max(u_xlat16_23, 0.0);
    u_xlat3.x = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat3.x * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3.x));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3.x);
#endif
    u_xlat16_6 = (u_xlatb3) ? u_xlat10.x : 1.0;
    u_xlat3.x = u_xlat22 * _HeigtFogParams2.y;
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_23 = u_xlat16_23 + u_xlat16_6;
    u_xlat3.x = u_xlat22 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat3.x) + 2.0;
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat3.x = u_xlat16_6 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat3.x = u_xlat3.x + 1.0;
    u_xlat16_23 = u_xlat16_23 * u_xlat3.x;
    u_xlat3.x = min(u_xlat16_23, _HeigtFogColBase.w);
    u_xlat10.x = (-u_xlat3.x) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat8.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat8.x;
#endif
    u_xlat8.x = u_xlat22 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat22 + (-_HeigtFogRamp.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat22 = (-u_xlat8.x) + 2.0;
    u_xlat8.x = u_xlat22 * u_xlat8.x;
    u_xlat22 = u_xlat8.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat22 : u_xlat8.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat8.x = vs_TEXCOORD8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat16_23 = (-u_xlat8.x) + 2.0;
    u_xlat16_23 = u_xlat8.x * u_xlat16_23;
    u_xlat4.xyz = vec3(u_xlat16_23) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat15) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat1.yzw = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1 = u_xlat10.xxxx * u_xlat1;
    u_xlat10.x = vs_TEXCOORD8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat10.xyz = u_xlat10.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat8.xyz = u_xlat10.xyz * u_xlat3.xxx + u_xlat1.yzw;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat16_2.xyz + u_xlat8.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
bool u_xlatb7;
float u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat15;
float u_xlat16;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = u_xlat7.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7.x = u_xlat2.y * _HeigtFogParams.x;
    u_xlat21 = u_xlat7.x * -1.44269502;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = u_xlat21 / u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7.x));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7.x);
#endif
    u_xlat16_3.x = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat21 = u_xlat7.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat21 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat15 = u_xlat21 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 / u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.00999999978<abs(u_xlat21));
#else
    u_xlatb21 = 0.00999999978<abs(u_xlat21);
#endif
    u_xlat16_10 = (u_xlatb21) ? u_xlat15 : 1.0;
    u_xlat21 = u_xlat7.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat21 = u_xlat7.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat21) + 2.0;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat21 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat21 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat15 = (-u_xlat21) + 1.0;
    u_xlat23 = _ProjectionParams.z * 0.999899983;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat23);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat23;
#endif
    u_xlat9.x = u_xlat7.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x + (-_HeigtFogRamp.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9.x) + 2.0;
    u_xlat9.x = u_xlat16 * u_xlat9.x;
    u_xlat16 = u_xlat9.x * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9.x = u_xlat7.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat7.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat9.x) + 2.0;
    u_xlat16_3.x = u_xlat9.x * u_xlat16_3.x;
    u_xlat9.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat9.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat9.xyz = u_xlat7.xxx * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat2.xxx * u_xlat9.xyz;
    u_xlat7.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat15 * u_xlat7.x;
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat9.xyz;
    vs_TEXCOORD0.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.w = u_xlat7.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat7.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat7.xyz;
    u_xlat1 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat8;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
    vs_TEXCOORD3.z = (-u_xlat1.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.xyz = (-u_xlat7.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat7.xyz;
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    vs_TEXCOORD5.xyz = u_xlat7.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat7.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat7.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat7.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump float _Float7;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _R_Mask_Intensity;
uniform 	mediump float _Float3;
uniform 	mediump float _CubePower;
uniform 	mediump float _Float8;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _cubeint;
uniform 	mediump float _Float4;
uniform 	mediump float _Falloff;
uniform 	mediump float _Fade;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Color1;
uniform lowp sampler2D _OpacityMask;
uniform lowp samplerCube _TextureSample5;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec3 u_xlat10_3;
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
vec3 u_xlat8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
float u_xlat15;
float u_xlat21;
mediump float u_xlat16_21;
float u_xlat22;
bool u_xlatb22;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat21 = dot((-u_xlat0.xyz), vs_TEXCOORD4.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = vs_TEXCOORD4.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(u_xlat21) + vec3(vec3(_Float8, _Float8, _Float8));
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat10_3.xyz = texture(_TextureSample6, u_xlat16_2.xyz).xyz;
    u_xlat10_4.xyz = texture(_TextureSample5, u_xlat1.xyz).xyz;
    u_xlat10_1.xyz = texture(_TextureSample0, u_xlat1.xyz, _Float4).xyz;
    u_xlat16_5.xyz = (-u_xlat10_3.xyz) + u_xlat10_4.xyz;
    u_xlat16_3.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_5.xyz + u_xlat10_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_3.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_2.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_CubePower);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_CubePower);
    u_xlat16_3.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = (-u_xlat10_1.xyz) + u_xlat10_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(0.200000003, 0.200000003, 0.200000003) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.514705896, 0.514705896, 0.514705896) + u_xlat16_3.xyz;
    u_xlat21 = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat21 = u_xlat21 + (-_Fade);
    u_xlat16_23 = _Falloff * 5.0;
    u_xlat16_23 = u_xlat21 / u_xlat16_23;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vec3(u_xlat16_23) * (-u_xlat16_2.xyz) + u_xlat16_2.xyz;
    u_xlat3.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat10_3.xy = texture(_OpacityMask, u_xlat3.xy).xy;
    u_xlat16_2.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_21 = (-u_xlat10_3.y) + 1.0;
    u_xlat16_21 = u_xlat16_21 + (-_Float7);
    u_xlat16_1.xyz = u_xlat16_2.xxx * (-u_xlat16_1.xyz) + u_xlat16_1.xyz;
    u_xlat16_9.xyz = (-_DayColor.xyz) + _Color1.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(0.5, 0.5, 0.5) + _DayColor.xyz;
    u_xlat16_9.xyz = (-u_xlat16_1.xyz) + u_xlat16_9.xyz;
    u_xlat22 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat3.xyz = vec3(u_xlat22) * vs_TEXCOORD4.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _NVint;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NVfalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat16_21 + _Float7;
    u_xlat0.x = _R_Mask_Intensity * u_xlat16_2.x + u_xlat0.x;
    u_xlat0.w = u_xlat0.x + _Float3;
    u_xlat16_2.xyz = u_xlat0.www * u_xlat16_9.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = vs_TEXCOORD8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat22 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat3.x = u_xlat22 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_23 = (u_xlatb22) ? u_xlat3.x : 1.0;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = sqrt(u_xlat22);
    u_xlat3.x = u_xlat22 * _HeigtFogParams.y;
    u_xlat16_23 = u_xlat16_23 * u_xlat3.x;
    u_xlat16_23 = exp2((-u_xlat16_23));
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat16_23 = max(u_xlat16_23, 0.0);
    u_xlat3.x = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat3.x * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3.x));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3.x);
#endif
    u_xlat16_6 = (u_xlatb3) ? u_xlat10.x : 1.0;
    u_xlat3.x = u_xlat22 * _HeigtFogParams2.y;
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_23 = u_xlat16_23 + u_xlat16_6;
    u_xlat3.x = u_xlat22 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat3.x) + 2.0;
    u_xlat16_6 = u_xlat3.x * u_xlat16_6;
    u_xlat3.x = u_xlat16_6 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat3.x = u_xlat3.x + 1.0;
    u_xlat16_23 = u_xlat16_23 * u_xlat3.x;
    u_xlat3.x = min(u_xlat16_23, _HeigtFogColBase.w);
    u_xlat10.x = (-u_xlat3.x) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat8.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat8.x;
#endif
    u_xlat8.x = u_xlat22 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat22 + (-_HeigtFogRamp.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat22 = (-u_xlat8.x) + 2.0;
    u_xlat8.x = u_xlat22 * u_xlat8.x;
    u_xlat22 = u_xlat8.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat22 : u_xlat8.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat8.x = vs_TEXCOORD8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat16_23 = (-u_xlat8.x) + 2.0;
    u_xlat16_23 = u_xlat8.x * u_xlat16_23;
    u_xlat4.xyz = vec3(u_xlat16_23) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat15) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat1.yzw = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1 = u_xlat10.xxxx * u_xlat1;
    u_xlat10.x = vs_TEXCOORD8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat10.xyz = u_xlat10.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat8.xyz = u_xlat10.xyz * u_xlat3.xxx + u_xlat1.yzw;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat16_2.xyz + u_xlat8.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
bool u_xlatb14;
float u_xlat16;
float u_xlat21;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
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
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat14 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat22 = u_xlat14 * -1.44269502;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat22 / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_3.x = (u_xlatb14) ? u_xlat22 : 1.0;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = sqrt(u_xlat14);
    u_xlat22 = u_xlat14 * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat22 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat22 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(0.00999999978<abs(u_xlat22));
#else
    u_xlatb22 = 0.00999999978<abs(u_xlat22);
#endif
    u_xlat16_10 = (u_xlatb22) ? u_xlat23 : 1.0;
    u_xlat22 = u_xlat14 * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat22 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat22 = u_xlat14 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat22) + 2.0;
    u_xlat16_10 = u_xlat22 * u_xlat16_10;
    u_xlat22 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat22 = u_xlat22 + 1.0;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat23 = (-u_xlat22) + 1.0;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat4.x);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat4.x;
#endif
    u_xlat9 = u_xlat14 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat14 + (-_HeigtFogRamp.w);
    u_xlat14 = u_xlat14 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9) + 2.0;
    u_xlat9 = u_xlat16 * u_xlat9;
    u_xlat16 = u_xlat9 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat9) + 2.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat4.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = vec3(u_xlat14) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat2.xxx * u_xlat4.xyz;
    u_xlat14 = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat23 * u_xlat14;
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz;
    u_xlat14 = u_xlat1.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat4.xyz * vec3(u_xlat22) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat7 * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat7 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat7;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD3.z = (-u_xlat0.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD5.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _Float7;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _R_Mask_Intensity;
uniform 	mediump float _Float3;
uniform 	mediump float _CubePower;
uniform 	mediump float _Float8;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _cubeint;
uniform 	mediump float _Float4;
uniform 	mediump float _Falloff;
uniform 	mediump float _Fade;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Color1;
uniform lowp sampler2D _OpacityMask;
uniform lowp samplerCube _TextureSample5;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
vec2 u_xlat7;
float u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
float u_xlat11;
float u_xlat14;
float u_xlat15;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
mediump float u_xlat16_24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat0.xy = texture(_OpacityMask, u_xlat0.xy).xy;
    u_xlat14 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xyz = vec3(u_xlat14) * vs_TEXCOORD4.xyz;
    u_xlat14 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * vs_TEXCOORD5.xyz;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat7.xy = vec2((-u_xlat0.y) + float(1.0), (-u_xlat0.z) + float(1.0));
    u_xlat14 = u_xlat7.y * _NVint;
    u_xlat14 = max(u_xlat14, 9.99999975e-05);
    u_xlat14 = log2(u_xlat14);
    u_xlat14 = u_xlat14 * _NVfalloff;
    u_xlat14 = exp2(u_xlat14);
    u_xlat7.x = u_xlat7.x + (-_Float7);
    u_xlat7.x = u_xlat14 * u_xlat7.x + _Float7;
    u_xlat16_3.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = _R_Mask_Intensity * u_xlat16_3.x + u_xlat7.x;
    u_xlat0.w = u_xlat0.x + _Float3;
    u_xlat1.x = dot((-u_xlat2.xyz), vs_TEXCOORD4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.xyz = vs_TEXCOORD4.xyz * (-u_xlat1.xxx) + (-u_xlat2.xyz);
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat16_10.xyz = u_xlat1.xyz * vec3(u_xlat22) + vec3(vec3(_Float8, _Float8, _Float8));
    u_xlat10_1.xyz = texture(_TextureSample5, u_xlat2.xyz).xyz;
    u_xlat10_4.xyz = texture(_TextureSample6, u_xlat16_10.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_1.xyz + (-u_xlat10_4.xyz);
    u_xlat16_4.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_5.xyz + u_xlat10_4.xyz;
    u_xlat16_10.xyz = max(u_xlat16_4.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_10.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_CubePower);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_CubePower);
    u_xlat16_4.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_10.xyz) + u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_TextureSample0, u_xlat2.xyz, _Float4).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.200000003, 0.200000003, 0.200000003) + u_xlat10_2.xyz;
    u_xlat16_10.xyz = (-u_xlat16_4.xyz) + u_xlat16_1.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.514705896, 0.514705896, 0.514705896) + u_xlat16_4.xyz;
    u_xlat1.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_Fade);
    u_xlat16_6 = _Falloff * 5.0;
    u_xlat16_6 = u_xlat1.x / u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vec3(u_xlat16_6) * (-u_xlat16_10.xyz) + u_xlat16_10.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xxx * (-u_xlat16_1.xyz) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-_DayColor.xyz) + _Color1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5) + _DayColor.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat0.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = vs_TEXCOORD8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat15 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat2.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat9 * u_xlat2.x;
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!((-u_xlat22)>=u_xlat9);
#else
    u_xlatb22 = (-u_xlat22)>=u_xlat9;
#endif
    u_xlat9 = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat22 = (u_xlatb22) ? u_xlat9 : u_xlat2.x;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * unity_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat2.x = vs_TEXCOORD8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_24 = (-u_xlat2.x) + 2.0;
    u_xlat16_24 = u_xlat2.x * u_xlat16_24;
    u_xlat2.xyz = vec3(u_xlat16_24) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat23 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat1.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat11 = u_xlat23 * -1.44269502;
    u_xlat11 = exp2(u_xlat11);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat23 = u_xlat11 / u_xlat23;
    u_xlat16_24 = (u_xlatb4) ? u_xlat23 : 1.0;
    u_xlat8 = u_xlat1.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat4.x = u_xlat8 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat8 = u_xlat4.x / u_xlat8;
    u_xlat16_6 = (u_xlatb23) ? u_xlat8 : 1.0;
    u_xlat8 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_24 = u_xlat15 * u_xlat16_24;
    u_xlat16_6 = u_xlat8 * u_xlat16_6;
    u_xlat16_24 = exp2((-u_xlat16_24));
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_24 = u_xlat16_24 + u_xlat16_6;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat1.x) + 2.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.x = u_xlat16_6 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_24 = u_xlat1.x * u_xlat16_24;
    u_xlat1.x = min(u_xlat16_24, _HeigtFogColBase.w);
    u_xlat8 = vs_TEXCOORD8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat8) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat8 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat4.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.x = (-u_xlat22) + 1.0;
    u_xlat1.x = u_xlat8 * u_xlat1.x;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat16_3.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
bool u_xlatb7;
float u_xlat8;
vec3 u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat15;
float u_xlat16;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = u_xlat7.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7.x = u_xlat2.y * _HeigtFogParams.x;
    u_xlat21 = u_xlat7.x * -1.44269502;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = u_xlat21 / u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7.x));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7.x);
#endif
    u_xlat16_3.x = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat21 = u_xlat7.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat21 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat15 = u_xlat21 * -1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlat15 / u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.00999999978<abs(u_xlat21));
#else
    u_xlatb21 = 0.00999999978<abs(u_xlat21);
#endif
    u_xlat16_10 = (u_xlatb21) ? u_xlat15 : 1.0;
    u_xlat21 = u_xlat7.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat21 = u_xlat7.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat21) + 2.0;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat21 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat21 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat15 = (-u_xlat21) + 1.0;
    u_xlat23 = _ProjectionParams.z * 0.999899983;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat23);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat23;
#endif
    u_xlat9.x = u_xlat7.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x + (-_HeigtFogRamp.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9.x) + 2.0;
    u_xlat9.x = u_xlat16 * u_xlat9.x;
    u_xlat16 = u_xlat9.x * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9.x = u_xlat7.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat7.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat9.x) + 2.0;
    u_xlat16_3.x = u_xlat9.x * u_xlat16_3.x;
    u_xlat9.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat9.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat9.xyz = u_xlat7.xxx * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat9.xyz = u_xlat2.xxx * u_xlat9.xyz;
    u_xlat7.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat15 * u_xlat7.x;
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat9.xyz;
    vs_TEXCOORD0.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xyz = u_xlat7.xxx * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_6.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_6.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat1.w = u_xlat7.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat7.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat7.xyz;
    u_xlat1 = u_xlat7.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat7.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat7.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8 = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat8;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
    vs_TEXCOORD3.z = (-u_xlat1.x);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.xyz = (-u_xlat7.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat7.xyz;
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    vs_TEXCOORD5.xyz = u_xlat7.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat7.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat7.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat7.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump float _Float7;
uniform 	vec4 _OpacityMask_ST;
uniform 	mediump float _NVint;
uniform 	mediump float _NVfalloff;
uniform 	mediump float _R_Mask_Intensity;
uniform 	mediump float _Float3;
uniform 	mediump float _CubePower;
uniform 	mediump float _Float8;
uniform 	mediump float _cubeoffet;
uniform 	mediump float _cubeint;
uniform 	mediump float _Float4;
uniform 	mediump float _Falloff;
uniform 	mediump float _Fade;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _Color1;
uniform lowp sampler2D _OpacityMask;
uniform lowp samplerCube _TextureSample5;
uniform lowp samplerCube _TextureSample6;
uniform lowp samplerCube _TextureSample0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
lowp vec3 u_xlat10_4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
vec2 u_xlat7;
float u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
float u_xlat11;
float u_xlat14;
float u_xlat15;
float u_xlat22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
mediump float u_xlat16_24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
    u_xlat0.xy = texture(_OpacityMask, u_xlat0.xy).xy;
    u_xlat14 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xyz = vec3(u_xlat14) * vs_TEXCOORD4.xyz;
    u_xlat14 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * vs_TEXCOORD5.xyz;
    u_xlat0.z = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat7.xy = vec2((-u_xlat0.y) + float(1.0), (-u_xlat0.z) + float(1.0));
    u_xlat14 = u_xlat7.y * _NVint;
    u_xlat14 = max(u_xlat14, 9.99999975e-05);
    u_xlat14 = log2(u_xlat14);
    u_xlat14 = u_xlat14 * _NVfalloff;
    u_xlat14 = exp2(u_xlat14);
    u_xlat7.x = u_xlat7.x + (-_Float7);
    u_xlat7.x = u_xlat14 * u_xlat7.x + _Float7;
    u_xlat16_3.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = _R_Mask_Intensity * u_xlat16_3.x + u_xlat7.x;
    u_xlat0.w = u_xlat0.x + _Float3;
    u_xlat1.x = dot((-u_xlat2.xyz), vs_TEXCOORD4.xyz);
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.xyz = vs_TEXCOORD4.xyz * (-u_xlat1.xxx) + (-u_xlat2.xyz);
    u_xlat22 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat1.xyz;
    u_xlat16_10.xyz = u_xlat1.xyz * vec3(u_xlat22) + vec3(vec3(_Float8, _Float8, _Float8));
    u_xlat10_1.xyz = texture(_TextureSample5, u_xlat2.xyz).xyz;
    u_xlat10_4.xyz = texture(_TextureSample6, u_xlat16_10.xyz).xyz;
    u_xlat16_5.xyz = u_xlat10_1.xyz + (-u_xlat10_4.xyz);
    u_xlat16_4.xyz = vec3(vec3(_cubeoffet, _cubeoffet, _cubeoffet)) * u_xlat16_5.xyz + u_xlat10_4.xyz;
    u_xlat16_10.xyz = max(u_xlat16_4.xyz, vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_10.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_CubePower);
    u_xlat16_10.xyz = exp2(u_xlat16_10.xyz);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_CubePower);
    u_xlat16_4.xyz = vec3(vec3(_cubeint, _cubeint, _cubeint)) * (-u_xlat16_10.xyz) + u_xlat16_10.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat10_2.xyz = texture(_TextureSample0, u_xlat2.xyz, _Float4).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.200000003, 0.200000003, 0.200000003) + u_xlat10_2.xyz;
    u_xlat16_10.xyz = (-u_xlat16_4.xyz) + u_xlat16_1.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.514705896, 0.514705896, 0.514705896) + u_xlat16_4.xyz;
    u_xlat1.x = vs_TEXCOORD3.z + (-_ProjectionParams.y);
    u_xlat1.x = u_xlat1.x + (-_Fade);
    u_xlat16_6 = _Falloff * 5.0;
    u_xlat16_6 = u_xlat1.x / u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vec3(u_xlat16_6) * (-u_xlat16_10.xyz) + u_xlat16_10.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xxx * (-u_xlat16_1.xyz) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-_DayColor.xyz) + _Color1.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.5, 0.5, 0.5) + _DayColor.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat0.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = vs_TEXCOORD8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat22 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat15 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat2.x = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat9 * u_xlat2.x;
    u_xlat9 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!((-u_xlat22)>=u_xlat9);
#else
    u_xlatb22 = (-u_xlat22)>=u_xlat9;
#endif
    u_xlat9 = u_xlat2.x * _HeigtFogColDelta.w;
    u_xlat22 = (u_xlatb22) ? u_xlat9 : u_xlat2.x;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * unity_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat2.x = vs_TEXCOORD8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_24 = (-u_xlat2.x) + 2.0;
    u_xlat16_24 = u_xlat2.x * u_xlat16_24;
    u_xlat2.xyz = vec3(u_xlat16_24) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat23 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat2.xyz;
    u_xlat23 = u_xlat1.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat11 = u_xlat23 * -1.44269502;
    u_xlat11 = exp2(u_xlat11);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat23 = u_xlat11 / u_xlat23;
    u_xlat16_24 = (u_xlatb4) ? u_xlat23 : 1.0;
    u_xlat8 = u_xlat1.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat4.x = u_xlat8 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat8 = u_xlat4.x / u_xlat8;
    u_xlat16_6 = (u_xlatb23) ? u_xlat8 : 1.0;
    u_xlat8 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat16_24 = u_xlat15 * u_xlat16_24;
    u_xlat16_6 = u_xlat8 * u_xlat16_6;
    u_xlat16_24 = exp2((-u_xlat16_24));
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_6 = max(u_xlat16_6, 0.0);
    u_xlat16_24 = u_xlat16_24 + u_xlat16_6;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_6 = (-u_xlat1.x) + 2.0;
    u_xlat16_6 = u_xlat1.x * u_xlat16_6;
    u_xlat1.x = u_xlat16_6 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_24 = u_xlat1.x * u_xlat16_24;
    u_xlat1.x = min(u_xlat16_24, _HeigtFogColBase.w);
    u_xlat8 = vs_TEXCOORD8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat8) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
    u_xlat8 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat8) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat4.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.x = (-u_xlat22) + 1.0;
    u_xlat1.x = u_xlat8 * u_xlat1.x;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat16_3.xyz + u_xlat2.xyz;
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
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
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
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}