//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Decal/Deferred Decal Particle" {
Properties {
_MainTex ("Particle Texture", 2D) = "white" { }
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend ("SrcBlend", Float) = 5
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlend ("DstBlend", Float) = 10
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOp ("BlendOp", Float) = 0
}
SubShader {
 Pass {
  Tags { "LIGHTMODE" = "PREPASSDECALFINAL" }
  ZTest GEqual
  ZWrite Off
  Cull Front
  GpuProgramID 42473
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
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
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD2 = in_COLOR0 * _TintColor;
    vs_TEXCOORD4 = in_TEXCOORD0;
    u_xlat0.xyz = sin(in_TEXCOORD1.xyz);
    u_xlat1.xyz = cos(in_TEXCOORD1.xyz);
    vs_TEXCOORD5.x = u_xlat1.x * u_xlat1.y;
    vs_TEXCOORD5.y = u_xlat0.x * u_xlat1.y;
    vs_TEXCOORD5.z = (-u_xlat0.y);
    u_xlat12 = u_xlat1.x * u_xlat1.z;
    u_xlat2.xy = u_xlat0.yx * u_xlat0.zz;
    vs_TEXCOORD6.y = u_xlat2.x * u_xlat0.x + u_xlat12;
    u_xlat3.xyz = u_xlat0.yxz * u_xlat1.zzx;
    vs_TEXCOORD6.x = u_xlat2.x * u_xlat1.x + (-u_xlat3.y);
    vs_TEXCOORD7.x = u_xlat3.x * u_xlat1.x + u_xlat2.y;
    vs_TEXCOORD7.y = u_xlat3.x * u_xlat0.x + (-u_xlat3.z);
    vs_TEXCOORD6.z = u_xlat0.z * u_xlat1.y;
    vs_TEXCOORD7.z = u_xlat1.z * u_xlat1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec3 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vs_TEXCOORD4.xyz);
    u_xlat0.xyz = u_xlat0.xyz / vs_TEXCOORD4.www;
    u_xlat1.y = dot(vs_TEXCOORD6.xyz, u_xlat0.xyz);
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat1.z = dot(vs_TEXCOORD7.xyz, u_xlat0.xyz);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat1.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlatb0.xyz = lessThan(u_xlat0.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0 = vs_TEXCOORD2 + vs_TEXCOORD2;
    u_xlat16_0 = u_xlat10_1 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * vec4(_EmissionScaler);
    SV_Target0 = u_xlat16_0;
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
uniform 	mediump vec4 _TintColor;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD7;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
    vs_TEXCOORD2 = in_COLOR0 * _TintColor;
    vs_TEXCOORD4 = in_TEXCOORD0;
    u_xlat0.xyz = sin(in_TEXCOORD1.xyz);
    u_xlat1.xyz = cos(in_TEXCOORD1.xyz);
    vs_TEXCOORD5.x = u_xlat1.x * u_xlat1.y;
    vs_TEXCOORD5.y = u_xlat0.x * u_xlat1.y;
    vs_TEXCOORD5.z = (-u_xlat0.y);
    u_xlat12 = u_xlat1.x * u_xlat1.z;
    u_xlat2.xy = u_xlat0.yx * u_xlat0.zz;
    vs_TEXCOORD6.y = u_xlat2.x * u_xlat0.x + u_xlat12;
    u_xlat3.xyz = u_xlat0.yxz * u_xlat1.zzx;
    vs_TEXCOORD6.x = u_xlat2.x * u_xlat1.x + (-u_xlat3.y);
    vs_TEXCOORD7.x = u_xlat3.x * u_xlat1.x + u_xlat2.y;
    vs_TEXCOORD7.y = u_xlat3.x * u_xlat0.x + (-u_xlat3.z);
    vs_TEXCOORD6.z = u_xlat0.z * u_xlat1.y;
    vs_TEXCOORD7.z = u_xlat1.z * u_xlat1.y;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec3 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2.x = _ProjectionParams.z / vs_TEXCOORD1.z;
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-vs_TEXCOORD4.xyz);
    u_xlat0.xyz = u_xlat0.xyz / vs_TEXCOORD4.www;
    u_xlat1.y = dot(vs_TEXCOORD6.xyz, u_xlat0.xyz);
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, u_xlat0.xyz);
    u_xlat1.z = dot(vs_TEXCOORD7.xyz, u_xlat0.xyz);
    u_xlat0.xyz = -abs(u_xlat1.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat1.w = (-u_xlat1.x);
    u_xlat1.xy = vec2(u_xlat1.w + float(0.5), u_xlat1.z + float(0.5));
    u_xlat1.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlatb0.xyz = lessThan(u_xlat0.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    u_xlatb0.x = u_xlatb0.z || u_xlatb0.x;
    if((int(u_xlatb0.x) * int(0xffffffffu))!=0){discard;}
    u_xlat16_0 = vs_TEXCOORD2 + vs_TEXCOORD2;
    u_xlat16_0 = u_xlat10_1 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * vec4(_EmissionScaler);
    SV_Target0 = u_xlat16_0;
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