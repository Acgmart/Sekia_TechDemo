//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Scene/Dissolve" {
Properties {
_Scale ("Scale Compared to Maya", Float) = 0.01
[Header(Element View)] _ElementViewEleID ("Element ID", Float) = 0
[MHYToggle] _ReceiveShadow ("Receive Shadow", Float) = 0
_MaterialShadowBias ("Shadow Bias", Range(0, 0.1)) = 0
[MHYToggle] _EnableEmission ("Enable Emission", Float) = 0
[Toggle] _EnableAlphaTest ("Enable Alpha Test", Float) = 0
_CutOff ("Mask Clip Value", Range(0, 1)) = 0
[Header(Dithering)] [Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
_Color ("Main Color", Color) = (1,1,1,0)
_MainTex ("Main Tex", 2D) = "white" { }
_EmissionColor ("Emission Color", Color) = (0,0,0,0)
_EmissionStrenght ("Emission Strenght", Float) = 1
_BumpMap ("Main Normal Map", 2D) = "bump" { }
_DissolveNoise ("DissolveNoise", 2D) = "white" { }
_DissolveValue ("DissolveValue", Range(0, 1)) = 0
[Toggle(_DISSOLVEBYVERTEXALPHA_ON)] _DissolveByVertexAlpha ("DissolveByVertexAlpha", Float) = 0
_DissolveEdgeWidth ("DissolveEdgeWidth", Float) = 1.5
_DissolveColor ("DissolveColor", Color) = (0.2058824,0.8685598,1,0)
_RGColor ("Rim Glow Color", Color) = (1,1,1,0)
_RGPower ("Rim Glow Power", Range(0.0001, 10)) = 4.825887
_MainMaskMapRSmoothnessGMetallicBBlendAEmission ("Main Mask Map(R Smoothness,G Metallic,B Blend,A Emission)", 2D) = "white" { }
_RGStrength ("Rim Glow Strength", Range(0, 20)) = 5.380094
_CubeMap ("CubeMap", Cube) = "white" { }
_DepthBiasScaled ("Depth bias scaled", Range(0, 16)) = 1.8
_texcoord ("", 2D) = "white" { }
}
SubShader {
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "HYBRIDDEFERRED"
  Tags { "LIGHTMODE" = "HYBRIDDEFERRED" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 62962
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
float u_xlat10;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD0.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _DepthBiasScaled;
uniform 	float _EnableEmission;
uniform 	vec4 _DissolveNoise_ST;
uniform 	float _DissolveValue;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _CubeMap_HDR;
uniform 	vec4 _CubeMap_TexelSize;
uniform 	float _DissolveEdgeWidth;
uniform 	vec4 _DissolveColor;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrenght;
uniform 	mediump float _RGStrength;
uniform 	vec4 _RGColor;
uniform 	mediump float _RGPower;
uniform lowp sampler2D _DissolveNoise;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainMaskMapRSmoothnessGMetallicBBlendAEmission;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube _CubeMap;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
vec2 u_xlat12;
lowp vec3 u_xlat10_12;
bool u_xlatb12;
mediump vec3 u_xlat16_15;
vec3 u_xlat16;
mediump float u_xlat16_16;
bool u_xlatb16;
mediump vec3 u_xlat16_21;
mediump float u_xlat16_27;
float u_xlat36;
mediump float u_xlat16_36;
float u_xlat37;
mediump float u_xlat16_39;
float u_xlat40;
bool u_xlatb40;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy * _DissolveNoise_ST.xy + _DissolveNoise_ST.zw;
    u_xlat0.x = texture(_DissolveNoise, u_xlat0.xy).x;
    u_xlat12.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_12.xyz = texture(_MainTex, u_xlat12.xy).xyz;
    u_xlat1.xyz = u_xlat10_12.xyz * _Color.xyz;
    u_xlat2.xy = vs_TEXCOORD3.xy * _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST.xy + _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST.zw;
    u_xlat10_2.xyz = texture(_MainMaskMapRSmoothnessGMetallicBBlendAEmission, u_xlat2.xy).xyw;
    u_xlat16_3.x = u_xlat10_2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_15.x = (-u_xlat10_2.x) + 1.0;
    u_xlat16_15.x = max(u_xlat16_15.x, 0.00100000005);
    u_xlat16_15.x = min(u_xlat16_15.x, 0.999000013);
    u_xlat37 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat2.xyw = vec3(u_xlat37) * vs_TEXCOORD4.xyz;
    u_xlat4.xy = vs_TEXCOORD3.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat10_4.xyz = texture(_BumpMap, u_xlat4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_5.xyz);
    u_xlat6.x = vs_TEXCOORD5.y;
    u_xlat6.y = vs_TEXCOORD7.y;
    u_xlat6.z = vs_TEXCOORD6.y;
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat16_5.xyz);
    u_xlat6.x = vs_TEXCOORD5.z;
    u_xlat6.y = vs_TEXCOORD7.z;
    u_xlat6.z = vs_TEXCOORD6.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_5.xyz);
    u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat4.xyz;
    u_xlat16_5.xyz = _Color.xyz * u_xlat10_12.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_27 = u_xlat16_15.x * u_xlat16_3.x;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * -0.5 + 1.0;
    u_xlat16_8.xyz = vec3(u_xlat16_27) * u_xlat16_7.xyz;
    u_xlat16_39 = dot(u_xlat2.xyw, u_xlat6.xyz);
    u_xlat16_43 = u_xlat16_39 + u_xlat16_39;
    u_xlat16_9.xyz = u_xlat6.xyz * (-vec3(u_xlat16_43)) + u_xlat2.xyw;
    u_xlat16_9.xyz = (-u_xlat16_9.xyz);
    u_xlat16_43 = log2(_CubeMap_TexelSize.z);
    u_xlat16_43 = u_xlat16_15.x * u_xlat16_43;
    u_xlat10_5 = textureLod(_CubeMap, u_xlat16_9.xyz, u_xlat16_43);
    u_xlat16_43 = u_xlat10_5.w + -1.0;
    u_xlat16_43 = _CubeMap_HDR.w * u_xlat16_43 + 1.0;
    u_xlat16_43 = log2(u_xlat16_43);
    u_xlat16_43 = u_xlat16_43 * _CubeMap_HDR.y;
    u_xlat16_43 = exp2(u_xlat16_43);
    u_xlat16_43 = u_xlat16_43 * _CubeMap_HDR.x;
    u_xlat16_10.xyz = u_xlat10_5.xyz * vec3(u_xlat16_43);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_10.xyz;
    u_xlat16_43 = (-u_xlat16_15.x) + 1.0;
    u_xlat16_10.xyz = vec3(u_xlat16_43) * u_xlat16_10.xyz;
    u_xlat16_39 = max(u_xlat16_39, 0.00100000005);
    u_xlat16_44 = dot(u_xlat6.xyz, u_xlat16_9.xyz);
    u_xlat16_44 = max(u_xlat16_44, 0.00100000005);
    u_xlat16_9.x = u_xlat16_39 * -5.55472994 + -6.98316002;
    u_xlat16_9.x = u_xlat16_39 * u_xlat16_9.x;
    u_xlat16_9.x = exp2(u_xlat16_9.x);
    u_xlat16_21.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_27) + vec3(1.0, 1.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_21.xyz * u_xlat16_9.xxx + u_xlat16_8.xyz;
    u_xlat16_15.x = u_xlat16_15.x * u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x * 0.5;
    u_xlat16_15.x = max(u_xlat16_15.x, 9.99999975e-05);
    u_xlat16_27 = (-u_xlat16_15.x) + 1.0;
    u_xlat16_9.x = u_xlat16_44 * u_xlat16_27 + u_xlat16_15.x;
    u_xlat16_9.x = float(1.0) / u_xlat16_9.x;
    u_xlat16_15.x = u_xlat16_39 * u_xlat16_27 + u_xlat16_15.x;
    u_xlat16_15.x = float(1.0) / u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x * u_xlat16_9.x;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz;
    u_xlat16_8.xyz = u_xlat16_15.xxx * u_xlat16_8.xyz;
    u_xlat16_15.xyz = vec3(u_xlat16_39) * u_xlat16_8.xyz;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_8.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_15.xyz * vec3(u_xlat16_44) + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb12 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb12){
        u_xlat12.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat36 = texture(_CameraDepthBlendTexture, u_xlat12.xy).x;
        u_xlat36 = _ZBufferParams.z * u_xlat36 + _ZBufferParams.w;
        u_xlat36 = float(1.0) / u_xlat36;
        u_xlat36 = u_xlat36 + (-vs_TEXCOORD1.w);
        u_xlat36 = abs(u_xlat36) * _DepthBiasScaled;
#ifdef UNITY_ADRENO_ES3
        u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
        u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
        u_xlat36 = sqrt(u_xlat36);
        u_xlat10_2.xyw = texture(_CameraDepthBlendNormTexture, u_xlat12.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_2.xyw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_2.xyw = texture(_CameraDepthBlendDiffTexture, u_xlat12.xy).xyz;
        u_xlat16_11.xyz = (-u_xlat10_2.xyw) + u_xlat16_3.xyz;
        u_xlat3.xyz = vec3(u_xlat36) * u_xlat16_11.xyz + u_xlat10_2.xyw;
        u_xlat2.xyw = u_xlat4.xyz * vec3(u_xlat37) + (-u_xlat16_8.xyz);
        u_xlat2.xyw = vec3(u_xlat36) * u_xlat2.xyw + u_xlat16_8.xyz;
        u_xlat4.x = dot(u_xlat2.xyw, u_xlat2.xyw);
        u_xlat4.x = inversesqrt(u_xlat4.x);
        u_xlat2.xyw = u_xlat2.xyw * u_xlat4.xxx;
        u_xlat16_3.xyz = u_xlat3.xyz;
        u_xlat16_2.xyw = u_xlat2.xyw;
        u_xlat16_36 = u_xlat36;
    } else {
        u_xlat16_2.xyw = u_xlat6.xyz;
        u_xlat16_36 = 1.0;
    //ENDIF
    }
    u_xlat4.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_4.x = texture(_CameraDepthBlendDiffTexture, u_xlat4.xy).w;
    u_xlat16_39 = (-u_xlat10_4.x) + u_xlat16_43;
    u_xlat16_1.x = u_xlat16_36 * u_xlat16_39 + u_xlat10_4.x;
    u_xlat4.xyz = (-vs_TEXCOORD8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat4.xyz = vec3(u_xlat40) * u_xlat4.xyz;
    u_xlat40 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat11.xyz = vec3(u_xlat40) * vs_TEXCOORD6.xyz;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat11.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = max(u_xlat4.x, 9.99999975e-05);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _RGPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat16.x = _DissolveValue * _DissolveEdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16.x>=u_xlat0.x);
#else
    u_xlatb16 = u_xlat16.x>=u_xlat0.x;
#endif
    u_xlat16.x = u_xlatb16 ? 1.0 : float(0.0);
    u_xlat16_8.xyz = _EmissionColor.xyz * vec3(_EmissionStrenght);
    u_xlat16_8.xyz = u_xlat10_2.zzz * u_xlat16_8.xyz;
    u_xlat16.xyz = u_xlat16.xxx * _DissolveColor.xyz + u_xlat16_8.xyz;
    u_xlat11.xyz = vec3(vec3(_RGStrength, _RGStrength, _RGStrength)) * _RGColor.xyz;
    u_xlat4.xyz = u_xlat11.xyz * u_xlat4.xxx + u_xlat16.xyz;
    u_xlat40 = dot(u_xlat4.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
#ifdef UNITY_ADRENO_ES3
    u_xlatb40 = !!(0.0500000007>=u_xlat40);
#else
    u_xlatb40 = 0.0500000007>=u_xlat40;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb40)) ? vec3(0.0, 0.0, 0.0) : u_xlat4.xyz;
    u_xlat16_39 = dot(u_xlat16_2.xyw, u_xlat16_2.xyw);
    u_xlat16_39 = inversesqrt(u_xlat16_39);
    u_xlat16_9.xyz = u_xlat16_2.xyw * vec3(u_xlat16_39);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.5<_EnableEmission);
#else
    u_xlatb4 = 0.5<_EnableEmission;
#endif
    u_xlat16_39 = dot(u_xlat16_8.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(9.99999975e-05<u_xlat16_39);
#else
    u_xlatb16 = 9.99999975e-05<u_xlat16_39;
#endif
    u_xlatb4 = u_xlatb16 && u_xlatb4;
    u_xlat16_1.yzw = u_xlat16_3.xyz + u_xlat16_8.xyz;
    u_xlat16_39 = max(u_xlat16_1.w, u_xlat16_1.z);
    u_xlat16_0.w = max(u_xlat16_1.y, u_xlat16_39);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(1.0<u_xlat16_0.w);
#else
    u_xlatb16 = 1.0<u_xlat16_0.w;
#endif
    u_xlat16_0.xyz = vec3(u_xlat16_1.y / u_xlat16_0.w, u_xlat16_1.z / u_xlat16_0.w, u_xlat16_1.w / u_xlat16_0.w);
    u_xlat16_0 = (bool(u_xlatb16)) ? u_xlat16_0 : u_xlat16_1.yzwx;
    u_xlat16_16 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16.x = sqrt(u_xlat16_16);
    SV_Target1.xyz = (bool(u_xlatb4)) ? u_xlat16_0.xyz : u_xlat16_3.xyz;
    u_xlat16_3.x = 0.400000006;
    SV_Target2.w = (u_xlatb4) ? u_xlat16.x : u_xlat16_1.x;
    SV_Target1.w = (u_xlatb4) ? u_xlat16_0.w : u_xlat16_3.x;
    SV_Target0.w = (u_xlatb4) ? 0.00392156886 : 0.0;
    SV_Target0.xyz = u_xlat16_9.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_3.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb4) ? u_xlat16_3.x : u_xlat16_7.z;
    SV_Target2.xy = u_xlat16_7.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
