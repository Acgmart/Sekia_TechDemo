//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "MiHoYo/Nature/LocalWindsMapReproject" {
Properties {
_MainTex ("MainTex", 2D) = "white" { }
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
  GpuProgramID 59818
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_ReprojectionMatrix[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_ReprojectionMatrix[1];
    u_xlat1 = hlslcc_mtx4x4_ReprojectionMatrix[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_ReprojectionMatrix[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4_ReprojectionMatrix[3] * u_xlat0.wwww + u_xlat1;
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
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec2 u_xlat2;
ivec2 u_xlati2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
ivec2 u_xlati10;
void main()
{
    u_xlat0 = unity_DeltaTime.x * 1.60000002;
    u_xlat0 = max(u_xlat0, 0.01953125);
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat1 = texture(_MainTex, u_xlat4.xy);
    u_xlat0 = u_xlat1.z * 5.0 + (-u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlat4.x = u_xlat0 * unity_DeltaTime.x;
    u_xlat1.z = u_xlat0 * 0.200000003;
    u_xlat0 = u_xlat4.x * 0.159999996;
    u_xlat0 = max(u_xlat0, 0.0078125);
    u_xlat4.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati2.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat4.xyxx).xy) * 0xFFFFFFFFu);
    u_xlati10.xy = ivec2(uvec2(lessThan(u_xlat4.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = (-u_xlati2.xy) + u_xlati10.xy;
    u_xlat2.xy = vec2(u_xlati2.xy);
    u_xlat2.xy = (-vec2(u_xlat0)) * u_xlat2.xy + u_xlat4.xy;
    u_xlatb0.xy = greaterThanEqual(vec4(u_xlat0), abs(u_xlat4.xyxx)).xy;
    u_xlat16_3.x = (u_xlatb0.x) ? float(0.0) : u_xlat2.x;
    u_xlat16_3.y = (u_xlatb0.y) ? float(0.0) : u_xlat2.y;
    u_xlat1.xy = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
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