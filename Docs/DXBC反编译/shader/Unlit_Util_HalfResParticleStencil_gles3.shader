//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/Util_HalfResParticleStencil" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 52129
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
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
    u_xlat2 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat2 * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD1 = _ScreenParams.zwzw * vec4(-0.5, -0.5, 0.5, -0.5) + vec4(0.5, 0.5, -0.5, 0.5);
    vs_TEXCOORD2 = _ScreenParams.zwzw * vec4(-0.5, 0.5, 0.5, 0.5) + vec4(0.5, -0.5, -0.5, -0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform lowp sampler2D _CameraNormalsTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp float u_xlat10_0;
ivec2 u_xlati0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump float u_xlat16_2;
lowp float u_xlat10_3;
ivec2 u_xlati3;
bvec3 u_xlatb3;
lowp float u_xlat10_6;
int u_xlati6;
bvec2 u_xlatb6;
void main()
{
    u_xlat0 = vs_TEXCOORD0.xyxy + vs_TEXCOORD1;
    u_xlat10_0 = texture(_CameraNormalsTexture, u_xlat0.xy).w;
    u_xlat10_3 = texture(_CameraNormalsTexture, u_xlat0.zw).w;
    u_xlat16_1 = u_xlat10_3 * 255.0 + 0.499000013;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlati3.x = int(u_xlat16_1);
    u_xlatb3.xy = equal(u_xlati3.xxxx, ivec4(4, 5, 0, 0)).xy;
    u_xlati0.y = int(uint(u_xlatb3.y) * 0xffffffffu | uint(u_xlatb3.x) * 0xffffffffu);
    u_xlat16_1 = u_xlat10_0 * 255.0 + 0.499000013;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlati0.x = int(u_xlat16_1);
    u_xlatb0.xz = equal(u_xlati0.xxxx, ivec4(4, 0, 5, 0)).xz;
    u_xlati0.x = int(uint(u_xlatb0.z) * 0xffffffffu | uint(u_xlatb0.x) * 0xffffffffu);
    u_xlati0.xy = ~u_xlati0.xy;
    u_xlati0.x = int(uint(u_xlati0.y) | uint(u_xlati0.x));
    u_xlat1 = vs_TEXCOORD0.xyxy + vs_TEXCOORD2;
    u_xlat10_3 = texture(_CameraNormalsTexture, u_xlat1.xy).w;
    u_xlat10_6 = texture(_CameraNormalsTexture, u_xlat1.zw).w;
    u_xlat16_2 = u_xlat10_6 * 255.0 + 0.499000013;
    u_xlat16_2 = floor(u_xlat16_2);
    u_xlati6 = int(u_xlat16_2);
    u_xlatb6.xy = equal(ivec4(u_xlati6), ivec4(4, 5, 4, 5)).xy;
    u_xlati3.y = int(uint(u_xlatb6.y) * 0xffffffffu | uint(u_xlatb6.x) * 0xffffffffu);
    u_xlat16_2 = u_xlat10_3 * 255.0 + 0.499000013;
    u_xlat16_2 = floor(u_xlat16_2);
    u_xlati3.x = int(u_xlat16_2);
    u_xlatb3.xz = equal(u_xlati3.xxxx, ivec4(4, 0, 5, 5)).xz;
    u_xlati3.x = int(uint(u_xlatb3.z) * 0xffffffffu | uint(u_xlatb3.x) * 0xffffffffu);
    u_xlati3.xy = ~u_xlati3.xy;
    u_xlati0.x = int(uint(u_xlati3.x) | uint(u_xlati0.x));
    u_xlati0.x = int(uint(u_xlati3.y) | uint(u_xlati0.x));
    if((u_xlati0.x)!=0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 1.0);
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