float u_xlat10;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD0.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _DepthBiasScaled;
uniform 	float _EnableEmission;
uniform 	float _CutOff;
uniform 	vec4 _DissolveNoise_ST;
uniform 	float _DissolveValue;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _CubeMap_HDR;
uniform 	vec4 _CubeMap_TexelSize;
uniform 	float _DissolveEdgeWidth;
uniform 	vec4 _DissolveColor;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrenght;
uniform 	mediump float _RGStrength;
uniform 	vec4 _RGColor;
uniform 	mediump float _RGPower;
uniform lowp sampler2D _DissolveNoise;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainMaskMapRSmoothnessGMetallicBBlendAEmission;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube _CubeMap;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
vec2 u_xlat12;
lowp vec3 u_xlat10_12;
bool u_xlatb12;
mediump vec3 u_xlat16_15;
vec3 u_xlat16;
mediump float u_xlat16_16;
bool u_xlatb16;
mediump vec3 u_xlat16_21;
mediump float u_xlat16_27;
float u_xlat36;
mediump float u_xlat16_36;
float u_xlat37;
mediump float u_xlat16_39;
float u_xlat40;
bool u_xlatb40;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy * _DissolveNoise_ST.xy + _DissolveNoise_ST.zw;
    u_xlat0.x = texture(_DissolveNoise, u_xlat0.xy).x;
    u_xlat12.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_12.xyz = texture(_MainTex, u_xlat12.xy).xyz;
    u_xlat1.xyz = u_xlat10_12.xyz * _Color.xyz;
    u_xlat2.xy = vs_TEXCOORD3.xy * _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST.xy + _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST.zw;
    u_xlat10_2.xyz = texture(_MainMaskMapRSmoothnessGMetallicBBlendAEmission, u_xlat2.xy).xyw;
    u_xlat16_3.x = u_xlat10_2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_15.x = (-u_xlat10_2.x) + 1.0;
    u_xlat16_15.x = max(u_xlat16_15.x, 0.00100000005);
    u_xlat16_15.x = min(u_xlat16_15.x, 0.999000013);
    u_xlat37 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat2.xyw = vec3(u_xlat37) * vs_TEXCOORD4.xyz;
    u_xlat4.xy = vs_TEXCOORD3.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat10_4.xyz = texture(_BumpMap, u_xlat4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_5.xyz);
    u_xlat6.x = vs_TEXCOORD5.y;
    u_xlat6.y = vs_TEXCOORD7.y;
    u_xlat6.z = vs_TEXCOORD6.y;
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat16_5.xyz);
    u_xlat6.x = vs_TEXCOORD5.z;
    u_xlat6.y = vs_TEXCOORD7.z;
    u_xlat6.z = vs_TEXCOORD6.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_5.xyz);
    u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat4.xyz;
    u_xlat16_5.xyz = _Color.xyz * u_xlat10_12.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_27 = u_xlat16_15.x * u_xlat16_3.x;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * -0.5 + 1.0;
    u_xlat16_8.xyz = vec3(u_xlat16_27) * u_xlat16_7.xyz;
    u_xlat16_39 = dot(u_xlat2.xyw, u_xlat6.xyz);
    u_xlat16_43 = u_xlat16_39 + u_xlat16_39;
    u_xlat16_9.xyz = u_xlat6.xyz * (-vec3(u_xlat16_43)) + u_xlat2.xyw;
    u_xlat16_9.xyz = (-u_xlat16_9.xyz);
    u_xlat16_43 = log2(_CubeMap_TexelSize.z);
    u_xlat16_43 = u_xlat16_15.x * u_xlat16_43;
    u_xlat10_5 = textureLod(_CubeMap, u_xlat16_9.xyz, u_xlat16_43);
    u_xlat16_43 = u_xlat10_5.w + -1.0;
    u_xlat16_43 = _CubeMap_HDR.w * u_xlat16_43 + 1.0;
    u_xlat16_43 = log2(u_xlat16_43);
    u_xlat16_43 = u_xlat16_43 * _CubeMap_HDR.y;
    u_xlat16_43 = exp2(u_xlat16_43);
    u_xlat16_43 = u_xlat16_43 * _CubeMap_HDR.x;
    u_xlat16_10.xyz = u_xlat10_5.xyz * vec3(u_xlat16_43);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_10.xyz;
    u_xlat16_43 = (-u_xlat16_15.x) + 1.0;
    u_xlat16_10.xyz = vec3(u_xlat16_43) * u_xlat16_10.xyz;
    u_xlat16_39 = max(u_xlat16_39, 0.00100000005);
    u_xlat16_44 = dot(u_xlat6.xyz, u_xlat16_9.xyz);
    u_xlat16_44 = max(u_xlat16_44, 0.00100000005);
    u_xlat16_9.x = u_xlat16_39 * -5.55472994 + -6.98316002;
    u_xlat16_9.x = u_xlat16_39 * u_xlat16_9.x;
    u_xlat16_9.x = exp2(u_xlat16_9.x);
    u_xlat16_21.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_27) + vec3(1.0, 1.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_21.xyz * u_xlat16_9.xxx + u_xlat16_8.xyz;
    u_xlat16_15.x = u_xlat16_15.x * u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x * 0.5;
    u_xlat16_15.x = max(u_xlat16_15.x, 9.99999975e-05);
    u_xlat16_27 = (-u_xlat16_15.x) + 1.0;
    u_xlat16_9.x = u_xlat16_44 * u_xlat16_27 + u_xlat16_15.x;
    u_xlat16_9.x = float(1.0) / u_xlat16_9.x;
    u_xlat16_15.x = u_xlat16_39 * u_xlat16_27 + u_xlat16_15.x;
    u_xlat16_15.x = float(1.0) / u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x * u_xlat16_9.x;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz;
    u_xlat16_8.xyz = u_xlat16_15.xxx * u_xlat16_8.xyz;
    u_xlat16_15.xyz = vec3(u_xlat16_39) * u_xlat16_8.xyz;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_8.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_15.xyz * vec3(u_xlat16_44) + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb12 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb12){
        u_xlat12.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat36 = texture(_CameraDepthBlendTexture, u_xlat12.xy).x;
        u_xlat36 = _ZBufferParams.z * u_xlat36 + _ZBufferParams.w;
        u_xlat36 = float(1.0) / u_xlat36;
        u_xlat36 = u_xlat36 + (-vs_TEXCOORD1.w);
        u_xlat36 = abs(u_xlat36) * _DepthBiasScaled;
#ifdef UNITY_ADRENO_ES3
        u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
        u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
        u_xlat36 = sqrt(u_xlat36);
        u_xlat10_2.xyw = texture(_CameraDepthBlendNormTexture, u_xlat12.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_2.xyw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_2.xyw = texture(_CameraDepthBlendDiffTexture, u_xlat12.xy).xyz;
        u_xlat16_11.xyz = (-u_xlat10_2.xyw) + u_xlat16_3.xyz;
        u_xlat3.xyz = vec3(u_xlat36) * u_xlat16_11.xyz + u_xlat10_2.xyw;
        u_xlat2.xyw = u_xlat4.xyz * vec3(u_xlat37) + (-u_xlat16_8.xyz);
        u_xlat2.xyw = vec3(u_xlat36) * u_xlat2.xyw + u_xlat16_8.xyz;
        u_xlat4.x = dot(u_xlat2.xyw, u_xlat2.xyw);
        u_xlat4.x = inversesqrt(u_xlat4.x);
        u_xlat2.xyw = u_xlat2.xyw * u_xlat4.xxx;
        u_xlat16_3.xyz = u_xlat3.xyz;
        u_xlat16_2.xyw = u_xlat2.xyw;
        u_xlat16_36 = u_xlat36;
    } else {
        u_xlat16_2.xyw = u_xlat6.xyz;
        u_xlat16_36 = 1.0;
    //ENDIF
    }
    u_xlat4.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_4.x = texture(_CameraDepthBlendDiffTexture, u_xlat4.xy).w;
    u_xlat16_39 = (-u_xlat10_4.x) + u_xlat16_43;
    u_xlat16_1.x = u_xlat16_36 * u_xlat16_39 + u_xlat10_4.x;
    u_xlat4.xyz = (-vs_TEXCOORD8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat4.xyz = vec3(u_xlat40) * u_xlat4.xyz;
    u_xlat40 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat11.xyz = vec3(u_xlat40) * vs_TEXCOORD6.xyz;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat11.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = max(u_xlat4.x, 9.99999975e-05);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _RGPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat16.x = _DissolveValue * _DissolveEdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16.x>=u_xlat0.x);
#else
    u_xlatb16 = u_xlat16.x>=u_xlat0.x;
#endif
    u_xlat16.x = u_xlatb16 ? 1.0 : float(0.0);
    u_xlat16_8.xyz = _EmissionColor.xyz * vec3(_EmissionStrenght);
    u_xlat16_8.xyz = u_xlat10_2.zzz * u_xlat16_8.xyz;
    u_xlat16.xyz = u_xlat16.xxx * _DissolveColor.xyz + u_xlat16_8.xyz;
    u_xlat11.xyz = vec3(vec3(_RGStrength, _RGStrength, _RGStrength)) * _RGColor.xyz;
    u_xlat4.xyz = u_xlat11.xyz * u_xlat4.xxx + u_xlat16.xyz;
    u_xlat40 = dot(u_xlat4.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
#ifdef UNITY_ADRENO_ES3
    u_xlatb40 = !!(0.0500000007>=u_xlat40);
#else
    u_xlatb40 = 0.0500000007>=u_xlat40;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb40)) ? vec3(0.0, 0.0, 0.0) : u_xlat4.xyz;
    u_xlat16_39 = (-_DissolveValue) + 1.0;
    u_xlat4.x = u_xlat0.x + u_xlat16_39;
    u_xlat4.x = u_xlat4.x + -1.0;
    u_xlat4.x = u_xlat4.x + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat16_39 = dot(u_xlat16_2.xyw, u_xlat16_2.xyw);
    u_xlat16_39 = inversesqrt(u_xlat16_39);
    u_xlat16_9.xyz = u_xlat16_2.xyw * vec3(u_xlat16_39);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.5<_EnableEmission);
#else
    u_xlatb4 = 0.5<_EnableEmission;
#endif
    u_xlat16_39 = dot(u_xlat16_8.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(9.99999975e-05<u_xlat16_39);
#else
    u_xlatb16 = 9.99999975e-05<u_xlat16_39;
#endif
    u_xlatb4 = u_xlatb16 && u_xlatb4;
    u_xlat16_1.yzw = u_xlat16_3.xyz + u_xlat16_8.xyz;
    u_xlat16_39 = max(u_xlat16_1.w, u_xlat16_1.z);
    u_xlat16_0.w = max(u_xlat16_1.y, u_xlat16_39);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(1.0<u_xlat16_0.w);
#else
    u_xlatb16 = 1.0<u_xlat16_0.w;
#endif
    u_xlat16_0.xyz = vec3(u_xlat16_1.y / u_xlat16_0.w, u_xlat16_1.z / u_xlat16_0.w, u_xlat16_1.w / u_xlat16_0.w);
    u_xlat16_0 = (bool(u_xlatb16)) ? u_xlat16_0 : u_xlat16_1.yzwx;
    u_xlat16_16 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16.x = sqrt(u_xlat16_16);
    SV_Target1.xyz = (bool(u_xlatb4)) ? u_xlat16_0.xyz : u_xlat16_3.xyz;
    u_xlat16_3.x = 0.400000006;
    SV_Target2.w = (u_xlatb4) ? u_xlat16.x : u_xlat16_1.x;
    SV_Target1.w = (u_xlatb4) ? u_xlat16_0.w : u_xlat16_3.x;
    SV_Target0.w = (u_xlatb4) ? 0.00392156886 : 0.0;
    SV_Target0.xyz = u_xlat16_9.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_3.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb4) ? u_xlat16_3.x : u_xlat16_7.z;
    SV_Target2.xy = u_xlat16_7.xy;
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
uniform 	vec4 unity_WorldTransformParams;
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
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    gl_Position = u_xlat1;
    vs_TEXCOORD0.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat3.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat3.xyz;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.xyz = u_xlat1.xxx * u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _DepthBiasScaled;
