//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Projector/DeferredProjectorAlphaBlend" {
Properties {
_DayColor ("Albedo (Multiplier)", Color) = (1,1,1,1)
_Brightness ("Brightness", Float) = 1
_MainTex ("Main Texture", 2D) = "white" { }
_FalloffTex ("FallOff", 2D) = "white" { }
[Toggle(PROJECTOR_OCCLUSION)] _occlusion ("Enable Occlusion", Float) = 0
}
SubShader {
 Pass {
  Tags { "LIGHTMODE" = "PREPASSDECALFINAL" }
  ZTest GEqual
  ZWrite Off
  Cull Front
  GpuProgramID 41380
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_ObjectToWorld[2].xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 hlslcc_mtx4x4_DeferredProj_WorldToProjector[4];
uniform 	vec4 hlslcc_mtx4x4_DeferredProj_WorldToProjectorClip[4];
uniform 	float _Brightness;
uniform 	vec4 _DayColor;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _FalloffTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
vec3 u_xlat5;
mediump vec2 u_xlat16_7;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat15 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat10_1.xyz = texture(_CameraNormalsTexture, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat15 = _ZBufferParams.x * u_xlat15 + _ZBufferParams.y;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_DeferredProj_WorldToProjector[1];
    u_xlat1 = hlslcc_mtx4x4_DeferredProj_WorldToProjector[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_DeferredProj_WorldToProjector[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4_DeferredProj_WorldToProjector[3];
    u_xlat16_3.xyz = u_xlat1.xyz / u_xlat1.www;
    u_xlat1.xyz = -abs(u_xlat16_3.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xy = u_xlat16_3.xy + vec2(0.5, 0.5);
    u_xlat4.xy = u_xlat16_3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3 = texture(_MainTex, u_xlat4.xy);
    u_xlatb1.xyz = lessThan(u_xlat1.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb15 = u_xlatb1.y || u_xlatb1.x;
    u_xlatb15 = u_xlatb1.z || u_xlatb15;
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = (-u_xlat0.xyz) + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2.x<0.0);
#else
    u_xlatb15 = u_xlat16_2.x<0.0;
#endif
    if((int(u_xlatb15) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_DeferredProj_WorldToProjectorClip[1].xyw;
    u_xlat0.xyw = hlslcc_mtx4x4_DeferredProj_WorldToProjectorClip[0].xyw * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_DeferredProj_WorldToProjectorClip[2].xyw * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_DeferredProj_WorldToProjectorClip[3].xyw;
    u_xlat16_7.xy = u_xlat0.xy / u_xlat0.zz;
    u_xlat10_0 = texture(_FalloffTex, u_xlat16_7.xy).x;
    u_xlat16_0 = u_xlat16_2.x * u_xlat10_0;
    u_xlat5.xyz = vec3(_Brightness) * _DayColor.xyz;
    u_xlat3.xyz = u_xlat5.xyz * u_xlat3.xyz;
    SV_Target0 = vec4(u_xlat16_0) * u_xlat3;
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
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat4.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat4.x * 0.5;
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat4.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat1.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat1.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat1.www + u_xlat4.xyz;
    vs_TEXCOORD2.xyz = u_xlat4.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat4.x = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat0.xyz = u_xlat4.xxx * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	float _Brightness;
uniform 	vec4 _DayColor;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct DeferredprojectorFragPropsArray_Type {
	vec4 hlslcc_mtx4x4_DeferredProj_WorldToProjector[4];
	vec4 hlslcc_mtx4x4_DeferredProj_WorldToProjectorClip[4];
};
layout(std140) uniform UnityInstancing_DeferredprojectorFragProps {
	DeferredprojectorFragPropsArray_Type DeferredprojectorFragPropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _CameraNormalsTexture;
uniform lowp sampler2D _FalloffTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec3 u_xlatb1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
vec3 u_xlat5;
mediump vec2 u_xlat16_7;
float u_xlat15;
int u_xlati15;
float u_xlat16;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat15 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat10_1.xyz = texture(_CameraNormalsTexture, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat15 = _ZBufferParams.x * u_xlat15 + _ZBufferParams.y;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlati15 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati15 = u_xlati15 << 3;
    u_xlat1 = u_xlat0.yyyy * DeferredprojectorFragPropsArray[u_xlati15 / 8].hlslcc_mtx4x4_DeferredProj_WorldToProjector[1];
    u_xlat1 = DeferredprojectorFragPropsArray[u_xlati15 / 8].hlslcc_mtx4x4_DeferredProj_WorldToProjector[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = DeferredprojectorFragPropsArray[u_xlati15 / 8].hlslcc_mtx4x4_DeferredProj_WorldToProjector[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + DeferredprojectorFragPropsArray[u_xlati15 / 8].hlslcc_mtx4x4_DeferredProj_WorldToProjector[3];
    u_xlat16_3.xyz = u_xlat1.xyz / u_xlat1.www;
    u_xlat1.xyz = -abs(u_xlat16_3.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xy = u_xlat16_3.xy + vec2(0.5, 0.5);
    u_xlat4.xy = u_xlat16_3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3 = texture(_MainTex, u_xlat4.xy);
    u_xlatb1.xyz = lessThan(u_xlat1.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = (-u_xlat0.xyz) + unity_Builtins0Array[u_xlati15 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat16_2.x<0.0);
#else
    u_xlatb1.x = u_xlat16_2.x<0.0;
#endif
    if((int(u_xlatb1.x) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * DeferredprojectorFragPropsArray[u_xlati15 / 8].hlslcc_mtx4x4_DeferredProj_WorldToProjectorClip[1].xyw;
    u_xlat1.xyz = DeferredprojectorFragPropsArray[u_xlati15 / 8].hlslcc_mtx4x4_DeferredProj_WorldToProjectorClip[0].xyw * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = DeferredprojectorFragPropsArray[u_xlati15 / 8].hlslcc_mtx4x4_DeferredProj_WorldToProjectorClip[2].xyw * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + DeferredprojectorFragPropsArray[u_xlati15 / 8].hlslcc_mtx4x4_DeferredProj_WorldToProjectorClip[3].xyw;
    u_xlat16_7.xy = u_xlat0.xy / u_xlat0.zz;
    u_xlat10_0 = texture(_FalloffTex, u_xlat16_7.xy).x;
    u_xlat16_0 = u_xlat16_2.x * u_xlat10_0;
    u_xlat5.xyz = vec3(_Brightness) * _DayColor.xyz;
    u_xlat3.xyz = u_xlat5.xyz * u_xlat3.xyz;
    SV_Target0 = vec4(u_xlat16_0) * u_xlat3;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_ObjectToWorld[2].xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 hlslcc_mtx4x4_DeferredProj_WorldToProjector[4];
uniform 	vec4 hlslcc_mtx4x4_DeferredProj_WorldToProjectorClip[4];
uniform 	float _Brightness;
uniform 	vec4 _DayColor;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _FalloffTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
uvec4 u_xlatu1;
vec4 u_xlat2;
bvec3 u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec2 u_xlat16_11;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat18 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.xy = u_xlat1.xy * _ScreenParams.xy;
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat1.xy));
    u_xlat18 = _ZBufferParams.x * u_xlat18 + _ZBufferParams.y;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4_DeferredProj_WorldToProjector[1];
    u_xlat2 = hlslcc_mtx4x4_DeferredProj_WorldToProjector[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_DeferredProj_WorldToProjector[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4_DeferredProj_WorldToProjector[3];
    u_xlat16_3.xyz = u_xlat2.xyz / u_xlat2.www;
    u_xlat2.xyz = -abs(u_xlat16_3.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xy = u_xlat16_3.xy + vec2(0.5, 0.5);
    u_xlat4.xy = u_xlat16_3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3 = texture(_MainTex, u_xlat4.xy);
    u_xlatb2.xyz = lessThan(u_xlat2.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb18 = u_xlatb2.y || u_xlatb2.x;
    u_xlatb18 = u_xlatb2.z || u_xlatb18;
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat1.xyz = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).xyz;
    u_xlat16_5.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat16_5.x<0.0);
#else
    u_xlatb18 = u_xlat16_5.x<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4_DeferredProj_WorldToProjectorClip[1].xyw;
    u_xlat0.xyw = hlslcc_mtx4x4_DeferredProj_WorldToProjectorClip[0].xyw * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_DeferredProj_WorldToProjectorClip[2].xyw * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_DeferredProj_WorldToProjectorClip[3].xyw;
    u_xlat16_11.xy = u_xlat0.xy / u_xlat0.zz;
    u_xlat10_0 = texture(_FalloffTex, u_xlat16_11.xy).x;
    u_xlat16_0 = u_xlat16_5.x * u_xlat10_0;
    u_xlat6.xyz = vec3(_Brightness) * _DayColor.xyz;
    u_xlat3.xyz = u_xlat6.xyz * u_xlat3.xyz;
    SV_Target0 = vec4(u_xlat16_0) * u_xlat3;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat4.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat4.x * 0.5;
    u_xlat3.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat4.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat1.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat1.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat1.www + u_xlat4.xyz;
    vs_TEXCOORD2.xyz = u_xlat4.xyz * vec3(-1.0, -1.0, 1.0);
    u_xlat4.x = dot(unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat0.xyz = u_xlat4.xxx * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	float _Brightness;
uniform 	vec4 _DayColor;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct DeferredprojectorFragPropsArray_Type {
	vec4 hlslcc_mtx4x4_DeferredProj_WorldToProjector[4];
	vec4 hlslcc_mtx4x4_DeferredProj_WorldToProjectorClip[4];
};
layout(std140) uniform UnityInstancing_DeferredprojectorFragProps {
	DeferredprojectorFragPropsArray_Type DeferredprojectorFragPropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _FalloffTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2DMS _CameraNormalsTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
uvec4 u_xlatu1;
bool u_xlatb1;
vec4 u_xlat2;
bvec3 u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec2 u_xlat16_11;
float u_xlat18;
int u_xlati18;
float u_xlat19;
void main()
{
    u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD2.z;
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat18 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.xy = u_xlat1.xy * _ScreenParams.xy;
    u_xlat1.xy = floor(u_xlat1.xy);
    u_xlatu1.xy = uvec2(ivec2(u_xlat1.xy));
    u_xlat18 = _ZBufferParams.x * u_xlat18 + _ZBufferParams.y;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlati18 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlati18 = u_xlati18 << 3;
    u_xlat2 = u_xlat0.yyyy * DeferredprojectorFragPropsArray[u_xlati18 / 8].hlslcc_mtx4x4_DeferredProj_WorldToProjector[1];
    u_xlat2 = DeferredprojectorFragPropsArray[u_xlati18 / 8].hlslcc_mtx4x4_DeferredProj_WorldToProjector[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = DeferredprojectorFragPropsArray[u_xlati18 / 8].hlslcc_mtx4x4_DeferredProj_WorldToProjector[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + DeferredprojectorFragPropsArray[u_xlati18 / 8].hlslcc_mtx4x4_DeferredProj_WorldToProjector[3];
    u_xlat16_3.xyz = u_xlat2.xyz / u_xlat2.www;
    u_xlat2.xyz = -abs(u_xlat16_3.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xy = u_xlat16_3.xy + vec2(0.5, 0.5);
    u_xlat4.xy = u_xlat16_3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3 = texture(_MainTex, u_xlat4.xy);
    u_xlatb2.xyz = lessThan(u_xlat2.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb2.x = u_xlatb2.y || u_xlatb2.x;
    u_xlatb2.x = u_xlatb2.z || u_xlatb2.x;
    if((int(u_xlatb2.x) * int(0xffffffffu))!=0){discard;}
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    u_xlat1.xyz = texelFetch(_CameraNormalsTexture, ivec2(u_xlatu1.xy), 0).xyz;
    u_xlat16_5.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = (-u_xlat0.xyz) + unity_Builtins0Array[u_xlati18 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat16_5.x = dot(u_xlat1.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_5.x<0.0);
#else
    u_xlatb1 = u_xlat16_5.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xyz = u_xlat0.yyy * DeferredprojectorFragPropsArray[u_xlati18 / 8].hlslcc_mtx4x4_DeferredProj_WorldToProjectorClip[1].xyw;
    u_xlat1.xyz = DeferredprojectorFragPropsArray[u_xlati18 / 8].hlslcc_mtx4x4_DeferredProj_WorldToProjectorClip[0].xyw * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = DeferredprojectorFragPropsArray[u_xlati18 / 8].hlslcc_mtx4x4_DeferredProj_WorldToProjectorClip[2].xyw * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + DeferredprojectorFragPropsArray[u_xlati18 / 8].hlslcc_mtx4x4_DeferredProj_WorldToProjectorClip[3].xyw;
    u_xlat16_11.xy = u_xlat0.xy / u_xlat0.zz;
    u_xlat10_0 = texture(_FalloffTex, u_xlat16_11.xy).x;
    u_xlat16_0 = u_xlat16_5.x * u_xlat10_0;
    u_xlat6.xyz = vec3(_Brightness) * _DayColor.xyz;
    u_xlat3.xyz = u_xlat6.xyz * u_xlat3.xyz;
    SV_Target0 = vec4(u_xlat16_0) * u_xlat3;
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
}
}
}
}