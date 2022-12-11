//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "MiHoYo/Nature/SphereWind" {
Properties {
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
  GpuProgramID 55444
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 _ScaleAndWindspeed;
uniform 	vec4 hlslcc_mtx4x4_ViewProject[4];
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * _ScaleAndWindspeed.xxx;
    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_ViewProject[1];
    u_xlat2 = hlslcc_mtx4x4_ViewProject[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_ViewProject[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4_ViewProject[3];
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = u_xlat1;
    u_xlat3 = dot(u_xlat0.xz, u_xlat0.xz);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat3 = max(u_xlat3, 0.0);
    u_xlat0.w = u_xlat3 * u_xlat3;
    vs_TEXCOORD0.xyz = u_xlat0.xzw;
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
uniform 	vec4 _ScaleAndWindspeed;
uniform 	vec4 hlslcc_mtx4x4_ReprojectionMatrix[4];
uniform lowp sampler2D _LastLocalWindsMapTex;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec2 u_xlat2;
int u_xlati2;
int u_xlati4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.yy * hlslcc_mtx4x4_ReprojectionMatrix[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_ReprojectionMatrix[0].xy * vs_TEXCOORD1.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4_ReprojectionMatrix[2].xy * vs_TEXCOORD1.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4_ReprojectionMatrix[3].xy * vs_TEXCOORD1.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_LastLocalWindsMapTex, u_xlat0.xy).z;
    u_xlat2.xy = unity_DeltaTime.xx * vec2(1.60000002, 6.4000001);
    u_xlat2.xy = max(u_xlat2.xy, vec2(0.01953125, 0.01953125));
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat0.x = u_xlat10_0 * 5.0 + u_xlat2.x;
    u_xlat2.x = vs_TEXCOORD0.z * abs(_ScaleAndWindspeed.y);
    u_xlat0.x = min(u_xlat2.x, u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<_ScaleAndWindspeed.y; u_xlati2 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati2 = int((0.0<_ScaleAndWindspeed.y) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = _ScaleAndWindspeed.y<0.0; u_xlati4 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati4 = int((_ScaleAndWindspeed.y<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlati2 = (-u_xlati2) + u_xlati4;
    u_xlat2.x = float(u_xlati2);
    u_xlat2.x = u_xlat2.x * u_xlat0.x;
    u_xlat1.z = u_xlat0.x * 0.200000003;
    u_xlat0.x = u_xlat2.x * -0.100000001;
    u_xlat2.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xy = u_xlat2.xx * vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat1.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat1.w = 1.0;
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
}
}
}
}