uniform 	float _EnableEmission;
uniform 	vec4 _DissolveNoise_ST;
uniform 	float _DissolveValue;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _CubeMap_HDR;
uniform 	vec4 _CubeMap_TexelSize;
uniform 	float _DissolveEdgeWidth;
uniform 	vec4 _DissolveColor;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrenght;
uniform 	mediump float _RGStrength;
uniform 	vec4 _RGColor;
uniform 	mediump float _RGPower;
uniform lowp sampler2D _DissolveNoise;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainMaskMapRSmoothnessGMetallicBBlendAEmission;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube _CubeMap;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
vec2 u_xlat12;
lowp vec3 u_xlat10_12;
bool u_xlatb12;
mediump vec3 u_xlat16_15;
vec3 u_xlat16;
mediump float u_xlat16_16;
bool u_xlatb16;
mediump vec3 u_xlat16_21;
mediump float u_xlat16_27;
float u_xlat36;
mediump float u_xlat16_36;
float u_xlat37;
mediump float u_xlat16_39;
float u_xlat40;
bool u_xlatb40;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy * _DissolveNoise_ST.xy + _DissolveNoise_ST.zw;
    u_xlat0.x = texture(_DissolveNoise, u_xlat0.xy).x;
    u_xlat12.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_12.xyz = texture(_MainTex, u_xlat12.xy).xyz;
    u_xlat1.xyz = u_xlat10_12.xyz * _Color.xyz;
    u_xlat2.xy = vs_TEXCOORD3.xy * _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST.xy + _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST.zw;
    u_xlat10_2.xyz = texture(_MainMaskMapRSmoothnessGMetallicBBlendAEmission, u_xlat2.xy).xyw;
    u_xlat16_3.x = u_xlat10_2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_15.x = (-u_xlat10_2.x) + 1.0;
    u_xlat16_15.x = max(u_xlat16_15.x, 0.00100000005);
    u_xlat16_15.x = min(u_xlat16_15.x, 0.999000013);
    u_xlat37 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat2.xyw = vec3(u_xlat37) * vs_TEXCOORD4.xyz;
    u_xlat4.xy = vs_TEXCOORD3.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat10_4.xyz = texture(_BumpMap, u_xlat4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_5.xyz);
    u_xlat6.x = vs_TEXCOORD5.y;
    u_xlat6.y = vs_TEXCOORD7.y;
    u_xlat6.z = vs_TEXCOORD6.y;
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat16_5.xyz);
    u_xlat6.x = vs_TEXCOORD5.z;
    u_xlat6.y = vs_TEXCOORD7.z;
    u_xlat6.z = vs_TEXCOORD6.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_5.xyz);
    u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat4.xyz;
    u_xlat16_5.xyz = _Color.xyz * u_xlat10_12.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_27 = u_xlat16_15.x * u_xlat16_3.x;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * -0.5 + 1.0;
    u_xlat16_8.xyz = vec3(u_xlat16_27) * u_xlat16_7.xyz;
    u_xlat16_39 = dot(u_xlat2.xyw, u_xlat6.xyz);
    u_xlat16_43 = u_xlat16_39 + u_xlat16_39;
    u_xlat16_9.xyz = u_xlat6.xyz * (-vec3(u_xlat16_43)) + u_xlat2.xyw;
    u_xlat16_9.xyz = (-u_xlat16_9.xyz);
    u_xlat16_43 = log2(_CubeMap_TexelSize.z);
    u_xlat16_43 = u_xlat16_15.x * u_xlat16_43;
    u_xlat10_5 = textureLod(_CubeMap, u_xlat16_9.xyz, u_xlat16_43);
    u_xlat16_43 = u_xlat10_5.w + -1.0;
    u_xlat16_43 = _CubeMap_HDR.w * u_xlat16_43 + 1.0;
    u_xlat16_43 = log2(u_xlat16_43);
    u_xlat16_43 = u_xlat16_43 * _CubeMap_HDR.y;
    u_xlat16_43 = exp2(u_xlat16_43);
    u_xlat16_43 = u_xlat16_43 * _CubeMap_HDR.x;
    u_xlat16_10.xyz = u_xlat10_5.xyz * vec3(u_xlat16_43);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_10.xyz;
    u_xlat16_43 = (-u_xlat16_15.x) + 1.0;
    u_xlat16_10.xyz = vec3(u_xlat16_43) * u_xlat16_10.xyz;
    u_xlat16_39 = max(u_xlat16_39, 0.00100000005);
    u_xlat16_44 = dot(u_xlat6.xyz, u_xlat16_9.xyz);
    u_xlat16_44 = max(u_xlat16_44, 0.00100000005);
    u_xlat16_9.x = u_xlat16_39 * -5.55472994 + -6.98316002;
    u_xlat16_9.x = u_xlat16_39 * u_xlat16_9.x;
    u_xlat16_9.x = exp2(u_xlat16_9.x);
    u_xlat16_21.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_27) + vec3(1.0, 1.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_21.xyz * u_xlat16_9.xxx + u_xlat16_8.xyz;
    u_xlat16_15.x = u_xlat16_15.x * u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x * 0.5;
    u_xlat16_15.x = max(u_xlat16_15.x, 9.99999975e-05);
    u_xlat16_27 = (-u_xlat16_15.x) + 1.0;
    u_xlat16_9.x = u_xlat16_44 * u_xlat16_27 + u_xlat16_15.x;
    u_xlat16_9.x = float(1.0) / u_xlat16_9.x;
    u_xlat16_15.x = u_xlat16_39 * u_xlat16_27 + u_xlat16_15.x;
    u_xlat16_15.x = float(1.0) / u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x * u_xlat16_9.x;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz;
    u_xlat16_8.xyz = u_xlat16_15.xxx * u_xlat16_8.xyz;
    u_xlat16_15.xyz = vec3(u_xlat16_39) * u_xlat16_8.xyz;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_8.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_15.xyz * vec3(u_xlat16_44) + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb12 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb12){
        u_xlat12.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat36 = texture(_CameraDepthBlendTexture, u_xlat12.xy).x;
        u_xlat36 = _ZBufferParams.z * u_xlat36 + _ZBufferParams.w;
        u_xlat36 = float(1.0) / u_xlat36;
        u_xlat36 = u_xlat36 + (-vs_TEXCOORD1.w);
        u_xlat36 = abs(u_xlat36) * _DepthBiasScaled;
#ifdef UNITY_ADRENO_ES3
        u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
        u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
        u_xlat36 = sqrt(u_xlat36);
        u_xlat10_2.xyw = texture(_CameraDepthBlendNormTexture, u_xlat12.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_2.xyw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_2.xyw = texture(_CameraDepthBlendDiffTexture, u_xlat12.xy).xyz;
        u_xlat16_11.xyz = (-u_xlat10_2.xyw) + u_xlat16_3.xyz;
        u_xlat3.xyz = vec3(u_xlat36) * u_xlat16_11.xyz + u_xlat10_2.xyw;
        u_xlat2.xyw = u_xlat4.xyz * vec3(u_xlat37) + (-u_xlat16_8.xyz);
        u_xlat2.xyw = vec3(u_xlat36) * u_xlat2.xyw + u_xlat16_8.xyz;
        u_xlat4.x = dot(u_xlat2.xyw, u_xlat2.xyw);
        u_xlat4.x = inversesqrt(u_xlat4.x);
        u_xlat2.xyw = u_xlat2.xyw * u_xlat4.xxx;
        u_xlat16_3.xyz = u_xlat3.xyz;
        u_xlat16_2.xyw = u_xlat2.xyw;
        u_xlat16_36 = u_xlat36;
    } else {
        u_xlat16_2.xyw = u_xlat6.xyz;
        u_xlat16_36 = 1.0;
    //ENDIF
    }
    u_xlat4.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_4.x = texture(_CameraDepthBlendDiffTexture, u_xlat4.xy).w;
    u_xlat16_39 = (-u_xlat10_4.x) + u_xlat16_43;
    u_xlat16_1.x = u_xlat16_36 * u_xlat16_39 + u_xlat10_4.x;
    u_xlat4.xyz = (-vs_TEXCOORD8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat4.xyz = vec3(u_xlat40) * u_xlat4.xyz;
    u_xlat40 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat11.xyz = vec3(u_xlat40) * vs_TEXCOORD6.xyz;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat11.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = max(u_xlat4.x, 9.99999975e-05);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _RGPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat16.x = _DissolveValue * _DissolveEdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16.x>=u_xlat0.x);
#else
    u_xlatb16 = u_xlat16.x>=u_xlat0.x;
#endif
    u_xlat16.x = u_xlatb16 ? 1.0 : float(0.0);
    u_xlat16_8.xyz = _EmissionColor.xyz * vec3(_EmissionStrenght);
    u_xlat16_8.xyz = u_xlat10_2.zzz * u_xlat16_8.xyz;
    u_xlat16.xyz = u_xlat16.xxx * _DissolveColor.xyz + u_xlat16_8.xyz;
    u_xlat11.xyz = vec3(vec3(_RGStrength, _RGStrength, _RGStrength)) * _RGColor.xyz;
    u_xlat4.xyz = u_xlat11.xyz * u_xlat4.xxx + u_xlat16.xyz;
    u_xlat40 = dot(u_xlat4.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
#ifdef UNITY_ADRENO_ES3
    u_xlatb40 = !!(0.0500000007>=u_xlat40);
#else
    u_xlatb40 = 0.0500000007>=u_xlat40;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb40)) ? vec3(0.0, 0.0, 0.0) : u_xlat4.xyz;
    u_xlat16_39 = dot(u_xlat16_2.xyw, u_xlat16_2.xyw);
    u_xlat16_39 = inversesqrt(u_xlat16_39);
    u_xlat16_9.xyz = u_xlat16_2.xyw * vec3(u_xlat16_39);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.5<_EnableEmission);
#else
    u_xlatb4 = 0.5<_EnableEmission;
#endif
    u_xlat16_39 = dot(u_xlat16_8.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(9.99999975e-05<u_xlat16_39);
#else
    u_xlatb16 = 9.99999975e-05<u_xlat16_39;
#endif
    u_xlatb4 = u_xlatb16 && u_xlatb4;
    u_xlat16_1.yzw = u_xlat16_3.xyz + u_xlat16_8.xyz;
    u_xlat16_39 = max(u_xlat16_1.w, u_xlat16_1.z);
    u_xlat16_0.w = max(u_xlat16_1.y, u_xlat16_39);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(1.0<u_xlat16_0.w);
#else
    u_xlatb16 = 1.0<u_xlat16_0.w;
#endif
    u_xlat16_0.xyz = vec3(u_xlat16_1.y / u_xlat16_0.w, u_xlat16_1.z / u_xlat16_0.w, u_xlat16_1.w / u_xlat16_0.w);
    u_xlat16_0 = (bool(u_xlatb16)) ? u_xlat16_0 : u_xlat16_1.yzwx;
    u_xlat16_16 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16.x = sqrt(u_xlat16_16);
    SV_Target1.xyz = (bool(u_xlatb4)) ? u_xlat16_0.xyz : u_xlat16_3.xyz;
    u_xlat16_3.x = 0.400000006;
    SV_Target2.w = (u_xlatb4) ? u_xlat16.x : u_xlat16_1.x;
    SV_Target1.w = (u_xlatb4) ? u_xlat16_0.w : u_xlat16_3.x;
    SV_Target0.w = (u_xlatb4) ? 0.00392156886 : 0.0;
    SV_Target0.xyz = u_xlat16_9.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_3.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb4) ? u_xlat16_3.x : u_xlat16_7.z;
    SV_Target2.xy = u_xlat16_7.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
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
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    gl_Position = u_xlat1;
    vs_TEXCOORD0.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat3.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat3.xyz;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.xyz = u_xlat1.xxx * u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _DepthBiasScaled;
