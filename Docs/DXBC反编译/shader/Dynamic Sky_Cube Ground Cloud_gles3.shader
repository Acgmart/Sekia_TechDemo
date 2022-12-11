//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Dynamic Sky/Cube Ground Cloud" {
Properties {
[Header(Basic)] _Color ("Color", Color) = (1,1,1,1)
_InnerColor ("Inner Color", Color) = (1,1,1,1)
_MaxThickness ("Max Thickness", Range(0, 100)) = 1
[Header(Height)] _HeightTex ("Height Tex", 2D) = "white" { }
_FlowSpeedX ("Flow Speed X", Range(-10, 10)) = 0.5
_FlowSpeedY ("Flow Speed Y", Range(-10, 10)) = 0
_Intensity ("Intensity", Range(0, 5)) = 1
_LayerSpeed ("Layer Speed", Vector) = (1,1,1,1)
_LayerTiling ("Layer Tiling", Vector) = (1,1,1,1)
_LayerReduction ("Layer Reduction", Vector) = (0,0,0,0)
[Header(Lighting)] _DiffuseWrap ("Diffuse Wrap", Range(0, 5)) = 0.4
_AmbientIntensity ("Ambient Intensity", Range(0, 1)) = 1
[Header(Fade)] _FadeBeginDistance ("Fade Begin Distance", Float) = 10
_FadeEndDistance ("Fade End Distance", Float) = 60
}
SubShader {
 LOD 100
 Tags { "AllowHalfResolution" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "AllowHalfResolution" = "False" "DebugView" = "On" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Front
  GpuProgramID 11554
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + in_POSITION0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    vs_TEXCOORD0.w = u_xlat1.x;
    vs_TEXCOORD1.w = u_xlat1.y;
    vs_TEXCOORD2.w = u_xlat1.z;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _InnerColor;
uniform 	mediump float _MaxThickness;
uniform 	mediump vec4 _HeightTex_ST;
uniform 	mediump float _FlowSpeedX;
uniform 	mediump float _FlowSpeedY;
uniform 	mediump float _Intensity;
uniform 	mediump vec4 _LayerSpeed;
uniform 	mediump vec4 _LayerTiling;
uniform 	mediump vec4 _LayerReduction;
uniform 	mediump float _DiffuseWrap;
uniform 	mediump float _AmbientIntensity;
uniform 	mediump float _FadeBeginDistance;
uniform 	mediump float _FadeEndDistance;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _HeightTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec2 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec2 u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_18;
float u_xlat19;
mediump float u_xlat16_19;
void main()
{
    u_xlat16_0.xyz = (-vs_TEXCOORD2.xyz) + vec3(-0.5, -0.5, -0.5);
    u_xlat1.x = vs_TEXCOORD0.w;
    u_xlat1.y = vs_TEXCOORD1.w;
    u_xlat1.z = vs_TEXCOORD2.w;
    u_xlat16_18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_2.xyz = vec3(u_xlat16_18) * u_xlat1.xyz;
    u_xlat16_3.xyz = vec3(1.0) / vec3(u_xlat16_2.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_4.xyz = (-vs_TEXCOORD2.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    u_xlat16_0.xyz = min(u_xlat16_0.xyz, u_xlat16_3.xyz);
    u_xlat16_0.xy = max(u_xlat16_0.yz, u_xlat16_0.xx);
    u_xlat16_0.x = max(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat16_1 = max(u_xlat16_0.x, 0.0);
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_1) + vs_TEXCOORD2.xyz;
    u_xlat16_19 = max((-u_xlat16_2.y), 9.99999975e-05);
    u_xlat16_19 = 0.100000001 / u_xlat16_19;
    u_xlat16_0.xy = u_xlat16_2.xz * vec2(u_xlat16_19) + u_xlat1.xz;
    u_xlat16_12.xy = u_xlat16_2.xz * vec2(u_xlat16_19) + u_xlat16_0.xy;
    u_xlat16_0.xy = u_xlat16_0.xy * _LayerTiling.yy;
    u_xlat16_0.xy = u_xlat16_0.xy * _HeightTex_ST.xy + _HeightTex_ST.zw;
    u_xlat16_2.xy = u_xlat16_2.xz * vec2(u_xlat16_19) + u_xlat16_12.xy;
    u_xlat16_12.xy = u_xlat16_12.xy * _LayerTiling.zz;
    u_xlat16_12.xy = u_xlat16_12.xy * _HeightTex_ST.xy + _HeightTex_ST.zw;
    u_xlat16_2.xy = u_xlat16_2.xy * _LayerTiling.ww;
    u_xlat16_2.xy = u_xlat16_2.xy * _HeightTex_ST.xy + _HeightTex_ST.zw;
    u_xlat3 = _Time.xxxx * vec4(_FlowSpeedX, _FlowSpeedY, _FlowSpeedX, _FlowSpeedY);
    u_xlat16_2.xy = u_xlat3.zw * _LayerSpeed.ww + u_xlat16_2.xy;
    u_xlat2.w = texture(_HeightTex, u_xlat16_2.xy).x;
    u_xlat16_12.xy = u_xlat3.xy * _LayerSpeed.zz + u_xlat16_12.xy;
    u_xlat2.z = texture(_HeightTex, u_xlat16_12.xy).x;
    u_xlat16_0.xy = u_xlat3.zw * _LayerSpeed.yy + u_xlat16_0.xy;
    u_xlat2.y = texture(_HeightTex, u_xlat16_0.xy).x;
    u_xlat16_0.xy = u_xlat1.xz * _LayerTiling.xx;
    u_xlat16_0.xy = u_xlat16_0.xy * _HeightTex_ST.xy + _HeightTex_ST.zw;
    u_xlat16_0.xy = u_xlat3.zw * _LayerSpeed.xx + u_xlat16_0.xy;
    u_xlat2.x = texture(_HeightTex, u_xlat16_0.xy).x;
    u_xlat16_0 = u_xlat2 + (-_LayerReduction);
    u_xlat16_6.x = (-u_xlat16_0.y) * u_xlat16_0.x + u_xlat16_0.y;
    u_xlat16_0.x = u_xlat16_6.x + u_xlat16_0.x;
    u_xlat16_6.x = (-u_xlat16_0.z) * u_xlat16_0.x + u_xlat16_0.z;
    u_xlat16_0.x = u_xlat16_6.x + u_xlat16_0.x;
    u_xlat16_6.x = (-u_xlat16_0.w) * u_xlat16_0.x + u_xlat16_0.w;
    u_xlat16_0.x = u_xlat16_6.x + u_xlat16_0.x;
    u_xlat16_19 = u_xlat16_0.x + -0.800000012;
    u_xlat5.x = vs_TEXCOORD2.y * 10.0 + -5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat19 = u_xlat5.x * u_xlat16_19 + 0.800000012;
    u_xlat5.xy = u_xlat1.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * u_xlat1.xx + u_xlat5.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * u_xlat1.zz + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy + hlslcc_mtx4x4unity_ObjectToWorld[3].xz;
    u_xlat1.xy = u_xlat1.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat1.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + (-_FadeBeginDistance);
    u_xlat1.x = u_xlat1.x / _FadeEndDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat1.x) * u_xlat19 + u_xlat19;
    u_xlat1.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xz = vec2(u_xlat1.x * vs_TEXCOORD1.y, u_xlat1.x * vs_TEXCOORD1.z);
    u_xlat7 = (-u_xlat1.y) / u_xlat1.z;
    u_xlat16_6.x = u_xlat1.x * 20.0 + 0.200000003;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat1.xz = gl_FragCoord.xy * _ScreenParams.zw + (-gl_FragCoord.xy);
    u_xlat1.x = texture(_CameraDepthTexture, u_xlat1.xz).x;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat13 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat13 = u_xlat13 * vs_TEXCOORD0.z;
    u_xlat16_12.x = float(1.0) / float(u_xlat13);
    u_xlat16_18 = u_xlat16_12.x * (-u_xlat1.x);
    u_xlat1.x = u_xlat16_12.x * vs_TEXCOORD0.z;
    u_xlat16_12.x = min(u_xlat16_18, u_xlat1.x);
    u_xlat16_18 = min(u_xlat16_18, u_xlat7);
    u_xlat16_12.x = (-u_xlat16_18) + u_xlat16_12.x;
    u_xlat16_12.x = min(u_xlat16_12.x, _MaxThickness);
    u_xlat16_12.x = u_xlat16_12.x / _MaxThickness;
    u_xlat16_12.x = u_xlat16_12.x * _Intensity;
    u_xlat16_12.x = u_xlat16_0.x * u_xlat16_12.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12.x = min(max(u_xlat16_12.x, 0.0), 1.0);
#else
    u_xlat16_12.x = clamp(u_xlat16_12.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_12.x * u_xlat16_6.x;
    u_xlat16_6.xyz = _Color.xyz + (-_InnerColor.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_6.xyz + _InnerColor.xyz;
    u_xlat16_18 = _WorldSpaceLightPos0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat16_18 + _DiffuseWrap;
    u_xlat16_18 = u_xlat16_18 * _DiffuseWrap + u_xlat16_4.x;
    u_xlat16_18 = u_xlat16_18 + 1.0;
    u_xlat16_18 = float(1.0) / float(u_xlat16_18);
    u_xlat16_18 = u_xlat16_18 * u_xlat16_4.x;
    u_xlat16_4.x = dot(unity_SHAr.yw, vec2(1.0, 1.0));
    u_xlat16_4.y = dot(unity_SHAg.yw, vec2(1.0, 1.0));
    u_xlat16_4.z = dot(unity_SHAb.yw, vec2(1.0, 1.0));
    u_xlat16_4.xyz = u_xlat16_4.xyz + (-unity_SHC.xyz);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_AmbientIntensity, _AmbientIntensity, _AmbientIntensity));
    u_xlat16_4.xyz = _LightColor0.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
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