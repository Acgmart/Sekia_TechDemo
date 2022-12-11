//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "MiHoYo/Vegetation/Interactor" {
Properties {
_PushIntensity ("Push Intensity", Range(0, 1)) = 0.8
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Opaque" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 8254
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4_ViewProject[4];
uniform 	mediump float _PushIntensity;
in highp vec4 in_POSITION0;
in mediump vec4 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat3;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_ViewProject[1];
    u_xlat1 = hlslcc_mtx4x4_ViewProject[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4_ViewProject[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4_ViewProject[3];
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_POSITION0.xz, in_POSITION0.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = u_xlat1.x * _PushIntensity;
    u_xlat3.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat3.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat3.xy;
    u_xlat3.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat3.xy;
    vs_TEXCOORD0.xy = (-u_xlat3.xy) * u_xlat1.xx + vec2(0.5, 0.5);
    vs_TEXCOORD0.z = u_xlat0.z * 0.5 + 0.5;
    vs_TEXCOORD1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 unity_DeltaTime;
uniform 	vec4 hlslcc_mtx4x4_ReprojectionMatrix[4];
uniform lowp sampler2D _LastLocalWindsMapTex;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
float u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.yy * hlslcc_mtx4x4_ReprojectionMatrix[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_ReprojectionMatrix[0].xy * vs_TEXCOORD1.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4_ReprojectionMatrix[2].xy * vs_TEXCOORD1.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4_ReprojectionMatrix[3].xy * vs_TEXCOORD1.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_LastLocalWindsMapTex, u_xlat0.xy).z;
    u_xlat1 = unity_DeltaTime.x * 1.60000002;
    u_xlat1 = max(u_xlat1, 0.01953125);
    u_xlat0.x = u_xlat10_0 * 5.0 + (-u_xlat1);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    SV_Target0.z = u_xlat0.x * 0.200000003;
    SV_Target0.xyw = vs_TEXCOORD0.xyz;
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
}
}
}
}