uniform 	float _EnableEmission;
uniform 	float _CutOff;
uniform 	vec4 _DissolveNoise_ST;
uniform 	float _DissolveValue;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _CubeMap_HDR;
uniform 	vec4 _CubeMap_TexelSize;
uniform 	float _DissolveEdgeWidth;
uniform 	vec4 _DissolveColor;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrenght;
uniform 	mediump float _RGStrength;
uniform 	vec4 _RGColor;
uniform 	mediump float _RGPower;
uniform lowp sampler2D _DissolveNoise;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainMaskMapRSmoothnessGMetallicBBlendAEmission;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube _CubeMap;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
vec2 u_xlat12;
lowp vec3 u_xlat10_12;
bool u_xlatb12;
mediump vec3 u_xlat16_15;
vec3 u_xlat16;
mediump float u_xlat16_16;
bool u_xlatb16;
mediump vec3 u_xlat16_21;
mediump float u_xlat16_27;
float u_xlat36;
mediump float u_xlat16_36;
float u_xlat37;
mediump float u_xlat16_39;
float u_xlat40;
bool u_xlatb40;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy * _DissolveNoise_ST.xy + _DissolveNoise_ST.zw;
    u_xlat0.x = texture(_DissolveNoise, u_xlat0.xy).x;
    u_xlat12.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_12.xyz = texture(_MainTex, u_xlat12.xy).xyz;
    u_xlat1.xyz = u_xlat10_12.xyz * _Color.xyz;
    u_xlat2.xy = vs_TEXCOORD3.xy * _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST.xy + _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST.zw;
    u_xlat10_2.xyz = texture(_MainMaskMapRSmoothnessGMetallicBBlendAEmission, u_xlat2.xy).xyw;
    u_xlat16_3.x = u_xlat10_2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_15.x = (-u_xlat10_2.x) + 1.0;
    u_xlat16_15.x = max(u_xlat16_15.x, 0.00100000005);
    u_xlat16_15.x = min(u_xlat16_15.x, 0.999000013);
    u_xlat37 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat2.xyw = vec3(u_xlat37) * vs_TEXCOORD4.xyz;
    u_xlat4.xy = vs_TEXCOORD3.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat10_4.xyz = texture(_BumpMap, u_xlat4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_5.xyz);
    u_xlat6.x = vs_TEXCOORD5.y;
    u_xlat6.y = vs_TEXCOORD7.y;
    u_xlat6.z = vs_TEXCOORD6.y;
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat16_5.xyz);
    u_xlat6.x = vs_TEXCOORD5.z;
    u_xlat6.y = vs_TEXCOORD7.z;
    u_xlat6.z = vs_TEXCOORD6.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_5.xyz);
    u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat4.xyz;
    u_xlat16_5.xyz = _Color.xyz * u_xlat10_12.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_5.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_27 = u_xlat16_15.x * u_xlat16_3.x;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * -0.5 + 1.0;
    u_xlat16_8.xyz = vec3(u_xlat16_27) * u_xlat16_7.xyz;
    u_xlat16_39 = dot(u_xlat2.xyw, u_xlat6.xyz);
    u_xlat16_43 = u_xlat16_39 + u_xlat16_39;
    u_xlat16_9.xyz = u_xlat6.xyz * (-vec3(u_xlat16_43)) + u_xlat2.xyw;
    u_xlat16_9.xyz = (-u_xlat16_9.xyz);
    u_xlat16_43 = log2(_CubeMap_TexelSize.z);
    u_xlat16_43 = u_xlat16_15.x * u_xlat16_43;
    u_xlat10_5 = textureLod(_CubeMap, u_xlat16_9.xyz, u_xlat16_43);
    u_xlat16_43 = u_xlat10_5.w + -1.0;
    u_xlat16_43 = _CubeMap_HDR.w * u_xlat16_43 + 1.0;
    u_xlat16_43 = log2(u_xlat16_43);
    u_xlat16_43 = u_xlat16_43 * _CubeMap_HDR.y;
    u_xlat16_43 = exp2(u_xlat16_43);
    u_xlat16_43 = u_xlat16_43 * _CubeMap_HDR.x;
    u_xlat16_10.xyz = u_xlat10_5.xyz * vec3(u_xlat16_43);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_10.xyz;
    u_xlat16_43 = (-u_xlat16_15.x) + 1.0;
    u_xlat16_10.xyz = vec3(u_xlat16_43) * u_xlat16_10.xyz;
    u_xlat16_39 = max(u_xlat16_39, 0.00100000005);
    u_xlat16_44 = dot(u_xlat6.xyz, u_xlat16_9.xyz);
    u_xlat16_44 = max(u_xlat16_44, 0.00100000005);
    u_xlat16_9.x = u_xlat16_39 * -5.55472994 + -6.98316002;
    u_xlat16_9.x = u_xlat16_39 * u_xlat16_9.x;
    u_xlat16_9.x = exp2(u_xlat16_9.x);
    u_xlat16_21.xyz = (-u_xlat16_7.xyz) * vec3(u_xlat16_27) + vec3(1.0, 1.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_21.xyz * u_xlat16_9.xxx + u_xlat16_8.xyz;
    u_xlat16_15.x = u_xlat16_15.x * u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x * 0.5;
    u_xlat16_15.x = max(u_xlat16_15.x, 9.99999975e-05);
    u_xlat16_27 = (-u_xlat16_15.x) + 1.0;
    u_xlat16_9.x = u_xlat16_44 * u_xlat16_27 + u_xlat16_15.x;
    u_xlat16_9.x = float(1.0) / u_xlat16_9.x;
    u_xlat16_15.x = u_xlat16_39 * u_xlat16_27 + u_xlat16_15.x;
    u_xlat16_15.x = float(1.0) / u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x * u_xlat16_9.x;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz;
    u_xlat16_8.xyz = u_xlat16_15.xxx * u_xlat16_8.xyz;
    u_xlat16_15.xyz = vec3(u_xlat16_39) * u_xlat16_8.xyz;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_8.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_15.xyz * vec3(u_xlat16_44) + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb12 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb12){
        u_xlat12.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat36 = texture(_CameraDepthBlendTexture, u_xlat12.xy).x;
        u_xlat36 = _ZBufferParams.z * u_xlat36 + _ZBufferParams.w;
        u_xlat36 = float(1.0) / u_xlat36;
        u_xlat36 = u_xlat36 + (-vs_TEXCOORD1.w);
        u_xlat36 = abs(u_xlat36) * _DepthBiasScaled;
#ifdef UNITY_ADRENO_ES3
        u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
        u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
        u_xlat36 = sqrt(u_xlat36);
        u_xlat10_2.xyw = texture(_CameraDepthBlendNormTexture, u_xlat12.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_2.xyw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_2.xyw = texture(_CameraDepthBlendDiffTexture, u_xlat12.xy).xyz;
        u_xlat16_11.xyz = (-u_xlat10_2.xyw) + u_xlat16_3.xyz;
        u_xlat3.xyz = vec3(u_xlat36) * u_xlat16_11.xyz + u_xlat10_2.xyw;
        u_xlat2.xyw = u_xlat4.xyz * vec3(u_xlat37) + (-u_xlat16_8.xyz);
        u_xlat2.xyw = vec3(u_xlat36) * u_xlat2.xyw + u_xlat16_8.xyz;
        u_xlat4.x = dot(u_xlat2.xyw, u_xlat2.xyw);
        u_xlat4.x = inversesqrt(u_xlat4.x);
        u_xlat2.xyw = u_xlat2.xyw * u_xlat4.xxx;
        u_xlat16_3.xyz = u_xlat3.xyz;
        u_xlat16_2.xyw = u_xlat2.xyw;
        u_xlat16_36 = u_xlat36;
    } else {
        u_xlat16_2.xyw = u_xlat6.xyz;
        u_xlat16_36 = 1.0;
    //ENDIF
    }
    u_xlat4.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_4.x = texture(_CameraDepthBlendDiffTexture, u_xlat4.xy).w;
    u_xlat16_39 = (-u_xlat10_4.x) + u_xlat16_43;
    u_xlat16_1.x = u_xlat16_36 * u_xlat16_39 + u_xlat10_4.x;
    u_xlat4.xyz = (-vs_TEXCOORD8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat4.xyz = vec3(u_xlat40) * u_xlat4.xyz;
    u_xlat40 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat11.xyz = vec3(u_xlat40) * vs_TEXCOORD6.xyz;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat11.xyz);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat4.x = max(u_xlat4.x, 9.99999975e-05);
    u_xlat4.x = log2(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _RGPower;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat16.x = _DissolveValue * _DissolveEdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16.x>=u_xlat0.x);
#else
    u_xlatb16 = u_xlat16.x>=u_xlat0.x;
#endif
    u_xlat16.x = u_xlatb16 ? 1.0 : float(0.0);
    u_xlat16_8.xyz = _EmissionColor.xyz * vec3(_EmissionStrenght);
    u_xlat16_8.xyz = u_xlat10_2.zzz * u_xlat16_8.xyz;
    u_xlat16.xyz = u_xlat16.xxx * _DissolveColor.xyz + u_xlat16_8.xyz;
    u_xlat11.xyz = vec3(vec3(_RGStrength, _RGStrength, _RGStrength)) * _RGColor.xyz;
    u_xlat4.xyz = u_xlat11.xyz * u_xlat4.xxx + u_xlat16.xyz;
    u_xlat40 = dot(u_xlat4.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
#ifdef UNITY_ADRENO_ES3
    u_xlatb40 = !!(0.0500000007>=u_xlat40);
#else
    u_xlatb40 = 0.0500000007>=u_xlat40;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb40)) ? vec3(0.0, 0.0, 0.0) : u_xlat4.xyz;
    u_xlat16_39 = (-_DissolveValue) + 1.0;
    u_xlat4.x = u_xlat0.x + u_xlat16_39;
    u_xlat4.x = u_xlat4.x + -1.0;
    u_xlat4.x = u_xlat4.x + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.x<0.0);
#else
    u_xlatb4 = u_xlat4.x<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    u_xlat16_39 = dot(u_xlat16_2.xyw, u_xlat16_2.xyw);
    u_xlat16_39 = inversesqrt(u_xlat16_39);
    u_xlat16_9.xyz = u_xlat16_2.xyw * vec3(u_xlat16_39);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.5<_EnableEmission);
#else
    u_xlatb4 = 0.5<_EnableEmission;
#endif
    u_xlat16_39 = dot(u_xlat16_8.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(9.99999975e-05<u_xlat16_39);
#else
    u_xlatb16 = 9.99999975e-05<u_xlat16_39;
#endif
    u_xlatb4 = u_xlatb16 && u_xlatb4;
    u_xlat16_1.yzw = u_xlat16_3.xyz + u_xlat16_8.xyz;
    u_xlat16_39 = max(u_xlat16_1.w, u_xlat16_1.z);
    u_xlat16_0.w = max(u_xlat16_1.y, u_xlat16_39);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(1.0<u_xlat16_0.w);
#else
    u_xlatb16 = 1.0<u_xlat16_0.w;
#endif
    u_xlat16_0.xyz = vec3(u_xlat16_1.y / u_xlat16_0.w, u_xlat16_1.z / u_xlat16_0.w, u_xlat16_1.w / u_xlat16_0.w);
    u_xlat16_0 = (bool(u_xlatb16)) ? u_xlat16_0 : u_xlat16_1.yzwx;
    u_xlat16_16 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16.x = sqrt(u_xlat16_16);
    SV_Target1.xyz = (bool(u_xlatb4)) ? u_xlat16_0.xyz : u_xlat16_3.xyz;
    u_xlat16_3.x = 0.400000006;
    SV_Target2.w = (u_xlatb4) ? u_xlat16.x : u_xlat16_1.x;
    SV_Target1.w = (u_xlatb4) ? u_xlat16_0.w : u_xlat16_3.x;
    SV_Target0.w = (u_xlatb4) ? 0.00392156886 : 0.0;
    SV_Target0.xyz = u_xlat16_9.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb4 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_3.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb4) ? u_xlat16_3.x : u_xlat16_7.z;
    SV_Target2.xy = u_xlat16_7.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_DISSOLVEBYVERTEXALPHA_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
float u_xlat10;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD0.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _DepthBiasScaled;
uniform 	float _EnableEmission;
uniform 	vec4 _DissolveNoise_ST;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _CubeMap_HDR;
uniform 	vec4 _CubeMap_TexelSize;
uniform 	float _DissolveEdgeWidth;
uniform 	vec4 _DissolveColor;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrenght;
uniform 	mediump float _RGStrength;
uniform 	vec4 _RGColor;
uniform 	mediump float _RGPower;
uniform lowp sampler2D _DissolveNoise;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainMaskMapRSmoothnessGMetallicBBlendAEmission;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube _CubeMap;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec4 u_xlat3;
lowp vec3 u_xlat10_3;
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
vec3 u_xlat14;
mediump float u_xlat16_14;
bool u_xlatb14;
mediump vec3 u_xlat16_15;
mediump vec3 u_xlat16_20;
vec2 u_xlat22;
mediump float u_xlat16_26;
float u_xlat33;
mediump float u_xlat16_33;
bool u_xlatb33;
float u_xlat34;
float u_xlat36;
bool u_xlatb36;
mediump float u_xlat16_37;
mediump float u_xlat16_39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy * _DissolveNoise_ST.xy + _DissolveNoise_ST.zw;
    u_xlat0.x = texture(_DissolveNoise, u_xlat0.xy).x;
    u_xlat11 = (-vs_COLOR0.w) + 1.0;
    u_xlat22.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat22.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat22.xy = vs_TEXCOORD3.xy * _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST.xy + _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST.zw;
    u_xlat10_3.xyz = texture(_MainMaskMapRSmoothnessGMetallicBBlendAEmission, u_xlat22.xy).xyw;
    u_xlat16_4.x = u_xlat10_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_15.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_15.x = max(u_xlat16_15.x, 0.00100000005);
    u_xlat16_15.x = min(u_xlat16_15.x, 0.999000013);
    u_xlat22.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat22.x = inversesqrt(u_xlat22.x);
    u_xlat3.xyw = u_xlat22.xxx * vs_TEXCOORD4.xyz;
    u_xlat22.xy = vs_TEXCOORD3.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat10_5.xyz = texture(_BumpMap, u_xlat22.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat5.x = vs_TEXCOORD5.x;
    u_xlat5.y = vs_TEXCOORD7.x;
    u_xlat5.z = vs_TEXCOORD6.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat16_6.xyz);
    u_xlat7.x = vs_TEXCOORD5.y;
    u_xlat7.y = vs_TEXCOORD7.y;
    u_xlat7.z = vs_TEXCOORD6.y;
    u_xlat5.y = dot(u_xlat7.xyz, u_xlat16_6.xyz);
    u_xlat7.x = vs_TEXCOORD5.z;
    u_xlat7.y = vs_TEXCOORD7.z;
    u_xlat7.z = vs_TEXCOORD6.z;
    u_xlat5.z = dot(u_xlat7.xyz, u_xlat16_6.xyz);
    u_xlat22.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22.x = inversesqrt(u_xlat22.x);
    u_xlat7.xyz = u_xlat22.xxx * u_xlat5.xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_1.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_6.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_26 = u_xlat16_15.x * u_xlat16_4.x;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * -0.5 + 1.0;
    u_xlat16_8.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz;
    u_xlat16_37 = dot(u_xlat3.xyw, u_xlat7.xyz);
    u_xlat16_39 = u_xlat16_37 + u_xlat16_37;
    u_xlat16_9.xyz = u_xlat7.xyz * (-vec3(u_xlat16_39)) + u_xlat3.xyw;
    u_xlat16_9.xyz = (-u_xlat16_9.xyz);
    u_xlat16_39 = log2(_CubeMap_TexelSize.z);
    u_xlat16_39 = u_xlat16_15.x * u_xlat16_39;
    u_xlat10_1 = textureLod(_CubeMap, u_xlat16_9.xyz, u_xlat16_39);
    u_xlat16_39 = u_xlat10_1.w + -1.0;
    u_xlat16_39 = _CubeMap_HDR.w * u_xlat16_39 + 1.0;
    u_xlat16_39 = log2(u_xlat16_39);
    u_xlat16_39 = u_xlat16_39 * _CubeMap_HDR.y;
    u_xlat16_39 = exp2(u_xlat16_39);
    u_xlat16_39 = u_xlat16_39 * _CubeMap_HDR.x;
    u_xlat16_10.xyz = u_xlat10_1.xyz * vec3(u_xlat16_39);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_10.xyz;
    u_xlat16_39 = (-u_xlat16_15.x) + 1.0;
    u_xlat16_10.xyz = vec3(u_xlat16_39) * u_xlat16_10.xyz;
    u_xlat16_37 = max(u_xlat16_37, 0.00100000005);
    u_xlat16_41 = dot(u_xlat7.xyz, u_xlat16_9.xyz);
    u_xlat16_41 = max(u_xlat16_41, 0.00100000005);
    u_xlat16_9.x = u_xlat16_37 * -5.55472994 + -6.98316002;
    u_xlat16_9.x = u_xlat16_37 * u_xlat16_9.x;
    u_xlat16_9.x = exp2(u_xlat16_9.x);
    u_xlat16_20.xyz = (-u_xlat16_6.xyz) * vec3(u_xlat16_26) + vec3(1.0, 1.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_20.xyz * u_xlat16_9.xxx + u_xlat16_8.xyz;
    u_xlat16_15.x = u_xlat16_15.x * u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x * 0.5;
    u_xlat16_15.x = max(u_xlat16_15.x, 9.99999975e-05);
    u_xlat16_26 = (-u_xlat16_15.x) + 1.0;
    u_xlat16_9.x = u_xlat16_41 * u_xlat16_26 + u_xlat16_15.x;
    u_xlat16_9.x = float(1.0) / u_xlat16_9.x;
    u_xlat16_15.x = u_xlat16_37 * u_xlat16_26 + u_xlat16_15.x;
    u_xlat16_15.x = float(1.0) / u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x * u_xlat16_9.x;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz;
    u_xlat16_8.xyz = u_xlat16_15.xxx * u_xlat16_8.xyz;
    u_xlat16_15.xyz = vec3(u_xlat16_37) * u_xlat16_8.xyz;
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_8.xyz = u_xlat2.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_15.xyz * vec3(u_xlat16_41) + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb33 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb33){
        u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat33 = texture(_CameraDepthBlendTexture, u_xlat1.xy).x;
        u_xlat33 = _ZBufferParams.z * u_xlat33 + _ZBufferParams.w;
        u_xlat33 = float(1.0) / u_xlat33;
        u_xlat33 = u_xlat33 + (-vs_TEXCOORD1.w);
        u_xlat33 = abs(u_xlat33) * _DepthBiasScaled;
#ifdef UNITY_ADRENO_ES3
        u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
        u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
        u_xlat33 = sqrt(u_xlat33);
        u_xlat10_2.xyz = texture(_CameraDepthBlendNormTexture, u_xlat1.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_1.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat1.xy).xyz;
        u_xlat16_2.xyz = (-u_xlat10_1.xyz) + u_xlat16_4.xyz;
        u_xlat4.xyz = vec3(u_xlat33) * u_xlat16_2.xyz + u_xlat10_1.xyz;
        u_xlat1.xyz = u_xlat5.xyz * u_xlat22.xxx + (-u_xlat16_8.xyz);
        u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz + u_xlat16_8.xyz;
        u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat34 = inversesqrt(u_xlat34);
        u_xlat1.xyz = vec3(u_xlat34) * u_xlat1.xyz;
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_1.xyz = u_xlat1.xyz;
        u_xlat16_33 = u_xlat33;
    } else {
        u_xlat16_1.xyz = u_xlat7.xyz;
        u_xlat16_33 = 1.0;
    //ENDIF
    }
    u_xlat2.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_2.x = texture(_CameraDepthBlendDiffTexture, u_xlat2.xy).w;
    u_xlat16_37 = (-u_xlat10_2.x) + u_xlat16_39;
    u_xlat16_2.x = u_xlat16_33 * u_xlat16_37 + u_xlat10_2.x;
    u_xlat3.xyw = (-vs_TEXCOORD8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5.x = dot(u_xlat3.xyw, u_xlat3.xyw);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat3.xyw = u_xlat3.xyw * u_xlat5.xxx;
    u_xlat5.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD6.xyz;
    u_xlat3.x = dot(u_xlat3.xyw, u_xlat5.xyz);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _RGPower;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat14.x = u_xlat11 * _DissolveEdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat14.x>=u_xlat0.x);
