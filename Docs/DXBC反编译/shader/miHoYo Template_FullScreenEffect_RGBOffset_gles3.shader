//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo Template/FullScreenEffect/RGBOffset" {
Properties {
[Header(ASE Properties)] _RGBOffset ("RGBOffset", Float) = 0.1
_ScreenScale ("ScreenScale", Float) = 1
_RGBScreenPositionX ("RGBScreenPositionX", Float) = 0.5
_RGBScreenPositionY ("RGBScreenPositionY", Float) = 0.5
_ASEHeader ("", Float) = 0
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 28156
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec3 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz * vec3(-1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _RGBScreenPositionX;
uniform 	mediump float _RGBScreenPositionY;
uniform 	mediump float _ScreenScale;
uniform 	mediump float _RGBOffset;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
void main()
{
    u_xlat16_0.x = _RGBOffset + _ScreenScale;
    u_xlat16_2.xy = vs_TEXCOORD0.xy + (-vec2(_RGBScreenPositionX, _RGBScreenPositionY));
    u_xlat16_0.xw = u_xlat16_2.xy * u_xlat16_0.xx + vec2(_RGBScreenPositionX, _RGBScreenPositionY);
    u_xlat1.x = texture(_MainTex, u_xlat16_0.xw).x;
    u_xlat16_0.x = (-_RGBOffset) + _ScreenScale;
    u_xlat16_0.xw = u_xlat16_2.xy * u_xlat16_0.xx + vec2(_RGBScreenPositionX, _RGBScreenPositionY);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_ScreenScale, _ScreenScale)) + vec2(_RGBScreenPositionX, _RGBScreenPositionY);
    u_xlat1.y = texture(_MainTex, u_xlat16_2.xy).y;
    u_xlat1.z = texture(_MainTex, u_xlat16_0.xw).z;
    u_xlat1.w = 0.0;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_CameraInvProjection[4];
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec3 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_CameraInvProjection[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_CameraInvProjection[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraInvProjection[3].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz * vec3(-1.0, 1.0, 1.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _RGBScreenPositionX;
uniform 	mediump float _RGBScreenPositionY;
uniform 	mediump float _ScreenScale;
uniform 	mediump float _RGBOffset;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
void main()
{
    u_xlat16_0.x = _RGBOffset + _ScreenScale;
    u_xlat16_2.xy = vs_TEXCOORD0.xy + (-vec2(_RGBScreenPositionX, _RGBScreenPositionY));
    u_xlat16_0.xw = u_xlat16_2.xy * u_xlat16_0.xx + vec2(_RGBScreenPositionX, _RGBScreenPositionY);
    u_xlat1.x = texture(_MainTex, u_xlat16_0.xw).x;
    u_xlat16_0.x = (-_RGBOffset) + _ScreenScale;
    u_xlat16_0.xw = u_xlat16_2.xy * u_xlat16_0.xx + vec2(_RGBScreenPositionX, _RGBScreenPositionY);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(vec2(_ScreenScale, _ScreenScale)) + vec2(_RGBScreenPositionX, _RGBScreenPositionY);
    u_xlat1.y = texture(_MainTex, u_xlat16_2.xy).y;
    u_xlat1.z = texture(_MainTex, u_xlat16_0.xw).z;
    u_xlat1.w = 0.0;
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
Keywords { "MSAA_INTERPOLATION" }
""
}
}
}
}
}