#else
    u_xlatb14 = u_xlat14.x>=u_xlat0.x;
#endif
    u_xlat14.x = u_xlatb14 ? 1.0 : float(0.0);
    u_xlat16_8.xyz = _EmissionColor.xyz * vec3(_EmissionStrenght);
    u_xlat16_8.xyz = u_xlat10_3.zzz * u_xlat16_8.xyz;
    u_xlat14.xyz = u_xlat14.xxx * _DissolveColor.xyz + u_xlat16_8.xyz;
    u_xlat5.xyz = vec3(vec3(_RGStrength, _RGStrength, _RGStrength)) * _RGColor.xyz;
    u_xlat3.xyz = u_xlat5.xyz * u_xlat3.xxx + u_xlat14.xyz;
    u_xlat36 = dot(u_xlat3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(0.0500000007>=u_xlat36);
#else
    u_xlatb36 = 0.0500000007>=u_xlat36;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb36)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat16_37 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_9.xyz = u_xlat16_1.xyz * vec3(u_xlat16_37);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.5<_EnableEmission);
#else
    u_xlatb3 = 0.5<_EnableEmission;
#endif
    u_xlat16_37 = dot(u_xlat16_8.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(9.99999975e-05<u_xlat16_37);
#else
    u_xlatb14 = 9.99999975e-05<u_xlat16_37;
#endif
    u_xlatb3 = u_xlatb14 && u_xlatb3;
    u_xlat16_2.yzw = u_xlat16_4.xyz + u_xlat16_8.xyz;
    u_xlat16_37 = max(u_xlat16_2.w, u_xlat16_2.z);
    u_xlat16_0.w = max(u_xlat16_2.y, u_xlat16_37);
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(1.0<u_xlat16_0.w);
#else
    u_xlatb14 = 1.0<u_xlat16_0.w;
#endif
    u_xlat16_0.xyz = vec3(u_xlat16_2.y / u_xlat16_0.w, u_xlat16_2.z / u_xlat16_0.w, u_xlat16_2.w / u_xlat16_0.w);
    u_xlat16_0 = (bool(u_xlatb14)) ? u_xlat16_0 : u_xlat16_2.yzwx;
    u_xlat16_14 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat14.x = sqrt(u_xlat16_14);
    SV_Target1.xyz = (bool(u_xlatb3)) ? u_xlat16_0.xyz : u_xlat16_4.xyz;
    u_xlat16_4.x = 0.400000006;
    SV_Target2.w = (u_xlatb3) ? u_xlat14.x : u_xlat16_2.x;
    SV_Target1.w = (u_xlatb3) ? u_xlat16_0.w : u_xlat16_4.x;
    SV_Target0.w = (u_xlatb3) ? 0.00392156886 : 0.0;
    SV_Target0.xyz = u_xlat16_9.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb3 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_4.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb3) ? u_xlat16_4.x : u_xlat16_6.z;
    SV_Target2.xy = u_xlat16_6.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
float u_xlat10;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    vs_TEXCOORD0.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _DepthBiasScaled;
uniform 	float _EnableEmission;
uniform 	float _CutOff;
uniform 	vec4 _DissolveNoise_ST;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _CubeMap_HDR;
uniform 	vec4 _CubeMap_TexelSize;
uniform 	float _DissolveEdgeWidth;
uniform 	vec4 _DissolveColor;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrenght;
uniform 	mediump float _RGStrength;
uniform 	vec4 _RGColor;
uniform 	mediump float _RGPower;
uniform lowp sampler2D _DissolveNoise;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainMaskMapRSmoothnessGMetallicBBlendAEmission;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube _CubeMap;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec4 u_xlat3;
lowp vec3 u_xlat10_3;
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
vec3 u_xlat14;
mediump float u_xlat16_14;
bool u_xlatb14;
mediump vec3 u_xlat16_15;
mediump vec3 u_xlat16_20;
vec2 u_xlat22;
mediump float u_xlat16_26;
float u_xlat33;
mediump float u_xlat16_33;
bool u_xlatb33;
float u_xlat34;
float u_xlat36;
bool u_xlatb36;
mediump float u_xlat16_37;
mediump float u_xlat16_39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy * _DissolveNoise_ST.xy + _DissolveNoise_ST.zw;
    u_xlat0.x = texture(_DissolveNoise, u_xlat0.xy).x;
    u_xlat11 = (-vs_COLOR0.w) + 1.0;
    u_xlat22.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat22.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat22.xy = vs_TEXCOORD3.xy * _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST.xy + _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST.zw;
    u_xlat10_3.xyz = texture(_MainMaskMapRSmoothnessGMetallicBBlendAEmission, u_xlat22.xy).xyw;
    u_xlat16_4.x = u_xlat10_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_15.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_15.x = max(u_xlat16_15.x, 0.00100000005);
    u_xlat16_15.x = min(u_xlat16_15.x, 0.999000013);
    u_xlat22.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat22.x = inversesqrt(u_xlat22.x);
    u_xlat3.xyw = u_xlat22.xxx * vs_TEXCOORD4.xyz;
    u_xlat22.xy = vs_TEXCOORD3.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat10_5.xyz = texture(_BumpMap, u_xlat22.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat5.x = vs_TEXCOORD5.x;
    u_xlat5.y = vs_TEXCOORD7.x;
    u_xlat5.z = vs_TEXCOORD6.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat16_6.xyz);
    u_xlat7.x = vs_TEXCOORD5.y;
    u_xlat7.y = vs_TEXCOORD7.y;
    u_xlat7.z = vs_TEXCOORD6.y;
    u_xlat5.y = dot(u_xlat7.xyz, u_xlat16_6.xyz);
    u_xlat7.x = vs_TEXCOORD5.z;
    u_xlat7.y = vs_TEXCOORD7.z;
    u_xlat7.z = vs_TEXCOORD6.z;
    u_xlat5.z = dot(u_xlat7.xyz, u_xlat16_6.xyz);
    u_xlat22.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22.x = inversesqrt(u_xlat22.x);
    u_xlat7.xyz = u_xlat22.xxx * u_xlat5.xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_1.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_6.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_26 = u_xlat16_15.x * u_xlat16_4.x;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * -0.5 + 1.0;
    u_xlat16_8.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz;
    u_xlat16_37 = dot(u_xlat3.xyw, u_xlat7.xyz);
    u_xlat16_39 = u_xlat16_37 + u_xlat16_37;
    u_xlat16_9.xyz = u_xlat7.xyz * (-vec3(u_xlat16_39)) + u_xlat3.xyw;
    u_xlat16_9.xyz = (-u_xlat16_9.xyz);
    u_xlat16_39 = log2(_CubeMap_TexelSize.z);
    u_xlat16_39 = u_xlat16_15.x * u_xlat16_39;
    u_xlat10_1 = textureLod(_CubeMap, u_xlat16_9.xyz, u_xlat16_39);
    u_xlat16_39 = u_xlat10_1.w + -1.0;
    u_xlat16_39 = _CubeMap_HDR.w * u_xlat16_39 + 1.0;
    u_xlat16_39 = log2(u_xlat16_39);
    u_xlat16_39 = u_xlat16_39 * _CubeMap_HDR.y;
    u_xlat16_39 = exp2(u_xlat16_39);
    u_xlat16_39 = u_xlat16_39 * _CubeMap_HDR.x;
    u_xlat16_10.xyz = u_xlat10_1.xyz * vec3(u_xlat16_39);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_10.xyz;
    u_xlat16_39 = (-u_xlat16_15.x) + 1.0;
    u_xlat16_10.xyz = vec3(u_xlat16_39) * u_xlat16_10.xyz;
    u_xlat16_37 = max(u_xlat16_37, 0.00100000005);
    u_xlat16_41 = dot(u_xlat7.xyz, u_xlat16_9.xyz);
    u_xlat16_41 = max(u_xlat16_41, 0.00100000005);
    u_xlat16_9.x = u_xlat16_37 * -5.55472994 + -6.98316002;
    u_xlat16_9.x = u_xlat16_37 * u_xlat16_9.x;
    u_xlat16_9.x = exp2(u_xlat16_9.x);
    u_xlat16_20.xyz = (-u_xlat16_6.xyz) * vec3(u_xlat16_26) + vec3(1.0, 1.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_20.xyz * u_xlat16_9.xxx + u_xlat16_8.xyz;
    u_xlat16_15.x = u_xlat16_15.x * u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x * 0.5;
    u_xlat16_15.x = max(u_xlat16_15.x, 9.99999975e-05);
    u_xlat16_26 = (-u_xlat16_15.x) + 1.0;
    u_xlat16_9.x = u_xlat16_41 * u_xlat16_26 + u_xlat16_15.x;
    u_xlat16_9.x = float(1.0) / u_xlat16_9.x;
    u_xlat16_15.x = u_xlat16_37 * u_xlat16_26 + u_xlat16_15.x;
    u_xlat16_15.x = float(1.0) / u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x * u_xlat16_9.x;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz;
    u_xlat16_8.xyz = u_xlat16_15.xxx * u_xlat16_8.xyz;
    u_xlat16_15.xyz = vec3(u_xlat16_37) * u_xlat16_8.xyz;
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_8.xyz = u_xlat2.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_15.xyz * vec3(u_xlat16_41) + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb33 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb33){
        u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat33 = texture(_CameraDepthBlendTexture, u_xlat1.xy).x;
        u_xlat33 = _ZBufferParams.z * u_xlat33 + _ZBufferParams.w;
        u_xlat33 = float(1.0) / u_xlat33;
        u_xlat33 = u_xlat33 + (-vs_TEXCOORD1.w);
        u_xlat33 = abs(u_xlat33) * _DepthBiasScaled;
#ifdef UNITY_ADRENO_ES3
        u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
        u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
        u_xlat33 = sqrt(u_xlat33);
        u_xlat10_2.xyz = texture(_CameraDepthBlendNormTexture, u_xlat1.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_1.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat1.xy).xyz;
        u_xlat16_2.xyz = (-u_xlat10_1.xyz) + u_xlat16_4.xyz;
        u_xlat4.xyz = vec3(u_xlat33) * u_xlat16_2.xyz + u_xlat10_1.xyz;
        u_xlat1.xyz = u_xlat5.xyz * u_xlat22.xxx + (-u_xlat16_8.xyz);
        u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz + u_xlat16_8.xyz;
        u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat34 = inversesqrt(u_xlat34);
        u_xlat1.xyz = vec3(u_xlat34) * u_xlat1.xyz;
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_1.xyz = u_xlat1.xyz;
        u_xlat16_33 = u_xlat33;
    } else {
        u_xlat16_1.xyz = u_xlat7.xyz;
        u_xlat16_33 = 1.0;
    //ENDIF
    }
    u_xlat2.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_2.x = texture(_CameraDepthBlendDiffTexture, u_xlat2.xy).w;
    u_xlat16_37 = (-u_xlat10_2.x) + u_xlat16_39;
    u_xlat16_2.x = u_xlat16_33 * u_xlat16_37 + u_xlat10_2.x;
    u_xlat3.xyw = (-vs_TEXCOORD8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5.x = dot(u_xlat3.xyw, u_xlat3.xyw);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat3.xyw = u_xlat3.xyw * u_xlat5.xxx;
    u_xlat5.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD6.xyz;
    u_xlat3.x = dot(u_xlat3.xyw, u_xlat5.xyz);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _RGPower;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat14.x = u_xlat11 * _DissolveEdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat14.x>=u_xlat0.x);
#else
    u_xlatb14 = u_xlat14.x>=u_xlat0.x;
#endif
    u_xlat14.x = u_xlatb14 ? 1.0 : float(0.0);
    u_xlat16_8.xyz = _EmissionColor.xyz * vec3(_EmissionStrenght);
    u_xlat16_8.xyz = u_xlat10_3.zzz * u_xlat16_8.xyz;
    u_xlat14.xyz = u_xlat14.xxx * _DissolveColor.xyz + u_xlat16_8.xyz;
    u_xlat5.xyz = vec3(vec3(_RGStrength, _RGStrength, _RGStrength)) * _RGColor.xyz;
    u_xlat3.xyz = u_xlat5.xyz * u_xlat3.xxx + u_xlat14.xyz;
    u_xlat36 = dot(u_xlat3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(0.0500000007>=u_xlat36);
#else
    u_xlatb36 = 0.0500000007>=u_xlat36;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb36)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat16_37 = (-u_xlat11) + 1.0;
    u_xlat3.x = u_xlat0.x + u_xlat16_37;
    u_xlat3.x = u_xlat3.x + -1.0;
    u_xlat3.x = u_xlat3.x + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<0.0);
#else
    u_xlatb3 = u_xlat3.x<0.0;
#endif
    if((int(u_xlatb3) * int(0xffffffffu))!=0){discard;}
    u_xlat16_37 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_9.xyz = u_xlat16_1.xyz * vec3(u_xlat16_37);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.5<_EnableEmission);
#else
    u_xlatb3 = 0.5<_EnableEmission;
#endif
    u_xlat16_37 = dot(u_xlat16_8.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(9.99999975e-05<u_xlat16_37);
#else
    u_xlatb14 = 9.99999975e-05<u_xlat16_37;
#endif
    u_xlatb3 = u_xlatb14 && u_xlatb3;
    u_xlat16_2.yzw = u_xlat16_4.xyz + u_xlat16_8.xyz;
    u_xlat16_37 = max(u_xlat16_2.w, u_xlat16_2.z);
    u_xlat16_0.w = max(u_xlat16_2.y, u_xlat16_37);
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(1.0<u_xlat16_0.w);
#else
    u_xlatb14 = 1.0<u_xlat16_0.w;
#endif
    u_xlat16_0.xyz = vec3(u_xlat16_2.y / u_xlat16_0.w, u_xlat16_2.z / u_xlat16_0.w, u_xlat16_2.w / u_xlat16_0.w);
    u_xlat16_0 = (bool(u_xlatb14)) ? u_xlat16_0 : u_xlat16_2.yzwx;
    u_xlat16_14 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat14.x = sqrt(u_xlat16_14);
    SV_Target1.xyz = (bool(u_xlatb3)) ? u_xlat16_0.xyz : u_xlat16_4.xyz;
    u_xlat16_4.x = 0.400000006;
    SV_Target2.w = (u_xlatb3) ? u_xlat14.x : u_xlat16_2.x;
    SV_Target1.w = (u_xlatb3) ? u_xlat16_0.w : u_xlat16_4.x;
    SV_Target0.w = (u_xlatb3) ? 0.00392156886 : 0.0;
    SV_Target0.xyz = u_xlat16_9.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb3 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_4.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb3) ? u_xlat16_4.x : u_xlat16_6.z;
    SV_Target2.xy = u_xlat16_6.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
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
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    gl_Position = u_xlat1;
    vs_TEXCOORD0.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat3.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat3.xyz;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.xyz = u_xlat1.xxx * u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _DepthBiasScaled;
uniform 	float _EnableEmission;
uniform 	vec4 _DissolveNoise_ST;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _CubeMap_HDR;
uniform 	vec4 _CubeMap_TexelSize;
uniform 	float _DissolveEdgeWidth;
uniform 	vec4 _DissolveColor;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrenght;
uniform 	mediump float _RGStrength;
uniform 	vec4 _RGColor;
uniform 	mediump float _RGPower;
uniform lowp sampler2D _DissolveNoise;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainMaskMapRSmoothnessGMetallicBBlendAEmission;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube _CubeMap;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec4 u_xlat3;
lowp vec3 u_xlat10_3;
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
vec3 u_xlat14;
mediump float u_xlat16_14;
bool u_xlatb14;
mediump vec3 u_xlat16_15;
mediump vec3 u_xlat16_20;
vec2 u_xlat22;
mediump float u_xlat16_26;
float u_xlat33;
mediump float u_xlat16_33;
bool u_xlatb33;
float u_xlat34;
float u_xlat36;
bool u_xlatb36;
mediump float u_xlat16_37;
mediump float u_xlat16_39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy * _DissolveNoise_ST.xy + _DissolveNoise_ST.zw;
    u_xlat0.x = texture(_DissolveNoise, u_xlat0.xy).x;
    u_xlat11 = (-vs_COLOR0.w) + 1.0;
    u_xlat22.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat22.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat22.xy = vs_TEXCOORD3.xy * _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST.xy + _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST.zw;
    u_xlat10_3.xyz = texture(_MainMaskMapRSmoothnessGMetallicBBlendAEmission, u_xlat22.xy).xyw;
    u_xlat16_4.x = u_xlat10_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_15.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_15.x = max(u_xlat16_15.x, 0.00100000005);
    u_xlat16_15.x = min(u_xlat16_15.x, 0.999000013);
    u_xlat22.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat22.x = inversesqrt(u_xlat22.x);
    u_xlat3.xyw = u_xlat22.xxx * vs_TEXCOORD4.xyz;
    u_xlat22.xy = vs_TEXCOORD3.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat10_5.xyz = texture(_BumpMap, u_xlat22.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat5.x = vs_TEXCOORD5.x;
    u_xlat5.y = vs_TEXCOORD7.x;
    u_xlat5.z = vs_TEXCOORD6.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat16_6.xyz);
    u_xlat7.x = vs_TEXCOORD5.y;
    u_xlat7.y = vs_TEXCOORD7.y;
    u_xlat7.z = vs_TEXCOORD6.y;
    u_xlat5.y = dot(u_xlat7.xyz, u_xlat16_6.xyz);
    u_xlat7.x = vs_TEXCOORD5.z;
    u_xlat7.y = vs_TEXCOORD7.z;
    u_xlat7.z = vs_TEXCOORD6.z;
    u_xlat5.z = dot(u_xlat7.xyz, u_xlat16_6.xyz);
    u_xlat22.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22.x = inversesqrt(u_xlat22.x);
    u_xlat7.xyz = u_xlat22.xxx * u_xlat5.xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_1.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_6.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_26 = u_xlat16_15.x * u_xlat16_4.x;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * -0.5 + 1.0;
    u_xlat16_8.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz;
    u_xlat16_37 = dot(u_xlat3.xyw, u_xlat7.xyz);
    u_xlat16_39 = u_xlat16_37 + u_xlat16_37;
    u_xlat16_9.xyz = u_xlat7.xyz * (-vec3(u_xlat16_39)) + u_xlat3.xyw;
    u_xlat16_9.xyz = (-u_xlat16_9.xyz);
    u_xlat16_39 = log2(_CubeMap_TexelSize.z);
    u_xlat16_39 = u_xlat16_15.x * u_xlat16_39;
    u_xlat10_1 = textureLod(_CubeMap, u_xlat16_9.xyz, u_xlat16_39);
    u_xlat16_39 = u_xlat10_1.w + -1.0;
    u_xlat16_39 = _CubeMap_HDR.w * u_xlat16_39 + 1.0;
    u_xlat16_39 = log2(u_xlat16_39);
    u_xlat16_39 = u_xlat16_39 * _CubeMap_HDR.y;
    u_xlat16_39 = exp2(u_xlat16_39);
    u_xlat16_39 = u_xlat16_39 * _CubeMap_HDR.x;
    u_xlat16_10.xyz = u_xlat10_1.xyz * vec3(u_xlat16_39);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_10.xyz;
    u_xlat16_39 = (-u_xlat16_15.x) + 1.0;
    u_xlat16_10.xyz = vec3(u_xlat16_39) * u_xlat16_10.xyz;
    u_xlat16_37 = max(u_xlat16_37, 0.00100000005);
    u_xlat16_41 = dot(u_xlat7.xyz, u_xlat16_9.xyz);
    u_xlat16_41 = max(u_xlat16_41, 0.00100000005);
    u_xlat16_9.x = u_xlat16_37 * -5.55472994 + -6.98316002;
    u_xlat16_9.x = u_xlat16_37 * u_xlat16_9.x;
    u_xlat16_9.x = exp2(u_xlat16_9.x);
    u_xlat16_20.xyz = (-u_xlat16_6.xyz) * vec3(u_xlat16_26) + vec3(1.0, 1.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_20.xyz * u_xlat16_9.xxx + u_xlat16_8.xyz;
    u_xlat16_15.x = u_xlat16_15.x * u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x * 0.5;
    u_xlat16_15.x = max(u_xlat16_15.x, 9.99999975e-05);
    u_xlat16_26 = (-u_xlat16_15.x) + 1.0;
    u_xlat16_9.x = u_xlat16_41 * u_xlat16_26 + u_xlat16_15.x;
    u_xlat16_9.x = float(1.0) / u_xlat16_9.x;
    u_xlat16_15.x = u_xlat16_37 * u_xlat16_26 + u_xlat16_15.x;
    u_xlat16_15.x = float(1.0) / u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x * u_xlat16_9.x;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz;
    u_xlat16_8.xyz = u_xlat16_15.xxx * u_xlat16_8.xyz;
    u_xlat16_15.xyz = vec3(u_xlat16_37) * u_xlat16_8.xyz;
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_8.xyz = u_xlat2.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_15.xyz * vec3(u_xlat16_41) + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb33 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb33){
        u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat33 = texture(_CameraDepthBlendTexture, u_xlat1.xy).x;
        u_xlat33 = _ZBufferParams.z * u_xlat33 + _ZBufferParams.w;
        u_xlat33 = float(1.0) / u_xlat33;
        u_xlat33 = u_xlat33 + (-vs_TEXCOORD1.w);
        u_xlat33 = abs(u_xlat33) * _DepthBiasScaled;
#ifdef UNITY_ADRENO_ES3
        u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
        u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
        u_xlat33 = sqrt(u_xlat33);
        u_xlat10_2.xyz = texture(_CameraDepthBlendNormTexture, u_xlat1.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_1.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat1.xy).xyz;
        u_xlat16_2.xyz = (-u_xlat10_1.xyz) + u_xlat16_4.xyz;
        u_xlat4.xyz = vec3(u_xlat33) * u_xlat16_2.xyz + u_xlat10_1.xyz;
        u_xlat1.xyz = u_xlat5.xyz * u_xlat22.xxx + (-u_xlat16_8.xyz);
        u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz + u_xlat16_8.xyz;
        u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat34 = inversesqrt(u_xlat34);
        u_xlat1.xyz = vec3(u_xlat34) * u_xlat1.xyz;
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_1.xyz = u_xlat1.xyz;
        u_xlat16_33 = u_xlat33;
    } else {
        u_xlat16_1.xyz = u_xlat7.xyz;
        u_xlat16_33 = 1.0;
    //ENDIF
    }
    u_xlat2.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_2.x = texture(_CameraDepthBlendDiffTexture, u_xlat2.xy).w;
    u_xlat16_37 = (-u_xlat10_2.x) + u_xlat16_39;
    u_xlat16_2.x = u_xlat16_33 * u_xlat16_37 + u_xlat10_2.x;
    u_xlat3.xyw = (-vs_TEXCOORD8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5.x = dot(u_xlat3.xyw, u_xlat3.xyw);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat3.xyw = u_xlat3.xyw * u_xlat5.xxx;
    u_xlat5.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD6.xyz;
    u_xlat3.x = dot(u_xlat3.xyw, u_xlat5.xyz);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _RGPower;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat14.x = u_xlat11 * _DissolveEdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat14.x>=u_xlat0.x);
#else
    u_xlatb14 = u_xlat14.x>=u_xlat0.x;
#endif
    u_xlat14.x = u_xlatb14 ? 1.0 : float(0.0);
    u_xlat16_8.xyz = _EmissionColor.xyz * vec3(_EmissionStrenght);
    u_xlat16_8.xyz = u_xlat10_3.zzz * u_xlat16_8.xyz;
    u_xlat14.xyz = u_xlat14.xxx * _DissolveColor.xyz + u_xlat16_8.xyz;
    u_xlat5.xyz = vec3(vec3(_RGStrength, _RGStrength, _RGStrength)) * _RGColor.xyz;
    u_xlat3.xyz = u_xlat5.xyz * u_xlat3.xxx + u_xlat14.xyz;
    u_xlat36 = dot(u_xlat3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(0.0500000007>=u_xlat36);
#else
    u_xlatb36 = 0.0500000007>=u_xlat36;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb36)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat16_37 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_9.xyz = u_xlat16_1.xyz * vec3(u_xlat16_37);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.5<_EnableEmission);
#else
    u_xlatb3 = 0.5<_EnableEmission;
#endif
    u_xlat16_37 = dot(u_xlat16_8.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(9.99999975e-05<u_xlat16_37);
#else
    u_xlatb14 = 9.99999975e-05<u_xlat16_37;
#endif
    u_xlatb3 = u_xlatb14 && u_xlatb3;
    u_xlat16_2.yzw = u_xlat16_4.xyz + u_xlat16_8.xyz;
    u_xlat16_37 = max(u_xlat16_2.w, u_xlat16_2.z);
    u_xlat16_0.w = max(u_xlat16_2.y, u_xlat16_37);
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(1.0<u_xlat16_0.w);
#else
    u_xlatb14 = 1.0<u_xlat16_0.w;
#endif
    u_xlat16_0.xyz = vec3(u_xlat16_2.y / u_xlat16_0.w, u_xlat16_2.z / u_xlat16_0.w, u_xlat16_2.w / u_xlat16_0.w);
    u_xlat16_0 = (bool(u_xlatb14)) ? u_xlat16_0 : u_xlat16_2.yzwx;
    u_xlat16_14 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat14.x = sqrt(u_xlat16_14);
    SV_Target1.xyz = (bool(u_xlatb3)) ? u_xlat16_0.xyz : u_xlat16_4.xyz;
    u_xlat16_4.x = 0.400000006;
    SV_Target2.w = (u_xlatb3) ? u_xlat14.x : u_xlat16_2.x;
    SV_Target1.w = (u_xlatb3) ? u_xlat16_0.w : u_xlat16_4.x;
    SV_Target0.w = (u_xlatb3) ? 0.00392156886 : 0.0;
    SV_Target0.xyz = u_xlat16_9.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb3 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_4.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb3) ? u_xlat16_4.x : u_xlat16_6.z;
    SV_Target2.xy = u_xlat16_6.xy;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
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
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat9;
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
    gl_Position = u_xlat1;
    vs_TEXCOORD0.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat3.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat2.xyz;
    vs_TEXCOORD0.xyz = u_xlat3.xyz;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    u_xlat1.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD8.xyz = u_xlat1.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD4.xyz = u_xlat1.xxx * u_xlat2.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.xyz = u_xlat3.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	mediump float _DepthBiasScaled;
uniform 	float _EnableEmission;
uniform 	float _CutOff;
uniform 	vec4 _DissolveNoise_ST;
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _CubeMap_HDR;
uniform 	vec4 _CubeMap_TexelSize;
uniform 	float _DissolveEdgeWidth;
uniform 	vec4 _DissolveColor;
uniform 	mediump vec4 _EmissionColor;
uniform 	mediump float _EmissionStrenght;
uniform 	mediump float _RGStrength;
uniform 	vec4 _RGColor;
uniform 	mediump float _RGPower;
uniform lowp sampler2D _DissolveNoise;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainMaskMapRSmoothnessGMetallicBBlendAEmission;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube _CubeMap;
uniform highp sampler2D _CameraDepthBlendTexture;
uniform lowp sampler2D _CameraDepthBlendNormTexture;
uniform lowp sampler2D _CameraDepthBlendDiffTexture;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
vec4 u_xlat3;
lowp vec3 u_xlat10_3;
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
vec3 u_xlat14;
mediump float u_xlat16_14;
bool u_xlatb14;
mediump vec3 u_xlat16_15;
mediump vec3 u_xlat16_20;
vec2 u_xlat22;
mediump float u_xlat16_26;
float u_xlat33;
mediump float u_xlat16_33;
bool u_xlatb33;
float u_xlat34;
float u_xlat36;
bool u_xlatb36;
mediump float u_xlat16_37;
mediump float u_xlat16_39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.xy = vs_TEXCOORD3.xy * _DissolveNoise_ST.xy + _DissolveNoise_ST.zw;
    u_xlat0.x = texture(_DissolveNoise, u_xlat0.xy).x;
    u_xlat11 = (-vs_COLOR0.w) + 1.0;
    u_xlat22.xy = vs_TEXCOORD3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_1.xyz = texture(_MainTex, u_xlat22.xy).xyz;
    u_xlat2.xyz = u_xlat10_1.xyz * _Color.xyz;
    u_xlat22.xy = vs_TEXCOORD3.xy * _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST.xy + _MainMaskMapRSmoothnessGMetallicBBlendAEmission_ST.zw;
    u_xlat10_3.xyz = texture(_MainMaskMapRSmoothnessGMetallicBBlendAEmission, u_xlat22.xy).xyw;
    u_xlat16_4.x = u_xlat10_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_15.x = (-u_xlat10_3.x) + 1.0;
    u_xlat16_15.x = max(u_xlat16_15.x, 0.00100000005);
    u_xlat16_15.x = min(u_xlat16_15.x, 0.999000013);
    u_xlat22.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat22.x = inversesqrt(u_xlat22.x);
    u_xlat3.xyw = u_xlat22.xxx * vs_TEXCOORD4.xyz;
    u_xlat22.xy = vs_TEXCOORD3.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    u_xlat10_5.xyz = texture(_BumpMap, u_xlat22.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat5.x = vs_TEXCOORD5.x;
    u_xlat5.y = vs_TEXCOORD7.x;
    u_xlat5.z = vs_TEXCOORD6.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat16_6.xyz);
    u_xlat7.x = vs_TEXCOORD5.y;
    u_xlat7.y = vs_TEXCOORD7.y;
    u_xlat7.z = vs_TEXCOORD6.y;
    u_xlat5.y = dot(u_xlat7.xyz, u_xlat16_6.xyz);
    u_xlat7.x = vs_TEXCOORD5.z;
    u_xlat7.y = vs_TEXCOORD7.z;
    u_xlat7.z = vs_TEXCOORD6.z;
    u_xlat5.z = dot(u_xlat7.xyz, u_xlat16_6.xyz);
    u_xlat22.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat22.x = inversesqrt(u_xlat22.x);
    u_xlat7.xyz = u_xlat22.xxx * u_xlat5.xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat10_1.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_6.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_26 = u_xlat16_15.x * u_xlat16_4.x;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_26 = u_xlat16_26 * -0.5 + 1.0;
    u_xlat16_8.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz;
    u_xlat16_37 = dot(u_xlat3.xyw, u_xlat7.xyz);
    u_xlat16_39 = u_xlat16_37 + u_xlat16_37;
    u_xlat16_9.xyz = u_xlat7.xyz * (-vec3(u_xlat16_39)) + u_xlat3.xyw;
    u_xlat16_9.xyz = (-u_xlat16_9.xyz);
    u_xlat16_39 = log2(_CubeMap_TexelSize.z);
    u_xlat16_39 = u_xlat16_15.x * u_xlat16_39;
    u_xlat10_1 = textureLod(_CubeMap, u_xlat16_9.xyz, u_xlat16_39);
    u_xlat16_39 = u_xlat10_1.w + -1.0;
    u_xlat16_39 = _CubeMap_HDR.w * u_xlat16_39 + 1.0;
    u_xlat16_39 = log2(u_xlat16_39);
    u_xlat16_39 = u_xlat16_39 * _CubeMap_HDR.y;
    u_xlat16_39 = exp2(u_xlat16_39);
    u_xlat16_39 = u_xlat16_39 * _CubeMap_HDR.x;
    u_xlat16_10.xyz = u_xlat10_1.xyz * vec3(u_xlat16_39);
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_10.xyz;
    u_xlat16_39 = (-u_xlat16_15.x) + 1.0;
    u_xlat16_10.xyz = vec3(u_xlat16_39) * u_xlat16_10.xyz;
    u_xlat16_37 = max(u_xlat16_37, 0.00100000005);
    u_xlat16_41 = dot(u_xlat7.xyz, u_xlat16_9.xyz);
    u_xlat16_41 = max(u_xlat16_41, 0.00100000005);
    u_xlat16_9.x = u_xlat16_37 * -5.55472994 + -6.98316002;
    u_xlat16_9.x = u_xlat16_37 * u_xlat16_9.x;
    u_xlat16_9.x = exp2(u_xlat16_9.x);
    u_xlat16_20.xyz = (-u_xlat16_6.xyz) * vec3(u_xlat16_26) + vec3(1.0, 1.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_20.xyz * u_xlat16_9.xxx + u_xlat16_8.xyz;
    u_xlat16_15.x = u_xlat16_15.x * u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x * 0.5;
    u_xlat16_15.x = max(u_xlat16_15.x, 9.99999975e-05);
    u_xlat16_26 = (-u_xlat16_15.x) + 1.0;
    u_xlat16_9.x = u_xlat16_41 * u_xlat16_26 + u_xlat16_15.x;
    u_xlat16_9.x = float(1.0) / u_xlat16_9.x;
    u_xlat16_15.x = u_xlat16_37 * u_xlat16_26 + u_xlat16_15.x;
    u_xlat16_15.x = float(1.0) / u_xlat16_15.x;
    u_xlat16_15.x = u_xlat16_15.x * u_xlat16_9.x;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz;
    u_xlat16_8.xyz = u_xlat16_15.xxx * u_xlat16_8.xyz;
    u_xlat16_15.xyz = vec3(u_xlat16_37) * u_xlat16_8.xyz;
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_8.xyz = u_xlat2.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_15.xyz * vec3(u_xlat16_41) + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(vs_TEXCOORD1.w<100.0);
#else
    u_xlatb33 = vs_TEXCOORD1.w<100.0;
#endif
    if(u_xlatb33){
        u_xlat1.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
        u_xlat33 = texture(_CameraDepthBlendTexture, u_xlat1.xy).x;
        u_xlat33 = _ZBufferParams.z * u_xlat33 + _ZBufferParams.w;
        u_xlat33 = float(1.0) / u_xlat33;
        u_xlat33 = u_xlat33 + (-vs_TEXCOORD1.w);
        u_xlat33 = abs(u_xlat33) * _DepthBiasScaled;
#ifdef UNITY_ADRENO_ES3
        u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
        u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
        u_xlat33 = sqrt(u_xlat33);
        u_xlat10_2.xyz = texture(_CameraDepthBlendNormTexture, u_xlat1.xy).xyz;
        u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat10_1.xyz = texture(_CameraDepthBlendDiffTexture, u_xlat1.xy).xyz;
        u_xlat16_2.xyz = (-u_xlat10_1.xyz) + u_xlat16_4.xyz;
        u_xlat4.xyz = vec3(u_xlat33) * u_xlat16_2.xyz + u_xlat10_1.xyz;
        u_xlat1.xyz = u_xlat5.xyz * u_xlat22.xxx + (-u_xlat16_8.xyz);
        u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz + u_xlat16_8.xyz;
        u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat34 = inversesqrt(u_xlat34);
        u_xlat1.xyz = vec3(u_xlat34) * u_xlat1.xyz;
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_1.xyz = u_xlat1.xyz;
        u_xlat16_33 = u_xlat33;
    } else {
        u_xlat16_1.xyz = u_xlat7.xyz;
        u_xlat16_33 = 1.0;
    //ENDIF
    }
    u_xlat2.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_2.x = texture(_CameraDepthBlendDiffTexture, u_xlat2.xy).w;
    u_xlat16_37 = (-u_xlat10_2.x) + u_xlat16_39;
    u_xlat16_2.x = u_xlat16_33 * u_xlat16_37 + u_xlat10_2.x;
    u_xlat3.xyw = (-vs_TEXCOORD8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat5.x = dot(u_xlat3.xyw, u_xlat3.xyw);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat3.xyw = u_xlat3.xyw * u_xlat5.xxx;
    u_xlat5.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD6.xyz;
    u_xlat3.x = dot(u_xlat3.xyw, u_xlat5.xyz);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = max(u_xlat3.x, 9.99999975e-05);
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _RGPower;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat14.x = u_xlat11 * _DissolveEdgeWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat14.x>=u_xlat0.x);
#else
    u_xlatb14 = u_xlat14.x>=u_xlat0.x;
#endif
    u_xlat14.x = u_xlatb14 ? 1.0 : float(0.0);
    u_xlat16_8.xyz = _EmissionColor.xyz * vec3(_EmissionStrenght);
    u_xlat16_8.xyz = u_xlat10_3.zzz * u_xlat16_8.xyz;
    u_xlat14.xyz = u_xlat14.xxx * _DissolveColor.xyz + u_xlat16_8.xyz;
    u_xlat5.xyz = vec3(vec3(_RGStrength, _RGStrength, _RGStrength)) * _RGColor.xyz;
    u_xlat3.xyz = u_xlat5.xyz * u_xlat3.xxx + u_xlat14.xyz;
    u_xlat36 = dot(u_xlat3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(0.0500000007>=u_xlat36);
#else
    u_xlatb36 = 0.0500000007>=u_xlat36;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb36)) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    u_xlat16_37 = (-u_xlat11) + 1.0;
    u_xlat3.x = u_xlat0.x + u_xlat16_37;
    u_xlat3.x = u_xlat3.x + -1.0;
    u_xlat3.x = u_xlat3.x + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<0.0);
#else
    u_xlatb3 = u_xlat3.x<0.0;
#endif
    if((int(u_xlatb3) * int(0xffffffffu))!=0){discard;}
    u_xlat16_37 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_37 = inversesqrt(u_xlat16_37);
    u_xlat16_9.xyz = u_xlat16_1.xyz * vec3(u_xlat16_37);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.5<_EnableEmission);
#else
    u_xlatb3 = 0.5<_EnableEmission;
#endif
    u_xlat16_37 = dot(u_xlat16_8.xyz, vec3(0.0396819152, 0.45802179, 0.00609653955));
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(9.99999975e-05<u_xlat16_37);
#else
    u_xlatb14 = 9.99999975e-05<u_xlat16_37;
#endif
    u_xlatb3 = u_xlatb14 && u_xlatb3;
    u_xlat16_2.yzw = u_xlat16_4.xyz + u_xlat16_8.xyz;
    u_xlat16_37 = max(u_xlat16_2.w, u_xlat16_2.z);
    u_xlat16_0.w = max(u_xlat16_2.y, u_xlat16_37);
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(1.0<u_xlat16_0.w);
#else
    u_xlatb14 = 1.0<u_xlat16_0.w;
#endif
    u_xlat16_0.xyz = vec3(u_xlat16_2.y / u_xlat16_0.w, u_xlat16_2.z / u_xlat16_0.w, u_xlat16_2.w / u_xlat16_0.w);
    u_xlat16_0 = (bool(u_xlatb14)) ? u_xlat16_0 : u_xlat16_2.yzwx;
    u_xlat16_14 = u_xlat16_0.w * 0.0500000007;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat14.x = sqrt(u_xlat16_14);
    SV_Target1.xyz = (bool(u_xlatb3)) ? u_xlat16_0.xyz : u_xlat16_4.xyz;
    u_xlat16_4.x = 0.400000006;
    SV_Target2.w = (u_xlatb3) ? u_xlat14.x : u_xlat16_2.x;
    SV_Target1.w = (u_xlatb3) ? u_xlat16_0.w : u_xlat16_4.x;
    SV_Target0.w = (u_xlatb3) ? 0.00392156886 : 0.0;
    SV_Target0.xyz = u_xlat16_9.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb3 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_4.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb3) ? u_xlat16_4.x : u_xlat16_6.z;
    SV_Target2.xy = u_xlat16_6.xy;
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
Keywords { "_ENABLEALPHATEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_DISSOLVEBYVERTEXALPHA_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
""
}
}
}
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 71060
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _MaterialShadowBias;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = min(_MaterialShadowBias, 0.100000001);
    u_xlat0 = (-u_xlat0) * 2.0 + unity_LightShadowBias.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0 = u_xlat0 / u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 + u_xlat1.z;
    u_xlat3 = max((-u_xlat1.w), u_xlat0);
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat3 = (-u_xlat0) + u_xlat3;
    gl_Position.z = unity_LightShadowBias.y * u_xlat3 + u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _MaterialShadowBias;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = min(_MaterialShadowBias, 0.100000001);
    u_xlat0 = (-u_xlat0) * 2.0 + unity_LightShadowBias.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0 = u_xlat0 / u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 + u_xlat1.z;
    u_xlat3 = max((-u_xlat1.w), u_xlat0);
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat3 = (-u_xlat0) + u_xlat3;
    gl_Position.z = unity_LightShadowBias.y * u_xlat3 + u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _CutOff;
uniform 	vec4 _DissolveNoise_ST;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveNoise;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _DissolveNoise_ST.xy + _DissolveNoise_ST.zw;
    u_xlat10_0 = texture(_DissolveNoise, u_xlat0.xy).x;
    u_xlat16_1 = (-_DissolveValue) + 1.0;
    u_xlat16_0 = u_xlat10_0 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + -1.0;
    u_xlat0.x = u_xlat16_0 + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
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

uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _MaterialShadowBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
void main()
{
    u_xlat0 = min(_MaterialShadowBias, 0.100000001);
    u_xlat0 = (-u_xlat0) * 2.0 + unity_LightShadowBias.x;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0 = u_xlat0 / u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 + u_xlat1.z;
    u_xlat3 = max((-u_xlat1.w), u_xlat0);
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat3 = (-u_xlat0) + u_xlat3;
    gl_Position.z = unity_LightShadowBias.y * u_xlat3 + u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _MaterialShadowBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
void main()
{
    u_xlat0 = min(_MaterialShadowBias, 0.100000001);
    u_xlat0 = (-u_xlat0) * 2.0 + unity_LightShadowBias.x;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0 = u_xlat0 / u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 + u_xlat1.z;
    u_xlat3 = max((-u_xlat1.w), u_xlat0);
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat3 = (-u_xlat0) + u_xlat3;
    gl_Position.z = unity_LightShadowBias.y * u_xlat3 + u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _CutOff;
uniform 	vec4 _DissolveNoise_ST;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveNoise;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _DissolveNoise_ST.xy + _DissolveNoise_ST.zw;
    u_xlat10_0 = texture(_DissolveNoise, u_xlat0.xy).x;
    u_xlat16_1 = (-_DissolveValue) + 1.0;
    u_xlat16_0 = u_xlat10_0 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + -1.0;
    u_xlat0.x = u_xlat16_0 + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_DISSOLVEBYVERTEXALPHA_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _MaterialShadowBias;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = min(_MaterialShadowBias, 0.100000001);
    u_xlat0 = (-u_xlat0) * 2.0 + unity_LightShadowBias.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0 = u_xlat0 / u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 + u_xlat1.z;
    u_xlat3 = max((-u_xlat1.w), u_xlat0);
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat3 = (-u_xlat0) + u_xlat3;
    gl_Position.z = unity_LightShadowBias.y * u_xlat3 + u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _MaterialShadowBias;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = min(_MaterialShadowBias, 0.100000001);
    u_xlat0 = (-u_xlat0) * 2.0 + unity_LightShadowBias.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0 = u_xlat0 / u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 + u_xlat1.z;
    u_xlat3 = max((-u_xlat1.w), u_xlat0);
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat3 = (-u_xlat0) + u_xlat3;
    gl_Position.z = unity_LightShadowBias.y * u_xlat3 + u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _CutOff;
uniform 	vec4 _DissolveNoise_ST;
uniform lowp sampler2D _DissolveNoise;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
float u_xlat2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _DissolveNoise_ST.xy + _DissolveNoise_ST.zw;
    u_xlat10_0 = texture(_DissolveNoise, u_xlat0.xy).x;
    u_xlat2 = (-vs_COLOR0.w) + 1.0;
    u_xlat16_1 = (-u_xlat2) + 1.0;
    u_xlat16_0 = u_xlat10_0 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + -1.0;
    u_xlat0.x = u_xlat16_0 + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _MaterialShadowBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
void main()
{
    u_xlat0 = min(_MaterialShadowBias, 0.100000001);
    u_xlat0 = (-u_xlat0) * 2.0 + unity_LightShadowBias.x;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0 = u_xlat0 / u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 + u_xlat1.z;
    u_xlat3 = max((-u_xlat1.w), u_xlat0);
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat3 = (-u_xlat0) + u_xlat3;
    gl_Position.z = unity_LightShadowBias.y * u_xlat3 + u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _MaterialShadowBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
void main()
{
    u_xlat0 = min(_MaterialShadowBias, 0.100000001);
    u_xlat0 = (-u_xlat0) * 2.0 + unity_LightShadowBias.x;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0 = u_xlat0 / u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 + u_xlat1.z;
    u_xlat3 = max((-u_xlat1.w), u_xlat0);
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat3 = (-u_xlat0) + u_xlat3;
    gl_Position.z = unity_LightShadowBias.y * u_xlat3 + u_xlat0;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _CutOff;
uniform 	vec4 _DissolveNoise_ST;
uniform lowp sampler2D _DissolveNoise;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
float u_xlat2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _DissolveNoise_ST.xy + _DissolveNoise_ST.zw;
    u_xlat10_0 = texture(_DissolveNoise, u_xlat0.xy).x;
    u_xlat2 = (-vs_COLOR0.w) + 1.0;
    u_xlat16_1 = (-u_xlat2) + 1.0;
    u_xlat16_0 = u_xlat10_0 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + -1.0;
    u_xlat0.x = u_xlat16_0 + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
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
Keywords { "_ENABLEALPHATEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_DISSOLVEBYVERTEXALPHA_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
""
}
}
}
 Pass {
  Name "DEPTHONLY"
  Tags { "LIGHTMODE" = "DepthOnly" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 141990
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _CutOff;
uniform 	vec4 _DissolveNoise_ST;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveNoise;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _DissolveNoise_ST.xy + _DissolveNoise_ST.zw;
    u_xlat10_0 = texture(_DissolveNoise, u_xlat0.xy).x;
    u_xlat16_1 = (-_DissolveValue) + 1.0;
    u_xlat16_0 = u_xlat10_0 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + -1.0;
    u_xlat0.x = u_xlat16_0 + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
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
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _CutOff;
uniform 	vec4 _DissolveNoise_ST;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveNoise;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _DissolveNoise_ST.xy + _DissolveNoise_ST.zw;
    u_xlat10_0 = texture(_DissolveNoise, u_xlat0.xy).x;
    u_xlat16_1 = (-_DissolveValue) + 1.0;
    u_xlat16_0 = u_xlat10_0 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + -1.0;
    u_xlat0.x = u_xlat16_0 + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_DISSOLVEBYVERTEXALPHA_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _CutOff;
uniform 	vec4 _DissolveNoise_ST;
uniform lowp sampler2D _DissolveNoise;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
float u_xlat2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _DissolveNoise_ST.xy + _DissolveNoise_ST.zw;
    u_xlat10_0 = texture(_DissolveNoise, u_xlat0.xy).x;
    u_xlat2 = (-vs_COLOR0.w) + 1.0;
    u_xlat16_1 = (-u_xlat2) + 1.0;
    u_xlat16_0 = u_xlat10_0 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + -1.0;
    u_xlat0.x = u_xlat16_0 + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_TARGET0;
void main()
{
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _CutOff;
uniform 	vec4 _DissolveNoise_ST;
uniform lowp sampler2D _DissolveNoise;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
float u_xlat2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _DissolveNoise_ST.xy + _DissolveNoise_ST.zw;
    u_xlat10_0 = texture(_DissolveNoise, u_xlat0.xy).x;
    u_xlat2 = (-vs_COLOR0.w) + 1.0;
    u_xlat16_1 = (-u_xlat2) + 1.0;
    u_xlat16_0 = u_xlat10_0 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + -1.0;
    u_xlat0.x = u_xlat16_0 + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_TARGET0 = vec4(0.0, 0.5, 0.0, 0.5);
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
Keywords { "_ENABLEALPHATEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_DISSOLVEBYVERTEXALPHA_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
""
}
}
}
 Pass {
  Name "MOTIONVECTORS"
  Tags { "LIGHTMODE" = "MOTIONVECTORS" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 215788
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousM[4];
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MotionVectorDepthBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4_PreviousM[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousM[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousM[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousM[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_TARGET0;
vec2 u_xlat0;
ivec2 u_xlati1;
vec2 u_xlat4;
ivec2 u_xlati4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat4.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati4.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati1.xy;
    u_xlat4.xy = vec2(u_xlati4.xy);
    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
    SV_TARGET0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_TARGET0.zw = vec2(1.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousM[4];
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MotionVectorDepthBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4_PreviousM[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousM[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousM[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousM[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _CutOff;
uniform 	vec4 _DissolveNoise_ST;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveNoise;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_TARGET0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
ivec2 u_xlati2;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveNoise_ST.xy + _DissolveNoise_ST.zw;
    u_xlat10_0 = texture(_DissolveNoise, u_xlat0.xy).x;
    u_xlat16_1 = (-_DissolveValue) + 1.0;
    u_xlat16_0 = u_xlat10_0 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + -1.0;
    u_xlat0.x = u_xlat16_0 + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati2.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
    SV_TARGET0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_TARGET0.zw = vec2(1.0, 0.0);
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
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct MotionVectorParam0Array_Type {
	vec4 hlslcc_mtx4x4unity_MVPreviousMArray[4];
};
layout(std140) uniform UnityInstancing_MotionVectorParam0 {
	MotionVectorParam0Array_Type MotionVectorParam0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
ivec2 u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
void main()
{
    u_xlati0.x = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0.xy = u_xlati0.xx << ivec2(3, 2);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.z = _MotionVectorDepthBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD0 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = in_POSITION0.yyyy * MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[1];
    u_xlat1 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_TARGET0;
vec2 u_xlat0;
ivec2 u_xlati1;
vec2 u_xlat4;
ivec2 u_xlati4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat4.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati4.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati1.xy;
    u_xlat4.xy = vec2(u_xlati4.xy);
    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
    SV_TARGET0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_TARGET0.zw = vec2(1.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct MotionVectorParam0Array_Type {
	vec4 hlslcc_mtx4x4unity_MVPreviousMArray[4];
};
layout(std140) uniform UnityInstancing_MotionVectorParam0 {
	MotionVectorParam0Array_Type MotionVectorParam0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
ivec2 u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
void main()
{
    u_xlati0.x = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0.xy = u_xlati0.xx << ivec2(3, 2);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.z = _MotionVectorDepthBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD0 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = in_POSITION0.yyyy * MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[1];
    u_xlat1 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _CutOff;
uniform 	vec4 _DissolveNoise_ST;
uniform 	float _DissolveValue;
uniform lowp sampler2D _DissolveNoise;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_TARGET0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
ivec2 u_xlati2;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveNoise_ST.xy + _DissolveNoise_ST.zw;
    u_xlat10_0 = texture(_DissolveNoise, u_xlat0.xy).x;
    u_xlat16_1 = (-_DissolveValue) + 1.0;
    u_xlat16_0 = u_xlat10_0 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + -1.0;
    u_xlat0.x = u_xlat16_0 + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati2.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
    SV_TARGET0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_TARGET0.zw = vec2(1.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_DISSOLVEBYVERTEXALPHA_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousM[4];
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MotionVectorDepthBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4_PreviousM[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousM[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousM[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousM[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_TARGET0;
vec2 u_xlat0;
ivec2 u_xlati1;
vec2 u_xlat4;
ivec2 u_xlati4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat4.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati4.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati1.xy;
    u_xlat4.xy = vec2(u_xlati4.xy);
    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
    SV_TARGET0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_TARGET0.zw = vec2(1.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousM[4];
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MotionVectorDepthBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4_PreviousM[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousM[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousM[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousM[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _CutOff;
uniform 	vec4 _DissolveNoise_ST;
uniform lowp sampler2D _DissolveNoise;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_TARGET0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
ivec2 u_xlati2;
float u_xlat3;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveNoise_ST.xy + _DissolveNoise_ST.zw;
    u_xlat10_0 = texture(_DissolveNoise, u_xlat0.xy).x;
    u_xlat3 = (-vs_COLOR0.w) + 1.0;
    u_xlat16_1 = (-u_xlat3) + 1.0;
    u_xlat16_0 = u_xlat10_0 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + -1.0;
    u_xlat0.x = u_xlat16_0 + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati2.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
    SV_TARGET0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_TARGET0.zw = vec2(1.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct MotionVectorParam0Array_Type {
	vec4 hlslcc_mtx4x4unity_MVPreviousMArray[4];
};
layout(std140) uniform UnityInstancing_MotionVectorParam0 {
	MotionVectorParam0Array_Type MotionVectorParam0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
ivec2 u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
void main()
{
    u_xlati0.x = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0.xy = u_xlati0.xx << ivec2(3, 2);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.z = _MotionVectorDepthBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD0 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = in_POSITION0.yyyy * MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[1];
    u_xlat1 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_TARGET0;
vec2 u_xlat0;
ivec2 u_xlati1;
vec2 u_xlat4;
ivec2 u_xlati4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat4.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat4.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati4.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati1.xy;
    u_xlat4.xy = vec2(u_xlati4.xy);
    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
    SV_TARGET0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_TARGET0.zw = vec2(1.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
struct MotionVectorParam0Array_Type {
	vec4 hlslcc_mtx4x4unity_MVPreviousMArray[4];
};
layout(std140) uniform UnityInstancing_MotionVectorParam0 {
	MotionVectorParam0Array_Type MotionVectorParam0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
ivec2 u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
void main()
{
    u_xlati0.x = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0.xy = u_xlati0.xx << ivec2(3, 2);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = unity_Builtins0Array[u_xlati0.x / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.z = _MotionVectorDepthBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD0 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = in_POSITION0.yyyy * MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[1];
    u_xlat1 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = MotionVectorParam0Array[u_xlati0.y / 4].hlslcc_mtx4x4unity_MVPreviousMArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD1 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _CutOff;
uniform 	vec4 _DissolveNoise_ST;
uniform lowp sampler2D _DissolveNoise;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_TARGET0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
ivec2 u_xlati2;
float u_xlat3;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy * _DissolveNoise_ST.xy + _DissolveNoise_ST.zw;
    u_xlat10_0 = texture(_DissolveNoise, u_xlat0.xy).x;
    u_xlat3 = (-vs_COLOR0.w) + 1.0;
    u_xlat16_1 = (-u_xlat3) + 1.0;
    u_xlat16_0 = u_xlat10_0 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + -1.0;
    u_xlat0.x = u_xlat16_0 + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati2.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
    SV_TARGET0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_TARGET0.zw = vec2(1.0, 0.0);
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
Keywords { "_ENABLEALPHATEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_DISSOLVEBYVERTEXALPHA_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" "_DISSOLVEBYVERTEXALPHA_ON" }
""
}
}
}
}
Fallback "Legacy Shaders/VertexLit"
CustomEditor "MiHoYoASEMaterialInspector"
}